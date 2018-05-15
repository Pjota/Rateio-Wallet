//-----------------------------------------------------------------
// COMBOBOX: MONTAGEM
//-----------------------------------------------------------------
function criaComboboxP(alvo,nome1,nome2,titulo,local,posx,posy,escala,tipo,busca,buscaadd,dependencia,cores,campos,callback,callbackclick){
	var nome = nome1+nome2;
	root[nome] = new ComboboxP();
	root[nome].name = nome;
	root[nome].tipo = "P";
	root[nome].dados;
	root[nome].x = posx;
	root[nome].infos = [alvo,nome1,nome2,titulo,local,posx,posy,escala,tipo,busca,buscaadd,dependencia,cores,campos,callback,callbackclick]
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].scaleX = root[nome].scaleY = escala;
	root[nome].titulo.htmlText = "<font color='#"+root["corbt1"]+"'>"+titulo+"</font>";
	root[nome].valor = "Selecione...";
	Tweener.addTween(root[nome].selecao.fundo, {_color:"0x"+root["coricon"],time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].fundo, {_color:cores[0],time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].texto, {_color:cores[1],time: 0,transition: "linear",delay: 0});
	root[nome].alpha=0;
	root[nome].addEventListener(MouseEvent.CLICK, open_combobox);
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	var ativo = false;
	root[nome].ativo = false;
	if(dependencia!=""){
		if(buscaadd!=""){
			ativo = 1;
			root[nome].ativo = true;
		}
	}else{
		ativo = 1;
		root[nome].ativo = true;
	}
	if(ativo!=1){
		Tweener.removeTweens(root[nome]);
		root[nome].alpha=.4;
	}
	local.addChild(root[nome]);
}

function criaCombobox(alvo,nome1,nome2,titulo,local,posx,posy,escala,tipo,busca,buscaadd,dependencia,cores,campos,callback,callbackclick){
	var nome = nome1+nome2;
	root[nome] = new Combobox();
	root[nome].name = nome;
	root[nome].tipo = "";
	root[nome].dados;
	root[nome].x = posx;
	root[nome].infos = [alvo,nome1,nome2,titulo,local,posx,posy,escala,tipo,busca,buscaadd,dependencia,cores,campos,callback,callbackclick]
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].scaleX = root[nome].scaleY = escala;
	root[nome].titulo.htmlText = "<font color='#"+root["corbt1"]+"'>"+titulo+"</font>";
	root[nome].valor = "Selecione...";
	Tweener.addTween(root[nome].selecao.fundo, {_color:"0x"+root["coricon"],time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].fundo, {_color:cores[0],time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].texto, {_color:cores[1],time: 0,transition: "linear",delay: 0});
	root[nome].addEventListener(MouseEvent.CLICK, open_combobox);
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	var ativo = false;
	root[nome].ativo = false;
	if(dependencia!=""){
		if(buscaadd!=""){
			ativo = 1;
			root[nome].ativo = true;
		}
	}else{
		ativo = 1;
		root[nome].ativo = true;
	}
	if(ativo!=1){
		Tweener.removeTweens(root[nome]);
		root[nome].alpha=.4;
	}
	local.addChild(root[nome]);
}
function open_combobox(e:Event):void {
	if(e.currentTarget.ativo==true){
		Combobox_abrir(e.currentTarget.infos,1,"");
	}
};
	
