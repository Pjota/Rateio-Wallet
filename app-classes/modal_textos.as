if(tipo[0]=="texto"){
	root["modal_texto"] = new Titulo_Modal();
	root["modal_texto"].y=40;
	root["modal_texto"].titulo.autoSize =  TextFieldAutoSize.CENTER;
	root["modal_texto"].titulo.htmlText="<font color='#"+corbt1+"'>"+tipo[1]+"</font>"
	root["modal_texto"].texto.y =(root["modal_texto"].titulo.y+root["modal_texto"].titulo.height+10);
	root["modal_texto"].texto.htmlText="<font color='#"+cortexto+"'>"+tipo[2]+"</font>";
	root["modal_texto"].texto.selectable = true;
	root["modal_texto"].texto.height = 520-(root["modal_texto"].titulo.height);
	root[nome].conteudo.addChild(root["modal_texto"]);
};