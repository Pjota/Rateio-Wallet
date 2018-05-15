//-----------------------------------------------------------------
// INPUT: Single Line / Password
//-----------------------------------------------------------------
function criaInput(nome,texto,local,posx,posy,scala,cor,cortxt,maxChars,password,tipo){
	if(tipo=="G"){ root[nome] = new Input();}
	if(tipo=="M"){ root[nome] = new InputM();}
	if(tipo=="P"){ root[nome] = new InputP();}
	root[nome].name = nome;
	root[nome].x = posx;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].gotoAndStop(1);
	root[nome].labeltxt.visible = false;
	root[nome].corinicial = cortxt;
	root[nome].feedback.gotoAndStop(1);
	if(texto.indexOf("$")>=0){ root[nome].gotoAndStop(2); }
	root[nome].texto.maxChars = maxChars;
	root[nome].texto.text=texto;
	root[nome].valor = texto;
	root[nome].scaleX = root[nome].scaleY = scala;
	root[nome].pass = password;
	Tweener.addTween(root[nome].fundo, {_color:cor,time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].texto, {_color:cortxt,time: 0,transition: "linear",delay: 0});
	local.addChild(root[nome]);
	root[nome].addCor();
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	// -----------------------
	// Alternativas de layout
	// # 1) Label sempre presente acima:
	root[nome].labelShow = function(cor){
		root[nome].labeltxt.visible = true;
		root[nome].texto.y = 20;
		root[nome].labeltxt.htmlText = "<font color='#"+cor+"'>"+texto+"</font>";
		root[nome].texto.htmlText = "Digite Aqui";
		root[nome].valor = "Digite Aqui";
	}
	// # 2) Fundo Invisível:
	root[nome].invisivel = function(){
		root[nome].fundo.visible=false;
		root[nome].feedback.visible=false;
		root[nome].relevo.visible=false;
	}
}
function corInput(alvo,cor,duracao){
	Tweener.addTween(alvo.texto, {_color:cor,time:duracao,transition:"easeOutExpo",delay:0});
}
//-----------------------------------------------------------------
// INPUT TEXT AREA
//-----------------------------------------------------------------
function criaInputTxtArea(nome,texto,local,posx,posy,scala,altura,cor,cortxt,maxChars,tipo){
	if(tipo=="G"){ root[nome] = new InputTextG();}
	root[nome].name = nome;
	root[nome].x = posx;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].feedback.gotoAndStop(1);
	root[nome].feedback.visible=false;
	root[nome].labeltxt.visible = false;
	root[nome].corinicial = cortxt;
	root[nome].texto.maxChars = maxChars;
	root[nome].texto.height = altura;
	root[nome].texto.text=texto;
	root[nome].texto.multiline=true;
	root[nome].valor = texto;
	root[nome].scaleX = root[nome].scaleY = scala;
	Tweener.addTween(root[nome].topo, {_color:"0x"+cor,time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].meio, {_color:"0x"+cor,time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].rodape, {_color:"0x"+cor,time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].texto, {_color:"0x"+cortxt,time: 0,transition: "linear",delay: 0});
	local.addChild(root[nome]);
	root[nome].meio.height = altura;
	root[nome].rodape.y = root[nome].meio.y+root[nome].meio.height;
	root[nome].relevo.y = root[nome].rodape.y;
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	//
}