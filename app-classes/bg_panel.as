//-----------------------------------------------------------------
// BG PANEL - Cria Imagem panel do Background
//-----------------------------------------------------------------
// [ VARIÁVEIS ]
// + nome				"Nome"
// + local				Local onde será aplicado
// + tipo  				(fixo,galeria)
// + configs			[fade_forcado,cor,altura]
// + loop_infinity  	(true,false)
// + infos				Infos [object JSON]
// + bgPrint			(true,false)
// + extras				func = Variáveis extras para componentes
function bg_Panel(nome,local,tipo,configs,loop_infinity,infos,bgPrint,extras){
	// -----------------------------------------
	// Variáveis Iniciais:
	root["bgPanel_img"]
	root["bgPanel_total"] = infos.length;
	root["bgPanel_count"] = 0;
	root["bgPanel_posts"] = 1;
	root["bgPanel_Infos"] = infos;
	root["bgPanel_Func"] = extras;
	// -----------------------------------------
	// Cria objeto que recebe a galeria ou foto:
	root["bgPanel_mv"] = new Vazio();
	local.addChild(root["bgPanel_mv"]);
	// ---------------------------------
	// Carregamento de Imagem:
	var carregandoMV = new carregando();
	carregandoMV.fundo.visible=false;
	carregandoMV.scaleX = carregandoMV.scaleY = scalaFixa; 
	carregandoMV.x = ScreenSizeW2/2;
	carregandoMV.y = ScreenSizeH2/2;
	Tweener.addTween(carregandoMV, {_color:"0x"+corbt1,time: 0,transition: "linear",delay: 0});
	carregandoMV.alpha = 0;
	root["bgPanel_mv"].addChild(carregandoMV);
	if(tipo=="fixo"){
		carregandoMV.alpha = 1;
		img_load("fotoPanel",infos,root["bgPanel_mv"],["width",ScreenSizeW,"resize"],null,[0,0,"left"],[],0,someloading);
		function someloading(){
			carregandoMV.alpha = 0;
			if(extras!=null){extras[0]()};
		};
	}else{
		// Carrega: FOTO 1
		carregandoMV.alpha = 1;
		root["bgPanel_post"+root["bgPanel_posts"]] = new Vazio();
		trace("Foto: "+infos[root["bgPanel_count"]].foto)
		root["bgPanel_img"] = infos[root["bgPanel_count"]].foto;
		img_load("fotoPanel"+root["bgPanel_posts"],blast.list.server.upload_path+"/"+root["bgPanel_img"],root["bgPanel_post"+root["bgPanel_posts"]],["width",ScreenSizeW,"resize"],null,[0,0,"left"],[],0,nextSecond);
		root["bgPanel_mv"].addChild(root["bgPanel_post"+root["bgPanel_posts"]]);
		root["bgPanel_post"+root["bgPanel_posts"]].infos = infos;
		root["bgPanel_post"+root["bgPanel_posts"]].addEventListener( MouseEvent.MOUSE_DOWN, bgPanel_PostStartDrag);
		root["bgPanel_post"+root["bgPanel_posts"]].addEventListener( MouseEvent.MOUSE_UP, bgPanel_PostStopDrag);
		root["bgPanel_post"+root["bgPanel_posts"]].addEventListener( Event.MOUSE_LEAVE, bgPanel_PostLeaveDrag);
		root["bgPanel_Func"](infos[root["bgPanel_count"]])
		// Carrega: FOTO 2
		function nextSecond(){ bg_Panel_loadNextImage(); carregandoMV.alpha = 0; }
	};
	// ---------------------------------
	// Configurações:
	if(tipo!="fixo"){
		if(configs[0]==true){
			var fadeForcado = new fade_forcado();
			fadeForcado.width = ScreenSizeW2;
			fadeForcado.height = configs[2];
			fadeForcado.y = ScreenSizeH2+fadeForcado.height;
			fadeForcado.alpha=0;
			Tweener.addTween(fadeForcado, {alpha:.9, y:ScreenSizeH2, time: 1,transition: "easeOutExpo",delay:0});
			Tweener.addTween(fadeForcado, {_color:"0xffffff", time: 0,transition: "easeOutExpo",delay:0});
			local.addChild(fadeForcado);
		};
		if(bgPrint==true){
			print_bg("0x"+infos[0].id_d_modalidades.cor,2,0);
		};
	};
};

