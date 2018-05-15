// ====================================================
// ATIVAÇÃO: #1) SUAS INFORMAÇÕES
// ====================================================
root["ativacao_suas_informacoes"] = function(){
	// -------------------
	// Variáveis Iniciais:
	var posy = 0;
	root["atv_retorno"].visible=true;
	// --------------------
	// Título:
	criaTitulo("atv_titulo",root["ativacao_conteudo"],0,posy,"Dados Pessoais","Conte um pouco sobre você:");
	posy += root["atv_titulo"].y+root["atv_titulo"].height+10
	// ---------------------
	// Tipo de Usuário:
	criaCheckBox("atv_pf",45,posy,root["ativacao_conteudo"],[["Pessoa Física","1"]],corbt1,atv_tipo)
	criaCheckBox("atv_pj",180,posy,root["ativacao_conteudo"],[["Pessoa Jurídica","0"]],corbt1,atv_tipo)
	function atv_tipo(alvo){
		destroir(root["atv_conteudo"],false);
		if(alvo.name=="atv_pf"){
			root["atv_pf1"].changeStatus(true);
			root["atv_pj1"].changeStatus(false);
			atv_pf_form();
		}else{
			root["atv_pf1"].changeStatus(false);
			root["atv_pj1"].changeStatus(true);
			atv_pj_form();
		};
	};
	// ---------------------
	// Conteúdo:
	posy += 60;
	root["atv_conteudo"] = new Vazio();
	root["atv_conteudo"].y = posy;
	root["ativacao_conteudo"].addChild(root["atv_conteudo"]);
	// ---------------------
	// Conteúdo: Formulário Pessoa Física
	function atv_pf_form(){
		criaInput("ativa_nome", "Nome Completo", root["atv_conteudo"], 35, 0, .95, "0xFFFFFF", "0x"+cortexto, 100, false,"G");
		criaInput("ativa_cpf_cnpj", "CPF", root["atv_conteudo"], 35, "ativa_nome", .95, "0xFFFFFF", "0x"+cortexto, 18, false,"G");	
		criaInput("ativa_celular", "Celular", root["atv_conteudo"], 35, "ativa_cpf_cnpj", .95, "0xFFFFFF", "0x"+cortexto, 12, false,"G");	
		
		posy = root["ativa_celular"].y+root["ativa_celular"].height+20;
		criaTitulo("atv_acesso",root["atv_conteudo"],0,posy,"Acesso","Informe o seu email e defina uma senha segura:");
		criaInput("ativa_email", "Email", root["atv_conteudo"], 35, "atv_acesso", .95, "0xFFFFFF", "0x"+cortexto, 18, false,"G");	
		criaInput("ativa_senha", "Nova Senha", root["atv_conteudo"], 35, "ativa_email", .95, "0xFFFFFF", "0x"+cortexto, 12, true,"P");
		criaInput("ativa_senhaConfirma", "Repetir Senha", root["atv_conteudo"], 190, "ativa_email", .95, "0xFFFFFF", "0x"+cortexto, 12, true,"P");
		
		posy = root["ativa_senhaConfirma"].y+root["ativa_senhaConfirma"].height+20;
		criaTitulo("atv_imagem",root["atv_conteudo"],0,posy,"Documento","Para validação dos seus dados pessoa do RG:");
		
		root["ativa_nome"].labelShow(corbt1);
		root["ativa_cpf_cnpj"].labelShow(corbt1);
		root["ativa_celular"].labelShow(corbt1);
		root["ativa_email"].labelShow(corbt1);
		root["ativa_cpf_cnpj"].texto.restrict = "0-9";
		root["ativa_celular"].texto.restrict = "0-9";
		/*
		root["ativa_nome"].setText(root["User"]['nome']);
		root["ativa_cpf_cnpj"].setText(root["User"]['cpf_cnpj']);
		root["ativa_celular"].setText(root["User"]['celular']);
		*/
	};
	atv_pf_form();
	// ---------------------
	// Conteúdo: Formulário Pessoa Jurídica
	function atv_pj_form(){
		criaInput("ativa_nome", "Razão Social", root["atv_conteudo"], 35, 0, .95, "0xFFFFFF", "0x"+cortexto, 100, false,"G");
		criaInput("ativa_cpf_cnpj", "CNPJ", root["atv_conteudo"], 35, "ativa_nome", .95, "0xFFFFFF", "0x"+cortexto, 18, false,"G");	
		criaInput("ativa_celular", "Celular", root["atv_conteudo"], 35, "ativa_cpf_cnpj", .95, "0xFFFFFF", "0x"+cortexto, 12, false,"G");	
		criaInput("ativa_email", "Email", root["atv_conteudo"], 35, "ativa_celular", .95, "0xFFFFFF", "0x"+cortexto, 18, false,"G");	
		criaInput("ativa_senha", "Nova Senha", root["atv_conteudo"], 35, "ativa_email", .95, "0xFFFFFF", "0x"+cortexto, 12, true,"P");
		criaInput("ativa_senhaConfirma", "Repetir Senha", root["atv_conteudo"], 190, "ativa_email", .95, "0xFFFFFF", "0x"+cortexto, 12, true,"P");
		root["ativa_nome"].labelShow(corbt1);
		root["ativa_cpf_cnpj"].labelShow(corbt1);
		root["ativa_celular"].labelShow(corbt1);
		root["ativa_email"].labelShow(corbt1);
		root["ativa_cpf_cnpj"].texto.restrict = "0-9";
		root["ativa_celular"].texto.restrict = "0-9";
		/*
		root["ativa_nome"].setText(root["User"]['nome']);
		root["ativa_cpf_cnpj"].setText(root["User"]['cpf_cnpj']);
		root["ativa_celular"].setText(root["User"]['celular']);
		*/
	};
	
	/*
	// -> Mude a sua Senha:
	root["ativa_txt_mudeasenha"] = new Titulo();
	root["ativa_txt_mudeasenha"].y=root["ativa_celular"].y+root["ativa_celular"].height+20;
	root["ativa_txt_mudeasenha"].titulo.htmlText = "<font color='#"+corbt1+"'>Defina sua nova Senha</font>";
	root["ativa_txt_mudeasenha"].texto.autoSize = TextFieldAutoSize.CENTER;
	root["ativa_txt_mudeasenha"].texto.htmlText = "<font color='#"+cortexto+"'>Por medidas de segurança é necessário que<br>você defina uma nova senha de acesso:</font>"
	root["ativacao_conteudo"].addChild(root["ativa_txt_mudeasenha"]);
	
	// -> Confirmação:
	criaBt("ativacao_etapa1_ok","Ok! Próximo Passo (2/3)",root["ativacao_conteudo"],35,"ativa_senhaConfirma",.95,"0x"+corbt1,"G");
	Tweener.addTween(root["ativacao_etapa1_ok"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay:0});
	criaIcon("ativacao_etapa1_ok_icon",root["ativacao_etapa1_ok"],servidor+"com/icones/right-chevron.png",270,15,27,"normal",["0xffffff",null],["alpha","easeOutExpo",1]);			
	root["ativacao_etapa1_ok"].addEventListener(MouseEvent.CLICK, function(){ativacao_etapa1_confirma();});
	root["ativacao_etapa1_ok"].buttonMode = true;
	function ativacao_etapa1_confirma(){
		
	}
	*/
};