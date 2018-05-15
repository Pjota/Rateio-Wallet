if(tipo[0]=="esquecisenha"){
	
	// 1) Existe mais de um tipo de usuário?
	var ModalEsqueciIconSize = "";
	var tableUser = "";
	if(blast.list[app].pages.login['table'].length>1){
		ModalEsqueciIconSize = 20;
	}else{
		ModalEsqueciIconSize = 80;
	}
	tableUser = blast.list[app].pages.login['table'][0];
	
	// # Ícone de Proteção
	criaIcon("modal_esquecisenha_", root[nome].conteudo, blast.list[app].paths.icon_master_path+"/lock.png",(365/2)-(ModalEsqueciIconSize/2),50,ModalEsqueciIconSize,"normal",["0x"+corbt2,"0x"+corbt2],["alpha","easeOutExpo",1]);
	
	// # Título e Texto:
	root["modal_esquecisenha"] = new Titulo_Modal();
	root["modal_esquecisenha"].y = 60+ModalEsqueciIconSize; 
	root["modal_esquecisenha"].titulo.htmlText="<font color='#"+corbt1+"'>"+titulo+"</font>";
	root["modal_esquecisenha"].texto.autoSize =  TextFieldAutoSize.CENTER;
	texto = "<font color='#"+cortexto+"'>"+texto+"</font>";
	root["modal_esquecisenha"].texto.htmlText=texto;
	root["modal_esquecisenha"].texto.selectable = true;
	root[nome].conteudo.addChild(root["modal_esquecisenha"]);
	
	// # Input Email
	criaInput("modal_esquecisenha_email", "Email de Cadastro", root[nome].conteudo, 70, "modal_esquecisenha", .95, "0xFFFFFF", "0x"+cortexto, 60, false,"M");
	if(root["loginInput"].texto.text!="Email"){
		root["modal_esquecisenha_email"].setText(root["loginInput"].texto.text);
	};
	
	// # VÁRIOS TIPOS DE USUÁRIO?
	var proximoCampo;
	var tipoinput = false;
	var tipoUsuario = "";
	if(blast.list[app].pages.login['table'].length>1 && (blast.list[app].pages.login.tipo_selecao!=false)){
		tipoinput = true;
		function montaObjetoTiposModalEsqueci(){
			var combo:Object = new Object();
			combo.list = [];
			var item:Object = new Object();
			for(var i=0; i<blast.list[app].pages.login['table'].length; i++){
				item = {id:blast.list[app].pages.login['table'][i], nome: blast.list[app].pages.login['tipo_selecao'][i]}
				combo.list[i];
				combo.list[i] = item;
			}
			var_dump(combo);
			return combo;
		}
		
		var posyModalEsqueci = root["modal_esquecisenha_email"].y+root["modal_esquecisenha_email"].height+10;
		var combosModalEsqueci:Object = [
			["Tipo","tipoInputEsqueci","combobox","","edit","required",[]]
		];
		
		var alvoModalEsqueci = combosModalEsqueci[0][0];
		var nome1ModalEsqueci = "";
		var nome2ModalEsqueci = combosModalEsqueci[0][1];
		var tituloModalEsqueci = "Tipo de Usuário:";
		var localModalEsqueci = root[nome].conteudo;
		var posxModalEsqueci = 103;
		var escalaModalEsqueci = .95;
		var tipoModalEsqueci = "objeto"
		var buscaModalEsqueci = "";
		var buscaaddModalEsqueci = "";
		var dependenciaModalEsqueci = "";
		var coresModalEsqueci = ["0xffffff","0x"+cortexto];
		var camposModalEsqueci = combosModalEsqueci;
		criaComboboxP(alvoModalEsqueci,nome1ModalEsqueci,nome2ModalEsqueci,tituloModalEsqueci,localModalEsqueci,posxModalEsqueci,posyModalEsqueci,escalaModalEsqueci,tipoModalEsqueci,buscaModalEsqueci,buscaaddModalEsqueci,dependenciaModalEsqueci,coresModalEsqueci,camposModalEsqueci,montaObjetoTiposModalEsqueci,null);
		proximoCampo = nome1ModalEsqueci+nome2ModalEsqueci;
		
		// # AUTOCOMPLETE: TIPO
		root["tipoInputEsqueci"].texto.text = root["tipoInput"].texto.text+""
		root["tipoInputEsqueci"].valor = root["tipoInput"].valor+"";
	
	}else{
		proximoCampo = "modal_esquecisenha_email";
		tipoinput = false;
	}
	
	// # Enviar
	criaBt("modal_esquecisenha_enviar","Enviar",root[nome].conteudo,120,proximoCampo,.9,"0x"+corbt1,"M");
	root["modal_esquecisenha_enviar"].addEventListener(MouseEvent.CLICK, modal_esquecisenha_enviar_click);
	root["modal_esquecisenha_enviar"].buttonMode = true;
	function modal_esquecisenha_enviar_click(){
		var ativo = false;
		if(root["modal_esquecisenha_email"].texto.text!="Email" && root["modal_esquecisenha_email"].texto.text.indexOf("@")>-1){
			if(tipoinput == true){
				if(root["tipoInputEsqueci"].texto.text!="Selecione..."){
					ativo = true;
					tipoUsuario = root["tipoInputEsqueci"].valor;
					tableUser = root["tipoInputEsqueci"].valor;
				}else{
					newbalaoInfo(root[nome].conteudo,'Selecione o seu tipo de acesso.',(root["modal_esquecisenha_enviar"].x+(root["modal_esquecisenha_enviar"].width/2)),(root["modal_esquecisenha_enviar"].y+40),"BalaoInfo","0x"+corcancel);
				}
			}else{
				tipoUsuario = "usuarios";
				tableUser = blast.list.usuarios['table'][0];
				ativo = true;
			}
		}else{
			newbalaoInfo(root[nome].conteudo,'Informe o seu email de cadastro.',(root["modal_esquecisenha_enviar"].x+(root["modal_esquecisenha_enviar"].width/2)),(root["modal_esquecisenha_enviar"].y+40),"BalaoInfo","0x"+corcancel);
		}
		if(ativo == true){
			// ------------------
			// Cria o Carregando:
			root["modal_esquecisenha_enviar_load"] = new carregando();
			root["modal_esquecisenha_enviar_load"].fundo.visible=false;
			root["modal_esquecisenha_enviar_load"].scaleX = root["modal_esquecisenha_enviar_load"].scaleY = .6; 
			root["modal_esquecisenha_enviar_load"].x = root["modal_esquecisenha_enviar"].x+(root["modal_esquecisenha_enviar"].width/2)
			root["modal_esquecisenha_enviar_load"].y = root["modal_esquecisenha_enviar"].y+(root["modal_esquecisenha_enviar"].height/2)
			root[nome].conteudo.addChild(root["modal_esquecisenha_enviar_load"]);
			Tweener.addTween(root["modal_esquecisenha_enviar_load"], {_color:"0x"+corbt1,time: 0,transition: "linear",delay: 0});
			// ------------------
			// Desativa Opções:
			root[nome+"_fechar"].visible=false;
			desativaInput(root["modal_esquecisenha_email"]);
			root["modal_esquecisenha_enviar"].removeEventListener(MouseEvent.CLICK, modal_esquecisenha_enviar_click);
			root["modal_esquecisenha_enviar"].visible=false;
			if(tipoinput == true){root["tipoInputEsqueci"].visible=false;}
			// ------------------
			// Faz o Envio:
			connectServer(false,"screen",servidor+"api/recupera_senha",[
			["email",root["modal_esquecisenha_email"].getValue(),"texto"],
			["table",tableUser,"texto"],
			["template_email",email_template,"texto"]
			],modal_esquecisenha_start);
			function modal_esquecisenha_start(dados){
				trace("Table User: "+tableUser)
				trace(root["modal_esquecisenha_email"].getValue());
				
				if(dados.list.retorno=="email"){
					root[nome].conteudo.removeChild(root["modal_esquecisenha_enviar_load"]);
					root[nome+"_fechar"].visible=true;
					ativaInput(root["modal_esquecisenha_email"]);
					root["modal_esquecisenha_enviar"].addEventListener(MouseEvent.CLICK, modal_esquecisenha_enviar_click);
					root["modal_esquecisenha_enviar"].visible=true;
					if(tipoinput == true){root["tipoInputEsqueci"].visible=true;}
					newbalaoInfo(root[nome].conteudo,'Falha ao enviar o email. Tente mais tarde.',(root["modal_esquecisenha_enviar"].x+(root["modal_esquecisenha_enviar"].width/2)),(root["modal_esquecisenha_enviar"].y+40),"BalaoInfo","0x"+corcancel);
				}
				if(dados.list.retorno=="ok"){
					root[nome].conteudo.removeChild(root["modal_esquecisenha_enviar_load"]);
					root[nome+"_fechar"].visible=true;
					criaIcon("modal_esquecisenha_iconeok", root[nome].conteudo, blast.list.server.server_path+"/com/icones/006-thumbs-up.png",(365/2)-(60/2),root["modal_esquecisenha_enviar"].y-10,60,"normal",["0x"+corbt2,"0x"+corbt2],["alpha","easeOutExpo",1]);
					root["modal_esquecisenha_email"].texto.text = "Email enviado!";
					newbalaoInfo(root[nome].conteudo,'Email enviado com Sucesso!',(root["modal_esquecisenha_enviar"].x+(root["modal_esquecisenha_enviar"].width/2)),(root["modal_esquecisenha_enviar"].y),"BalaoInfo","0x"+corbt1);
				}
				
			}			
		}
	};
	
	
};