// ====================================================
// MINHAS ANTECIPACOES - Init
// ====================================================
// Verifica arraste:
var minhasantecipacoes_mouse_y;

function minhas_antecipacoes(sessao){
	pages_history.push("minhas_antecipacoes");
	root["offset_antecipacao"] = convertDataOnlyNumbers(blast.list[app].pages.extras.saque_antecipacao_offset);
	// ------------------------------------------
	// Busca informações financeiras do usuário:
	// ------------------------------------------
	connectServer(false,"screen",servidor+"api/max/wallet",[
	],minhas_antecipacoes_start);
	function minhas_antecipacoes_start(dados){
		root["minhas_antecipacoes_wallet"] = dados;
		minhas_antecipacoes_init(dados);
	};
	function minhas_antecipacoes_init(dados){
		connectServer(false,"screen",servidor+"api/list/r_atividades/tabela="+root["User"]['table']+",id_responsavel="+root["User"]['id']+",tipo=antecipacao,level=2,order_column=cadastro,order_direct=DESC,page_limit=30",[
		],minhas_antecipacoes_start);
		function minhas_antecipacoes_start(dados){
			minhas_antecipacoes_load(dados);
		};
	};
};
// ====================================================
// MINHAS ANTECIPAÇÕES - Constroi Página
// ====================================================
function minhas_antecipacoes_load(dados){
	
	// Título e Descrição:
	root["minhasantecipacoes_titulo"] = new Titulo();
	root["minhasantecipacoes_titulo"].y = 170;
	root["minhasantecipacoes_titulo"].titulo.htmlText="<font color='#"+cortitulos+"'>"+blast.list[app].pages.minhas_antecipacoes.conteudo.titulo+"</font>";
	root["minhasantecipacoes_titulo"].texto.htmlText="<font color='#"+cortexto+"'>"+blast.list[app].pages.minhas_antecipacoes.conteudo.subtitulo+"</font>";
	root["minhasantecipacoes_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER ;
	tela.addChild(root["minhasantecipacoes_titulo"]);
	
	// Conteúdos:
	root["minhasantecipacoes_conteudo"] = new Vazio();
	root["minhasantecipacoes_conteudo"].y = 250
	tela.addChild(root["minhasantecipacoes_conteudo"]);
	root["minhasantecipacoes_listagem"] = new Vazio();
	
	// ----------------------------------------
	// # LISTAGEM DOS ITENS:
	if(dados.list.length==0){
		semConteudo("minhasantecipacoes_sc",blast.list[app].pages.minhas_antecipacoes.semconteudo.titulo,blast.list[app].pages.minhas_antecipacoes.semconteudo.texto,170,blast.list[app].pages.minhas_antecipacoes.semconteudo.foto,300,root["minhasantecipacoes_listagem"],0,0,["Simular Proposta",minhas_antecipacoes_clique_act]);
		function minhas_antecipacoes_clique_act(){
			pages_new("antecipacao","antecipacao");
		};
	}else{
		var setaCor = coricon;
		var antecipacoes = 0;
		for(var i=0; i<dados.list.length; i++){
			// Montagem das linhas do resultado:
			minhasantecipacoes_criaLinha(i+1,true);
			root["minhasantecipacoes_listagem"+(i+1)].conteudo = dados.list[i];
			root["data_item"] = convertDataOnlyNumbers(dados.list[i].cadastro);
			root["minhasantecipacoes_listagem"+(i+1)].horario.htmlText = "<font color='#"+cortexto+"'>"+convertDataDiaMesHora(dados.list[i].cadastro)+"</font>";
			setaCor = "41BF8B";
			if(dados['status']=="Aprovado"){antecipacoes+=Number(dados.list[i].valor_final)};
			criaIcon("minhasantecipacoes_listagem_icon_seta"+(i+1),root["minhasantecipacoes_listagem"+(i+1)],blast.list.server.server_path+"/com/icones/dinheiro.png",290,13,20,"normal",["0x"+setaCor,"0x"+cortexto],["alpha","easeOutExpo",1]);
			if(root["data_item"]>root["offset_antecipacao"]){
				root["minhasantecipacoes_listagem"+(i+1)].informacoes.htmlText = "<font color='#"+cortexto+"'>Antecipação ("+dados.list[i]['status']+")</font>";
			}else{
				root["minhasantecipacoes_listagem"+(i+1)].informacoes.htmlText = "<font color='#"+cortexto+"'>Antecipação</font>";
			}
			root["minhasantecipacoes_listagem_valor"+(i+1)].htmlText = "<font color='#"+setaCor+"'>"+convertValor(dados.list[i].valor_final)+"</font>";
		};
	};
	setScroller("minhasantecipacoes_scroller",root["minhasantecipacoes_listagem"],root["minhasantecipacoes_conteudo"],350,330,0,0,0,0,false,"VERTICAL")
	
};

// ====================================================
// MEUS SAQUES - CRIAÇÃO DE OBJETO LISTA
// ====================================================
function minhasantecipacoes_criaLinha(i,clique){
	var myFont = new MyriadC();
	var myFormat:TextFormat = new TextFormat();
	myFormat.size = 16;
	myFormat.font = myFont.fontName;
	var myFontBold = new MyriadCBold();
	var myFormatBold:TextFormat = new TextFormat();
	myFormatBold.size = 16;
	myFormatBold.font = myFontBold.fontName;
	var myFontBoldR = new MyriadCBold();
	var myFormatBoldR:TextFormat = new TextFormat();
	myFormatBoldR.size = 16;
	myFormatBoldR.align = TextFormatAlign.RIGHT;
	myFormatBoldR.font = myFontBoldR.fontName;
	root["minhasantecipacoes_listagem"+(i)] = new Listagem_simples2();
	root["minhasantecipacoes_listagem"+(i)].x = 25;
	root["minhasantecipacoes_listagem"+(i)].y=(root["minhasantecipacoes_listagem"].height)
	if(clique==true){
		root["minhasantecipacoes_listagem"+(i)].addEventListener(MouseEvent.MOUSE_DOWN,minhasantecipacoes_detalhes_start);
		root["minhasantecipacoes_listagem"+(i)].addEventListener(MouseEvent.MOUSE_UP,minhasantecipacoes_detalhes_stop);
		root["minhasantecipacoes_listagem"+(i)].buttonMode = true;
	}
	Tweener.addTween(root["minhasantecipacoes_listagem"+(i)].linha, {_color:"0xdadada", time: 0,transition: "linear",delay: 0});
	root["minhasantecipacoes_listagem"].addChild(root["minhasantecipacoes_listagem"+(i)]);
	root["minhasantecipacoes_listagem_valor"+(i)] = new TextField();
	root["minhasantecipacoes_listagem_valor"+(i)].defaultTextFormat = myFormatBoldR;
	root["minhasantecipacoes_listagem_valor"+(i)].x=180;
	root["minhasantecipacoes_listagem_valor"+(i)].y=13;
	root["minhasantecipacoes_listagem_valor"+(i)].selectable=false;
	root["minhasantecipacoes_listagem_valor"+(i)].autoSize = TextFieldAutoSize.RIGHT;  
	root["minhasantecipacoes_listagem_valor"+(i)].embedFonts = true;
	root["minhasantecipacoes_listagem"+(i)].addChild(root["minhasantecipacoes_listagem_valor"+(i)]);
};
// ====================================================
// MINHAS ANTECIPAÇÕES
// ====================================================
function minhasantecipacoes_detalhes_start(e:MouseEvent):void {
	minhasantecipacoes_mouse_y = this.mouseY;
}
function minhasantecipacoes_detalhes_stop(e:MouseEvent):void {
	var resultado = this.mouseY-minhasantecipacoes_mouse_y;
	if(resultado<5 && resultado>-5){
		minhasantecipacoes_detalhes_open(e.currentTarget.conteudo);
	}
}
function minhasantecipacoes_detalhes_open(alvo){
	var conteudo = alvo;
	var icone;
	var cor;
	var infos;
	var tamanho;
	var titulo;
	var texto;
	var metodo;
	
	connectServer(false,"screen",servidor+"api/list/r_atividades/id="+alvo['id']+",tabela="+root["User"]['table']+",id_responsavel="+root["User"]['id']+",level=3",[
	],minhasantecipacoes_detalhes_start);
	
	function minhasantecipacoes_detalhes_start(resultado){
		
		if(conteudo.forma_de_pagamento=="D"){metodo="Débito"}
		if(conteudo.forma_de_pagamento=="C"){metodo="Crédito"}
		if(conteudo.tipo=="antecipacao"){ 
			cor = "41BF8B"; icone = "dinheiro.png"; tamanho="M";
			titulo = "<font color='#"+cortexto+"'>Antecipação:</font> <font color='#"+cor+"'>"+convertValor(conteudo.valor_final)+"</font>";
			texto = ""+blast.list[app].pages.antecipacao.antecipacao_descricao;
			if(root["data_item"]>root["offset_antecipacao"]){
				conteudo['status'] = conteudo['status'];
			}else{
				conteudo['status'] = "--";
			}
			infos = [
				["Status",conteudo['status'],"e7e7e7",cortexto],
				["Liberação",convertDataDiaMes(conteudo.liberacao),"e7e7e7",cortexto],
				["Código",conteudo.gateway_transaction_id,"e7e7e7",cortexto],
				["Valor Antecipado",convertValor(conteudo.valor),"e7e7e7",cortexto],
				["Taxa",convertValor(conteudo.taxa_gateway_valor),"f65246","ffffff"],
				["Valor Final",convertValor(conteudo.valor_final),"e7e7e7",cortexto]
			]
			
		}
		modal_abrir("modal_informacoes",["modal_infos",infos],titulo,texto,true,null,tamanho);
	}
}