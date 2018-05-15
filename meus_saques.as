// ====================================================
// MEUS SAQUES - Init
// ====================================================
// Verifica arraste:
var meussaques_mouse_y;

function meus_saques(sessao){
	pages_history.push("meus_saques");
	root["offset_saque"] = convertDataOnlyNumbers(blast.list[app].pages.extras.saque_antecipacao_offset);
	
	// ------------------------------------------
	// Busca informações financeiras do usuário:
	// ------------------------------------------
	connectServer(false,"screen",servidor+"api/list/"+root["User"]['table']+"/id="+root["User"]['id'],[
	],meus_saques_start);
	function meus_saques_start(dados){
		root["meus_saques_wallet"] = dados;
		meus_saques_init(dados);
	};
	function meus_saques_init(dados){
		connectServer(false,"screen",servidor+"api/list/r_atividades/tabela="+root["User"]['table']+",id_responsavel="+root["User"]['id']+",tipo=saque,level=2,order_column=cadastro,order_direct=DESC,page_limit=30",[
		],meussaques_start);
		function meussaques_start(dados){
			meus_saques_load(dados);
		};
	}
	
};
// ====================================================
// MEUS SAQUES - Constroi Página
// ====================================================
function meus_saques_load(dados){
	
	// Título e Descrição:
	root["meussaques_titulo"] = new Titulo();
	root["meussaques_titulo"].y = 170;
	root["meussaques_titulo"].titulo.htmlText="<font color='#"+cortitulos+"'>"+blast.list[app].pages.meus_saques.conteudo.titulo+"</font>";
	root["meussaques_titulo"].texto.htmlText="<font color='#"+cortexto+"'>"+blast.list[app].pages.meus_saques.conteudo.subtitulo+"</font>";
	root["meussaques_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER ;
	tela.addChild(root["meussaques_titulo"]);
	
	// Conteúdos:
	root["meussaques_conteudo"] = new Vazio();
	root["meussaques_conteudo"].y = 250
	tela.addChild(root["meussaques_conteudo"]);
	root["meussaques_listagem"] = new Vazio();
	
	// ----------------------------------------
	// # LISTAGEM DOS ITENS:
	if(dados.list.length==0){
		semConteudo("meussaques_sc",blast.list[app].pages.meus_saques.semconteudo.titulo,blast.list[app].pages.meus_saques.semconteudo.texto,170,blast.list[app].pages.meus_saques.semconteudo.foto,300,root["meussaques_listagem"],0,0,["Solicitar Agora!",meus_saques_clique_act]);
		function meus_saques_clique_act(){
			if(root["meus_saques_wallet"].list[0].carteira.pagarme.saldo>0){
				modal_abrir("saque_modal",["modal_wallet_saque",blast.list[app].pages.carteira_digital.conteudo.saque_taxa,blast.list[app].pages.carteira_digital.conteudo.saque_gratuito,blast.list[app].pages.carteira_digital.conteudo.saque_valor],"Realizar Saque","Informe o valor de saque para:",true,null,"BS-G");
			}else{
				newbalaoInfo(root["meussaques_listagem"],'Você não possui saldo disponível.',(root["meussaques_sc_bt"].x+(root["meussaques_sc_bt"].width/2)),(root["meussaques_sc_bt"].y+30),"BalaoInfo","0x"+corcancel);
			}
		}
	}else{
		var setaCor = coricon;
		var saques = 0;
		for(var i=0; i<dados.list.length; i++){
			// Montagem das linhas do resultado:
			meussaques_criaLinha(i+1,true);
			root["meussaques_listagem"+(i+1)].conteudo = dados.list[i];
			root["data_item"] = convertDataOnlyNumbers(dados.list[i].cadastro);
			root["meussaques_listagem"+(i+1)].horario.htmlText = "<font color='#"+cortexto+"'>"+convertDataDiaMesHora(dados.list[i].cadastro)+"</font>";
			if(dados.list[i].tipo=="saque"){
				setaCor = coricon;
				if(dados.list[i]['status']=="Transferido"){saques+=Number(dados.list[i].valor_final)};
				criaIcon("meussaques_listagem_icon_seta"+(i+1),root["meussaques_listagem"+(i+1)],blast.list.server.server_path+"/com/icones/dinheiro.png",290,13,20,"normal",["0x"+setaCor,"0x"+cortexto],["alpha","easeOutExpo",1]);
				if(root["data_item"]>root["offset_saque"]){
					root["meussaques_listagem"+(i+1)].informacoes.htmlText = "<font color='#"+cortexto+"'>Saque ("+dados.list[i]['status']+")</font>";
				}else{
					root["meussaques_listagem"+(i+1)].informacoes.htmlText = "<font color='#"+cortexto+"'>Saque</font>";
				}
				root["meussaques_listagem_valor"+(i+1)].htmlText = "<font color='#"+setaCor+"'>"+convertValor(dados.list[i].valor_final)+"</font>";
			
			}
		};
		
	}
	setScroller("meussaques_scroller",root["meussaques_listagem"],root["meussaques_conteudo"],350,330,0,0,0,0,false,"VERTICAL")
	
};

// ====================================================
// MEUS SAQUES - CRIAÇÃO DE OBJETO LISTA
// ====================================================
function meussaques_criaLinha(i,clique){
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
	root["meussaques_listagem"+(i)] = new Listagem_simples2();
	root["meussaques_listagem"+(i)].x = 25;
	root["meussaques_listagem"+(i)].y=(root["meussaques_listagem"].height)
	if(clique==true){
		root["meussaques_listagem"+(i)].addEventListener(MouseEvent.MOUSE_DOWN,meussaques_detalhes_start);
		root["meussaques_listagem"+(i)].addEventListener(MouseEvent.MOUSE_UP,meussaques_detalhes_stop);
		root["meussaques_listagem"+(i)].buttonMode = true;
	}
	Tweener.addTween(root["meussaques_listagem"+(i)].linha, {_color:"0xdadada", time: 0,transition: "linear",delay: 0});
	root["meussaques_listagem"].addChild(root["meussaques_listagem"+(i)]);
	root["meussaques_listagem_valor"+(i)] = new TextField();
	root["meussaques_listagem_valor"+(i)].defaultTextFormat = myFormatBoldR;
	root["meussaques_listagem_valor"+(i)].x=180;
	root["meussaques_listagem_valor"+(i)].y=13;
	root["meussaques_listagem_valor"+(i)].selectable=false;
	root["meussaques_listagem_valor"+(i)].autoSize = TextFieldAutoSize.RIGHT;  
	root["meussaques_listagem_valor"+(i)].embedFonts = true;
	root["meussaques_listagem"+(i)].addChild(root["meussaques_listagem_valor"+(i)]);
};
// ====================================================
// MEUS SAQUES
// ====================================================
function meussaques_detalhes_start(e:MouseEvent):void {
	meussaques_mouse_y = this.mouseY;
}
function meussaques_detalhes_stop(e:MouseEvent):void {
	var resultado = this.mouseY-meussaques_mouse_y;
	if(resultado<5 && resultado>-5){
		meussaques_detalhes_open(e.currentTarget.conteudo);
	}
}
function meussaques_detalhes_open(alvo){
	var conteudo = alvo;
	var icone;
	var cor;
	var infos;
	var tamanho;
	var titulo;
	var texto;
	var metodo;
	var agencia = "";
	var conta = "";
	
	connectServer(false,"screen",servidor+"api/list/r_atividades/id="+alvo['id']+",tabela="+root["User"]['table']+",id_responsavel="+root["User"]['id']+",level=3",[
	],meussaques_detalhes_start);
	
	function meussaques_detalhes_start(conteudo){
		conteudo = conteudo.list[0];
		root["data_item"] = convertDataOnlyNumbers(conteudo.cadastro);
		if(conteudo.forma_de_pagamento=="D"){metodo="Débito"}
		if(conteudo.forma_de_pagamento=="C"){metodo="Crédito"}
		cor = coricon; icone = "dinheiro.png"; tamanho="M";
		titulo = "<font color='#"+cortexto+"'>Saque:</font> <font color='#"+cor+"'>"+conteudo.gateway_transaction_id+"</font>";
		texto = blast.list[app].pages.atividades.conteudo.modal_descricao;
		if(conteudo.id_r_contas.conta_poupanca == null){ 
			conteudo.id_r_contas.conta_poupanca = "Conta Corrente";
		}else{
			conteudo.id_r_contas.conta_poupanca = "Conta Corrente";
		};
		if(root["data_item"]>root["offset_saque"]){
			conteudo['status'] = conteudo['status'];
		}else{
			conteudo['status'] = "--";
		}
		infos = [
			["Liberação",convertDataDiaMes(conteudo.liberacao),"e7e7e7",cortexto],
			["Status",conteudo['status'],"e7e7e7",cortexto]
		]
		
		if(conteudo.taxa_gateway_valor==0){
			infos.push(["Taxa de Saque","GRATUITO","33cc33","ffffff"]);
		}else{
			infos.push(["Taxa de Saque",convertValor(conteudo.taxa_gateway_valor),"f65246","ffffff"]);
		}
		infos.push(["Valor Depositado",convertValor(conteudo.valor_total),"e7e7e7",cortexto]);
		infos.push(["Banco",conteudo.id_r_contas.id_r_bancos.nick,"e7e7e7",cortexto]);
		agencia = conteudo.id_r_contas.agencia;
		if(conteudo.id_r_contas.agencia_digito!=""){agencia = conteudo.id_r_contas.agencia+"-"+conteudo.id_r_contas.agencia_digito}
		infos.push(["Agência",agencia,"e7e7e7",cortexto]);
		conta = conteudo.id_r_contas.conta;
		if(conteudo.id_r_contas.conta_digito!=""){conta = conteudo.id_r_contas.conta+"-"+conteudo.id_r_contas.conta_digito}
		infos.push(["Conta",conta,"e7e7e7",cortexto]);
		infos.push(["Tipo",conteudo.id_r_contas.conta_poupanca,"e7e7e7",cortexto]);
		modal_abrir("modal_informacoes",["modal_infos",infos],titulo,texto,true,null,tamanho);
	}
}