var n;
var infos;
var dados;

buttonMode=true;
addEventListener(MouseEvent.MOUSE_DOWN, clickDOWN);
addEventListener(MouseEvent.MOUSE_UP, clickUP);

function clickDOWN(e:MouseEvent):void {
	MovieClip(root).swipeMouse = MovieClip(root).mouseY;
}
function clickUP(e:MouseEvent):void {
	var diferenca;
	diferenca = (MovieClip(root).mouseY-MovieClip(root).swipeMouse);
	if(diferenca>=-10 && diferenca<=10){
		MovieClip(root).Combobox_fechar(dados,n,infos);
	}
}