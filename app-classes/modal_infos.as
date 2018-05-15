if(tipo[0]=="modal_infos"){
	// # Título e Texto:
	root["modal_titulo"] = new Titulo_Modal();
	root["modal_titulo"].y = 45; 
	if(titulo.indexOf("</font>")>0){
		titulo = titulo;
	}else{
		titulo = "<font color='#"+cortexto+"'>"+titulo+"</font>";
	}
	root["modal_titulo"].titulo.htmlText="<font color='#"+corbt1+"'>"+titulo+"</font>";
	root["modal_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER;
	if(texto.indexOf("</font>")>0){
		texto = texto;
	}else{
		texto = "<font color='#"+cortexto+"'>"+texto+"</font>";
	}
	root["modal_titulo"].texto.htmlText=texto;
	root["modal_titulo"].texto.selectable = true;
	root[nome].conteudo.addChild(root["modal_titulo"]);
	root[nome].posymax+=root["modal_titulo"].y+root["modal_titulo"].height+15;
	var posMy = [60,root["modal_titulo"].y+root["modal_titulo"].height+15];
	for(i=0; i<tipo[1].length; i++){
		count++;
		posMy[0] = 55+(135*(count-1));
		criaLabel("modal_labelTxt"+(i+1),tipo[1][i][0],tipo[1][i][1],root[nome].conteudo,posMy[0],posMy[1],1,tipo[1][i][2],tipo[1][i][3],"M");
		if(count==2){
			posMy[1]+=(60)
			root[nome].posymax+=60;
			count=0;
		}
	}
	root[nome].posymax+=20
	/*
	criaBt("confirmAlertbt",tipo[1],root[nome].conteudo,120,"modal_titulo",.9,"0x"+tipo[2],"0xffffff","M");
	root["confirmAlertbt"].addEventListener(MouseEvent.CLICK, confirmAlertbtClick);
	root["confirmAlertbt"].buttonMode = true;
	function confirmAlertbtClick(){
		modal_fechar(nome);
		callback();
	};
	*/
};