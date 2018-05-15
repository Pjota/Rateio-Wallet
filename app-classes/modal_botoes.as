if(tipo[0]=="botoes"){
	// # Título e Texto:
	root["modal_titulo"] = new Titulo_Modal();
	root["modal_titulo"].y = 40; 
	root["modal_titulo"].titulo.htmlText="<font color='#"+corbt1+"'>"+titulo+"</font>";
	root["modal_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER;
	texto = "<font color='#"+cortexto+"'>"+texto+"</font>";
	root["modal_titulo"].texto.htmlText=texto;
	root["modal_titulo"].texto.selectable = true;
	root[nome].conteudo.addChild(root["modal_titulo"]);
	// # Constroi Botões:
	for(var m=0; m<tipo[1].length; m++){
		trace("Teste: "+root[tipo[1][m][3]])
		criaBt(tipo[1][m][0],tipo[1][m][1],root[nome].conteudo,37+(100*m),110,.7,"0x"+tipo[1][m][2][0],"M");
		root[tipo[1][m][0]].addEventListener(MouseEvent.CLICK, tipo[1][m][3]);
		root[tipo[1][m][0]].buttonMode = true;
	}
};