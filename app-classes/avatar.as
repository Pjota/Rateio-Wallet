// ==============================================
// INPUT: AVATAR INPUT "IMG" (Foto/Album)
// ==============================================
function criaAvatarInput(nome,texto,local,posx,posy,callback,localAvatar){
	// Avatar:
    root[nome] = new Vazio();
    root[nome].x = posx;
    root[nome].y = posy;
    root[nome+"_titulo"] = new titulo_simples();
    root[nome+"_titulo"].texto.width = 280;
    root[nome+"_titulo"].texto.htmlText = "<font color='#"+cortexto+"' size='16'>"+texto+"</font>";
    root[nome].addChild(root[nome+"_titulo"]);
    criaIcon(nome+"_avatar_select",root[nome],blast.list.server.server_path+"/com/icones/social-3.png",100,35,90,"bullet",["0xffffff","0x"+corbt1],["alpha","easeOutExpo",1]);
    criaIcon(nome+"_avatar_select_icon",root[nome+"_avatar_select"],blast.list.server.server_path+"/com/icones/square-1.png",0,0,35,"bullet",["0x"+cortexto,"0xffffff"],["alpha","easeOutExpo",1]); 
    local.addChild(root[nome]);
	// Clique no Avatar:
	root[nome].addEventListener(MouseEvent.CLICK, function(){criaAvatarInput_click()});
	root[nome].buttonMode = true;
	function criaAvatarInput_click(){
		initCameraRoll(nome+"_cr",root[nome].loadAvatar);
	};
	root[nome].loadAvatar = function(bitmapadata,foto,salvar){
		if(foto is String){
			// [AVATAR] Carrega URL IMAGE no Avatar:
			var url = foto;
			foto = new Vazio();
			img_load("foto_avatar",url,foto,["scale",1,"scale"],null,[0,0],[],0,initLoadAvatar);
		}else{
			// [AVATAR] Carrega BITMAPDATA no Avatar:
			initLoadAvatar();
		};
		function initLoadAvatar(){
			destroir(root[nome+"_avatar_select"],true);
			root["avatar_view"] = new avatar_bola();
			root["avatar_view"].x = 40;
			root["avatar_view"].y = 40;
			root["avatar_view"].scaleX = root["avatar_view"].scaleY = .78; 
			Tweener.addTween(root["avatar_view"].fundo, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
			root["avatar_view"].conteudo.addChild(foto);
			root["avatar_view"].conteudo.width = 120;
			root["avatar_view"].conteudo.scaleY = root["avatar_view"].conteudo.scaleX;
			root["avatar_view"].conteudo.x -= (root["avatar_view"].conteudo.width/2);
			root["avatar_view"].conteudo.y -= (root["avatar_view"].conteudo.height/2);
			root["avatar_view"].alpha=0;
			Tweener.addTween(root["avatar_view"], {alpha:1, time: 1,transition: "easeOutExpo",delay: 0});
			root[nome+"_avatar_select"].addChild(root["avatar_view"]);
			// --------------------------------------
			// [AVATAR] Salva BITMAPDATA no Servidor:
			if(salvar==true){
				root["avatar_carregando"] = new carregando();
				root["avatar_carregando"].fundo.visible=false;
				root["avatar_carregando"].x = 40;
				root["avatar_carregando"].y = 40;
				Tweener.addTween(root["avatar_carregando"], {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
				root[nome+"_avatar_select"].addChild(root["avatar_carregando"]);
			}else{
				var tam = root["avatar_view"].fundo.scaleX
				root["avatar_view"].fundo.scaleX = root["avatar_view"].fundo.scaleY = tam/2;
				Tweener.addTween(root["avatar_view"].fundo, {_color:"0x"+corbt1, time: 1,transition: "easeOutExpo",delay: 0});
				Tweener.addTween(root["avatar_view"].fundo, {scaleX:tam,scaleY:tam, time: 1,transition: "easeOutElastic",delay: 0});
			}
		};
	};
};