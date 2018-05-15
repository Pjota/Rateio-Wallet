//-----------------------------------------------------------------
// COMUNICAÇÃO COM O SERVIDOR: MULTIPART (imagem/texto)
//-----------------------------------------------------------------
import com.adobe.images.JPGEncoder;
import com.jonas.net.Multipart;
import com.adobe.crypto.MD5;
var csm = consoleAPI; // <- Busca no FLA se ele terá exibição de conteudo baixado pela API
var microcsm = false; // <- Lista no Output apenas os cabeçalhos das chamadas

// ------------------
// Variáveis Iniciais:
var loader:URLLoader = new URLLoader();
var loaderCount = 0;

// ------------------
// Variáveis de conexão:
var connectServerCACHE;  // <-- Guarda a última requisição em Cache
var connectServerROW = []; // <-- Cria lista de requisições em Cache (Ordena a fila de Chamada)
var connectServerActive = false;

//-----------------------------------------------------------------
// CONNECT: Fecha Qualquer conexão. Para TUDO!
//-----------------------------------------------------------------
function stopServer(){
	try { root["loader"+(loaderCount-1)].close(); }catch(error:Error){}
	try { root["loader2_"+(loaderCount)].close(); }catch(error:Error){}
	trace(" > Server - Tarefas: "+connectServerROW.length);
	trace(" > Server - Chamadas: "+loaderCount)
	trace(" > Encerra comunicação com o Servidor! ")
}

