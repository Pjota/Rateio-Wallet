if(tipo[0]=="confirmacao"){
	
	// # Ícone:
	criaIcon("modal_confirma_icone",root[nome].conteudo,blast.list.server.server_path+"/com/icones/"+tipo[2],(365/2)-25,35,50,"bullet",["0xffffff","0x"+coricon],["alpha","easeOutExpo",1]);
	
	// # Título e Texto:
	root["modal_titulo"] = new Titulo_Modal();
	root["modal_titulo"].y= root["modal_confirma_icone"].y + root["modal_confirma_icone"].height + 10;
	if(titulo.indexOf("</font>")>0){
		root["modal_titulo"].titulo.htmlText=titulo;
	}else{
		root["modal_titulo"].titulo.htmlText="<font color='#"+corbt1+"'>"+titulo+"</font>";
	};
	root["modal_titulo"].texto.y+=20;
	root["modal_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER;
	if(texto.indexOf("</font>")>0){
		texto = texto;
	}else{
		texto = "<font color='#"+cortexto+"'>"+texto+"</font>";
	}
	if(tipo[3]!=null && tipo[3]!=""){
		if(tipo[3].indexOf("</font>")>0){
			observacao = "<font color='#"+corbt1+"'>"+tipo[3]+"</font>";
		}else{
			observacao = tipo[3];
		};
	}
	
	root["modal_titulo"].texto.htmlText=texto+"<br><br>"+observacao;
	root["modal_titulo"].texto.selectable = true;
	root[nome].conteudo.addChild(root["modal_titulo"]);
	
	// # Seleções: Demostração
	posy = root["modal_titulo"].y+root["modal_titulo"].height+20; 
	for(i=0; i<(tipo[1].length); i++){
		criaInput("select_demo_"+tipo[1][i][0], tipo[1][i][1], root[nome].conteudo, 53, posy, .85, "0xedfffc", "0x"+cortexto, 50, false,"G");
		desativaInputView(root["select_demo_"+tipo[1][i][0]]);
		posy += (root["select_demo_"+tipo[1][i][0]].height+5);
	};
	
	// # Opções:
	// --- Cancel:
	criaIcon("modal_confirma_cancel",root[nome].conteudo,blast.list.server.server_path+"/com/icones/remove-symbol.png",90,posy+5,80,"bullet",["0xffffff","0x"+corcancel],["alpha","easeOutExpo",1]);
	root["modal_confirma_cancel"].addEventListener(MouseEvent.CLICK, function(){modal_fechar(root[nome]);});
	root["modal_confirma_cancel"].buttonMode = true;
	// --- Confirma:
	criaIcon("modal_confirma_ok",root[nome].conteudo,blast.list.server.server_path+"/com/icones/correct-symbol.png",200,posy+5,80,"bullet",["0xffffff","0x"+corbt1],["alpha","easeOutExpo",1]);
	root["modal_confirma_ok"].addEventListener(MouseEvent.CLICK, function(){bt_ok();});
	root["modal_confirma_ok"].buttonMode = true;
	function bt_ok(){
		callback();
		modal_fechar(realnome);
	}
	
};