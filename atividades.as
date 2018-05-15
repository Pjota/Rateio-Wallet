// ====================================================
// ====================================================
// ATIVIDADES - Init
// ====================================================
// Verifica arraste:
var atividades_mouse_y;
var atividades_filtro = 1;
var atividades_filtroValor = 1;

function atividades(sessao){
	pages_history.push("atividades");
	connectServer(false,"screen",servidor+"api/list/"+blast.list.table['atividades']+"/id=0",[
	],getDate);
	function getDate(dados){
		atividades_load(dados);
	};
};
function atividades_reload(){
	// Variáveis Iniciais:
	var ext = "";
	//ext = ",column=id-cadastro-tipo-status-cliente-codigo-valor-valor_final";
	// # 2) Créditos:
	if(atividades_filtro==2){ ext+=",tipo=C" }
	// # 3) Saques:
	if(atividades_filtro==3){ ext+=",tipo=S" }
	// # 4) Antecipações:
	if(atividades_filtro==4){ ext+=",tipo=A" }
	// # 5) Recebimentos:
	if(atividades_filtro==5){ ext+=",tipo=E" }
	// Chamada na API:
	connectServer(false,"screen",servidor+"api/list/"+blast.list.table['atividades']+"/r_tabela="+root["User"]['table']+",r_id="+root["User"]['id']+",order_column=cadastro,order_direct=ASC,cadastro>="+removeHoras(root["Atividades_DataInicial"])+" 00:00:00,cadastro<="+removeHoras(root["Atividades_DataFinal"])+" 23:59:59"+ext,[
	],atividades_start);
	function atividades_start(dados){
		atividades_list(dados);
	};
};
// ====================================================
// ATIVIDADES - Constroi Página
// ====================================================
function atividades_load(dados){
	
	// Print:
	root["Atividades_DataInicial"] = dados.head['create'];
	root["Atividades_DataFinal"] = dados.head['create'];
	
	// Título e Descrição:
	root["atividades_titulo"] = new Titulo();
	root["atividades_titulo"].y = 100;
	root["atividades_titulo"].titulo.htmlText="<font color='#"+cortitulos+"'>"+blast.list[app].pages.atividades.conteudo.titulo+"</font>";
	root["atividades_titulo"].texto.htmlText="<font color='#"+cortexto+"'>"+blast.list[app].pages.atividades.conteudo.subtitulo+"</font>";
	root["atividades_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER ;
	tela.addChild(root["atividades_titulo"]);
	
	// Cria DateRange:
	criaRangeDate("AtividadesRange",["Data Inicial:","Data Final"],tela,38,170,1,["ffffff",corbt1,cortexto,corbt1],[dados.head['create'],dados.head['create']],"ateagora",true,atividades_reload_set,"GG");
	function atividades_reload_set(data1,data2){
		root["Atividades_DataInicial"] = data1;
		root["Atividades_DataFinal"] = data2;
		atividades_reload();
	}

	// Cria Filtro (POR TIPO):
	criaIcon("Atividades_FiltroIcone",tela,servidor+"com/icones/zoom_detail.png",28,247,20,"normal",["0x"+corbt1,null],["alpha","easeOutExpo",1]);		
	root["Atividades_Filtrolabel"] = new TextoLeft();
	root["Atividades_Filtrolabel"].x = 53; root["Atividades_Filtrolabel"].y = 247; 
	root["Atividades_Filtrolabel"].texto.width =100;
	root["Atividades_Filtrolabel"].texto.htmlText = "<font color='#"+cortexto+"'>Tipo:</font>";
	tela.addChild(root["Atividades_Filtrolabel"]);
	root["Atividades_FiltroCampo"] = new label_simples();
	root["Atividades_FiltroCampo"].x = 85; root["Atividades_FiltroCampo"].y = 245;
	root["Atividades_FiltroCampo"].texto.htmlText = "<font color='#"+cortexto+"'>Todos</font>";
	tela.addChild(root["Atividades_FiltroCampo"]);
	function getFiltros(){
		var combo:Object = new Object();
		combo.list = [];
		combo.list[0] = {id:1, nome:"Todos"}
		combo.list[1] = {id:2, nome:"Vendas"}
		combo.list[2] = {id:3, nome:"Saques"}
		combo.list[3] = {id:4, nome:"Antecipações"}
		combo.list[4] = {id:5, nome:"Estornos"}
		return combo;
	};
	criaCombobox("IC","input_","Filtros","",tela,80,247,.30,"objeto","","","",["0xffffff","0x202020"],null,getFiltros,setFiltro);
	root["input_Filtros"].scaleY = .5;
	Tweener.removeTweens(root["input_Filtros"]);
	root["input_Filtros"].alpha = 0;
	function setFiltro(info){
		atividades_filtro = root["input_Filtros"].valor;
		root["Atividades_FiltroCampo"].texto.htmlText = "<font color='#"+cortexto+"'>"+root["input_Filtros"].texto.text+"</font>";
		atividades_reload();
	};
	
	// Cria Filtro (POR VALOR):
	root["Atividades_FiltrolabelValor"] = new TextoLeft();
	root["Atividades_FiltrolabelValor"].x = 195; root["Atividades_FiltrolabelValor"].y = 247; 
	root["Atividades_FiltrolabelValor"].texto.width =100;
	root["Atividades_FiltrolabelValor"].texto.htmlText = "<font color='#"+cortexto+"'>Valor:</font>";
	tela.addChild(root["Atividades_FiltrolabelValor"]);
	root["Atividades_FiltroCampoValor"] = new label_simples();
	root["Atividades_FiltroCampoValor"].x = 235; root["Atividades_FiltroCampoValor"].y = 245;
	root["Atividades_FiltroCampoValor"].texto.htmlText = "<font color='#"+cortexto+"'>Bruto</font>";
	tela.addChild(root["Atividades_FiltroCampoValor"]);
	function getValores(){
		var combo:Object = new Object();
		combo.list = [];
		combo.list[0] = {id:1, nome:"Bruto"}
		combo.list[1] = {id:2, nome:"Líquido"}
		return combo;
	};
	criaCombobox("IC","input_","FiltrosValor","",tela,235,247,.30,"objeto","","","",["0xffffff","0x202020"],null,getValores,setValores);
	root["input_FiltrosValor"].scaleY = .5;
	Tweener.removeTweens(root["input_FiltrosValor"]);
	root["input_FiltrosValor"].alpha = 0;
	function setValores(info){
		atividades_filtroValor = root["input_FiltrosValor"].valor;
		root["Atividades_FiltroCampoValor"].texto.htmlText = "<font color='#"+cortexto+"'>"+root["input_FiltrosValor"].texto.text+"</font>";
		atividades_reload();
	};
	
	// Cria Espaço onde será criado a Listagem:
	root["atividades_conteudo"] = new Vazio();
	root["atividades_conteudo"].y = 290
	tela.addChild(root["atividades_conteudo"]);
	root["atividades_listagem"] = new Vazio();
	
	// Primeira Busca: "Vendas do Dia":
	connectServer(false,"screen",servidor+"api/list/"+blast.list.table['atividades']+"/r_tabela="+root["User"]['table']+",r_id="+root["User"]['id']+",order_column=cadastro,order_direct=ASC,cadastro>="+removeHoras(root["Atividades_DataInicial"])+" 00:00:00,cadastro<="+removeHoras(root["Atividades_DataFinal"])+" 23:59:59",[
	],atividades_start);
	function atividades_start(dados){
		atividades_list(dados);
	};
};

// ====================================================
// ATIVIDADES - Listagem
// ====================================================
function atividades_list(dados){
	root["AtividadesRange"].ativar();
	// ----------------------------------------
	// Destroir Listagem
	destroir(root["atividades_listagem"],true);
	
	if(dados.list.length==0){
		semConteudo("atividades_sc",blast.list[app].pages.atividades.semconteudo.titulo,blast.list[app].pages.atividades.semconteudo.texto,190,blast.list[app].pages.atividades.semconteudo.foto,335,root["atividades_listagem"],0,0,null);
	}else{
		// ----------------------------------------
		// # VARIÁVEIS INICIAS:
		var valor;
		var setaCor = coricon;
		var creditos = 0;
		var saques = 0;
		var antecipacoes = 0;
		var estornos = 0;
		// ----------------------------------------
		// # LISTAGEM DOS ITENS:
		for(var i=0; i<dados.list.length; i++){
			// Montagem das linhas do resultado:
			atividades_criaLinha(i+1,true);
			root["atividades_listagem"+(i+1)].conteudo = dados.list[i];
			root["atividades_listagem"+(i+1)]['id'] = dados.list[i]['id'];
			root["atividades_listagem"+(i+1)].horario.htmlText = "<font color='#"+cortexto+"'>"+convertDataDiaMesHora(dados.list[i].cadastro)+"</font>";
			// Texto: DATA
			// Texto: DESCRIÇÃO + ÍCONE + VALOR:
			if(dados.list[i].tipo=="C"){
				if(dados.list[i]['status']=="Pago" || dados.list[i]['status']=="paid"){
					setaCor = "494949";
					criaIcon("atividades_listagem_icon_seta"+(i+1),root["atividades_listagem"+(i+1)],blast.list.server.server_path+"/com/icones/more.png",290,13,20,"normal",["0x"+setaCor,"0x"+cortexto],["alpha","easeOutExpo",1]);
					root["atividades_listagem"+(i+1)].informacoes.htmlText = "<font color='#"+cortexto+"'>"+dados.list[i].cliente.substr(0,10)+" ("+dados.list[i].identificador+")</font>";
					if(atividades_filtroValor==1){valor = dados.list[i].valor_bruto}
					if(atividades_filtroValor==2){valor = dados.list[i].valor_liquido}
					creditos+=Number(valor);
					root["atividades_listagem_valor"+(i+1)].htmlText = "<font color='#"+setaCor+"'>"+convertValor(valor)+"</font>";
				};
				if(dados.list[i]['status']=="Processando"){
					setaCor = "999999";
					criaIcon("atividades_listagem_icon_seta"+(i+1),root["atividades_listagem"+(i+1)],blast.list.server.server_path+"/com/icones/clock.png",290,13,20,"normal",["0x"+setaCor,"0x"+cortexto],["alpha","easeOutExpo",1]);
					root["atividades_listagem"+(i+1)].informacoes.htmlText = "<font color='#"+setaCor+"'>"+dados.list[i].cliente.substr(0,10)+" ("+dados.list[i].identificador+")</font>";
					if(atividades_filtroValor==1){
						valor = convertValor(dados.list[i].valor_bruto)+"*"; 
						creditos+=Number(dados.list[i].valor_bruto);
					}
					if(atividades_filtroValor==2){
						valor = "Processando";
						creditos+=0;
					}
					root["atividades_listagem_valor"+(i+1)].htmlText = "<font color='#"+setaCor+"'>"+valor+"</font>";	
				};
				if(dados.list[i]['status']=="Bloqueado"){
					setaCor = "f65246";
					criaIcon("atividades_listagem_icon_seta"+(i+1),root["atividades_listagem"+(i+1)],blast.list.server.server_path+"/com/icones/warning-1.png",290,13,20,"normal",["0x"+setaCor,"0x"+cortexto],["alpha","easeOutExpo",1]);
					root["atividades_listagem"+(i+1)].informacoes.htmlText = "<font color='#"+setaCor+"'>"+dados.list[i].cliente.substr(0,10)+" ("+dados.list[i].identificador+")</font>";
					if(atividades_filtroValor==1){
						valor = convertValor(dados.list[i].valor_bruto)+"*"; 
						creditos+=Number(dados.list[i].valor_bruto);
					}
					if(atividades_filtroValor==2){
						valor = "Processando";
						creditos+=0;
					}
					root["atividades_listagem_valor"+(i+1)].htmlText = "<font color='#"+setaCor+"'>"+valor+"</font>";	
				};
			};
			if(dados.list[i].tipo=="S"){
				root["data_item"] = convertDataOnlyNumbers(dados.list[i].cadastro);
				setaCor = coricon;
				saques+=Number(dados.list[i].valor_liquido)
				criaIcon("atividades_listagem_icon_seta"+(i+1),root["atividades_listagem"+(i+1)],blast.list.server.server_path+"/com/icones/dinheiro.png",290,13,20,"normal",["0x41BF8B","0x"+cortexto],["alpha","easeOutExpo",1]);
				root["atividades_listagem"+(i+1)].informacoes.htmlText = "<font color='#"+cortexto+"'>Saque ("+dados.list[i]['status']+")</font>";
				root["atividades_listagem_valor"+(i+1)].htmlText = "<font color='#"+setaCor+"'>"+convertValor(dados.list[i].valor_liquido)+"</font>";
			};
			if(dados.list[i].tipo=="A"){
				root["data_item"] = convertDataOnlyNumbers(dados.list[i].cadastro);
				setaCor = "41BF8B";
				antecipacoes+=Number(dados.list[i].valor_bruto)
				criaIcon("atividades_listagem_icon_seta"+(i+1),root["atividades_listagem"+(i+1)],blast.list.server.server_path+"/com/icones/dinheiro.png",290,13,20,"normal",["0x"+setaCor,"0x"+cortexto],["alpha","easeOutExpo",1]);
				root["atividades_listagem"+(i+1)].informacoes.htmlText = "<font color='#"+cortexto+"'>Antecipação ("+dados.list[i]['status']+")</font>";
				root["atividades_listagem_valor"+(i+1)].htmlText = "<font color='#"+setaCor+"'>"+convertValor(dados.list[i].valor_liquido)+"</font>";
			};
			if(dados.list[i].tipo=="E"){
				setaCor = "f65246";
				estornos+=Number(dados.list[i].valor_liquido);
				criaIcon("atividades_listagem_icon_seta"+(i+1),root["atividades_listagem"+(i+1)],blast.list.server.server_path+"/com/icones/remove-symbol.png",290,13,20,"normal",["0x"+setaCor,"0x"+cortexto],["alpha","easeOutExpo",1]);
				root["atividades_listagem"+(i+1)].informacoes.htmlText = "<font color='#"+cortexto+"'>"+dados.list[i].cliente.substr(0,10)+" ("+dados.list[i].identificador+")</font>";
				root["atividades_listagem_valor"+(i+1)].htmlText = "<font color='#"+setaCor+"'>"+convertValor(dados.list[i].valor_bruto)+"</font>";
			};
		};
		// ----------------------------------------
		// # SOMA FINAL DE REGISTROS:
		// ----------------------------------------
		var count = (dados.list.length);
		var cor = "";
		// Título e Descrição:
		root["atividades_somafinaltitulo"] = new Titulo_Modal();
		root["atividades_somafinaltitulo"].y = root["atividades_listagem"].height+20;
		root["atividades_somafinaltitulo"].titulo.htmlText="<font color='#"+corbt1+"'>Fechamento:</font>";
		root["atividades_somafinaltitulo"].texto.htmlText="<font color='#"+cortexto+"'>Soma das atividades neste intervalo:</font>";
		root["atividades_somafinaltitulo"].texto.autoSize =  TextFieldAutoSize.CENTER ;
		root["atividades_listagem"].addChild(root["atividades_somafinaltitulo"]);
		// Recebíveis Totais:
		count++;
		atividades_criaLinha(count,false);
		criaIcon("atividades_listagem_icon_seta"+(count),root["atividades_listagem"+(count)],blast.list.server.server_path+"/com/icones/more.png",290,13,20,"normal",["0x494949","0x"+cortexto],["alpha","easeOutExpo",1]);
		root["atividades_listagem"+(count)].informacoes.htmlText = "<font color='#"+cortexto+"'></font>";		
		if(creditos>0){ 
			cor=cortexto;
			root["atividades_listagem_valor"+(count)].htmlText = "<font color='#"+cor+"'>"+convertValor(creditos)+"</font>";
		}else{ 
			cor="999999";
			root["atividades_listagem_valor"+(count)].htmlText = "<font color='#"+cor+"'>R$ 0,00</font>";
		}
		
		root["atividades_listagem"+(count)].horario.htmlText = "<font color='#494949'>Vendas:</font>";
		// Saques:
		count++;
		atividades_criaLinha(count,false);
		criaIcon("atividades_listagem_icon_seta"+(count),root["atividades_listagem"+(count)],blast.list.server.server_path+"/com/icones/dinheiro.png",290,13,20,"normal",["0x"+coricon,"0x"+cortexto],["alpha","easeOutExpo",1]);
		root["atividades_listagem"+(count)].informacoes.htmlText = "<font color='#"+cortexto+"'></font>";
		if(saques>0){ cor=cortexto; }else{ cor="999999"; }
		root["atividades_listagem_valor"+(count)].htmlText = "<font color='#"+cor+"'>"+convertValor(saques)+"</font>";
		root["atividades_listagem"+(count)].horario.htmlText = "<font color='#"+coricon+"'>Saques:</font>";
		// Antecipações:
		count++;
		atividades_criaLinha(count,false);
		criaIcon("atividades_listagem_icon_seta"+(count),root["atividades_listagem"+(count)],blast.list.server.server_path+"/com/icones/dinheiro.png",290,13,20,"normal",["0x41BF8B","0x"+cortexto],["alpha","easeOutExpo",1]);
		root["atividades_listagem"+(count)].informacoes.htmlText = "<font color='#"+cortexto+"'></font>";
		if(antecipacoes>0){ cor=cortexto; }else{ cor="999999"; }
		root["atividades_listagem_valor"+(count)].htmlText = "<font color='#"+cor+"'>"+convertValor(antecipacoes)+"</font>";
		root["atividades_listagem"+(count)].horario.htmlText = "<font color='#41BF8B'>Antecipações:</font>";
		// Saques:
		count++;
		atividades_criaLinha(count,false);
		criaIcon("atividades_listagem_icon_seta"+(count),root["atividades_listagem"+(count)],blast.list.server.server_path+"/com/icones/remove-symbol.png",290,13,20,"normal",["0xf65246","0x"+cortexto],["alpha","easeOutExpo",1]);
		root["atividades_listagem"+(count)].informacoes.htmlText = "<font color='#"+cortexto+"'></font>";
		if(estornos>0){ cor=cortexto; }else{ cor="999999"; }
		root["atividades_listagem_valor"+(count)].htmlText = "<font color='#"+cor+"'>"+convertValor(estornos)+"</font>";
		root["atividades_listagem"+(count)].horario.htmlText = "<font color='#f65246'>Estornos:</font>";
		
	};
	// ---------------------
	// # Scroll:
	setScroller("atividades_scroller",root["atividades_listagem"],root["atividades_conteudo"],350,290,0,0,0,0,true,"VERTICAL")
};

// ====================================================
// ATIVIDADES - CRIAÇÃO DE OBJETO LISTA
// ====================================================
function atividades_criaLinha(i,clique){
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
	root["atividades_listagem"+(i)] = new Listagem_simples2();
	root["atividades_listagem"+(i)].x = 25;
	root["atividades_listagem"+(i)].y=(root["atividades_listagem"].height)
	if(clique==true){
		root["atividades_listagem"+(i)].addEventListener(MouseEvent.MOUSE_DOWN,atividades_detalhes_start);
		root["atividades_listagem"+(i)].addEventListener(MouseEvent.MOUSE_UP,atividades_detalhes_stop);
		root["atividades_listagem"+(i)].buttonMode = true;
	}
	Tweener.addTween(root["atividades_listagem"+(i)].linha, {_color:"0xdadada", time: 0,transition: "linear",delay: 0});
	root["atividades_listagem"].addChild(root["atividades_listagem"+(i)]);
	root["atividades_listagem_valor"+(i)] = new TextField();
	root["atividades_listagem_valor"+(i)].defaultTextFormat = myFormatBoldR;
	root["atividades_listagem_valor"+(i)].x=180;
	root["atividades_listagem_valor"+(i)].y=13;
	root["atividades_listagem_valor"+(i)].selectable=false;
	root["atividades_listagem_valor"+(i)].autoSize = TextFieldAutoSize.RIGHT;  
	root["atividades_listagem_valor"+(i)].embedFonts = true;
	root["atividades_listagem"+(i)].addChild(root["atividades_listagem_valor"+(i)]);
};

// ====================================================
// ATIVIDADES - Modal com detalhes
// ====================================================
function atividades_detalhes_start(e:MouseEvent):void {
	atividades_mouse_y = this.mouseY;
}
function atividades_detalhes_stop(e:MouseEvent):void {
	var resultado = this.mouseY-atividades_mouse_y;
	if(resultado<5 && resultado>-5){
		atividades_detalhes_open(e.currentTarget['id']);
	}
}
function atividades_detalhes_open(alvo){
	var conteudo = alvo;
	var icone;
	var cor;
	var infos;
	var tamanho;
	var titulo;
	var texto;
	var metodo;
	
	connectServer(false,"screen",servidor+"api/list/"+blast.list.table['atividades']+"/id="+alvo+",r_tabela="+root["User"]['table']+",r_id="+root["User"]['id']+",level=3",[
	],atividades_detalhes_start);
	
	function atividades_detalhes_start(resultado){
		var conteudo = resultado.list[0];
		var agencia = "";
		var conta = "";
		
		// # Definição de Tipos de Atividade:
		if(conteudo.tipo=="C"){ 
			if(conteudo['status']=="Pago"){
				cor = "494949"; icone = "more.png"; tamanho="BS-G";
				titulo = "<font color='#"+cortexto+"'>Transação:</font> <font color='#"+cor+"'>"+conteudo.identificador+"</font>";
				texto = "Empresa: X - Cliente: "+conteudo.cliente;
				if(convertDataDiaMesHora(conteudo.liberacao)!="erro"){
					this['data_liberacao'] = convertDataDiaMesHora(conteudo.liberacao);
				}else{
					this['data_liberacao'] = "--/--";
				};
				infos = [
					["Pagamento",convertDataDiaMesHora(conteudo.cadastro),"f4f4f4",cortexto],
					["Liberação",this['data_liberacao'],"f4f4f4",cortexto]
				]
			};
			if(conteudo['status']=="Processando"){
				cor = "999999"; icone = "clock.png"; tamanho="BS-G";
				titulo = "<font color='#"+cortexto+"'>Transação:</font> <font color='#"+cor+"'>"+conteudo.identificador+"</font>";
				texto = "Empresa: X - Cliente: "+conteudo.cliente;
				//texto = blast.list[app].pages.atividades.conteudo.modal_descricao+" <font color='#"+corbt1+"'>"+conteudo.token+"</font>";
				infos = [
					["Pagamento",convertDataDiaMesHora(conteudo.cadastro),"f4f4f4",cortexto],
					["Análise RD","1 Dia (Útil)","f4f4f4",cortexto]
				]
			};
			if(conteudo['status']=="Bloqueado"){
				cor = "f65246"; icone = "warning-1.png"; tamanho="BS-G";
				titulo = "<font color='#"+cortexto+"'>Transação:</font> <font color='#"+cor+"'>"+conteudo.identificador+"</font>";
				texto = "Empresa: X - Cliente: "+conteudo.cliente;
				//texto = blast.list[app].pages.atividades.conteudo.modal_descricao+" <font color='#"+corbt1+"'>"+conteudo.token+"</font>";
				infos = [
					["Pagamento",convertDataDiaMesHora(conteudo.cadastro),"f4f4f4",cortexto],
					["Status","Ag. Credenciamento","f65246","ffffff"]
				]
			};
		};
		
		if(conteudo.tipo=="A"){ 
			root["data_item"] = convertDataOnlyNumbers(conteudo.cadastro);
			cor = "41BF8B"; icone = "dinheiro.png"; tamanho="BS-G";
			titulo = "<font color='#"+cortexto+"'>Antecipação:</font> <font color='#"+cor+"'>"+convertValor(conteudo.valor)+"</font>";
			texto = "";
			//texto = ""+blast.list[app].pages.antecipacao.antecipacao_descricao+" <font color='#"+corbt1+"'>"+conteudo.token+"</font>";;
			if(root["data_item"]>root["offset_saque_antecipacao"]){
				infos = [
					["Status",conteudo['status'],"e7e7e7",cortexto],
					["Liberação",convertDataDiaMes(conteudo.liberacao),"e7e7e7",cortexto],
					["Código",conteudo.gateway_transaction_id,"e7e7e7",cortexto],
					["Taxa",convertValor(conteudo.taxa_gateway_valor),"f65246","ffffff"],
					["Valor Antecipado",convertValor(conteudo.valor_final),"e7e7e7",cortexto]
				]
			}else{
				infos = [
					["Status","--","e7e7e7",cortexto],
					["Liberação",convertDataDiaMes(conteudo.liberacao),"e7e7e7",cortexto],
					["Código",conteudo.gateway_transaction_id,"e7e7e7",cortexto],
					["Taxa",convertValor(conteudo.taxa_gateway_valor),"f65246","ffffff"],
					["Valor Antecipado",convertValor(conteudo.valor_final),"e7e7e7",cortexto]
				]
			};
		};
		
		if(conteudo.tipo=="S"){
			root["data_item"] = convertDataOnlyNumbers(conteudo.cadastro);
			cor = coricon; icone = "dinheiro.png"; tamanho="BS-M";
			titulo = "<font color='#"+cortexto+"'>Saque:</font> <font color='#"+cor+"'>"+conteudo.token+"</font>";
			texto = "";
			if(root["data_item"]>root["offset_saque_antecipacao"]){
				infos = [
					["Liberação",convertDataDiaMes(conteudo.liberacao),"e7e7e7",cortexto],
					["Status",conteudo['status'],"e7e7e7",cortexto]
				]
			}else{
				infos = [
					["Liberação",convertDataDiaMes(conteudo.liberacao),"e7e7e7",cortexto],
					["Status","--","e7e7e7",cortexto]
				]
			}
			
			if(conteudo.taxa_gateway_valor==0){
				infos.push(["Taxa de Saque","GRATUITO","33cc33","ffffff"]);
			}else{
				infos.push(["Taxa de Saque",convertValor(conteudo.taxa_gateway_valor),"f65246","ffffff"]);
			}
			infos.push(["Valor Depositado",convertValor(conteudo.valor_final),"e7e7e7",cortexto]);
			infos.push(["Banco",conteudo.id_contas.id_bl_bancos.nick,"e7e7e7",cortexto]);
			agencia = conteudo.id_contas.agencia;
			if(conteudo.id_contas.agencia_digito!=""){agencia = conteudo.id_contas.agencia+"-"+conteudo.id_contas.agencia_digito}
			infos.push(["Agência",agencia,"e7e7e7",cortexto]);
			conta = conteudo.id_contas.conta;
			if(conteudo.id_contas.conta_digito!=""){conta = conteudo.id_contas.conta+"-"+conteudo.id_contas.conta_digito}
			infos.push(["Conta",conta,"e7e7e7",cortexto]);
			infos.push(["Tipo",conteudo.id_bl_contas.conta_poupanca,"e7e7e7",cortexto]);
		}
		if(conteudo.tipo=="E"){ 
			cor = "f65246"; icone = "remove-symbol.png"; tamanho="BS-M";
			titulo = "<font color='#"+cortexto+"'>Transações:</font> <font color='#"+cor+"'>"+conteudo.identificador+"</font>";
			texto = "";
			//texto = blast.list[app].pages.atividades.conteudo.modal_descricao+" <font color='#"+corbt1+"'>"+conteudo.token+"</font>";;
			infos = [
				["Estorno",convertDataDiaMesHora(conteudo.atualizacao),"e7e7e7",cortexto],
				["Status","Estornado",cor,"ffffff"],
				["Cliente",conteudo.cliente,"e7e7e7",cortexto],
				["Bandeira",conteudo.id_bl_cartoes.bandeira,"e7e7e7",cortexto],
				["Forma / Parcela",conteudo.id_bl_pagamento_forma.nick+" "+conteudo.parcelas+"x ("+conteudo.parcela+"/"+conteudo.parcelas+")","e7e7e7",cortexto]
			]
		};

		modal_abrir("modal_informacoes",["modal_infos",infos],titulo,texto,true,atividades_reportar,tamanho);
		
		// ==================================================
		// Aplica Informações:
		// ==================================================
		if(conteudo.tipo=="C"){
			// # Título:
			root["atividades_relatorio_titulo"] = new Titulo_Modal();
			root["atividades_relatorio_titulo"].y = 220;
			root["atividades_relatorio_titulo"].titulo.htmlText="<font color='#"+coricon+"' size='18'>Detalhamento:</font>";
			root["atividades_relatorio_titulo"].texto.htmlText="";
			root["modal_informacoes"].addChild(root["atividades_relatorio_titulo"]);
			// # Linhas:
			var rel_y = root["atividades_relatorio_titulo"].y+40;
			// - Valor total da Venda
			root["atividades_relatorio_l"+rel_y] = new relatorio_linha_normal();
			root["atividades_relatorio_l"+rel_y]['info'].htmlText="<font color='#"+cortexto+"'>Total da Venda ("+conteudo.identificador+")</font>";
			root["atividades_relatorio_l"+rel_y]['valor'].htmlText="<font color='#"+cortexto+"'>"+convertValor(conteudo.valor_total)+"</font>";
			root["atividades_relatorio_l"+rel_y].x = 70;
			root["atividades_relatorio_l"+rel_y].y = rel_y;
			root["modal_informacoes"].addChild(root["atividades_relatorio_l"+rel_y]);
			rel_y += root["atividades_relatorio_l"+rel_y].height+4;
			// - Bandeira e forma de Pagamento
			root["atividades_relatorio_l"+rel_y] = new relatorio_linha_normal();
			root["atividades_relatorio_l"+rel_y]['info'].htmlText="<font color='#"+cortexto+"'>"+conteudo.id_bl_pagamento_forma.nome+" "+conteudo.parcelas+"x ("+conteudo.parcela+"/"+conteudo.parcelas+")</font>";
			root["atividades_relatorio_l"+rel_y]['valor'].htmlText="<font color='#"+cortexto+"'>"+conteudo.id_bl_cartoes.bandeira_real+"</font>";
			root["atividades_relatorio_l"+rel_y].x = 70;
			root["atividades_relatorio_l"+rel_y].y = rel_y;
			root["modal_informacoes"].addChild(root["atividades_relatorio_l"+rel_y]);
			rel_y += root["atividades_relatorio_l"+rel_y].height+4;
			// - Valor Bruto do Usuário
			root["atividades_relatorio_l"+rel_y] = new relatorio_linha_bold();
			root["atividades_relatorio_l"+rel_y]['info'].htmlText="<font color='#"+cortexto+"'>"+root["User"].nome+" (Bruto)</font>";
			root["atividades_relatorio_l"+rel_y]['valor'].htmlText="<font color='#"+cortexto+"'>"+convertValor(conteudo.valor_bruto)+"</font>";
			root["atividades_relatorio_l"+rel_y].x = 70;
			root["atividades_relatorio_l"+rel_y].y = rel_y;
			root["modal_informacoes"].addChild(root["atividades_relatorio_l"+rel_y]);
			rel_y += root["atividades_relatorio_l"+rel_y].height+4;
			// - MDR
			root["atividades_relatorio_l"+rel_y] = new relatorio_linha_normal();
			root["atividades_relatorio_l"+rel_y]['info'].htmlText="<font color='#"+cortexto+"'>Taxa de Cartão ("+conteudo.valor_taxa+"%)</font>";
			root["atividades_relatorio_l"+rel_y]['valor'].htmlText="<font color='#f12d4e'>- "+convertValor(conteudo.valor_bruto-conteudo.valor_liquido)+"</font>";
			root["atividades_relatorio_l"+rel_y].x = 70;
			root["atividades_relatorio_l"+rel_y].y = rel_y;
			root["modal_informacoes"].addChild(root["atividades_relatorio_l"+rel_y]);
			rel_y += root["atividades_relatorio_l"+rel_y].height+4;
			// - Regra Fixa:
			root["atividades_relatorio_l"+rel_y] = new relatorio_linha_normal();
			root["atividades_relatorio_l"+rel_y]['info'].htmlText="<font color='#"+cortexto+"'>TXS2</font>";
			root["atividades_relatorio_l"+rel_y]['valor'].htmlText="<font color='#f12d4e'>- "+convertValor(1.00)+"</font>";
			root["atividades_relatorio_l"+rel_y].x = 70;
			root["atividades_relatorio_l"+rel_y].y = rel_y;
			root["modal_informacoes"].addChild(root["atividades_relatorio_l"+rel_y]);
			rel_y += root["atividades_relatorio_l"+rel_y].height+4; 
			// - Débitos (Dívidas)
			root["atividades_relatorio_l"+rel_y] = new relatorio_linha_normal();
			root["atividades_relatorio_l"+rel_y]['info'].htmlText="<font color='#"+cortexto+"'>Dívidas</font> <font color='#"+corbt1+"'>(+) Ver Detalhes</font>";
			root["atividades_relatorio_l"+rel_y]['valor'].htmlText="<font color='#f12d4e'>- "+convertValor(3.00)+"</font>";
			root["atividades_relatorio_l"+rel_y].x = 70;
			root["atividades_relatorio_l"+rel_y].y = rel_y;
			root["modal_informacoes"].addChild(root["atividades_relatorio_l"+rel_y]);
			rel_y += root["atividades_relatorio_l"+rel_y].height+4; 
			// Valor Final
			root["atividades_relatorio_l"+rel_y] = new relatorio_linha_bold();
			root["atividades_relatorio_l"+rel_y]['info'].htmlText="<font color='#33cc33'>Valor Final:</font>";
			root["atividades_relatorio_l"+rel_y]['valor'].htmlText="<font color='#33cc33'>"+convertValor(conteudo.valor_liquido)+"</font>";
			root["atividades_relatorio_l"+rel_y].x = 70;
			root["atividades_relatorio_l"+rel_y].y = rel_y;
			root["modal_informacoes"].addChild(root["atividades_relatorio_l"+rel_y]);
			rel_y += root["atividades_relatorio_l"+rel_y].height+4;
			
			qrcode_view(root["modal_informacoes"],convertDataOnlyNumbers(conteudo.cadastro)+"_"+conteudo['r_id']+"_"+conteudo['id']+"_"+conteudo['token'],(365/2),rel_y+35+10,70);
	
			
			/*
			
			texto = "Por existir créditos originados de vendas parceladas, fique atento a data de liberação. Assim que liberado, o valor ficará disponível para saque.";
			
			//# BOTÃO CADASTRAR:
			criaBt("credito_antecipar","Antecipar Recebimento",root["modal_informacoes"],50,555,.85,"0x"+corbt1,"G");
			root["credito_antecipar"].addEventListener(MouseEvent.CLICK, vaiantecipacao);
			root["credito_antecipar"].buttonMode = true;
			function vaiantecipacao(){
				modal_fechar(modalHistory[0]);
				pages_new("antecipacao","antecipacao");
			};
			*/
		};
		
	};
};
function atividades_reportar(){
	trace("enviou")
};
	