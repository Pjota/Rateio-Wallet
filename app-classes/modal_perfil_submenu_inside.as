//-----------------------------------------------------------------
// PEFIL SUBMENU - INSIDE
//-----------------------------------------------------------------

include "caurina.as"
var num;
var icone;
var sessao;
var itens;
var submenu;
var fundoover;
var iconeover;
var fundoout;
var iconeout;
var funcClique;

addEventListener(MouseEvent.CLICK, menuClick);
buttonMode=true;
function menuClick(e:MouseEvent):void{
	funcClique(num,sessao,itens);
};
function ativa(){
	Tweener.addTween(fundo, {_color:fundoover, time:  1.2,transition: "easeOutExpo",delay: 0});
	Tweener.addTween(root["submenu"+(num)+"_icone"], {_color:iconeover, time:  1.2,transition: "easeOutExpo",delay: 0});	
};
function desativa(){
	Tweener.addTween(fundo, {_color:fundoout, time: .6,transition: "easeOutExpo",delay: 0});
	Tweener.addTween(root["submenu"+(num)+"_icone"], {_color:iconeout, time: .6,transition: "easeOutExpo",delay: 0});	
};
