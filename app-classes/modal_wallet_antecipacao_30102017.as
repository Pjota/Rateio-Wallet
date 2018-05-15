if(tipo[0]=="modal_wallet_antecipacao"){
	
	// Variáveis iniciais:
	var tamvalor;
	var tipoatencipacao = "start";
	var textoTitle = texto;
	trace("Tentativa de Antecipação: "+tipo[1])
	
	// # Título:
	root["modal_titulo"] = new Titulo_Modal();
	root["modal_titulo"].y = 45; 
	root["modal_titulo"].titulo.htmlText="<font color='#"+corbt1+"'>"+titulo+"</font>";
	root["modal_titulo"].texto.text="";
	/*
	root["modal_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER;
	texto = "<font color='#"+cortexto+"'>"+texto+"</font>";
	root["modal_titulo"].texto.htmlText=texto;
	*/
	root[nome].conteudo.addChild(root["modal_titulo"]);
	
	// # Valor Solicitado:
	root["modal_valorsolicitado"] = new Creditos_boxDotted_1();
	root["modal_valorsolicitado"].y = root["modal_titulo"].y+root["modal_titulo"].height-20;
	root["modal_valorsolicitado"].scaleX = root["modal_valorsolicitado"].scaleY = 1
	root["modal_valorsolicitado"].x = (365/2)-(root["modal_valorsolicitado"].width/2);
	root["modal_valorsolicitado"].titulo.htmlText="<font color='#"+cortexto+"'>Valor Selecionado:</font>"
	root["modal_valorsolicitado"].unidade.htmlText="";
	root[nome].conteudo.addChild(root["modal_valorsolicitado"]);
	
	// # Modo de Antecipação:
	root["modal_modo"] = new Titulo_Modal();
	root["modal_modo"].y = root["modal_valorsolicitado"].y + root["modal_valorsolicitado"].height+20; 
	root["modal_modo"].titulo.htmlText="<font color='#"+corbt2+"' size='18'>Modo de Antecipação:</font>";
	root["modal_modo"].texto.autoSize =  TextFieldAutoSize.CENTER;
	texto = "<font color='#"+cortexto+"'>"+blast.list[app].pages.antecipacao.modo_de_anteicpacao+"</font>";
	root["modal_modo"].texto.htmlText=texto;
	root[nome].conteudo.addChild(root["modal_modo"]);
	
	// # Opções:
	root["modal_opcoes"] = new Vazio();
	root["modal_opcoes"].y = root["modal_modo"].y + root["modal_modo"].height+10;
	root[nome].conteudo.addChild(root["modal_opcoes"]);
	// # 1) Valores Próximos (START):
	var infos = [["Próximos","1"]]
	criaCheckBox("modal_opcoes_start",80,0,root["modal_opcoes"],infos,corbt1,null);
	root["modal_opcoes_start1"].check1.removeEventListener(MouseEvent.CLICK, root["modal_opcoes_start1"].checkfunc);
	root["modal_opcoes_start"].addEventListener(MouseEvent.CLICK, antecipa_start);
	root["modal_opcoes_start"].buttonMode = true;
	function antecipa_start(){
		tipoatencipacao = "start"
		root["modal_opcoes_start1"].checkfuncVisual(true);
		root["modal_opcoes_end1"].checkfuncVisual(false);
		calculaAntecipacao(tipoatencipacao);
	}
	// # 1) Valores Próximos (END):
	infos = [["Últimos","0"]]
	criaCheckBox("modal_opcoes_end",195,0,root["modal_opcoes"],infos,corbt1,null);
	root["modal_opcoes_end1"].check1.removeEventListener(MouseEvent.CLICK, root["modal_opcoes_end1"].checkfunc);
	root["modal_opcoes_end"].addEventListener(MouseEvent.CLICK, antecipa_end);
	root["modal_opcoes_end"].buttonMode = true;
	function antecipa_end(){
		tipoatencipacao = "end";
		root["modal_opcoes_start1"].checkfuncVisual(false);
		root["modal_opcoes_end1"].checkfuncVisual(true);
		calculaAntecipacao(tipoatencipacao);
	}
	
	// Mostra Taxas e o que será Sacado:
	root["modal_taxa"] = new Creditos_boxDotted_1();
	root["modal_taxa"].x = 60;
	root["modal_taxa"].y = root["modal_opcoes"].y+root["modal_opcoes"].height+10;
	root["modal_taxa"].scaleX = root["modal_taxa"].scaleY = .9;
	root["modal_taxa"].titulo.htmlText="<font color='#"+cortexto+"'>Taxa de Antecipação:</font>"
	root["modal_taxa"].unidade.htmlText="";
	root["modal_taxa"].valor.htmlText="<font color='#D63E3E'>...</font>"
	root[nome].conteudo.addChild(root["modal_taxa"]);
	
	// Valor Real Antecipável:
	root["modal_valorreal"] = new Creditos_boxDotted_1();
	root["modal_valorreal"].x = 195;
	root["modal_valorreal"].y = root["modal_taxa"].y;
	root["modal_valorreal"].scaleX = root["modal_valorreal"].scaleY = .9;
	root["modal_valorreal"].titulo.htmlText="<font color='#"+cortexto+"'>Valor Antecipável:</font>"
	root["modal_valorreal"].unidade.htmlText="";
	root["modal_valorreal"].valor.htmlText="<font color='#"+corbt1+"'>...</font>"
	root[nome].conteudo.addChild(root["modal_valorreal"]);
	
	// Função de Calculo de Antecipação:
	function calculaAntecipacao(tipoesc){
		root["modal_taxa"].valor.htmlText="<font color='#D63E3E'>...</font>"
		root["modal_valorreal"].valor.htmlText="<font color='#"+corbt1+"'>...</font>"
		connectServer(false,"screen",servidor+"api/marketplace/anticipate",[
		["build","true","texto"],
		["timeframe",tipoesc,"texto"],
		["valor",tipo[1],"texto"]
		],calculaAntecipacao_tipo);
		function calculaAntecipacao_tipo(dados){
			if(String(dados.list.info.solicitacao.amount).length<=7){ tamvalor = 26; }
			if(String(dados.list.info.solicitacao.amount).length>7){ tamvalor = 22; root["modal_valorsolicitado"].valor.y+=3; }
			root["modal_valorsolicitado"].valor.htmlText="<font color='#"+cortexto+"' size='"+tamvalor+"'>"+convertValorSemSifrao(centavos(dados.list.info.solicitacao.amount-dados.list.info.solicitacao.fee))+"</font>"
			root["modal_taxa"].valor.htmlText="<font color='#D63E3E'>"+convertValorSemSifrao(centavos(dados.list.info.solicitacao.anticipation_fee))+"</font>"
			root["modal_valorreal"].valor.htmlText="<font color='#"+corbt1+"'>"+convertValorSemSifrao(centavos(dados.list.info.solicitacao.amount-(dados.list.info.solicitacao.anticipation_fee+dados.list.info.solicitacao.fee)))+"</font>"
			root["antecipacao_valorproposto"] = centavos(dados.list.info.solicitacao.amount-(dados.list.info.solicitacao.anticipation_fee+dados.list.info.solicitacao.fee));
		};
	};
	calculaAntecipacao(tipoatencipacao);
	
	// # Texto:
	root["modal_texto"] = new Titulo_Modal();
	root["modal_texto"].y = 385; 
	root["modal_texto"].titulo.text="";
	root["modal_texto"].texto.autoSize =  TextFieldAutoSize.CENTER;
	texto = "<font color='#"+cortexto+"'>"+textoTitle+"</font>";
	root["modal_texto"].texto.htmlText=texto;
	root[nome].conteudo.addChild(root["modal_texto"]);
	
	// Aprovar!
	criaBt("modal_antecipacao_aprovar","Aprovar Proposta",root[nome].conteudo,100,485,.95,"0x"+corbt1,"MM");
	root["modal_antecipacao_aprovar"].addEventListener(MouseEvent.CLICK, modal_antecipacao_desejaaprovar);
	root["modal_antecipacao_aprovar"].buttonMode = true;
	function modal_antecipacao_desejaaprovar(){
		modal_abrir("modal_antecipacao_aprovar_confirmar",["confirmacaoAlert","Aprovar",corbt1,1,modal_antecipacao_ok,"senha"],"Antecipar: "+convertValor(root["antecipacao_valorproposto"]),"Deseja aprovar esta proposta de antecipação?",true,null,"P");
	}
	function modal_antecipacao_ok(){
		connectServer(false,"screen",servidor+"api/marketplace/anticipate",[
		 ["build","false","texto"],
		 ["timeframe",tipoatencipacao,"texto"],
		 ["valor",tipo[1],"texto"]
		],modal_antecipacao_ok_start);
		function modal_antecipacao_ok_start(dados){
			var icone;
			var cor;
			var infos;
			var tamanho;
			var titulo;
			var texto;
			var metodo;
			cor = coricon; icone = "dinheiro.png"; tamanho="PM";
			titulo = "<font color='#"+corbt1+"'>Pronto!</font>";
			texto = blast.list[app].pages.antecipacao.antecipacao_efetuada;
			infos = [
				["Código",dados.list['info'].solicitacao['id'],"e7e7e7",cortexto],
				["Liberação",convertData(dados.list['info'].solicitacao.payment_date),"e7e7e7",cortexto]
			]
			modal_abrir("modal_antecipacao",["modal_infos",infos],titulo,texto,true,null,tamanho);
			pages_new("antecipacao","antecipacao");
			modal_fechar(realnome);
		}
	}
};