// ==============================================
// COMBOBOX: ABRIR
// ==============================================
function Combobox_abrir(infos,tempo,string){
	// # Cria o fundo do Combobox:
	var combobox_fundo = new Vazio();
	comboselect.addChild(combobox_fundo);
	var matrix:Matrix = new Matrix();
	matrix.createGradientBox(ScreenSizeW2, ScreenSizeH2, Math.PI/2, 0, 0); 
	var square:Shape = new Shape; 
	square.graphics.beginGradientFill(
	GradientType.LINEAR, ["0x"+corbt1, "0x"+corbt1], 
	[1, 1], [0, 255], matrix, SpreadMethod.PAD,  
	InterpolationMethod.LINEAR_RGB, 0); 
	square.graphics.drawRect(0, 0, ScreenSizeW2, ScreenSizeH2); 
	combobox_fundo.addChild(square);
	combobox_fundo.alpha=.9;
	// # Botão Fechar:
	var fechar = new Botao_Fechar();
	fechar.name = "Combobox_Open_fechar";
	fechar.scaleX = fechar.scaleY = 0;
	fechar.x = (ScreenSizeW2/2);
	fechar.y = 50*scalaFixa;
	fechar.scaleX = fechar.scaleY = 0;
	Tweener.addTween(fechar, {scaleX:scalaFixa, scaleY:scalaFixa, time: (tempo/2),transition: "easeOutElastic",delay: (tempo/2)});
	Tweener.addTween(fechar.fundo, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
	Tweener.addTween(fechar.icone, {_color:"0x"+corcancel, time: 0,transition: "linear",delay: 0});
	comboselect.addChild(fechar);
	fechar.addEventListener(MouseEvent.CLICK, function():void{Combobox_fechar(null,null,null)});
	fechar.buttonMode = true;
	// Conteúdo:
	var conteudo = new Vazio();
	//conteudo.scaleX = conteudo.scaleY = scalaFixa;
	if(infos[8]=="banco"){
		var tabela:Array = infos[2].split("id_");
		var addapilink = "";
		if(infos[10]!="" && infos[10]!=null){
			addapilink = ","+infos[11]+"="+infos[10];
		}
		if(string!="" && string!=null){
			addapilink += ",like_column=nome";
			addapilink += ",like_string="+string;
		}
		connectServer(false,"screen",servidor+"api/list/"+tabela[1]+"/ativo=1,order_column=nome,order_direct=ASC"+addapilink,[
		],combobox_retorno);
		trace("Alterou a cor do carregando")
	};
	if(infos[8]=="objeto"){
		var combo:Object = new Object();
		combo = infos[14]();
		combobox_retorno(combo);
	};
	
		
	function combobox_retorno(dados){
		if(dados.list.length>0){
			for(var i=0; i<(dados.list.length); i++){
				root["combobox_item"+(i+1)] = new Combox_Item();
				root["combobox_item"+(i+1)].scaleX = root["combobox_item"+(i+1)].scaleY = scalaFixa;
				root["combobox_item"+(i+1)].x=0;
				root["combobox_item"+(i+1)].n=(i+1);
				root["combobox_item"+(i+1)].infos = infos;
				root["combobox_item"+(i+1)].dados = dados.list[i];
				root["combobox_item"+(i+1)].y=((root["combobox_item"+(i+1)].height+2)*i);
				root["combobox_item"+(i+1)].texto.htmlText = "<font color='#"+corbt2+"'>"+capitalize(dados.list[i].nome.toLowerCase())+"</font>";
				Tweener.addTween(root["combobox_item"+(i+1)].linha, {_color:"0x"+cordetalhemenus, time: 0,transition: "linear",delay: 0});
				conteudo.addChild(root["combobox_item"+(i+1)]);
			};
			
			if(dados.list.length>10){
				var rolagem = new Vazio();
				comboselect.addChild(rolagem);
				rolagem.x = (ScreenSizeW2/2)-(conteudo.width/2);
				rolagem.y = 100*scalaFixa;
				var masksize;
				if(dados.list.length>20 && infos[8]=="banco"){
					masksize = 450*scalaFixa;
					criaPesquisa(infos,string);
				}else{
					if(string!="" && string!=null){
						masksize = 450*scalaFixa;
						criaPesquisa(infos,string);
					}else{
						masksize = 500*scalaFixa;
					}
				}
				setScroller("scroller",conteudo,rolagem,ScreenSizeW2,masksize,0,0,0,0,false,"VERTICAL");
		
			}else{
				comboselect.addChild(conteudo);
				conteudo.x = (ScreenSizeW2/2)-(conteudo.width/2);
				conteudo.y = 100*scalaFixa;
				if(string!="" && string!=null){
					criaPesquisa(infos,string);
				}
			};
			
		}else{
			root["combo_pesquisa_nda"] = new Titulo();
			root["combo_pesquisa_nda"].scaleX = root["combo_pesquisa_nda"].scaleY = scalaFixa;
			root["combo_pesquisa_nda"].y=100*scalaFixa;
			root["combo_pesquisa_nda"].titulo.x=0;
			root["combo_pesquisa_nda"].texto.x=0;
			root["combo_pesquisa_nda"].x=(ScreenSizeW2/2)-(root["combo_pesquisa_nda"].width/2);
			root["combo_pesquisa_nda"].titulo.htmlText="<font color='#"+cortexto+"'>Pesquisa:</font>";
			root["combo_pesquisa_nda"].texto.htmlText="<font color='#ffffff' size='18'>Infelizmente não encontramos nada em sua pesquisa.</font>";
			root["combo_pesquisa_nda"].texto.autoSize =  TextFieldAutoSize.CENTER ;
			comboselect.addChild(root["combo_pesquisa_nda"]);
			criaPesquisa(infos,string)
		}
		// Cria componente de texto
		function criaPesquisa(infos,string){
			criaInput("combo_pesquisar", "Pesquisar", comboselect, 0, 570*scalaFixa, (.9*scalaFixa), "0xffffff", "0x202020", "", false,"P");
			criaIcon("combo_pesquisa",comboselect,blast.list.server.server_path+"/com/icones/magnifying-glass.png",0,570*scalaFixa,50*scalaFixa,"bullet",["0x"+corbt1,"0xffffff"],["alpha","easeOutExpo",1]);
			
			if(string!="" && string!=null){
				criaIcon("combo_pesquisa_limpar",comboselect,blast.list.server.server_path+"/com/icones/remove-symbol.png",0,580*scalaFixa,30*scalaFixa,"bullet",["0xffffff","0x"+corcancel],["alpha","easeOutExpo",1]);
				root["combo_pesquisar"].x =(ScreenSizeW2/2)-(root["combo_pesquisar"].width/2)-55;
				root["combo_pesquisa"].x =(root["combo_pesquisar"].x+root["combo_pesquisar"].width+10);
				root["combo_pesquisar"].texto.text = string;
				root["combo_pesquisa_limpar"].x =(root["combo_pesquisa"].x+root["combo_pesquisa"].width+10);
				root["combo_pesquisa_limpar"].addEventListener(MouseEvent.CLICK, combo_pesquisar_limpar);
				root["combo_pesquisa_limpar"].buttonMode = true;
				function combo_pesquisar_limpar(){
					destroir(comboselect,true);
					Combobox_abrir(infos,0,"");
				}
			}else{
				root["combo_pesquisar"].x =(ScreenSizeW2/2)-(root["combo_pesquisar"].width/2)-30;
				root["combo_pesquisa"].x =(root["combo_pesquisar"].x+root["combo_pesquisar"].width+10)
			}
			root["combo_pesquisa"].addEventListener(MouseEvent.CLICK, combo_pesquisar_clique);
			root["combo_pesquisa"].buttonMode = true;
			function combo_pesquisar_clique(){
				if(root["combo_pesquisar"].texto.text!="Pesquisar" && root["combo_pesquisar"].texto.text!="" ){
					Combobox_pesquisa(root["combo_pesquisar"].texto.text,infos)
				}else{
					newbalaoInfo(comboselect,'Digite para iniciar a pesquisa.',(root["combo_pesquisar"].x+(root["combo_pesquisar"].width/2)),(root["combo_pesquisar"].y+30),"BalaoInfo","0x"+corcancel);
				}
			};
		};
	}
	comboselect.alpha=0;
	Tweener.addTween(comboselect, {alpha:1, time: 1,transition: "easeOutExpo",delay: 0});	
};
// ==============================================
// COMBOBOX: PESQUISAR
// ==============================================
function Combobox_pesquisa(string,infos){
	trace("Procura para "+string);
	destroir(comboselect,true);
	Combobox_abrir(infos,0,string);
};

// ==============================================
// COMBOBOX: FECHAR
// ==============================================
function Combobox_fechar(dados,num,infos){
	
	//trace(dados)
	//trace(num)
	//trace(infos)

	// Selecione o item desejado no Combo
	if(infos!=null){
		// # 1) Aplica seleção ao Combobox:
		var nome = infos[1]+infos[2];
		root["ultimocomboboxid"] = dados.id;
		if(root[nome]){
			root[nome].valor = dados.id;
			root[nome].dados = dados;
			root[nome].texto.text = dados.nome;
		}
		// # 2) Existe algum Callback?
		if(infos[15]!=null){
			infos[15]();
		};
		// # 3) Existe algum combo que tenha dependencia deste? LIBERA!
		if(infos[13]!=null){
			for(var i=0; i<(infos[13].length); i++){
				if(infos[13][i][2]=="combobox" && infos[13][i][3]==infos[2]){
					var item = root[infos[1]+infos[13][i][1]]
					var alvo = item.infos[0];
					var nome1 = item.infos[1];
					var nome2 = item.infos[2];
					var titulo = item.infos[3];
					var local = item.infos[4];
					var posx = item.infos[5];
					var posy = item.infos[6];
					var escala = item.infos[7];
					var tipo = item.infos[8];
					var busca = item.infos[9];
					var buscaadd = dados.id;
					var dependencia = item.infos[11];
					var cores = item.infos[12];
					var campos = item.infos[13];
					var callback = item.infos[14];
					infos[4].removeChild(root[infos[1]+infos[13][i][1]]);
					if(root[infos[1]+infos[13][i][1]].tipo=="P"){
					  criaComboboxP(alvo,nome1,nome2,titulo,local,posx,posy,escala,tipo,busca,buscaadd,dependencia,cores,campos,callback,null);
					};
					if(root[infos[1]+infos[13][i][1]].tipo==""){
					  criaCombobox(alvo,nome1,nome2,titulo,local,posx,posy,escala,tipo,busca,buscaadd,dependencia,cores,campos,callback,null);
					};
					break;
				};
			}
		}
		
	};
	Tweener.addTween(comboselect, {alpha:0, time: 1,transition: "easeOutExpo",delay: 0, onComplete:some});
	function some(){
		destroir(comboselect,true);
		comboselect.alpha=1;
	};
};
