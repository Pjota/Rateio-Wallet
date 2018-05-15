//-----------------------------------------------------------------
// DRAGBAR - Cria Barra de Drag
//-----------------------------------------------------------------
function criadragBar(nome,texto,infos,local,posx,posy,scala,cor,cortxt,tamanho){
	// ---------------------
	// Variáveis iniciais:
	var myShape = new Shape();
	var porcentagem = 0;
	var calc = 0;
	// ---------------------
	// Monta Dragbar:
	if(tamanho == "G"){ root[nome] = new DragBarG(); }
	if(tamanho == "M"){ root[nome] = new DragBarM(); }
	root[nome].name = nome;
	root[nome].x = posx;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].texto.text=texto;
	root[nome].infos = infos;
	root[nome].btdrag.amostra.alpha=0;
	root[nome].valor = 0;
	Tweener.addTween(root[nome].texto, {_color:cortxt,time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].marca.linha, {_color:"0x"+corbt1,time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].marca.fundo, {_color:"0xffffff",time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].valor_amostra, {_color:"0x"+corbt2,time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].btdrag.esfera.overlay, {_color:"0x"+corbtnormalicone,time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].btdrag.circulo, {_color:"0x"+corbt1,time: 0,transition: "linear",delay: 0});
	
	root[nome].scaleX = root[nome].scaleY = scala;
	local.addChild(root[nome]);
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	// ---------------------
	// Informações iniciais:
	root[nome].btdrag.addEventListener(MouseEvent.MOUSE_DOWN, startDragging, true);
	function startDragging(e:MouseEvent) {
		Tweener.addTween(root[nome].btdrag.amostra, {alpha:1,time: 2,transition: "easeOutExpo",delay: 0});
		root[nome].btdrag.startDrag(false,new Rectangle(root[nome].area.x,root[nome].area.y,root[nome].area.width,root[nome].area.height));
		Tweener.addTween(root[nome].btdrag.esfera, {alpha:1, time: 1,transition: "easeOutExpo",delay: 0});
		root[nome].btdrag.esfera.scaleX = root[nome].btdrag.esfera.scaleY = .5;
		Tweener.addTween(root[nome].btdrag.esfera, {scaleX:1.1, scaleY:1.1, time: 1,transition: "easeOutElastic",delay: 0});
		stage.addEventListener(MouseEvent.MOUSE_UP, stopDragging, true);
		stage.addEventListener(Event.ENTER_FRAME, enterFrame);
	}
	function stopDragging(e:MouseEvent) {
		Tweener.addTween(root[nome].btdrag.amostra, {alpha:0,time: .4,transition: "easeOutExpo",delay: 0});
		root[nome].btdrag.stopDrag();
		Tweener.addTween(root[nome].btdrag.esfera, {alpha:0, time: 1,transition: "easeOutExpo",delay: 0});
		Tweener.addTween(root[nome].btdrag.esfera, {scaleX:1, scaleY:1, time: 1,transition: "easeOutExpo",delay: 0});
		stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragging, true);
		stage.removeEventListener(Event.ENTER_FRAME, enterFrame);
	}
	function enterFrame(e:Event):void{
	   traca();
	};
	function traca(){
		if(infos[0]=="left"){
			porcentagem = Math.ceil((root[nome].btdrag.x-root[nome].area.x)/(root[nome].area.width/100));
			root[nome].btdrag.amostra.texto.text = calc;
			while(root[nome].linha.numChildren > 0) {
				root[nome].linha.removeChildAt(0);
			};
			myShape = new Shape(); 
			myShape.graphics.lineStyle(5, "0x"+corbtcliqueicone, 1);
			myShape.graphics.beginFill("0x"+corbtcliqueicone);
			myShape.graphics.moveTo(root[nome].btdrag.x, root[nome].area.y); 
			myShape.graphics.lineTo(root[nome].marca.x, root[nome].area.y);
			root[nome].linha.addChild(myShape);
			if(infos[4]=="int"){
				calc = Number(infos[1])+Number(Math.round(((infos[2]-infos[1])/100)*porcentagem));
			};
			if(infos[4]=="decimal"){
				calc = ajustaDecimal(Number(infos[1])+Number(((infos[2]-infos[1])/100)*porcentagem),2);
			};
			root[nome].valor_amostra.text = calc+" "+infos[5];
			root[nome].valor = calc;
		}
	};
	root[nome].setDrag = function setdragBar(alvo,valor){
		//var alvox = (alvo.area.width/100)*((valor/(alvo.infos[2]))*100);
		var porcentagem = (valor-alvo.infos[1])/((alvo.infos[2]-alvo.infos[1])/100);
		var alvox = (alvo.area.width/100)*porcentagem;
		alvo.btdrag.x = alvo.area.x+alvox;
		traca();
	}
	root[nome].btdrag.x=root[nome].area.x;
	root[nome].btdrag.y=root[nome].area.y;
	traca();
}
