if(tipo[0]=="confirmacaoAlert"){
	// # Título e Texto:
	root["modal_titulo"] = new Titulo_Modal();
	root["modal_titulo"].y = 40; 
	root["modal_titulo"].titulo.htmlText="<font color='#"+corbt1+"'>"+titulo+"</font>";
	root["modal_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER;
	texto = "<font color='#"+cortexto+"'>"+texto+"</font>";
	root["modal_titulo"].texto.htmlText=texto;
	root["modal_titulo"].texto.selectable = true;
	root[nome].conteudo.addChild(root["modal_titulo"]);
	// 
	if(tipo[5] && tipo[5]=="senha"){
		root["CachePass2"] = "";
		criaInput("confirmacaoAlert_Senha", "Senha", root[nome].conteudo, 63, "modal_titulo", .90, "0xffffff", "0x202020", 20, true,"P");
		criaBt("confirmAlertbt",tipo[1],root[nome].conteudo,210,"modal_titulo",.9,"0x"+tipo[2],"P");
		root["confirmAlertbt"].texto.height = 10;
		root["confirmAlertbt"].texto.htmlText = "<font color='#ffffff' size='19'>"+tipo[1]+"</font>";
		ajustText(root["confirmAlertbt"].texto,root["confirmAlertbt"].fundo,"V")
	}else{
		criaBt("confirmAlertbt",tipo[1],root[nome].conteudo,(365/2)-((139*tipo[3])/2),"modal_titulo",.9,"0x"+tipo[2],"M");
	};
	
	root["confirmAlertbt"].addEventListener(MouseEvent.CLICK, confirmAlertbtClick);
	root["confirmAlertbt"].scaleX = root["confirmAlertbt"].scaleY = tipo[3]
	root["confirmAlertbt"].buttonMode = true;
	function confirmAlertbtClick(){
		if(tipo[5] && tipo[5]=="senha"){
			if(root["UserPass"]==root["CachePass2"]){
				tipo[4]();
				modal_fechar(realnome);
			}else{
				newbalaoInfo(root[nome].conteudo,'Senha Incorreta. Tente novamente.',(root["confirmacaoAlert_Senha"].x+(root["confirmacaoAlert_Senha"].width/2)),(root["confirmacaoAlert_Senha"].y+30),"BalaoInfo","0x"+corcancel);
			}
		}else{
			tipo[4]();
			modal_fechar(realnome);
		}
		
	};
};