//-----------------------------------------------------------------
// PÁGINA SEM CONTEÚDO: Mostra ausência de conteúdo em alguma página
//-----------------------------------------------------------------
function semConteudo(nome,titulo,texto,infosy,foto,fotoW,local,posx,posy,botao){
	// --------------------------
	// 1) Cria caixa de conteúdo!
	root[nome] = new Vazio();
	root[nome].name = nome;
	root[nome].x = posx;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	local.addChild(root[nome]);
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	// --------------------------
	// 2) Cria imagem de fundo:
	root[nome+"_img"] = new Vazio();
	root[nome].addChild(root[nome+"_img"]);
	var posxImg = (365-fotoW)/2
	img_load(nome+"_imagem",foto,root[nome+"_img"],["width",fotoW,"resize"],null,[posxImg,0],[],0,null)
	// --------------------------
	// 3) Aplica Título e Texto:
	root[nome+"_infos"] = new Titulo_Modal();
	root[nome+"_infos"].y = infosy;
	root[nome+"_infos"].x = 0;
	root[nome+"_infos"].titulo.htmlText="<font color='#"+cortitulos+"'>"+titulo+"</font>";
	root[nome+"_infos"].texto.htmlText="<font color='#"+cortexto+"'>"+texto+"</font>";
	root[nome+"_infos"].texto.autoSize =  TextFieldAutoSize.CENTER;
	root[nome].addChild(root[nome+"_infos"]);
	// --------------------------
	// 4) Existe algum botão logo após?
	if(botao!=null){
		var posbtY = (root[nome+"_infos"].y+root[nome+"_infos"].height+20);
		criaBt(nome+"_bt",botao[0],root[nome],0,posbtY,1,"0x"+corbt1,"G");
		root[nome+"_bt"].x = (365/2)-(root[nome+"_bt"].width/2)
		root[nome+"_bt"].addEventListener(MouseEvent.CLICK, function(){botao[1]();});
		root[nome+"_bt"].buttonMode = true;
	};
	
};