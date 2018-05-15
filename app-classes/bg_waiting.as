//-----------------------------------------------------------------
// BG WAITING - Cria BG de praticando com Contagem de TEMPO
//-----------------------------------------------------------------
// [ VARIÁVEIS ]
// + nome				"Nome"
// + bg					[cor1,cor2,alpha]
// + cortext			[cor1,cor2,alpha]
// + fechar				[cor1,cor2,alpha]

function bg_Waiting(nome,bg,cortext,fechar){
	// ---------------------------
	// # Variáveis Iniciais:
	root[nome] = new Vazio();
	root[nome+"_conteudo"] = new Vazio();
	// ---------------------------
	// # Cria Background:
	var fundo = new Vazio();
	var matrix:Matrix = new Matrix();
	matrix.createGradientBox(ScreenSizeW, ScreenSizeH, Math.PI/2, 0, 0); 
	var square:Shape = new Shape; 
	square.graphics.beginGradientFill(
	GradientType.LINEAR, ["0x"+bg[0], "0x"+bg[1]], 
	[1, 1], [0, 255], matrix, SpreadMethod.PAD,  
	InterpolationMethod.LINEAR_RGB, 0); 
	square.graphics.drawRect(0, 0, ScreenSizeW, ScreenSizeH);
	fundo.addChild(square);
	root[nome].addChild(fundo);
	// ---------------------------
	// # Aplica Layout da Página:
	// --> Logo:
	img_load(nome+"_logodesporter",blast.list.server.id_path+"/logo/logo_p_branco_transparent.png",root[nome+"_conteudo"],["width",100,"resize"],null,[(365/2),40,"center2"],[],0,null)
	// --> Atividade // "Titulo"
	root[nome+"_atividade_titulo"] = new Titulo_Modal();
	root[nome+"_atividade_titulo"].titulo.height = 10;
	root[nome+"_atividade_titulo"].titulo.htmlText="Ciclismo na Orla de Copacabana!";
	root[nome+"_atividade_titulo"].titulo.autoSize =  TextFieldAutoSize.CENTER;
	root[nome+"_atividade_titulo"].texto.y = root[nome+"_atividade_titulo"].titulo.y + root[nome+"_atividade_titulo"].titulo.height;
	root[nome+"_atividade_titulo"].texto.htmlText="<font color='#"+cortext[0]+"'>Evento</font>";
	root[nome+"_atividade_titulo"].y = 70;
	root[nome+"_conteudo"].addChild(root[nome+"_atividade_titulo"]);
	// --> Icone de Modalidade + Avatares
	if(1==1){
		root[nome+"_avatar"] = new avatar_bola();
		root[nome+"_avatar"].x = (365/2);
		root[nome+"_avatar"].y = 200;
		root[nome+"_avatar"].fundo.alpha=0;
		root[nome+"_avatar"].scaleX = root[nome+"_avatar"].scaleY = .55
		img_load(nome+"_avatar_foto","20170220015548_15107436_1298482333516077_7464246244379981800_n.jpg",root[nome+"_avatar"].conteudo,["width",113,"resize"],null,[0,0,"center2"],[],0,null);
		root[nome+"_conteudo"].addChild(root[nome+"_avatar"]);
		root[nome+"_avatar"].buttonMode = true;
		root[nome+"_avatar"].n = 2;
		root[nome+"_avatar"].instagram_id = "@betacandy";
		root[nome+"_avatar"].addEventListener(MouseEvent.CLICK, bg_Waiting_avatarClique);
		criaIcon(nome+"_icone",root[nome+"_conteudo"],blast.list.server.upload_path+"/"+"20170629215633_corrida.png",((365/2)-30),(200-30),60,"bullet",["0x"+corbt1,"0xffffff"],["alpha","easeOutExpo",1]);
		root[nome+"_avatar"].x += (root[nome+"_avatar"].width/3);
		root[nome+"_icone"].x -= (root[nome+"_avatar"].width/3);
	}else{
		
	}
	

	// --> Infos de Checkin + Checkout
	criaLabel(nome+"_checkin","Início:","09:00",root[nome+"_conteudo"],45,235,1,cortexto,"ffffff","M");
	root[nome+"_checkin"].fundo.alpha=.2
	root[nome+"_checkin_txt"] = new Texto();
	root[nome+"_checkin_txt"].texto.y = root[nome+"_checkin"].fundo.y + root[nome+"_checkin"].fundo.height+5;
	root[nome+"_checkin_txt"].texto.width = root[nome+"_checkin"].width;
	root[nome+"_checkin_txt"].texto.autoSize =  TextFieldAutoSize.CENTER;
	root[nome+"_checkin_txt"].texto.htmlText = "<font color='#"+cortext[0]+"'>Rua São João Vicente Paulo 3.132 - São Vicente</font>";
	root[nome+"_checkin"].addChild(root[nome+"_checkin_txt"]);
	root[nome+"_checkin"].buttonMode = true;
	root[nome+"_checkin"].addEventListener(MouseEvent.CLICK, click_checkin);
	function click_checkin(event:MouseEvent):void{
		modal_abrir(nome+"_checkin_End",["confirmacaoAlert","Ver Mapa",corbt2,1,abrir_mapa],"Início <font color='#"+cortexto+"'>(Ponto de Partida)</font>","Rua São João Vicente Paulo 3.132 - São Vicente - 30180100 - Belo Horizonte - Minas Gerais",true,null,"PM");
		function abrir_mapa(){
			navigateToURL(new URLRequest("http://www.globo.com.br"));
		}
	}
	
	criaLabel(nome+"_checkout","Fim:","16:30",root[nome+"_conteudo"],185,235,1,cortexto,"ffffff","M");
	root[nome+"_checkout"].fundo.alpha=.2
	root[nome+"_checkout_txt"] = new Texto();
	root[nome+"_checkout_txt"].texto.y = root[nome+"_checkout"].fundo.y + root[nome+"_checkout"].fundo.height+5;
	root[nome+"_checkout_txt"].texto.width = root[nome+"_checkout"].width;
	root[nome+"_checkout_txt"].texto.autoSize =  TextFieldAutoSize.CENTER;
	root[nome+"_checkout_txt"].texto.htmlText = "<font color='#"+cortext[0]+"'>Rua São Paulo 351 Centro</font>";
	root[nome+"_checkout"].addChild(root[nome+"_checkout_txt"]);
	root[nome+"_checkout"].buttonMode = true;
	root[nome+"_checkout"].addEventListener(MouseEvent.CLICK, click_checkout);
	function click_checkout(event:MouseEvent):void{
		modal_abrir(nome+"_checkout_End",["confirmacaoAlert","Ver Mapa",corbt2,1,abrir_mapa],"Fim <font color='#"+cortexto+"'>(Ponto de Chegada)</font>","Rua São Paulo 351 Centro  - 30180100 - Belo Horizonte - Minas Gerais",true,null,"PM");
		function abrir_mapa(){
			navigateToURL(new URLRequest("http://www.g1.com.br"));
		}
	}
	
	// --> Cronometro // "Titulo"
	root[nome+"_cronometro_titulo"] = new Titulo_Modal();
	root[nome+"_cronometro_titulo"].titulo.htmlText="";
	root[nome+"_cronometro_titulo"].texto.htmlText="<font color='#"+cortexto+"'>Tempo de Atividade:</font>";
	root[nome+"_cronometro_titulo"].y = 320;
	root[nome+"_conteudo"].addChild(root[nome+"_cronometro_titulo"]);
	// --> Cronometro // "Contagem"
	root[nome+"_cronometro"] = new cronometroG();
	root[nome+"_cronometro"].y = 420;
	root[nome+"_cronometro"].x = (365/2);
	root[nome+"_cronometro"].texto.text = "01:43";
	Tweener.addTween(root[nome+"_cronometro"], {_color:"0x"+cortext[0], time: 0,transition: "linear",delay: 0});
	root[nome+"_conteudo"].addChild(root[nome+"_cronometro"]);
	// Checkout:
	criaBtDestaque(nome+"_checkout","Concluiu sua Atividade?","<font size='20'>FINALIZAR E RESGATAR PRÊMIO!</font>",root[nome+"_conteudo"],40,480,1,null);
	// ---------------------------
	if(fechar[0]==true){
		root[nome+"_fechar"] = new Botao_Fechar();
		root[nome+"_fechar"].name = nome+"_fechar";
		root[nome+"_fechar"].scaleX = root[nome+"_fechar"].scaleY = 0;
		root[nome+"_fechar"].x = (365/2);
		root[nome+"_fechar"].y = ScreenSizeH-60;
		root[nome+"_fechar"].scaleX = root[nome+"_fechar"].scaleY = 0;
		Tweener.addTween(root[nome+"_fechar"], {scaleX:.7, scaleY:.7, time: .5,transition: "easeOutElastic",delay: .4});
		Tweener.addTween(root[nome+"_fechar"].fundo, {_color:"0x"+corcancel, time: 0,transition: "linear",delay: 0});
		root[nome+"_conteudo"].addChild(root[nome+"_fechar"]);
		root[nome+"_fechar"].addEventListener(MouseEvent.CLICK, fechar_click);
		root[nome+"_fechar"].buttonMode = true;
		function fechar_click(event:MouseEvent):void{
			// Para este botão de fechar temos 2 opções: Fechamento com confirmação e sem confirmação:
			if(fechar[1]==true){
				modal_abrir(nome+"_fechar_confirmacao",["confirmacaoAlert",fechar[5],corbt1,1,function(){bg_Waiting_fechar(fechar[2]);}],fechar[3],fechar[4],true,null,"P");
			}else{
				bg_Waiting_fechar(fechar[2]);
			};
		};
	};
	// ---------------------------
	// # Aplica Animação:
	fundo.alpha=0;
	Tweener.addTween(fundo, {alpha:bg[2], time: 1,transition: "easeOutExpo",delay: .2});
	// ---------------------------
	// # Carrega Conteúdo:
	bgSup.addChild(root[nome]);
	bgSup.addChild(root[nome+"_conteudo"]);
	// ---------------------------
	// # Aplica scala sobre o Conteúdo e Alinha:
	root[nome+"_conteudo"].scaleX = root[nome+"_conteudo"].scaleY = scalaFixa;
	root[nome+"_conteudo"].x = (ScreenSizeW-root[nome+"_conteudo"].width)/2;
};
// # 2) Modal - Fechar
function bg_Waiting_fechar(callback){
	Tweener.addTween(bgSup, {alpha:0, time:1 ,transition: "easeOutExpo",delay: 0, onComplete:bg_Waiting_fechado});
	function bg_Waiting_fechado(){
		destroir(bgSup,true);
		bgSup.alpha=1;
		if(callback!=null){callback()}
	}
}
// # 3) Avatar Clique
function bg_Waiting_avatarClique(e:MouseEvent):void{
	var bg = [
		"bgtopcolor",
		["e9f9f6","cdf2eb"],
		160
	];
	var menu = [
		["dados_pessoais","user-shape.png"],
		["fotos_pessoais","photo-camera.png"],
		["atividades_pessoais","atividades.png"]
	]
	var config = [
		"addFriend"
	]
	var social = [
		["instagram",e.currentTarget.instagram_id],
		["chat",e.currentTarget.n]
	]
	var addFriend = [
		"Desfazer Amizade",
		"Deseja realmente desefazer amizade com este usuário?",
		"Desfazer"
	]
	modal_abrir("perfilModal",["perfil",e.currentTarget.n,"avatar_bola",bg,menu,config,social,addFriend],"","",true,null,"G");
};
