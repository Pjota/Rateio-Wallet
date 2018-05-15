import com.caurina.transitions.*;
import com.caurina.transitions.properties.ColorShortcuts;
ColorShortcuts.init();

var valor;
var area;
var valor2;
var cor;
var funcao:Function;
var ativo = true;

check1.addEventListener(MouseEvent.CLICK, checkfunc);
function checkfunc(e:MouseEvent):void {
	if(ativo==true){
		if(valor==false){
			changeStatus(true)
		}else{
			changeStatus(false)
		}
		funcao(this);
	};
};
function changeStatus(status) {
	if(status==true){
		valor=true;
		valor2="{AGORA}";
		Tweener.addTween(check1.fundo, {_color:"0x"+cor,time: 0,transition: "easeOutExpo",delay: 0});
	}else{
		valor=false;
		valor2="null";
		Tweener.addTween(check1.fundo, {_color:null,time: 0,transition: "easeOutExpo",delay: 0});
	};
};
function checkfuncVisual(valor) {
	if(valor==true){
		Tweener.addTween(check1.fundo, {_color:"0x"+cor,time: 0,transition: "easeOutExpo",delay: 0});
	}else{
		Tweener.addTween(check1.fundo, {_color:null,time: 0,transition: "easeOutExpo",delay: 0});
	};
};
function getValue(){
	return valor;
};
