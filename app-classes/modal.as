// ====================================
//   MODAL 
// ====================================
// Opcionais: Título, Texto, fechar
// # 1) Modal - Abrir

var modalRegistro = 0;
var modalHistory = []
var modalKill = true;
var modalLimit = 4;

function modal_abrir(nome,tipo,titulo,texto,fecharStatus,callback,tamanho){
	
	// Variáveis Iniciais:
	var matrix:Matrix = new Matrix();
	var square:Shape = new Shape;
	var mascara = new Vazio()
	var mascaraMV = new Vazio()
	
	// Cria variavel alternativa para callback
	var callbackBug = callback;
	var modaltype = "";
	
	// Precisa matar algum Modal?
	if(modalRegistro!=0 && modalKill==true){
		if(modalHistory.length>modalLimit){
			modal_fechar(modalHistory[0]);
			modalHistory.shift();
			System.gc();
		};
	};
	
	// Init
	var posyFechar = 0;
	var modal_posy_start = 0;
	var modal_posy_stop = 0;
	
	// Modais: Floater:
	if(tamanho=="G"){ 	root[nome] =  new ModalBoxG(); 	posyFechar=0; modaltype="floater"; modal_posy_start=-20; modal_posy_stop=0; }
	if(tamanho=="MG"){ 	root[nome] =  new ModalBoxMG(); posyFechar=0; modaltype="floater"; modal_posy_start=-20; modal_posy_stop=0; }
	if(tamanho=="M"){ 	root[nome] =  new ModalBoxM(); 	posyFechar=0; modaltype="floater"; modal_posy_start=-20; modal_posy_stop=0; }
	if(tamanho=="PM"){ 	root[nome] =  new ModalBoxPM(); posyFechar=0; modaltype="floater"; modal_posy_start=-20; modal_posy_stop=0; }
	if(tamanho=="P"){ 	root[nome] =  new ModalBoxP(); 	posyFechar=0; modaltype="floater"; modal_posy_start=-20; modal_posy_stop=0; }
	// Modais: Bottom Slider:
	if(tamanho=="BS-G"){ 	root[nome] =  new ModalBoxG(); 	posyFechar=0; modaltype="bottom_slider"; modal_posy_start=(ScreenSizeHOriginal+30); modal_posy_stop=60;}
	if(tamanho=="BS-M"){ 	root[nome] =  new ModalBoxG(); 	posyFechar=0; modaltype="bottom_slider"; modal_posy_start=(ScreenSizeHOriginal+30); modal_posy_stop=200;}
	
	// Para Calcular posiução Y máxima de conteúdo
	root[nome].posymax = root[nome].conteudo.y;

	// Cria BG:
	matrix.createGradientBox(ScreenSizeWOriginal, ScreenSizeHOriginal, Math.PI/2, 0, 0); 
	square.graphics.beginGradientFill(
	GradientType.LINEAR, ["0x"+cor_bg1, "0x"+cor_bg2], 
	[1, 1], [0, 255], matrix, SpreadMethod.PAD,  
	InterpolationMethod.LINEAR_RGB, 0); 
	square.graphics.drawRect(0, 0, ScreenSizeWOriginal, ScreenSizeHOriginal); 
	root[nome].bg.addChild(square);
	
	// Cria rolagem para o conteúdo:
	//setScroller("modal_rolagem",root[nome].conteudo,root[nome].conteudo_rolagem,365,510,0,0,0,0,false,"VERTICAL");
	
	// -----------------------------------------
	// Tipo de Modal (Vars):
	var texto;
	var observacao;
	var posy;
	var i;
	var count =0;
	var array;
	modalRegistro++;
	
	//  Modais: Básicos:
	include "modal_infos.as";
	include "modal_numbers.as";
	include "modal_esquecisenha.as";
	include "modal_termos.as";
	include "modal_calendario.as";
	include "modal_confirmacao_Alert.as";
	include "modal_confirmacao.as";
	include "modal_detalhamento.as";
	include "modal_orcamento.as";
	include "modal_perfil.as";
	include "modal_chat.as";
	include "modal_textos.as";
	include "modal_botoes.as";
	include "modal_notificacoes.as";
	include "modal_endereco_listagem.as";
	include "modal_endereco_cadastro.as";
	
	//  Modais: Avançados:
	include "modal_wallet_saque.as";
	include "modal_wallet_antecipacao.as";
	include "modal_social_search_gps_users.as";
	
	// Modais: Semi Exclusivos:
	include "modal_eventos.as";
	include "modal_cupom.as";
	
	// -----------------------------------------
	// Modal: "Criação"
	var realnome = nome+"_mv_"+modalRegistro;
	root[nome+"_mv_"+modalRegistro] = new Vazio();
	root[nome+"_mv_"+modalRegistro].modal_posy_start = modal_posy_start;
	root[nome+"_mv_"+modalRegistro].modal_posy_stop = modal_posy_stop;
	modal.addChild(root[nome+"_mv_"+modalRegistro]);
	modalHistory.push(nome+"_mv_"+modalRegistro);
	root[nome+"_mv_"+modalRegistro].addChild(root[nome]);
	// -----------------------------------------
	// Modal: "Aparência"
	root[nome+"_mv_"+modalRegistro].alpha=0;
	Tweener.addTween(root[nome+"_mv_"+modalRegistro], {alpha:1, time: 1,transition: "easeOutExpo",delay: 0});
	// -----------------------------------------
	// Modal: "Posicionamento"
	root[nome+"_mv_"+modalRegistro].y=modal_posy_start;
	Tweener.addTween(root[nome+"_mv_"+modalRegistro], {y:modal_posy_stop, time: 1,transition: "easeOutExpo",delay: 0});
	// -----------------------------------------
	// Botão fechar?
	if(fecharStatus==true){
		root[nome+"_fechar"] = new Botao_Fechar();
		root[nome+"_fechar"].name = nome+"_fechar";
		root[nome+"_fechar"].scaleX = root[nome+"_fechar"].scaleY = 1;
		root[nome+"_fechar"].x = (ScreenSizeWOriginal/2);
		root[nome+"_fechar"].y = posyFechar;
		root[nome+"_fechar"].scaleX = root[nome+"_fechar"].scaleY = 0;
		Tweener.addTween(root[nome+"_fechar"], {scaleX:1, scaleY:1, time: .5,transition: "easeOutElastic",delay: .4});
		Tweener.addTween(root[nome+"_fechar"].fundo, {_color:"0x"+corcancel, time: 0,transition: "linear",delay: 0});
		root[nome].overmask.addChild(root[nome+"_fechar"]);
		root[nome+"_fechar"].nome = nome+"_mv_"+modalRegistro;
		root[nome+"_fechar"].addEventListener(MouseEvent.CLICK, fechar_click);
		root[nome+"_fechar"].buttonMode = true;
		function fechar_click(event:MouseEvent):void{
			modal_fechar(event.currentTarget.nome);
			if(callback!=null){callback()}
		};
	};
}
// # 2) Modal - Fechar
function modal_fechar(nome){
	// -----------------
	// Eventos Iniciais;
	// -----------------
	// #1) Para AUDIOS Canal:
	try{root["audio_canal"].stop();}catch(error:Error){}
	
	// --------------
	// Fechar Modal;
	// --------------
	Tweener.addTween(root[nome], {alpha:0,y:root[nome].modal_posy_start, time:.8 ,transition: "easeOutExpo",delay: 0, onComplete:fechar_modal});
	function fechar_modal(){
		try {
			modal.removeChild(root[nome]);
			var modalPosHistory = array_search(nome,modalHistory);
			if(modalPosHistory>=0){modalHistory.splice(modalPosHistory)}
			// Recarrega página principal?
			if(root["page_refresh_in_modal_close"]==true){
				pages_new(page_actual[0],page_actual[1]);
				root["page_refresh_in_modal_close"] = false;
			}
			if(root["page_refresh_cancel_prevent_timer_close"]==true){
				trace("fechou TIMER");
				modal_fechar_timer();
				root["page_refresh_cancel_prevent_timer_close"] = false;
			};
		}catch(error:Error){}
	};
}
function modal_fechar_timer(){
	if(root["timer_blast"]){root["timer_blast"].stop();}
}
function modal_fecha_ultimo(){
	try{modal_fechar(modalHistory[modalHistory.length-1]);}catch(error:Error){}
}

