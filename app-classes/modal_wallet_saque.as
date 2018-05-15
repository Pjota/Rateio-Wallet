import flash.text.engine.BreakOpportunity;

if(tipo[0]=="modal_wallet_saque"){
	
	// ==================================
	// Atualiza Informações de Crédito:
	// ==================================
	connectServer(false,"screen",servidor+"api/max/wallet",[
	],modal_wallet_saque_load);
	function modal_wallet_saque_load(dados){
		root["modal_wallet_saque_creditos"] = dados;
		// Configuração:
		connectServer(false,"screen",servidor+"api/list/"+blast.list.table['contas']+"/r_tabela="+root["User"]['table']+",r_id="+root["User"]['id']+",validacao_empresa!=null,validacao_operadora!=null,order_column=id,order_direct=DESC,level=2,page_limit=1",[
		],modal_wallet_saque_load2);
		function modal_wallet_saque_load2(dados){
			root["modal_wallet_saque_banco"] = dados;
			modal_wallet_saque_init(dados);
		};
	};
	
	// =====================================
	// Monta modal de solicitação de Saque:
	// =====================================
	function modal_wallet_saque_init(dados){
		
		// # Título e Texto:
		root["modal_titulo"] = new Titulo_Modal();
		root["modal_titulo"].y = 45; 
		root["modal_titulo"].titulo.htmlText="<font color='#"+corbt1+"'>"+titulo+"</font>";
		root["modal_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER;
		texto = "<font color='#"+cortexto+"'>"+texto+"</font><font size='18'>"+dados.list[0].titular+" - "+dados.list[0].id_bl_bancos.nick+" - Agência: "+dados.list[0].agencia+" Conta: "+dados.list[0].conta+"</font>";
		root["modal_titulo"].texto.htmlText=texto;
		root[nome].conteudo.addChild(root["modal_titulo"]);
		
		// # Total disponível:
		root["modal_wallet_saque_saldo"] = convertValorSemSifrao(root["modal_wallet_saque_creditos"].list.max.disponivel);
		root["modal_saldototal"] = new Creditos_boxDotted_1();
		root["modal_saldototal"].y = root["modal_titulo"].y + root["modal_titulo"].height + 10;
		root["modal_saldototal"].x = 55;
		root["modal_saldototal"].scaleX = root["modal_saldototal"].scaleY = .9
		root["modal_saldototal"].titulo.htmlText="<font color='#"+cortexto+"'>Saldo Disponível:</font>"
		root["modal_saldototal"].unidade.htmlText="<font color='#"+cortexto+"'></font>";
		var tamvalor;
		if(root["modal_wallet_saque_saldo"].length<=7){ tamvalor = 26; }
		if(root["modal_wallet_saque_saldo"].length>7){ tamvalor = 21; root["modal_saldototal"].valor.y+=4; }
		root["modal_saldototal"].valor.htmlText="<font color='#"+cortexto+"' size='"+tamvalor+"'>"+root["modal_wallet_saque_saldo"]+"</font>"
		Tweener.addTween(root["modal_saldototal"].fundo, {_color:"0x"+cortexto, time: 0,transition: "linear",delay: 0});
		root[nome].conteudo.addChild(root["modal_saldototal"]);
		
		// # Valor desejado:
		var valorpossivel = ajustaDecimal(root["modal_wallet_saque_creditos"].list.max.disponivel-root["modal_wallet_saque_creditos"].list.max.saque_taxa_max,2);
		root["modal_valor_parasaque"] = valorpossivel;
		root["modal_valordesejado"] = new Creditos_label();
		root["modal_valordesejado"].x = 180;
		root["modal_valordesejado"].y = root["modal_titulo"].y + root["modal_titulo"].height + 10;
		root["modal_valordesejado"].titulo.htmlText = "<font color='#"+cortexto+"' size='16'>Informe o Valor Desejado:</font>";
		root[nome].conteudo.addChild(root["modal_valordesejado"]);
		criaInput("modal_valordesejado_input", "", root[nome].conteudo, root["modal_valordesejado"].x, root["modal_valordesejado"].y+root["modal_valordesejado"].height+5, .95, "0xffffff", "0x"+corbt1, 50, false,"P");
		root["modal_valordesejado_input"].scaleX = root["modal_valordesejado_input"].scaleY = .85;
		root["modal_valordesejado_input"].x = root["modal_valordesejado_input"].x+6;
		root["modal_valordesejado_input"].y = root["modal_valordesejado_input"].y-5;
		root["modal_valordesejado_input"].texto.htmlText="<font color='#"+cortexto+"' size='"+ajustNumber(valorpossivel,[32,32,32,32,32,32,32,30,28])+"'>"+convertValor(valorpossivel)+"</font>";
		ajustText(root["modal_valordesejado_input"].texto,root["modal_valordesejado_input"].fundo,"V");
		desativaInputView(root["modal_valordesejado_input"]);
		root["modal_valordesejado_input"].texto.alpha = 1;
		root["modal_valordesejado_input"].addEventListener(MouseEvent.CLICK, modal_wallet_saque_inputValue);
		root["modal_valordesejado_input"].buttonMode = true;
		root["modal_valordesejado_input"].feedback.visible=false;
		function modal_wallet_saque_inputValue(){
			modal_abrir("modal_wallet_saque_inputValue_open",["numbers",valorpossivel,modal_wallet_saque_getValue],"Selecione o Valor:","Informe o valor desejado para o saque:",true,null,"MG");
		};
		function modal_wallet_saque_getValue(valor){
			valor = Number(valor)
			root["modal_valor_parasaque"] = valor;
			root["modal_valordesejado_input"].texto.htmlText="<font color='#"+cortexto+"' size='"+ajustNumber(valor,[32,32,32,32,32,32,32,30,28])+"'>"+convertValor(valor)+"</font>";
			ajustText(root["modal_valordesejado_input"].texto,root["modal_valordesejado_input"].fundo,"V");
			modal_wallet_saque_calculate();
		};
		
		// ------------ QUANTIDADE DE TRASNFERÊNCIAS:
		root["modal_qnttransferencias"] = new Texto();
		root["modal_qnttransferencias"].x = 30; 
		root["modal_qnttransferencias"].y = 230; 
		root["modal_qnttransferencias"].texto.autoSize =  TextFieldAutoSize.LEFT;
		root["modal_qnttransferencias"].texto.width = 305;
		root["modal_qnttransferencias"].texto.htmlText="<font color='#"+cortexto+"' size='18'>Carregando...</font>";
		root[nome].conteudo.addChild(root["modal_qnttransferencias"]);
		
		// # Confirmar Saque:
		criaBt("modal_valorparasaque_ok","Sacar Agora",root[nome].conteudo,100,430,.95,"0x"+corbt1,"MM");
		Tweener.addTween(root["modal_valorparasaque_ok"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});	
		root["modal_valorparasaque_ok"].addEventListener(MouseEvent.CLICK, modal_wallet_saque_start);
		root["modal_valorparasaque_ok"].buttonMode = true;
		root["modal_valorparasaque_ok"].visible = false;
		function modal_wallet_saque_start(){
			root["saque_valor"] = root["modal_valordesejado_input"].texto.text;
			modal_abrir("modal_wallet_saque_start_movie",["confirmacaoAlert","Aprovar",corbt1,1,modal_wallet_saque_go,"senha"],"Saque: "+convertValor(root["modal_valor_parasaque"]),"Deseja realizar este saque para a sua conta bancária?",true,null,"P");
		};
		function modal_wallet_saque_go(){
			connectServer(false,"screen",servidor+"api/max/draft",[
			["valor",root["modal_valor_parasaque"],"texto"],
			["solicitacao","true","texto"]
			],modal_wallet_saque_goReturn);
		};
		function modal_wallet_saque_goReturn(dados){
			var saques_total = dados.list.max.saques.length;
			var saques_aprovados = 0;
			for(var i=0; i<saques_total; i++){
				if(dados.list.max.saques[i].aprovacao==true){
					saques_aprovados++;
				};
			};
			// Aprovação Retorno:
			if(saques_aprovados == 0){
				newbalaoInfo(root[nome].conteudo,'Falha na tentativa do Saque.',(root["modal_valorparasaque_ok"].x+(root["modal_valorparasaque_ok"].width/2)),(root["modal_valorparasaque_ok"].y+30),"BalaoInfo","0x"+corcancel);
			}else{
				if(saques_aprovados != 0 && saques_aprovados < saques_total){
				};
				// Abre Modal de Saque:
				var icone;
				var cor;
				var infos;
				var tamanho;
				var titulo;
				var texto;
				var metodo;
				cor = coricon; icone = "dinheiro.png"; tamanho="PM";
				titulo = "<font color='#"+corbt1+"'>Pronto!</font>";
				texto = ""+blast.list[app].pages.carteira_digital.conteudo.saque_efetuado;
				infos = [
					["Saque feito em:",saques_aprovados+" Transferência(s)","e7e7e7",cortexto],
					["Valor Solicitado:",convertValor(dados.list.max.valor_sacado),"33cc33","ffffff"]
				]
				modal_abrir("modal_saque",["modal_infos",infos],titulo,texto,true,null,tamanho);
				// Fecha Modal e Visualiza Alterações:
				pages_new("meus_saques","meus_saques");
				modal_fechar(realnome);
			};
		};
		
		// ------------- Calculo de proposta de Saque:
		root["modal_saque_transferencias"] = new Vazio();
		root["modal_saque_transferencias"].x = 56; 
		root["modal_saque_transferencias"].y = root["modal_qnttransferencias"].y+root["modal_qnttransferencias"].height+20;
		root[nome].conteudo.addChild(root["modal_saque_transferencias"]);
		function modal_wallet_saque_calculate(){
			
			root["modal_valorparasaque_ok"].visible = false;
			root["modal_qnttransferencias"].texto.htmlText="<font color='#"+cortexto+"' size='18'>Carregando...</font>";
			destroir(root["modal_saque_transferencias"],true);
			connectServer(false,"screen",servidor+"api/max/draft",[
			["valor",root["modal_valor_parasaque"],"texto"]
			],modal_wallet_saque_calculateReturn);
			function modal_wallet_saque_calculateReturn(dados){
				
				// ----------------------------
				// # Calculo de Transferências:
				var transferencias = dados.list.max.saques.length;
				root["modal_wallet_saque_transferencias"] = transferencias;
				root["modal_wallet_saque_solictado"] = 0;
				trace("transferencias "+transferencias);
				// ---------------------------
				// # Desenha as transferências:
				for(var i=0; i<transferencias; i++){
					root["transferencia"+(i+1)] = new item_numerado();
					root["transferencia"+(i+1)].name = "transferencia"+(i+1);
					root["transferencia"+(i+1)].y=(75*i);
					root["transferencia"+(i+1)].num.text=(i+1)+"°";
					root["modal_wallet_saque_solictado"]+= dados.list.max.saques[i].valor;
					root["transferencia"+(i+1)].titulo.htmlText = "<font color='#"+cortexto+"'>Valor: "+convertValor(dados.list.max.saques[i].valor)+"</font>";
					root["transferencia"+(i+1)].descricao.htmlText = "<font color='#"+cortexto+"'>Transferido até:</font> <font color='#"+cortexto+"'>"+convertDataDiaMesAno(dados.list.max.saques[i].data)+" ("+dados.list.max.saques[i].dia+")</font>";
					var txttarifa = "";
					if(dados.list.max.saques[i].tarifa>0){
						root["transferencia"+(i+1)].texto.htmlText = "<font color='#"+cortexto+"'>Tarifa de Saque:</font> <font color='#ea2d4c'>"+convertValor(dados.list.max.saques[i].tarifa)+"</font>";
					}else{
						root["transferencia"+(i+1)].texto.htmlText = "<font color='#"+cortexto+"'>Tarifa de Saque:</font> <font color='#2b9a2b'>GRATUITO!</font>";
					};
					root["modal_saque_transferencias"].addChild(root["transferencia"+(i+1)]);
					root["transferencia"+(i+1)].alpha=0;
					root["transferencia"+(i+1)].posx = root["transferencia"+(i+1)].x;
					Tweener.addTween(root["transferencia"+(i+1)], {alpha:1, time: .5,transition: "easeOutExpo",delay: (i/10)});
				};
				// ---------------------------
				// # Define se vamos oferecer mais do que ele pediu:
				var descricaoValorAproximado = "";
				if(root["modal_wallet_saque_solictado"]<=root["modal_valor_parasaque"]){
					descricaoValorAproximado = "";
				}else{
					root["modal_valor_parasaque"] = root["modal_wallet_saque_solictado"];
					descricaoValorAproximado = "<font color='#F70D49'>Obs:</font> Ajustamos o seu valor de saque pois não é possível sacar metade do valor de uma venda.<br>";
				};
				root["modal_qnttransferencias"].texto.htmlText="<font color='#"+cortexto+"' size='18'><font color='#33cc33' size='20'>Proposta de Saque:</font><br>"+descricaoValorAproximado+"Seu saque será feito em "+transferencias+" Transferência(s):</font>";	
				// ------------------------------
				// # Atualiza Botão de aprovação:
				root["modal_saque_transferencias"].y = root["modal_qnttransferencias"].y+root["modal_qnttransferencias"].height+20;
				root["modal_valorparasaque_ok"].visible = true;
				root["modal_valorparasaque_ok"].alpha=0;
				root["modal_valorparasaque_ok"].y = root["modal_saque_transferencias"].y+root["modal_saque_transferencias"].height+20;
				Tweener.addTween(root["modal_valorparasaque_ok"], {alpha:1, time: .5,transition: "easeOutExpo",delay: 0});
				
			};
		};
		modal_wallet_saque_calculate();
	};
};