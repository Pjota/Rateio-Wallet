//--------------------------------------------------------------------
// LIGHTBOX {SINGLE}: Carrega Imagens internas e Externas em caixa de Destaque
//--------------------------------------------------------------------
// userPostInfos: [userData,legenda]
function lightbox_open(nome,overlay,url){
	// Cria clipe Principal:
	root[nome] = new Vazio();
	root[nome].name = nome;
	
	// Cria Fundo do Lightbox:
	var fundo = new Vazio();
	var matrix:Matrix = new Matrix();
	matrix.createGradientBox(ScreenSizeW2, ScreenSizeH2, Math.PI/2, 0, 0); 
	var square:Shape = new Shape; 
	square.graphics.beginGradientFill(
	GradientType.LINEAR, [overlay[0], overlay[0]], 
	[1, 1], [0, 255], matrix, SpreadMethod.PAD,  
	InterpolationMethod.LINEAR_RGB, 0); 
	square.graphics.drawRect(0, 0, ScreenSizeW2, ScreenSizeH2); 
	fundo.addChild(square);
	fundo.alpha=overlay[1];
	root[nome].addChild(fundo);
	
	// Cria Preloader branco para imagem:
	var carregandoImg = new Vazio();
	carregandoImg = new carregando();
	carregandoImg.fundo.visible=false;
	carregandoImg.scaleX = carregandoImg.scaleY = scalaFixa; 
	carregandoImg.x = (ScreenSizeW2/2);
	carregandoImg.y = (ScreenSizeH2/2);
	Tweener.addTween(carregandoImg, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
	root[nome].addChild(carregandoImg);
	
	// ==========================================
	// CARREGA IMAGEM PARA VISUALIZAÇÃO:
	// ==========================================
	var img = new Vazio();
	img_load("imagem",url,img,["scale",1,"scale"],null,[0,0],[],0,lightboxAlign);
	root[nome].addChild(img);
	function lightboxAlign(){
		root[nome].removeChild(carregandoImg);
		img.width = ScreenSizeW2;
		img.scaleY = img.scaleX;
		img.x = (ScreenSizeW2/2)-(img.width/2);
		img.y = (ScreenSizeH2/2)-(img.height/2);
	};
	
	// Fechar
	var fechar = new Botao_Fechar();
	fechar.scaleX = fechar.scaleY = 0;
	fechar.alvo = root[nome];
	fechar.x = (ScreenSizeW2/2);
	fechar.y = 50*scalaFixa;
	fechar.scaleX = fechar.scaleY = 0;
	Tweener.addTween(fechar, {scaleX:scalaFixa, scaleY:scalaFixa, time:.5, transition: "easeOutElastic",delay:0});
	Tweener.addTween(fechar.fundo, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
	Tweener.addTween(fechar.icone, {_color:"0x"+corcancel, time: 0,transition: "linear",delay: 0});
	root[nome].addChild(fechar);
	fechar.addEventListener(MouseEvent.CLICK,lightbox_close);
	fechar.buttonMode = true;
	
	// Carrega Lightbox:
	lightBox.addChild(root[nome]);
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
}

function lightbox_close(e:Event):void {
	var alvo = e.currentTarget.alvo;
	Tweener.addTween(alvo, {alpha:0, time: 1,transition: "easeOutExpo",delay: 0, onComplete:some});
	function some(){
		destroir(lightBox,true);
	};
}
