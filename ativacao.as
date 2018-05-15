import flash.text.engine.BreakOpportunity;

// ====================================================
// ATIVAÇÃO: Construção do Modal de Ativação
// ====================================================
function ativacao_start(){
	// Cria Fundo braanco por trás:
	root["ativacao_box"] = new Vazio();
	root["ativacao_box"].name = nome;
	var fundo = new Vazio();
	var matrix:Matrix = new Matrix();
	matrix.createGradientBox(ScreenSizeW2, ScreenSizeH2, Math.PI/2, 0, 0); 
	var square:Shape = new Shape;
	var color1:uint = uint("0xffffff");
	var color2:uint = uint("0xE7E7E7");
	square.graphics.beginGradientFill(
	GradientType.LINEAR, [color1, color2], 
	[1, 1], [0, 255], matrix, SpreadMethod.PAD,  
	InterpolationMethod.LINEAR_RGB, 0); 
	square.graphics.drawRect(0, 0, ScreenSizeW2, ScreenSizeH2); 
	fundo.addChild(square);
	fundo.alpha=.97;
	root["ativacao_box"].addChild(fundo);
	root["ativacao_interface"] = new Vazio();
	root["ativacao_box"].addChild(root["ativacao_interface"]);
	// Constroi Movies de Rolagem:
	root["ativacao_conteudo"] = new Vazio();
	root["ativacao_rolagem"] = new Vazio();
	root["ativacao_rolagem"].y=80;
	root["ativacao_box"].addChild(root["ativacao_rolagem"]);
	bgSup.alpha=0;
	bgSup.addChild(root["ativacao_box"]);
	root["ativacao_box"].scaleX = root["ativacao_box"].scaleY = scalaFixa;
	Tweener.addTween(bgSup, {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	// Topo LOGO:
	img_load("ativacao_logo",blast.list[app].paths.upload_path+"/"+logonormal,root["ativacao_box"],["width",120],null,[122,20,"left"],[],0,null)
	// Botão Retornar:
	criaIcon("atv_retorno",root["ativacao_interface"],servidor+"com/icones/direction.png",20,25,40,"bullet",["0xffffff","0x"+corbt1],["alpha","easeOutExpo",1]);			
	root["atv_retorno"].addEventListener(MouseEvent.CLICK, ativacao_retorno_home)
	root["atv_retorno"].buttonMode = true;
	root["atv_retorno"].visible=false;
	// Botão Fechar:
	root["ativacao_fechar"] = new Botao_Fechar();
	root["ativacao_fechar"].name = "ativacao_fechar";
	root["ativacao_fechar"].scaleX = root["ativacao_fechar"].scaleY = .7;
	root["ativacao_fechar"].x = (365-40);
	root["ativacao_fechar"].y = 40;
	root["ativacao_fechar"].scaleX = root["ativacao_fechar"].scaleY = 0;
	Tweener.addTween(root["ativacao_fechar"], {scaleX:.7, scaleY:.7, time: .5,transition: "easeOutElastic",delay: .4});
	Tweener.addTween(root["ativacao_fechar"].fundo, {_color:"0x"+corcancel, time: 0,transition: "linear",delay: 0});
	root["ativacao_interface"].addChild(root["ativacao_fechar"]);
	root["ativacao_fechar"].addEventListener(MouseEvent.CLICK, fechar_click);
	root["ativacao_fechar"].buttonMode = true;
	function fechar_click(event:MouseEvent):void{
		modal_abrir("ativacao_fechar_confirmacao",['confirmacaoAlert',"Sim",corbt1,.8,ativacao_fechar_confirmacao_ok],"Sair","Deseja voltar a página inicial?",true,null,"P");
		Tweener.addTween(root["confirmAlertbt"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
		function ativacao_fechar_confirmacao_ok(){
			root["autologinBlock"] = true;
			rebootBlast();
		};
	};
	ativacao_home();
};

// ====================================================
// ATIVAÇÃO: [HOME] Página Inicial
// ====================================================
function ativacao_home(){
	// variáveis Iniciais:
	var alvo = root["ativacao_conteudo"];
	destroir(root["ativacao_rolagem"],false);	
	// Título:
	root["ativacao_home_titulo"] = new Titulo_Modal();
	root["ativacao_home_titulo"].y=0;
	root["ativacao_home_titulo"].titulo.autoSize =  TextFieldAutoSize.CENTER;
	root["ativacao_home_titulo"].titulo.htmlText="<font color='#"+corbt1+"'>Falta muito pouco!</font>"
	root["ativacao_home_titulo"].texto.y =(root["ativacao_home_titulo"].titulo.y+root["ativacao_home_titulo"].titulo.height+5);
	root["ativacao_home_titulo"].texto.htmlText="<font color='#"+cortexto+"'>Veja o que você precisa para completar o seu cadastro e começar a utilizas a sua Carteira Digital.</font>";
	root["ativacao_home_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER;
	alvo.addChild(root["ativacao_home_titulo"]);
	// -----------------------------------
	// Itens de Credenciamento: Visual
	var posy = 100;
	var ativacao_passos = [
		["identidade.png","Suas Informações","Texto descritivo aqui.","suas_informacoes"],
		["map.png","Seu Endereço","Texto descritivo aqui.","seu_endereco"],
		["briefcase.png","Sua Atividade","Texto descritivo aqui.","sua_atividade"],
		["dinheiro.png","Meios de Recebimento","Texto descritivo aqui.","meios_de_recebimento"]
	];
	for(var i=0; i<ativacao_passos.length; i++){
		root["ativacao_home_item"+(i+1)] = new credenciamento_item();
		root["ativacao_home_item"+(i+1)].x=45;
		root["ativacao_home_item"+(i+1)].y=posy+((root["ativacao_home_item"+(i+1)].height+20)*i);
		criaIcon("ativacao_home_item"+(i+1)+"_icone",root["ativacao_home_item"+(i+1)],blast.list.server.server_path+"/com/icones/"+ativacao_passos[i][0],5,17,30,"normal",["0x"+corbt1,"0x"+cortexto],["alpha","easeOutExpo",1]);
		root["ativacao_home_item"+(i+1)].titulo.htmlText = "<font color='#"+cortexto+"'>"+ativacao_passos[i][1]+"</font>";
		root["ativacao_home_item"+(i+1)].texto.htmlText = "<font color='#"+cortexto+"'>"+ativacao_passos[i][2]+"</font>";
		root["ativacao_home_item"+(i+1)].addEventListener(MouseEvent.CLICK, ativacao_item_clique);
		root["ativacao_home_item"+(i+1)].tipo = ativacao_passos[i][3];
		root["ativacao_home_item"+(i+1)].buttonMode = true;
		alvo.addChild(root["ativacao_home_item"+(i+1)]);
	};
	setScroller("ativacao_swipe",root["ativacao_conteudo"],root["ativacao_rolagem"],365,550,0,0,0,0,true,"VERTICAL")
	
	// -----------------------------------
	// Itens de Credenciamento: Clique
	function ativacao_item_clique(event:MouseEvent):void{
		var tipo = event.currentTarget.tipo
		Tweener.addTween(alvo, {alpha:0,x:-30, time: .3,transition: "easeOutExpo",delay: 0, onComplete:ativacao_item_open});
		function ativacao_item_open():void{
			destroir(alvo,false);
			alvo.alpha=1;
			alvo.x = 0;
			root["ativacao_"+tipo]();
		};
	};
	// -----------------------------------
	// Itens de Credenciamento: Conteúdo
};
function ativacao_retorno_home(){
	root["atv_retorno"].visible=false;
	var alvo = root["ativacao_conteudo"];
	Tweener.addTween(alvo, {alpha:0, x:30, time: .3,transition: "easeOutExpo",delay: 0, onComplete:ativacao_retorno_home_alpha});
	function ativacao_retorno_home_alpha():void{
		destroir(alvo,false);
		alvo.alpha=1;
		alvo.x = 0;
		ativacao_home();
	};
}
// ====================================================
// ATIVAÇÃO: #1) SUAS INFORMAÇÕES
include "ativacao_suas_informacoes.as";
// ====================================================
// ATIVAÇÃO: #2) SEU ENDEREÇO
include "ativacao_seu_endereco.as";
// ====================================================
// ATIVAÇÃO: #3) SUA ATIVIDADE
include "ativacao_sua_atividade.as";
// ====================================================
// ATIVAÇÃO: #4) MEIOS DE RECEBIMENTO
include "ativacao_meios_de_recebimento.as";
// #