//-----------------------------------------------------------------
// CONNECT: Encaminha pra Fila:
//-----------------------------------------------------------------
function connectServer(remove,loadtype,link,parametros:Array,callback){
	connectServerROW.push([remove,loadtype,link,parametros,callback])
	if(connectServerActive==false){
		connectServerProcess(connectServerROW[0][0],connectServerROW[0][1],connectServerROW[0][2],connectServerROW[0][3],connectServerROW[0][4]);
	}else{
		trace(" - (!) Servidor ocupado: Chamada entrou na fila.")
	};
}
function connectServerProcess(remove,loadtype, link,parametros:Array,callback){
	connectServerActive = true;
	loaderCount++;
	root["loader"+loaderCount] = loader;
	if(remove==true){
		try {
			if(root["loader"+(loaderCount-1)]){
			root["loader"+(loaderCount-1)].close();
			root["loader"+(loaderCount-1)].removeEventListener(Event.COMPLETE, onComplete);
			}
		}catch(error:Error){}
	}else{
		try {
			if(root["loader"+(loaderCount-1)]){
			root["loader"+(loaderCount-1)].removeEventListener(Event.COMPLETE, onComplete);
			root["loader"+(loaderCount-1)].close();
			}
		}catch(error:Error){}
		// ==============================
		// CHAMANDO O SERVIDOR / API BLAST
		// ==============================
		// Cria Preloader Visual na Tela:
		if(loadtype=="screen"){
			//var preloadervisual = new carregando();
			root["preloadervisual"] = new carregando();
			var square:Sprite = new Sprite();
			modalload.addChild(square);
			square.graphics.beginFill(0x000000);
			square.graphics.drawRect(0,0,ScreenSizeW2, ScreenSizeH2);
			square.graphics.endFill();
			square.alpha=0;
			modalload.addChild(root["preloadervisual"]);
			root["preloadervisual"].x = (ScreenSizeW2/2);
			root["preloadervisual"].y = (ScreenSizeH2/2);
			root["preloadervisual"].scaleX = root["preloadervisual"].scaleY = scalaFixa;
			root["preloadervisual"].fundo.scaleX = root["preloadervisual"].fundo.scaleY = 0
			root["preloadervisual"].preloader.alpha=0;
			Tweener.addTween(root["preloadervisual"].fundo, {scaleX:1, scaleY:1, time: 1,transition: "easeOutElastic",delay: 1});
			Tweener.addTween(root["preloadervisual"].preloader, {_color:"0x"+corbt1, time: 0,transition: "linear",delay: 0});
			Tweener.addTween(root["preloadervisual"].preloader, {alpha:1, time: 1,transition: "easeOutExpo",delay: .2});
		}
		// Constroi link de chamada para a API:
		var resposta:Object;
		var randomico = Math.floor(Math.random() * 1000) + 1;
		var form:Multipart = new Multipart(link+"?num="+randomico);
		
		if(csm==true || microcsm==true){
			trace("------------------------------");
			trace(" + API Consulta ("+loaderCount+"): "+link+"?num="+randomico);
		};
		for(var i=0; i<parametros.length; i++){
			if(parametros[i][2]=="imagem"){
				var jpg:JPGEncoder = new JPGEncoder(90);
				var image:ByteArray = jpg.encode(parametros[i][1]); 
				form.addFile(parametros[i][0], image, "image/jpeg", "test.jpg");
			}
			if(parametros[i][2]=="texto"){
				form.addField(parametros[i][0], parametros[i][1]);	
			}
		};
		// Administra API Token nas chamadas:
		try {
			form.addField("id", root["User"]['login_id']);
			form.addField("cadastro", root["User"]['login_cadastro']);
			form.addField("apitoken", root["apitoken"]+1);
			form.addField("sid", root["User"]['sessao']['id']);
			form.addField("acess_id", root["User"]['id']);
			form.addField("acess_table", root["User"]['table']);
			if(csm==true){
				//trace(form)
				trace(" + Acesso: "+(root["apitoken"]+1)+" de sid = "+root["User"]['sessao']['id']+" : "+root["User"]['login_id']+root["User"]['login_cadastro']+root["User"]['sessao']['id']);
			};
		}catch(error:Error){}
			root["loader"+(loaderCount)] = new URLLoader();
			root["loader"+(loaderCount)].addEventListener(Event.COMPLETE, onComplete);
			root["loader"+(loaderCount)].addEventListener(IOErrorEvent.IO_ERROR, onError);
		try {
			root["loader"+(loaderCount)].load(form.request);
		} catch (error: Error) {
			trace("ERRO: "+error.message);
		}
		function onComplete(event:Event):void{
			root["loader2_"+(loaderCount)] = URLLoader(event.target);
			root["loader2_"+(loaderCount)].dataFormat = URLLoaderDataFormat.TEXT;
			var jsonstring = String(root["loader2_"+(loaderCount)].data);
			resposta = JSON.parse(jsonstring);
			try {
				root["AGORA"] = resposta['head']["print"];
			}catch(error:Error){}
			if(csm==true){
				if(root["AGORA"]!=undefined){ trace(" + JSON (Blast): Agora: "+root["AGORA"]); }
				if(link.indexOf("config.php")>=0){
					trace(" + JSON (Blast): Carregado com Sucesso!");
					//trace(jsonstring);
				}else{
					trace(jsonstring);
				};
			};
			root["apitoken"]++;
			connectServerActive = false;
			connectServerROW.splice(0, 1);
			callback(resposta);
			desativapreloader();
			reconnectServer();
		}
		function cancel(){
			connectServerActive = false;
			root["loader2_"+(loaderCount)].removeEventListener(Event.COMPLETE, onComplete);
		}
		function onError(event:IOErrorEvent):void {
			trace("------------------------------------");
			trace("Erro ao carregar conexão nº: "+loaderCount);
			trace("Erro:" + event);
			trace("URL:" + link);
			trace("------------------------------------");
			root["preloadervisual"].preloader.gotoAndStop("recarregar");
			newbalaoInfo(modalload,'Sem conexão com a internet!',root["preloadervisual"].x,root["preloadervisual"].y-15,"BalaoInfo","0x"+corcancel);
			root["preloadervisual"].buttonMode = true;
			root["preloadervisual"].addEventListener(MouseEvent.CLICK, reloadConnect);
			function reloadConnect(e:MouseEvent):void {
				connectServerActive = false;
				destroir(modalload,true);
				reconnectServer()
			}
		}
		function desativapreloader(){
			Tweener.addTween(root["preloadervisual"], {scaleX:0, scaleY:0, time: .4,transition: "easeOutExpo",delay: 0, onComplete:some});
			function some(){
				destroir(modalload,true);
			};
		}
	}
}
function reconnectServer(){
	if(connectServerROW.length>0){
		connectServerProcess(connectServerROW[0][0],connectServerROW[0][1],connectServerROW[0][2],connectServerROW[0][3],connectServerROW[0][4]);
	}
}
//-----------------------------------------------------------------
//   OBJECT FIELDS (Prepara objeto para EDIT/ADD em  ConnectServer)
//-----------------------------------------------------------------
function objectFields(prenome,obj){
	var campos = new Array();
	var valor;
	for(var i=0; i<obj.length; i++){
		valor = root[""+prenome+obj[i][1]].valor;
		if(obj[i][2]=="checkbox"){
			valor = root[""+prenome+obj[i][1]+"1"].valor;
		};
		if(obj[i][2]=="senha"){
			valor = root[""+prenome+obj[i][1]].texto.text;
		};
		valor = new Array(prenome+obj[i][1],valor);
		campos.push(valor);
	};
	return campos;
}
