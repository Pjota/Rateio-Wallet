//-----------------------------------------------------------------
// STRING: LABEL
//-----------------------------------------------------------------
function criaLabel(nome,campo,texto,local,posx,posy,scala,cor,cortxt,tipo){
	if(tipo=="G"){ root[nome] = new Label_G();}
	if(tipo=="M"){ root[nome] = new Label_M();}
	if(tipo=="P"){ root[nome] = new Label_P();}
	root[nome].name = nome;
	root[nome].x = posx;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].texto.text=texto;
	root[nome].campo.text=campo;
	root[nome].valor = texto;
	root[nome].scaleX = root[nome].scaleY = scala;
	trace("0x"+cortxt)
	Tweener.addTween(root[nome].fundo, {_color:"0x"+cor,time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].texto, {_color:"0x"+cortxt,time: 0,transition: "linear",delay: 0});
	local.addChild(root[nome]);
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
}