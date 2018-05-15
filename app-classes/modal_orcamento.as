if(tipo[0]=="orcamento"){
	
	// # Ícone:
	criaIcon("modal_confirma_icone",root[nome].conteudo,blast.list.server.server_path+"/com/icones/"+tipo[2],(365/2)-35,110,70,"bullet",["0xffffff","0x"+coricon],["alpha","easeOutExpo",1]);
	
	// # Título e Texto:
	root["modal_titulo"] = new Titulo_Modal();
	root["modal_titulo"].y= root["modal_confirma_icone"].y + root["modal_confirma_icone"].height + 10;
	root["modal_titulo"].titulo.htmlText="<font color='#"+corbt1+"'>"+titulo+"</font>"
	root["modal_titulo"].texto.y+=20;
	root["modal_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER;
	texto = "<font color='#"+cortexto+"'>"+texto+"</font>";
	observacao = "<font color='#"+corbt1+"'>"+tipo[3]+"</font>";
	root["modal_titulo"].texto.htmlText=texto+"<br><br>"+observacao;
	root["modal_titulo"].texto.selectable = true;
	root[nome].conteudo.addChild(root["modal_titulo"]);
	
	// # Seleções: Demostração:
	posy = root["modal_titulo"].y+root["modal_titulo"].height; 
	for(i=0; i<(tipo[1].length); i++){
		criaInput("select_demo_"+tipo[1][i][0], tipo[1][i][1], root[nome].conteudo, 53, posy, .85, "0xedfffc", "0x66ac9f", 50, false,"G");
		desativaInputView(root["select_demo_"+tipo[1][i][0]]);
		posy += (root["select_demo_"+tipo[1][i][0]].height+5);
	};
	
	// # Caixa de Orçamento:
};