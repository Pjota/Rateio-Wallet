//-----------------------------------------------------------------
// ANDROID: Deslizar Stage / softKeyboardBehavior = pan (Fix Bug)
//-----------------------------------------------------------------
function Android_MovieStage(alvo,modo){
	if(modo==true){
		trace("movimenta")
		var alvoY = alvo.y
		if(alvoY>290){
			var tecladoAndroid = (ScreenSizeH2/100)*37;
			var mascara = ScreenSizeH2-tecladoAndroid;
			var posAlvo = -(ScreenSizeH2-mascara);
			trace("posAlvo: "+posAlvo)
			Tweener.addTween(main, {y:posAlvo, time: .4,transition: "easeOutExpo",delay: .5});
		}
	}else{
		Tweener.addTween(main, {y:0, time: .4,transition: "easeOutExpo",delay: .5});
	};
	/*
	if(modo==true){
		var topStage:Point = alvo.localToGlobal(new Point(0, 0));
		var top = topStage.y-MovieClip(root).y
		var local = ((top*-1)+300)
		if(local>0){local=0}
		Tweener.addTween(MovieClip(root), {y:local, time: .4,transition: "easeOutExpo",delay: .5});
	}else{
		Tweener.addTween(MovieClip(root), {y:0, time: .4,transition: "easeOutExpo",delay: .5});
	}
	*/
}
//-----------------------------------------------------------------
// ANDROID: Ativa deslizamento de STAGE para caixa de textos
//-----------------------------------------------------------------
function Android_MovieStage_add(caixa_de_texto){
	trace("Adiconou Android")
	if(MovieClip(root).dispositivo=="android"){
		trace("Android")
		caixa_de_texto.addEventListener(FocusEvent.FOCUS_IN, addFocus);
		caixa_de_texto.addEventListener(FocusEvent.FOCUS_OUT, removeFocus);
		function addFocus(e:FocusEvent) {
			trace("focus IN")
			Android_MovieStage(caixa_de_texto,true);
		};
		function removeFocus(e:FocusEvent) {
			trace("focus OUT")
			Android_MovieStage(caixa_de_texto,false);
		};
	}
}