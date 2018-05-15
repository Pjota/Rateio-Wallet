if(tipo[0]=="modal_wallet_saque"){
	
	// ==================================
	// Atualiza Informações de Crédito:
	// ==================================
	connectServer(false,"screen",servidor+"api/list/"+root["User"]['table']+"/id="+root["User"]['id'],[
	],modal_wallet_saque_load);
	function modal_wallet_saque_load(dados){
		root["modal_wallet_saque_creditos"] = dados;
		// Configuração:
		var ext = "";
		var alvo = blast.list[app].pages.login['table']
		var total = alvo.length;
		for(var n=0; n<total; n++){
			if(alvo[n] == root["User"]['table']){
				ext += "id_"+alvo[n]+"="+root["User"]['id']+",";
			}else{
				if(root["User"]['table']=="usuarios"){
					ext += "id_"+alvo[n]+"=0,";
				}
			}
		}
		
		connectServer(false,"screen",servidor+"api/list/r_contas/"+ext+"order_column=id,order_direct=DESC,level=2,page_limit=1",[
		],modal_wallet_saque_load2);
		function modal_wallet_saque_load2(dados){
			root["modal_wallet_saque_banco"] = dados;
			modal_wallet_saque_init(dados);
		}
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
		texto = "<font color='#"+cortexto+"'>"+texto+"</font><br><font size='20'>"+dados.list[0].titular+" - "+dados.list[0].id_r_bancos.nome+"<br>Agência: "+dados.list[0].agencia+" Conta: "+dados.list[0].conta+"</font>";
		root["modal_titulo"].texto.htmlText=texto;
		root[nome].conteudo.addChild(root["modal_titulo"]);
		
		// # Total disponível:
		root["modal_wallet_saque_saldo"] = convertValorSemSifrao(root["modal_wallet_saque_creditos"].list[0].wallet.saldo_disponivel);
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
		
		// # Taxa para Saque:
		root["modal_taxasaque"] = new Creditos_boxDotted_1();
		root["modal_taxasaque"].y = root["modal_saldototal"].y;
		root["modal_taxasaque"].x = 195;
		root["modal_taxasaque"].scaleX = root["modal_taxasaque"].scaleY = .9
		root["modal_taxasaque"].titulo.htmlText="<font color='#"+cortexto+"'>Taxa de Saque (Máx):</font>"
		root["modal_taxasaque"].unidade.htmlText="";
		var precodesaque = root["modal_wallet_saque_creditos"].list[0].wallet.saque_valor_max;
		if(precodesaque==0){
			root["modal_taxasaque"].valor.htmlText="<font color='#"+corbt1+"'>Gratuito</font>";
		}else{
			root["modal_taxasaque"].valor.htmlText="<font color='#D63E3E'>"+convertValor(tipo[3])+"</font>";
		}
		root[nome].conteudo.addChild(root["modal_taxasaque"]);
		
		// # Input de Valor:
		var valorpossivel = ajustaDecimal(root["modal_wallet_saque_creditos"].list[0].wallet.saldo_disponivel,2);
		root["modal_valor_parasaque"] = valorpossivel;
		var posysaque = root["modal_taxasaque"].y + root["modal_taxasaque"].height + 20;
		criaValor("modal_valorparasaque", "Informe o Valor:",convertValor(valorpossivel), root[nome].conteudo, 70, posysaque, 1.2,"M");
		root["modal_valorparasaque"].texto.type = TextFieldType.DYNAMIC;
		root["modal_valorparasaque"].texto.selectable = false;
		modal_wallet_saque_getValue(valorpossivel);
		root["modal_valorparasaque"].addEventListener(MouseEvent.CLICK, modal_wallet_saque_inputValue);
		root["modal_valorparasaque"].buttonMode = true;
		function modal_wallet_saque_inputValue(){
			modal_abrir("modal_wallet_saque_inputValue_open",["numbers",valorpossivel,modal_wallet_saque_getValue],"Selecione o Valor:","Informe o valor desejado para o saque:",true,null,"MG");
		}
		function modal_wallet_saque_getValue(valor){
			valor = Number(valor)
			root["modal_valor_parasaque"] = valor;
			var tamvalor;
			trace("TAMANHOOOOOO: "+String(valor).length)
			if(String(valor).length<=3){ tamvalor = 26; root["modal_valorparasaque"].texto.y=20; }
			if(String(valor).length>3){ tamvalor = 20; root["modal_valorparasaque"].texto.y=25; }
			root["modal_valorparasaque"].texto.htmlText = "<font color='#"+cortexto+"' size='"+tamvalor+"'>"+convertValor(valor)+"</font>"
		}
		
		// # Confirmar Saque:
		criaBt("modal_valorparasaque_ok","Sacar Agora",root[nome].conteudo,100,"modal_valorparasaque",.95,"0x"+corbt1,"MM");
		root["modal_valorparasaque_ok"].addEventListener(MouseEvent.CLICK, modal_wallet_saque_start);
		root["modal_valorparasaque_ok"].buttonMode = true;
		function modal_wallet_saque_start(){
			root["saque_valor"] = root["modal_valorparasaque"].texto.text;
			modal_abrir("modal_wallet_saque_start_movie",["confirmacaoAlert","Aprovar",corbt1,1,modal_wallet_saque_go,"senha"],"Saque: "+convertValor(root["modal_valor_parasaque"]),"Deseja realizar este saque para a sua conta bancária?",true,null,"P");
		};
		function modal_wallet_saque_go(){
			connectServer(false,"screen",servidor+"api/marketplace/draft",[
			["valor",root["modal_valor_parasaque"],"texto"]
			],modal_wallet_saque_goReturn);
		};
		function modal_wallet_saque_goReturn(dados){
			if(dados.list.retorno=="erro"){
				newbalaoInfo(root[nome].conteudo,'Falha na tentativa do Saque.',(root["modal_valorparasaque_ok"].x+(root["modal_valorparasaque_ok"].width/2)),(root["modal_valorparasaque_ok"].y+30),"BalaoInfo","0x"+corcancel);
			}else{
				// Abre Modal de Saque:
				var icone;
				var cor;
				var infos;
				var tamanho;
				var titulo;
				var texto;
				var metodo;
				cor = coricon; icone = "dinheiro.png"; tamanho="M";
				titulo = "<font color='#"+corbt1+"'>Pronto!</font>";
				texto = ""+blast.list[app].pages.carteira_digital.conteudo.saque_efetuado;
				infos = [
					["Código:",dados.list['info'].gateway_transaction_id,"e7e7e7",cortexto],
					["Liberação até:",convertDataDiaMes(dados.list['info'].liberacao),"e7e7e7",cortexto],
					["Status:",dados.list['info'].tipo.toUpperCase(),"e7e7e7",cortexto],
					["Taxa de Saque:",convertValor(dados.list['info'].taxa_gateway_valor),"f65246","ffffff"],
					["Valor Depositado:",convertValor(dados.list['info'].valor_total),"e7e7e7",cortexto]
				]
				modal_abrir("modal_saque",["modal_infos",infos],titulo,texto,true,null,tamanho);
				// Fecha Modal e Visualiza Alterações:
				pages_new("carteira_digital","carteira_digital");
				modal_fechar(realnome);
			}
			
		}
		
		// # Observações sobre o Saque:
		if(tipo[1]!=null){
			root["modal_obs"] = new Titulo_Modal();
			root["modal_obs"].y = root["modal_valorparasaque_ok"].y + root["modal_valorparasaque_ok"].height + 10; 
			root["modal_obs"].titulo.htmlText="<font size='15' color='#"+cortexto+"'>Observações importantes:</font>";
			root["modal_obs"].texto.autoSize =  TextFieldAutoSize.CENTER;
			root["modal_obs"].texto.htmlText="<font color='#666666'>"+tipo[1]+"</font>";
			root[nome].conteudo.addChild(root["modal_obs"]);
		}
	}
};