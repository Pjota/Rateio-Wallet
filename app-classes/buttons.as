//-----------------------------------------------------------------
// BOTÕES: Várias Cores e Formatos + Ícone
//-----------------------------------------------------------------
function criaBt(nome,texto,local,posx,posy,scala,cor,tamanho){
	if(tamanho == "G"){ root[nome] = new BotaoG(); }
	if(tamanho == "MM"){ root[nome] = new BotaoMM(); }
	if(tamanho == "M"){ root[nome] = new BotaoM(); }
	if(tamanho == "P"){ root[nome] = new BotaoP(); }
	root[nome].name = nome;
	root[nome].x = posx;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].texto.text=texto;
	Tweener.addTween(root[nome].fundo.conteudo, {_color:cor,time: 0,transition: "linear",delay: 0});
	var cortxt;
	if(detectaCor(root[nome].fundo)=="escuro"){ cortxt="0xffffff"; }else{ cortxt="0x"+cortexto; }
	Tweener.addTween(root[nome].texto, {_color:cortxt,time: 0,transition: "linear",delay: 0});
	root[nome].scaleX = root[nome].scaleY = scala;
	local.addChild(root[nome]);
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
};
function criaBtTxt(nome,texto,local,posx,posy,scala,cor,cortxt){
	root[nome] = new BotaoTxt();
	root[nome].name = nome;
	root[nome].x = posx;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].texto.text=texto;
	Tweener.addTween(root[nome].texto, {_color:cortxt,time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].fundo.conteudo, {_color:cor,time: 0,transition: "linear",delay: 0});
	root[nome].scaleX = root[nome].scaleY = scala;
	local.addChild(root[nome]);
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
}
//-----------------------------------------------------------------
// BOTÕES ESPECIAIS:
//-----------------------------------------------------------------
// Botão de Destaque (com opção de mudança de cor)
function criaBtDestaque(nome,titulo,texto,local,posx,posy,scala,cores){
	root[nome] = new Botao_Destaque();
	root[nome].name = nome;
	root[nome].x = posx;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].textos.titulo.text=titulo;
	root[nome].textos.texto.htmlText=texto;
	root[nome].scaleX = root[nome].scaleY = scala;
	local.addChild(root[nome]);
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
}
function criaBtEspecial(nome,icone,texto,local,posx,posy,scala,cores,pisca){
	root[nome] = new Botao_Especial();
	root[nome].name = nome;
	root[nome].x = posx;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	// Informações
	criaIcon(nome+"_icone",root[nome].textos,icone,0,-12,50,"normal",["0x"+cores[0],"0x"+cores[0]],["alpha","easeOutExpo",0]);
	root[nome].textos.texto.x = 50;
	root[nome].textos.texto.autoSize =  TextFieldAutoSize.LEFT ;
	root[nome].textos.texto.htmlText="<font color='#"+cores[0]+"'>"+texto+"</font>";
	root[nome].textos.x = (root[nome].width/2)-((root[nome].textos.texto.width+50)/2)
	//
	Tweener.addTween(root[nome].fundo, {_color:"0x"+cores[2], time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].relevo, {_color:"0x"+cores[1], alpha:.2, time: 0,transition: "linear",delay: 0});
	root[nome].scaleX = root[nome].scaleY = scala;
	local.addChild(root[nome]);
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	if(pisca==true){
		Tweener.addTween(root[nome].pisca, {_color:"0x"+cores[2], time: 0,transition: "linear",delay: 0});
	}else{
		root[nome].pisca.stop();
		root[nome].pisca.visible=false;
	}
}