//-----------------------------------------------------------------
// BG PANEL POST - Drag 
//-----------------------------------------------------------------
function bgPanel_PostStartDrag(e:MouseEvent){
	root["bgPanel_postActive"] = e.currentTarget;
	e.currentTarget.posx = e.currentTarget.x;
	var areaSlide = new Rectangle (-(ScreenSizeW2), 0, (ScreenSizeW2*2), 0);
	e.currentTarget.startDrag(false,areaSlide);
	e.currentTarget.addEventListener( MouseEvent.MOUSE_MOVE, bgPanel_PostMoveDrag );
	stage.addEventListener( MouseEvent.MOUSE_UP, bgPanel_PostStopDrag );
}
function bgPanel_PostStopDrag(e:MouseEvent){
	bgPanel_PostStopDragActive(root["bgPanel_postActive"]);
}
function bgPanel_PostLeaveDrag(e:Event){
	bgPanel_PostStopDragActive(root["bgPanel_postActive"]);
}
function bgPanel_PostStopDragActive(alvo){
	alvo.stopDrag();
	stage.removeEventListener( MouseEvent.MOUSE_UP, bgPanel_PostStopDrag );
	alvo.removeEventListener( MouseEvent.MOUSE_MOVE, bgPanel_PostMoveDrag );
	alvo.removeEventListener( Event.MOUSE_LEAVE, bgPanel_PostMoveDrag );
	// Clique simples na imagem:
	if(alvo.x > (alvo.posx-(5*scalaFixa)) && alvo.x < (alvo.posx+(5*scalaFixa))){
		lightbox_open("lightboxperfil",["0x000000",.95],root["bgPanel_img"])
	};
	// Retorna a Foto para o Centro:
	if(alvo.x>-(ScreenSizeW2/3) && alvo.x<(ScreenSizeW2/3)){
		Tweener.addTween(alvo, {x:0, rotation:0, time: .6,transition: "easeOutExpo",delay:0});
	}
	// Foto: ANTERIOR
	if(alvo.x<-(ScreenSizeW2/3)){	bgPanel_dragImage(alvo,"left"); }
	// Foto: PRÓXIMA
	if(alvo.x>(ScreenSizeW2/3)){ bgPanel_dragImage(alvo,"right"); }
}
function bgPanel_PostMoveDrag(e:MouseEvent){
	e.currentTarget.rotation = .02*(e.currentTarget.x);
};
//-----------------------------------------------------------------
// BG PANEL POST - PRÓXIMO 
//-----------------------------------------------------------------
function bg_Panel_loadNextImage(){
	if(root["bgPanel_count"]<(root["bgPanel_total"]-1)){
		root["bgPanel_count"]++;
	}else{
		root["bgPanel_count"]=0;
	}
	root["bgPanel_posts"]++;
	root["bgPanel_post"+root["bgPanel_posts"]] = new Vazio();
	root["bgPanel_mv"].addChild(root["bgPanel_post"+root["bgPanel_posts"]]);
	root["bgPanel_mv"].setChildIndex( root["bgPanel_post"+root["bgPanel_posts"]],0);
	root["bgPanel_img_Cache"] = root["bgPanel_Infos"][root["bgPanel_count"]].foto;
	img_load("fotoPanel"+root["bgPanel_posts"],blast.list.server.upload_path+"/"+root["bgPanel_img_Cache"],root["bgPanel_post"+root["bgPanel_posts"]],["width",ScreenSizeW2,"resize"],null,[0,0,"left"],[],0,null);
	root["bgPanel_post"+root["bgPanel_posts"]].addEventListener( MouseEvent.MOUSE_DOWN, bgPanel_PostStartDrag );
	root["bgPanel_post"+root["bgPanel_posts"]].addEventListener( MouseEvent.MOUSE_UP, bgPanel_PostStopDrag );
};
function bgPanel_dragImage(alvo,direcao){
	// Joga Imagem fora:
	if(direcao=="left"){
	Tweener.addTween(alvo, {x:(-400*scalaFixa), alpha:0, time: .6,transition: "easeOutExpo",delay:0, onComplete:removeDragImage});
	};
	if(direcao=="right"){
	Tweener.addTween(alvo, {x:(400*scalaFixa), alpha:0, time: .6,transition: "easeOutExpo",delay:0, onComplete:removeDragImage});
	};
	function removeDragImage(){
		root["bgPanel_mv"].removeChild(root["bgPanel_post"+(root["bgPanel_posts"]-1)]);
		root["bgPanel_Func"](root["bgPanel_Infos"][root["bgPanel_count"]])
		root["bgPanel_img"] = root["bgPanel_img_Cache"]
		bg_Panel_loadNextImage();
	};
};