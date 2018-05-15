// ====================================================
// ANTECIPAÇÃO - Init
// ====================================================
function antecipacao(sessao){
	// -------------------
	// Variáveis Iniciais:
	pages_history.push("antecipacao");
	//root["antecipacao_tipo"] = "start";
	
	// ------------------
	// Busca informações:
	connectServer(false,"screen",servidor+"api/max/wallet",[
	],antecipacao_start);
	function antecipacao_start(dados){
		root["antecipacao_start_data"] = dados;
		// Buscando informações de LIMITE DE VALORES PARA ANTECIPAÇÃO:
		connectServer(false,"screen",servidor+"api/max/antecipate",[
		["valor",0,"texto"]
		],calculaAntecipacaoTipo_Load);
		function calculaAntecipacaoTipo_Load(dados){
			root["antecipacao_limites_data"] = dados;
			antecipacao_load(root["antecipacao_start_data"]);
		};
	};
};
// ====================================================
// ANTECIPAÇÃO - Constroi Página
// ====================================================
function antecipacao_load(dados){
	
	// ---------------------
	// # Variáveis Iniciais:
	var tamvalor;
	var valorpossivel = root["antecipacao_limites_data"].list.max.maximo;
	var valorminimo = root["antecipacao_limites_data"].list.max.minimo;
	if(valorminimo<1){valorminimo=1.00}
	root["modal_valor_paraatecipacao"] = valorpossivel;
	
	// ------------------------
	// # Cria o Topo da página:
	root["antecipacao_conteudo"] = new Vazio();
	root["antecipacao_titulo"] = new Vazio();
	root["antecipacao_listagem"] = new Vazio();
	root["antecipacao_spacer"] = new spacer();
	root["antecipacao_titulo"].addChild(root["antecipacao_spacer"]);
	semConteudo("antecipacao_img",blast.list[app].pages.antecipacao.titulo,blast.list[app].pages.antecipacao.descricao,180,"antecipacao.png",365,root["antecipacao_titulo"],0,0,null);
	root["antecipacao_conteudo"].addChild(root["antecipacao_titulo"]);
	
	// -------------------------------
	// # Saldo Disponível Antecipável:
	root["antecipacao_areceber"] = new Creditos_boxDotted_1();
	root["antecipacao_areceber"].y = 0;
	root["antecipacao_areceber"].x = 40;
	root["antecipacao_areceber"].titulo.htmlText="<font color='#"+cortexto+"'>Saldo Antecipável:</font>"
	root["antecipacao_areceber"].unidade.htmlText="<font color='#"+cortexto+"'></font>";
	var valor_a_receber = valorpossivel;
	root["antecipacao_areceber"].valor.htmlText="<font color='#"+cortexto+"' size='"+ajustNumber(valor_a_receber,[26,26,26,26,26,22,22,20,18])+"'>"+convertValor(valor_a_receber)+"</font>";
	ajustText(root["antecipacao_areceber"].valor,root["antecipacao_areceber"].fundo,"V")
	Tweener.addTween(root["antecipacao_areceber"].fundo, {_color:"0x"+cortexto, time: 0,transition: "linear",delay: 0});
	root["antecipacao_listagem"].addChild(root["antecipacao_areceber"]);
	
	// -----------------
	// # Valor Desejado:
	root["antecipacao_valor"] = new Creditos_label();
	root["antecipacao_valor"].x = 180;
	root["antecipacao_valor"].y = 0;
	root["antecipacao_valor"].titulo.htmlText = "<font color='#"+cortexto+"'>Informe o Valor:</font>";
	root["antecipacao_listagem"].addChild(root["antecipacao_valor"]);
	criaInput("antecipacao_valor", "", root["antecipacao_listagem"], root["antecipacao_valor"].x, root["antecipacao_valor"].y+root["antecipacao_valor"].height+5, .95, "0xffffff", "0x"+corbt1, 50, false,"P");
	if(valorpossivel!=0){
		root["antecipacao_valor"].texto.htmlText="<font color='#"+cortexto+"' size='"+ajustNumber(valorpossivel,[32,32,32,32,32,32,32,30,28])+"'>"+convertValor(valorpossivel)+"</font>";
	}else{
		root["antecipacao_valor"].texto.htmlText="<font color='#"+cortexto+"' size='36'>R$ 0,00</font>";
	}
	ajustText(root["antecipacao_valor"].texto,root["antecipacao_valor"].fundo,"V")
	desativaInputView(root["antecipacao_valor"]);
	root["antecipacao_valor"].posy = root["antecipacao_valor"].texto.y;
	root["antecipacao_valor"].texto.alpha = 1;
	root["antecipacao_valor"].addEventListener(MouseEvent.CLICK, antecipacao_inputValue);
	root["antecipacao_valor"].buttonMode = true;
	root["antecipacao_valor"].feedback.visible=false;
	function antecipacao_inputValue(){
		modal_abrir("antecipacao_valor_open",["numbers",valorpossivel,antecipacao_getValue],"Selecione o Valor:","Informe o valor desejado para antecipar:",true,null,"MG");
	};
	function antecipacao_getValue(valor){
		root["modal_valor_paraatecipacao"] = valor;
		root["antecipacao_valor"].texto.htmlText="<font color='#"+cortexto+"' size='"+ajustNumber(valor,[32,32,32,32,32,32,32,30,28])+"'>"+convertValor(valor)+"</font>";
		ajustText(root["antecipacao_valor"].texto,root["antecipacao_valor"].fundo,"V")
	};
	
	// ------------------------
	// # Solicitar Antecipação:
	criaBt("antecipacao_solicitar","Consultar Proposta",root["antecipacao_listagem"],35,100,.95,"0x"+corbt1,"G");
	Tweener.addTween(root["antecipacao_solicitar"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});		
	root["antecipacao_solicitar"].addEventListener(MouseEvent.CLICK, function(){antecipacao_solicitar_click();});
	root["antecipacao_solicitar"].buttonMode = true;
	function antecipacao_solicitar_click(){
		if(valorpossivel>0){
			if(root["modal_valor_paraatecipacao"]>0){
				if(root["modal_valor_paraatecipacao"]<valorminimo){
					newbalaoInfo(root["antecipacao_listagem"],'Valor Mínimo Antecipável:<br>'+convertValor(valorminimo),(root["antecipacao_solicitar"].x+(root["antecipacao_solicitar"].width/2)),(root["antecipacao_solicitar"].y+30),"BalaoInfo","0x"+corcancel);
				}else{
					modal_abrir("antecipacao_proposta_modal",["modal_wallet_antecipacao",root["modal_valor_paraatecipacao"]],"Proposta de Antecipação:",blast.list[app].pages.antecipacao.texto,true,null,"BS-G");
				}
			}else{
				newbalaoInfo(root["antecipacao_listagem"],'Informe um valor desejado para antecipar',(root["antecipacao_solicitar"].x+(root["antecipacao_solicitar"].width/2)),(root["antecipacao_solicitar"].y+30),"BalaoInfo","0x"+corcancel);
			}
		}else{
			newbalaoInfo(root["antecipacao_listagem"],'Você não possui Saldo Antecipável.',(root["antecipacao_solicitar"].x+(root["antecipacao_solicitar"].width/2)),(root["antecipacao_solicitar"].y+30),"BalaoInfo","0x"+corcancel);
		};
	};
	
	// ---------
	// # Scroll:
	addScroller(true,root["antecipacao_titulo"],root["antecipacao_listagem"],root["antecipacao_conteudo"]);
	
};