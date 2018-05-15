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
	root[nome].conteudo.addChild(root["modal_titulo"]);
	
	// # Valor Solicitado:
	root["modal_valorsolicitado"] = new Creditos_boxDotted_1();
	root["modal_valorsolicitado"].y = root["modal_titulo"].y+root["modal_titulo"].height-20;
	root["modal_valorsolicitado"].scaleX = root["modal_valorsolicitado"].scaleY = 1
	root["modal_valorsolicitado"].x = (365/2)-(root["modal_valorsolicitado"].width/2);
	root["modal_valorsolicitado"].titulo.htmlText="<font color='#"+cortexto+"'>Valor Selecionado:</font>";
	root["modal_valorsolicitado"].valor.htmlText="<font color='#"+cortexto+"' size='"+ajustNumber(tipo[1],[26,26,26,26,22,22,18,16,16])+"'>"+convertValor(tipo[1])+"</font>";
	ajustText(root["modal_valorsolicitado"].valor,root["modal_valorsolicitado"].fundo,"V")
	root["modal_valorsolicitado"].unidade.htmlText="";
	root[nome].conteudo.addChild(root["modal_valorsolicitado"]);
	
	// # Quantidade de Transferências:
	root["modal_qnttransferencias"] = new Texto();
	root["modal_qnttransferencias"].x = 30; 
	root["modal_qnttransferencias"].y = 180; 
	root["modal_qnttransferencias"].texto.autoSize =  TextFieldAutoSize.LEFT;
	root["modal_qnttransferencias"].texto.width = 305;
	root["modal_qnttransferencias"].texto.htmlText="<font color='#"+cortexto+"' size='18'>Carregando...</font>";
	root[nome].conteudo.addChild(root["modal_qnttransferencias"]);
	
	// Aprovar!
	criaBt("modal_antecipacao_aprovar","Aprovar Proposta",root[nome].conteudo,100,475,.95,"0x"+corbt1,"MM");
	Tweener.addTween(root["modal_antecipacao_aprovar"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});	
	root["modal_antecipacao_aprovar"].addEventListener(MouseEvent.CLICK, modal_antecipacao_desejaaprovar);
	root["modal_antecipacao_aprovar"].buttonMode = true;
	root["modal_antecipacao_aprovar"].visible = false;
	function modal_antecipacao_desejaaprovar(){
		modal_abrir("modal_antecipacao_aprovar_confirmar",["confirmacaoAlert","Aprovar",corbt1,1,modal_antecipacao_ok,"senha"],"Antecipar: "+convertValor(root["antecipacao_valorpossivel"]),"Deseja aprovar esta proposta de antecipação?",true,null,"P");
	}
	function modal_antecipacao_ok(){
		connectServer(false,"screen",servidor+"api/max/antecipate",[
		["solicitacao","true","texto"],
		["valor",tipo[1],"texto"]
		],modal_antecipacao_ok_start);
		function modal_antecipacao_ok_start(dados){
			root["modal_wallet_antecipacoes_transferencias"] = dados.list.max.antecipacoes.length;
			var icone;
			var cor;
			var infos;
			var tamanho;
			var titulo;
			var texto;
			var metodo;
			cor = coricon; icone = "dinheiro.png"; tamanho="M";
			titulo = "<font color='#"+corbt1+"'>Pronto!</font>";
			texto = blast.list[app].pages.antecipacao.antecipacao_efetuada;
			var valor_antecipado = dados.list.max.valor_sacado;
			var valor_tarifa = 0;
			var valor_final = 0;
			for(var i=0; i<dados.list.max.antecipacoes.length; i++){
				valor_tarifa += dados.list.max.antecipacoes[i].tarifa;
				valor_final += (dados.list.max.antecipacoes[i].valor-dados.list.max.antecipacoes[i].tarifa);
			};
			infos = [
				["Antecipação em",root["modal_wallet_antecipacoes_transferencias"]+" Transferência(s)","e7e7e7",cortexto],
				["Solicitação",convertDataDiaMesHora(dados.head['print']),"e7e7e7",cortexto],
				["Status","Em Processo","e7e7e7",cortexto],
				["Valor Antecipado",convertValor(valor_antecipado),"e7e7e7",cortexto],
				["Taxa",convertValor(valor_tarifa),"f65246","ffffff"],
				["Valor Final",convertValor(valor_final),"e7e7e7",cortexto]
			]
			modal_abrir("modal_antecipacao",["modal_infos",infos],titulo,texto,true,null,tamanho);
			pages_new("minhas_antecipacoes","minhas_antecipacoes");
			modal_fechar(realnome);
		};
	};
	
	// # Calculo de proposta de Saque:
	root["modal_antecipacao_transferencias"] = new Vazio();
	root["modal_antecipacao_transferencias"].x = 56; 
	root["modal_antecipacao_transferencias"].y = 240;
	root[nome].conteudo.addChild(root["modal_antecipacao_transferencias"]);
	function modal_wallet_antecipacao_calculate(){
		destroir(root["modal_antecipacao_transferencias"],true);
		connectServer(false,"screen",servidor+"api/max/antecipate",[
		["valor",tipo[1],"texto"]
		],modal_wallet_antecipacao_calculateReturn);
		function modal_wallet_antecipacao_calculateReturn(dados){
		
			root["transferencias_totais"] = dados.list.max.antecipacoes.length;
			var transferencias = dados.list.max.antecipacoes.length;
			// -------------------------------------------------
			root["modal_qnttransferencias"].texto.htmlText="<font color='#"+cortexto+"' size='18'>Carregando...</font>";			
			root["antecipacao_valorproposto"] = tipo[1];
			root["antecipacao_valorpossivel"] = 0;
			// Lista as antecipações:
			for(var i=0; i<transferencias; i++){
				root["transferencia"+(i+1)] = new item_numerado_g();
				root["transferencia"+(i+1)].name = "transferencia"+(i+1);
				root["transferencia"+(i+1)].y=(104*i);
				root["transferencia"+(i+1)].num.text=(i+1)+"°";
				root["antecipacao_valorpossivel"] += dados.list.max.antecipacoes[i].valor;
				root["transferencia"+(i+1)].titulo.htmlText = "<font color='#"+cortexto+"'>Valor: "+convertValor(dados.list.max.antecipacoes[i].valor)+"</font>";
				root["transferencia"+(i+1)].descricao.htmlText = "<font color='#"+cortexto+"'>Agendado para:</font> <font color='#"+cortexto+"'>"+convertDataDiaMesAno(dados.list.max.antecipacoes[i]['data'])+" ("+dados.list.max.antecipacoes[i]['dia']+")</font>";
				var txttarifa = "";
				if(dados.list.max.antecipacoes[i].tarifa>0){
					root["transferencia"+(i+1)].texto1.htmlText = "<font color='#"+cortexto+"'>[Tarifa] Antecipação: <font color='#ea2d4c'>"+convertValor(dados.list.max.antecipacoes[i].tarifa)+"</font></font>";
				}else{
					root["transferencia"+(i+1)].texto1.htmlText = "<font color='#"+cortexto+"'>[Tarifa] Antecipação: <font color='#2b9a2b'>GRATUITO!</font></font>";
				};
				root["transferencia"+(i+1)].texto2.htmlText = "<font color='#"+cortexto+"'>Forma: "+dados.list.max.antecipacoes[i].tipo+"</font>";
				root["modal_antecipacao_transferencias"].addChild(root["transferencia"+(i+1)]);
				root["transferencia"+(i+1)].alpha=0;
				root["transferencia"+(i+1)].posx = root["transferencia"+(i+1)].x;
				Tweener.addTween(root["transferencia"+(i+1)], {alpha:1, time: .5,transition: "easeOutExpo",delay: (i/10)});
			};
			// -------------------------------------------------
			// # Define se vamos oferecer mais do que ele pediu:
			var descricaoValorAproximado = "";
			if(root["antecipacao_valorpossivel"]<=tipo[1]){
				descricaoValorAproximado = "";
			}else{
				descricaoValorAproximado = "<font color='#F70D49'>Obs:</font> Ajustamos o seu o valor pois não é possível antecipar metade do valor de uma venda.<br>";
			};
			root["modal_qnttransferencias"].texto.htmlText="<font color='#"+cortexto+"' size='18'>"+descricaoValorAproximado+"Sua antecipação será liberada em <font color='#33cc33'>"+transferencias+" Transferência(s):</font></font>";	
			// -------------------------------------------------	
			// Atualiza Botão de aprovação:
			root["modal_antecipacao_transferencias"].y = root["modal_qnttransferencias"].y+root["modal_qnttransferencias"].height+20;	
			root["modal_antecipacao_aprovar"].visible = true;
			root["modal_antecipacao_aprovar"].alpha=0;
			root["modal_antecipacao_aprovar"].y = root["modal_antecipacao_transferencias"].y+root["modal_antecipacao_transferencias"].height+20;
			Tweener.addTween(root["modal_antecipacao_aprovar"], {alpha:1, time: .5,transition: "easeOutExpo",delay: 0});
		
		};
	};
	modal_wallet_antecipacao_calculate();
	
	// Função de Calculo de Antecipação:
	function calculaAntecipacao(tipoesc){
		/*
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
		*/
	};
	calculaAntecipacao(tipoatencipacao);
	
	
};