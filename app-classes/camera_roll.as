// ==============================================
// CAMERA ROLL | Complete Plugin
// ==============================================
function initCameraRoll(nome,callback){
	// ----------------------------------------
	// Cria Movie:
	// ----------------------------------------
	root["initCameraRollMV"] = new Vazio();
	cameraroll.addChild(root["initCameraRollMV"]);
	// Fundo colorido:
	var fundo = new Vazio();
	fundo.alpha=0;
	var matrix:Matrix = new Matrix();
	matrix.createGradientBox(ScreenSizeW2, ScreenSizeH2, Math.PI/2, 0, 0); 
	var square:Shape = new Shape; 
	square.graphics.beginGradientFill(
	GradientType.LINEAR, ["0x0E0E0E","0x000000"], 
	[1, 1], [0, 255], matrix, SpreadMethod.PAD,  
	InterpolationMethod.LINEAR_RGB, 0); 
	square.graphics.drawRect(0, 0, ScreenSizeW2, ScreenSizeH2); 
	fundo.addChild(square);
	Tweener.addTween(fundo, {alpha:.9, time: 1,transition: "easeOutExpo",delay: 0});
	root["initCameraRollMV"].addChild(fundo);
	// # Conteúdo / Vídeo:
	root["initCameraRoll_content"] = new Vazio();
	root["initCameraRollMV"].addChild(root["initCameraRoll_content"]);
	// # Conteúdo / Ferramentas:
	root["initCameraRoll_tools"] = new Vazio();
	root["initCameraRollMV"].addChild(root["initCameraRoll_tools"]);
	// # Conteúdo / Ferramentas 2:
	root["initCameraRoll_tools_ok"] = new Vazio();
	root["initCameraRollMV"].addChild(root["initCameraRoll_tools_ok"]);
	// # Botão Fechar:
	var fechar = new Botao_Fechar();
	fechar.name = "Combobox_Open_fechar";
	fechar.scaleX = fechar.scaleY = 0;
	fechar.x = (ScreenSizeW2/2);
	fechar.y = 50*scalaFixa;
	fechar.scaleX = fechar.scaleY = 0;
	Tweener.addTween(fechar, {scaleX:scalaFixa, scaleY:scalaFixa, time: 1,transition: "easeOutElastic",delay: .5});
	Tweener.addTween(fechar.fundo, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
	Tweener.addTween(fechar.icone, {_color:"0x"+corcancel, time: 0,transition: "linear",delay: 0});
	fechar.addEventListener(MouseEvent.CLICK, function():void{exitCameraRoll()});
	fechar.buttonMode = true;
	root["initCameraRollMV"].addChild(fechar);
	// ----------------------------------------
	// Cria Menu Inicial:
	// ----------------------------------------
	// # 1) Cria o Menu Instagram:
	root["CR_MenuInferior"] = new menuinferior_instagram();
	root["CR_MenuInferior"].name = "CR_MenuInferior";
	root["CR_MenuInferior"].fundo.width = ScreenSizeW2;
	root["CR_MenuInferior"].fundo.scaleY = scalaFixa;
	root["CR_MenuInferior"].x = 0;
	root["CR_MenuInferior"].y = ScreenSizeH2-(root["CR_MenuInferior"].fundo.height);
	root["CR_MenuInferior"].posy = ScreenSizeH2-(root["CR_MenuInferior"].fundo.height);
	root["initCameraRollMV"].addChild(root["CR_MenuInferior"]);
	Tweener.addTween(root["CR_MenuInferior"].fundo, {_color:"0x"+corbt2, time: 0,transition: "linear",delay: 0});
	// # 2) Cria Botões dentro do menu Instagram:
	var itens = ["photo-camera.png","photo.png"];
	var cores = blast.list[app].pages.menu.cores;
	var tamanhoMenu = Math.ceil((ScreenSizeW2)/itens.length)
	for(var i=0; i<itens.length; i++){
		root["CR_MenuInferior_instagram_menu"+(i+1)] = new menuinferior_instagram_menu();
		root["CR_MenuInferior_instagram_menu"+(i+1)].name = "CR_MenuInferior_instagram_menu"+(i+1);
		root["CR_MenuInferior_instagram_menu"+(i+1)].num = (i+1);
		Tweener.addTween(root["CR_MenuInferior_instagram_menu"+(i+1)].menuinsta.fundo, {_color:"0x"+cores.btnormalbg, time: 0,transition: "linear",delay: 0});
		root["CR_MenuInferior_instagram_menu"+(i+1)].menuinsta.width = tamanhoMenu;
		root["CR_MenuInferior_instagram_menu"+(i+1)].menuinsta.height = root["CR_MenuInferior"].fundo.height;
		root["CR_MenuInferior_instagram_menu"+(i+1)].filete.width = tamanhoMenu;
		root["CR_MenuInferior_instagram_menu"+(i+1)].filete.y = root["CR_MenuInferior_instagram_menu"+(i+1)].menuinsta.height;
		Tweener.addTween(root["CR_MenuInferior_instagram_menu"+(i+1)].filete, {_color:"0x"+cores.btfilete, time: 0,transition: "linear",delay: 0});
		root["CR_MenuInferior_instagram_menu"+(i+1)].x = (tamanhoMenu*i);
		root["CR_MenuInferior"].addChild(root["CR_MenuInferior_instagram_menu"+(i+1)]);
		root["CR_MenuInferior_instagram_menu"+(i+1)].fundoover = "0x"+cores.btcliquebg;
		root["CR_MenuInferior_instagram_menu"+(i+1)].iconeover = "0x"+cores.btcliqueicone;
		root["CR_MenuInferior_instagram_menu"+(i+1)].icone = "CR_MenuInferior_instagram_menu_icons"+i;
		criaIcon("CR_MenuInferior_instagram_menu_icons"+i,root["CR_MenuInferior_instagram_menu"+(i+1)],blast.list.server.server_path+"/com/icones/"+itens[i],(tamanhoMenu/2)-((35*scalaFixa)/2),15*scalaFixa,(35*scalaFixa),"normal",["0x"+cores.btnormalicone,null],["alpha","easeOutExpo",1]);
		root["CR_MenuInferior_instagram_menu"+(i+1)].addEventListener(MouseEvent.CLICK, CR_menu_inferior_instagram_clique);
		root["CR_MenuInferior_instagram_menu"+(i+1)].buttonMode = true;
		root["CR_MenuInferior_instagram_menu"+(i+1)].n = i;
	};
	// Muda visual do menu inferior:
	function CR_menu_inferior_instagram_clique(e:MouseEvent):void{
		CR_menu_inferior_instagram_clique_ok(e.currentTarget.num);
	}
	function CR_menu_inferior_instagram_clique_ok(num){
		cr_camerarollStart(num,"0")
		root["camera_cache"] = "0";
		for(var i=1; i<=itens.length; i++){
			if(i==num){
				root["CR_MenuInferior_instagram_menu"+(i)].ativa();
			}else{
				root["CR_MenuInferior_instagram_menu"+(i)].desativa();
			}
		}
	};
	function CR_MenuInferior_Move(tipo){
		var pos;
		if(tipo=="open"){ pos = root["CR_MenuInferior"].posy; }
		if(tipo=="close"){ pos = ScreenSizeH2+30; }
		Tweener.addTween(root["CR_MenuInferior"], {y:pos, time: .4,transition: "easeOutExpo",delay: 0});
	};
	// Init:
	CR_menu_inferior_instagram_clique_ok(1);
	// ----------------------------------------
	// CAMERA ROLL: OPÇÕES:
	// ----------------------------------------
	function cr_camerarollStart(num,parametros){
		destroir(root["initCameraRoll_content"],true);
		destroir(root["initCameraRoll_tools"],true);
		destroir(root["initCameraRoll_tools_ok"],true);
		root["initCameraRoll_tools"].visible = true;
		// # 1) Câmera
		if(num==1){
			// Cria Câmera:
			root["camera"] = Camera.getCamera(parametros);
			root["camera"].setMode( ScreenSizeW2, ScreenSizeH2 , 29, true);
			root["camera"].setQuality(0, 100);
			root["video"] = new Video(root["camera"].width, root["camera"].height);
			root["video"].attachCamera(root["camera"]);
			root["initCameraRoll_content"].addChild(root["video"]);
			// Cria Botão de Clique:
			var div2 = (ScreenSizeW2/2);
			// Cria: Tira Foto
			criaIcon("camera_photo",root["initCameraRoll_tools"],blast.list.server.server_path+"/com/icones/circle-3.png",div2-(40*scalaFixa),((ScreenSizeH2-root["CR_MenuInferior"].fundo.height-(90*scalaFixa))-(35*scalaFixa)),(80*scalaFixa),"normal",["0xffffff","0xffffff"],["scale","easeOutElastic",1.5]);
			root["camera_photo"].addEventListener(MouseEvent.CLICK, function(){camera_photo_click()});
			root["camera_photo"].buttonMode = true;
			// Cria: Flash
			criaIcon("camera_config",root["initCameraRoll_tools"],blast.list.server.server_path+"/com/icones/cog-wheel-silhouette.png",div2-(120*scalaFixa),root["camera_photo"].y+(root["camera_photo"].height/2)+(20*scalaFixa),(40*scalaFixa),"normal",["0xffffff","0xffffff"],["alpha","easeOutExpo",1]);
			root["camera_config"].alpha=.3;
			// Cria: Mudar Camera
			criaIcon("camera_change",root["initCameraRoll_tools"],blast.list.server.server_path+"/com/icones/refresh-page-option.png",div2+(80*scalaFixa),root["camera_photo"].y+(root["camera_photo"].height/2)+(20*scalaFixa),(40*scalaFixa),"normal",["0xffffff","0xffffff"],["alpha","easeOutExpo",1]);
			root["camera_change"].addEventListener(MouseEvent.CLICK, function(){camera_change_click(parametros)});
			root["camera_change"].buttonMode = true;
		};
		// # 2) Fotos
		if(num==2){
		};
	}
	function CR_camera_photoTools(tipo){
		var pos;
		if(tipo=="open"){
			root["initCameraRoll_tools"].visible = true;
			root["initCameraRoll_tools"].alpha = 0;
			root["initCameraRoll_tools"].y = -30;
			Tweener.addTween(root["initCameraRoll_tools"], {y:0, alpha:1, time: .5,transition: "easeOutExpo",delay: 0});
		}
		if(tipo=="close"){
			Tweener.addTween(root["initCameraRoll_tools"], {alpha:0, time: .5,transition: "easeOutExpo",delay: 0, onComplete:some});
		}
		function some(){root["initCameraRoll_tools"].visible=false}
	}
	// ----------------------------------------
	// CAMERA ROLL: Funcionalidades
	// ----------------------------------------
	// 1) Tira Foto:
	function camera_photo_click(){
		root["photo_bitmapdata"] = new BitmapData(ScreenSizeW2, ScreenSizeH2);
		root["photo_bitmapdata"].draw(root["video"]);
		root["bitmap"] = new Bitmap(root["photo_bitmapdata"]);
		root["fotografia"] = new Vazio();
		root["initCameraRoll_content"].addChild(root["fotografia"]);
		root["fotografia"].addChild(root["bitmap"]);
		CR_MenuInferior_Move("close");
		CR_camera_photoTools("close");
		root["video"].attachCamera(null);
		// Cria brilho na tela de foto:
		Tweener.addTween(root["fotografia"], {_color:"0xffffff", time:0,transition: "linear",delay: 0});
		Tweener.addTween(root["fotografia"], {_color:null, time:1,transition: "easeOutExpo",delay: .2});
		// Cria Opções de Escolher ou Sair:
		var div2 = (ScreenSizeW2/2);
		criaIcon("camera_photo_esc",root["initCameraRoll_tools_ok"],blast.list.server.server_path+"/com/icones/correct-symbol.png",div2+(20*scalaFixa),((ScreenSizeH2-(90*scalaFixa))),(70*scalaFixa),"bullet",["0xffffff","0x56B975"],["alpha","easeOutExpo",1]);
		root["camera_photo_esc"].addEventListener(MouseEvent.CLICK, function(){camera_photo_esc_click()});
		root["camera_photo_esc"].buttonMode = true;
		criaIcon("camera_photo_delete",root["initCameraRoll_tools_ok"],blast.list.server.server_path+"/com/icones/photo-camera.png",div2-(80*scalaFixa),((ScreenSizeH2-(70*scalaFixa))),(35*scalaFixa),"normal",["0xffffff","0xffffff"],["alpha","easeOutExpo",1]);
		root["camera_photo_delete"].addEventListener(MouseEvent.CLICK, function(){camera_photo_esc_back()});
		root["camera_photo_delete"].buttonMode = true;
	};
	// 2) Escolher foto tirada:
	function camera_photo_esc_click(){
		callback(root["photo_bitmapdata"],root["bitmap"],true);
		exitCameraRoll();
	}
	// 3) Voltar e tirar outra foto:
	function camera_photo_esc_back(){
		cr_camerarollStart(1,root["camera_cache"])
		CR_camera_photoTools("open");
		CR_MenuInferior_Move("open");
	}
	// 3) Configurações:
	function camera_change_click(camera){
		var cameraNew;
		if(camera=="1"){ cameraNew="0"; }
		if(camera=="0"){ cameraNew="1"; }
		root["camera_cache"] = cameraNew;
		cr_camerarollStart(1,cameraNew);
	};
}
// ==============================================
// CAMERA ROLL: FECHAR
// ==============================================
function exitCameraRoll(){
	root["video"].attachCamera(null);
	Tweener.addTween(cameraroll, {alpha:0, time: 1,transition: "easeOutExpo",delay: 0, onComplete:some});
	function some(){
		destroir(cameraroll,true);
		cameraroll.alpha=1;
	};
}