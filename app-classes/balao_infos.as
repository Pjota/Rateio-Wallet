function newbalaoInfo(local,texto,posx,posy,tipo,cor){
	if(root['balaoInfo']){
		try {
		Tweener.removeTweens(root['balaoInfo']);
		local.removeChild(root['balaoInfo']);
		root['balaoInfo'] = null;
		}catch(error:Error){}
	}
	var tempo =0;
	if(tipo=="BalaoGrande"){
		tempo = 3;
		root['balaoInfo'] = new BalaoGrande();
	}
	if(tipo=="BalaoInfo"){
		tempo = 1.5;
		root['balaoInfo'] = new BalaoInfo();
	}
	if(tipo=="BalaoPeq"){
		tempo = 1.5;
		root['balaoInfo'] = new BalaoPequeno();
	}
	if(tipo=="BalaoLateralEsq"){
		tempo = 1.5;
		root['balaoInfo'] = new BalaoMicroLateralEsq();
	}
	root['balaoInfo'].name = 'balaoInfo';
	if(posy==0 && posx==0){
		var originalsizeW = (local.width/local.scaleX)
		var originalsizeH = (local.height/local.scaleY)
		root['balaoInfo'].x = originalsizeW/2;
		root['balaoInfo'].y = (originalsizeH/2)+10;
		root['balaoInfo'].posy = (originalsizeH/2);
	}else{
		root['balaoInfo'].x = posx;
		root['balaoInfo'].y = (posy)+10;
		root['balaoInfo'].posy = (posy);
	}
	root['balaoInfo'].alpha=0;
	root['balaoInfo'].texto.htmlText = texto;
	local.addChild(root['balaoInfo']);
	Tweener.addTween(root['balaoInfo'], {alpha:1, time: .6,transition: "easeOutExpo",delay: 0});
	Tweener.addTween(root['balaoInfo'], {y:root['balaoInfo'].posy, time: .6,transition: "easeOutElastic",delay: 0});
	Tweener.addTween(root['balaoInfo'].fundo, {_color: cor, time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root['balaoInfo'], {alpha:0, time: .6,transition: "easeOutExpo",delay: tempo, onComplete:some});
	function some(){
		try {
		local.removeChild(root['balaoInfo'])
		root['balaoInfo'] = null;
		}catch(error:Error){}
	}
};