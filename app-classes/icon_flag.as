function icon_flag_alert(nome,local,posx,posy,scala,corfundo,cortxt,valor,animacao){
	root[nome] = new icon_flag();
	root[nome].name = nome;
	root[nome].x = posx;
	root[nome].y = posy;
	root[nome].texto.htmlText="<font color='#"+cortxt+"'>"+valor+"</font>"
	Tweener.addTween(root[nome].fundo, {_color:"0x"+corfundo,time: 0,transition: "linear",delay: 0});
	root[nome].scaleX = root[nome].scaleY = ((scala*scalaFixa)/3);
	local.addChild(root[nome]);
	Tweener.addTween(root[nome], {scaleX:(scala*scalaFixa),scaleY:(scala*scalaFixa),time: .6,transition: "easeOutElastic",delay: 0});
};