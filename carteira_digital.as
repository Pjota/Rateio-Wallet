// ====================================================
// CARTEIRA DIGITAL - Init
// ====================================================
function carteira_digital(sessao){
	pages_history.push(sessao);
	root[blast.list[app].pages.menu_superior.template+"_alpha"](false,"normal");
	
	// -------------------------------------
	// #1) Verifica se o "USER" está ativo:
	// -------------------------------------
	// 1.1) Existe Carteira? Está Finalizada?
	connectServer(false,"screen",servidor+"api/list/"+blast.list.table['carteiras']+"/r_tabela="+root["User"]['table']+",r_id="+root["User"]['id']+",ativo=1",[
	],carteira_digital_verifica_atividade);
	function carteira_digital_verifica_atividade(dados){
		if(dados.list.length>0){
			var total_carteiras = dados.list.length;
			var status_geral = "finalizado";
			var i;
			// Em Processo: (Aguardando Análise)
			for(i=0; i<total_carteiras; i++){
				if(dados.list[i]['status']=="Em Processo"){
					status_geral = "em_processo";
				};
			};
			// Pendente: (Usuário Precisa inserir informações obrigatórias)
			for(i=0; i<total_carteiras; i++){
				if(dados.list[i]['status']=="Pendente"){
					status_geral = "pendente";
				};
			};
			// Removido: (Usuário negado ou descredenciado por algum motivo)
			for(i=0; i<total_carteiras; i++){
				if(dados.list[i]['status']=="Removido"){
					status_geral = "removido";
				};
			};
			// Novo: Em caso de novo, encaminha para credenciamento:
			if(status_geral!="Finalizado"){
				for(i=0; i<total_carteiras; i++){
					if(dados.list[i]['status']=="Novo"){
						status_geral = "novo";
					};
				};
			};
			// ==================
			// Direciona Usuário:
			// ==================
			// #
			trace("----------------------------------------");
			trace(" Status de Credenciamento (Carteira):");
			trace(" + Status: "+status_geral);
			trace(" + Configuração de Credenciamento: "+blast.list.vendas.config.credenciamento_rapido);
			if(blast.list.vendas.config.credenciamento_rapido==true){
				if(status_geral == "novo"){
					carteira_digital_bemvindo(false);
				}else{
					carteira_digital_notificacoes();
				};
			}else{
				if(status_geral == "finalizado"){
					carteira_digital_notificacoes();
				};
				if(status_geral == "em_processo"){
					carteira_digital_emprocesso()
				};
				if(status_geral == "pendente"){
					carteira_digital_bemvindo(false);
				};
				if(status_geral == "removido"){
					root["User"] = [];
					mySharedObject.data.senha = "";
					mySharedObject.data.passoapasso = "";
					mySharedObject.flush();
					rebootBlast();
				};
				if(status_geral == "novo"){
					carteira_digital_bemvindo(false);
				};
			};
		}else{
			carteira_digital_bemvindo(true);
		};
	};
	// 1.2) NÃO: Envia o cliente ao Credenciamento:
	function carteira_digital_bemvindo(criar_carteira){
		var user:Array = root["User"]['nome'].split(" "); 
		var titulo = "Olá "+user[0]+", seja bem vindo(a) à "+blast.list.nome+"!";
		var texto = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec pulvinar nec urna vel consequat. Donec scelerisque nisi quis purus dignissim, ac convallis.";
		modal_abrir("sem_carteira",["texto",titulo,texto],"","",false,null,"M");
		img_load("sem_carteira_img",blast.list[app].paths.upload_path+"/"+cadastro_img,root["sem_carteira"],["width",200],null,[85,180,"left"],[],0,null)
		root["modal_texto"].y+=120;
		criaBt("sem_carteira_cadastrar","Vamos lá!",root["sem_carteira"],117,450,.95,"0x"+corbt1,"M");
		root["sem_carteira_cadastrar"].addEventListener(MouseEvent.CLICK, sem_carteira_iniciar);
		root["sem_carteira_cadastrar"].buttonMode = true;
		Tweener.addTween(root["sem_carteira_cadastrar"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
		function sem_carteira_iniciar(e:MouseEvent):void {
			trace("Criar Carteira: "+criar_carteira);
			modal_fecha_ultimo();
			ativacao_start();
		};
	};
	// 2.2) NÃO: Envia o cliente ao Credenciamento:
	function carteira_digital_emprocesso(){
		var user:Array = root["User"]['nome'].split(" "); 
		var titulo = "Aguarde. Seu cadastro<br>está sendo analisado.";
		var texto = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec pulvinar nec urna vel consequat. Donec scelerisque nisi quis purus dignissim, ac convallis.";
		modal_abrir("sem_carteira",["texto",titulo,texto],"","",false,null,"M");
		img_load("sem_carteira_img",blast.list[app].paths.upload_path+"/"+cadastro_pendente,root["sem_carteira"],["width",200],null,[85,180,"left"],[],0,null)
		root["modal_texto"].y+=120;
		criaBt("sem_carteira_conheca","Conheça",root["sem_carteira"],117,450,.95,"0x"+corbt1,"M");
		root["sem_carteira_conheca"].addEventListener(MouseEvent.CLICK, sem_carteira_manual);
		root["sem_carteira_conheca"].buttonMode = true;
		Tweener.addTween(root["sem_carteira_conheca"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
		function sem_carteira_manual(e:MouseEvent):void {
			var link:URLRequest = new URLRequest(blast.list[app].manual);
			navigateToURL(link, "_blank");
		};
	};
	
	// -------------------------------------
	// #2) Inicia ATIVAÇÃO de "USER":
	// -------------------------------------
	// Observação: As funções deste metodo são importadas via Include (por organização)
	// [Etapas de Ativação]
	// Start: Monta o Design do BOX + Verifica em que estágio se encontra esta ativação.
	// 1) Dados Pessoais (Nome + CPF + Avatar)
	// 2) Endereço Ccompleto
	// 3) Informações Bancárias:
	include "ativacao.as";
	
	// ----------------------------------------------
	// #3) LOGADO | Verifica se existem notificações:
	// ----------------------------------------------
	function carteira_digital_notificacoes(){
		/*
		connectServer(false,"screen",servidor+"api/now/",[
		],gethorario);
		function gethorario(dados){
			connectServer(false,"screen",servidor+"api/list/blast_modals/produto="+app_name+",page="+sessao+",validade>"+dados.head['print'],[
			],carteira_digital_modal);
			function carteira_digital_modal(dados){
				modal_comunicacao_start(dados,carteira_digital_init);
			};
		};
		*/
		carteira_digital_init();
	}
	// ----------------------------------------------
	// #4) LOGADO | Busca créditos das Wallete ma.X:
	// ----------------------------------------------
	function carteira_digital_init(){
		connectServer(false,"screen",servidor+"api/max/wallet",[
		],carteira_digital_start);
		function carteira_digital_start(dados){
			carteira_digital_load(dados);
		};
	};
	
};
// ====================================================
// CARTEIRA DIGITAL - Constroi Página
// ====================================================
function carteira_digital_load(dados){
	// ----------------------
	// Variáveis Iniciais:
	// ----------------------
	var conteudo = new Vazio();
	var valor = convertValorSemSifrao(dados.list.max.disponivel+dados.list.max.disponivel_bloqueado);
	var valor_a_receber = convertValorSemSifrao(dados.list.max.areceber+dados.list.max.areceber_bloqueado);
	var ultimo_saque;
	if(dados.list.max.ultimo_saque=="0000-00-00 00:00:00"){
		ultimo_saque = "--/--";
	}else{
		ultimo_saque = convertDataDiaMes(dados.list.max.ultimo_saque);
	};
	// -------------------
	// Título e Descrição:
	// -------------------
	root["carteira_digital_titulo"] = new Titulo();
	root["carteira_digital_titulo"].y = 110;
	root["carteira_digital_titulo"].titulo.htmlText="<font color='#"+cortitulos+"'>"+blast.list[app].pages.carteira_digital.conteudo.titulo+"</font>";
	var texto = ""+blast.list[app].pages.carteira_digital.conteudo.subtitulo;
	var pattern:RegExp = /nome/g;
	var novoNome:Array=root["User"].nome.split(" ");
	var novotexto = texto.replace(pattern,novoNome[0]+"");
	root["carteira_digital_titulo"].texto.htmlText="<font color='#"+cortexto+"'>"+novotexto+"</font>";
	root["carteira_digital_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER ;
	conteudo.addChild(root["carteira_digital_titulo"]);
	// ------------------
	// Saldo Disponíveis:
	// ------------------
	root["carteira_digital_saldo"] = new Creditos_box1();
	root["carteira_digital_saldo"].y = 190;
	root["carteira_digital_saldo"].x = 45;
	root["carteira_digital_saldo"].alpha = 0;
	if(blast.list[app].pages.carteira_digital.custom.saldo_disponivel!=""){
		root["carteira_digital_saldo"].gotoAndStop(blast.list[app].pages.carteira_digital.custom.saldo_disponivel)
	};
	root["carteira_digital_saldo"].valor.text= "";
	root["carteira_digital_saldo"].titulo.htmlText="<font color='#"+cortexto+"'>Saldo Disponível:</font>"
	Tweener.addTween(root["carteira_digital_saldo"], {y:200, alpha:1, time: 1,transition: "easeOutExpo",delay: .2});
	conteudo.addChild(root["carteira_digital_saldo"]);
	// Contagem Progressiva:
	root["carteira_digital_saldo_animate"] = new spacer();
	root["carteira_digital_saldo_animate"].width=0;
	addChild(root["carteira_digital_saldo_animate"]);
	var limitador = 1000;
	Tweener.addTween(root["carteira_digital_saldo_animate"], {width:(dados.list.max.disponivel+dados.list.max.disponivel_bloqueado), time: .9,transition: "easeOutExpo",delay:0,onComplete:killTimer});
	function getSizeAnimate():void {
		root["carteira_digital_saldo"].valor.text= convertValorSemSifrao(root["carteira_digital_saldo_animate"].width)
	};
	root["timer"] = setInterval(getSizeAnimate,20);
	function killTimer(){
		root["carteira_digital_saldo"].valor.text=convertValorSemSifrao(dados.list.max.disponivel+dados.list.max.disponivel_bloqueado)
		clearInterval(root["timer"]);
	};
	//
	// ----------------------
	// Saldo a Receber:
	// ----------------------
	root["carteira_digital_areceber"] = new Creditos_boxDotted_1();
	root["carteira_digital_areceber"].y = root["carteira_digital_saldo"].y+root["carteira_digital_saldo"].height+20;
	root["carteira_digital_areceber"].x = 40;
	root["carteira_digital_areceber"].titulo.htmlText="<font color='#"+cortexto+"'>Saldo a Receber:</font>";
	root["carteira_digital_areceber"].unidade.htmlText="<font color='#"+cortexto+"'></font>";
	if(valor_a_receber==0){valor_a_receber="R$ 0,00"}
	root["carteira_digital_areceber"].valor.htmlText="<font color='#"+cortexto+"' size='"+ajustNumber(valor_a_receber,[26,26,26,26,26,24,22,20,18])+"'>"+valor_a_receber+"</font>";
	ajustText(root["carteira_digital_areceber"].valor,root["carteira_digital_areceber"].fundo,"V")
	Tweener.addTween(root["carteira_digital_areceber"].fundo, {_color:"0x"+cortexto, time: 0,transition: "linear",delay: 0});
	conteudo.addChild(root["carteira_digital_areceber"]);
	// ----------------------
	// Último Saque:
	// ----------------------
	root["carteira_digital_saque"] = new Creditos_boxDotted_1();
	root["carteira_digital_saque"].y = root["carteira_digital_saldo"].y+root["carteira_digital_saldo"].height+20;
	root["carteira_digital_saque"].x = 190;
	root["carteira_digital_saque"].titulo.htmlText="<font color='#"+cortexto+"'>Último Saque:</font>"
	root["carteira_digital_saque"].unidade.htmlText=""
	root["carteira_digital_saque"].valor.htmlText="<font color='#"+cortexto+"'>"+ultimo_saque+"</font>"
	criaIcon("carteira_digital_saque_icone",root["carteira_digital_saque"],blast.list.server.server_path+"/com/icones/saque.png",8,50,20,"normal",["0x"+cortexto,"0x"+cortexto],["alpha","easeOutExpo",1]);
	Tweener.addTween(root["carteira_digital_saque"].fundo, {_color:"0x"+cortexto, time: 0,transition: "linear",delay: 0});
	conteudo.addChild(root["carteira_digital_saque"]);
	// ----------------------
	// Solicitar Saque:
	// ----------------------
	criaBt("saque","Solicitar Saque",conteudo,35,root["carteira_digital_saque"].y+95,.95,"0x"+corbt1,"G");
	Tweener.addTween(root["saque"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
	root["saque"].addEventListener(MouseEvent.CLICK, function(){carteira_digital_solicitar_saque();});
	root["saque"].buttonMode = true;
	function carteira_digital_solicitar_saque(){
		if(dados.list.max.disponivel>0){
			if(dados.list.max.disponivel>dados.list.max.saque_taxa_max){
				modal_abrir("saque_modal",["modal_wallet_saque",blast.list[app].pages.carteira_digital.conteudo.saque_taxa,blast.list[app].pages.carteira_digital.conteudo.saque_gratuito,blast.list[app].pages.carteira_digital.conteudo.saque_valor],"Solicitar Saque para:","",true,null,"BS-G");
			}else{
				newbalaoInfo(conteudo,'Saldo menor que a taxa de saque: '+convertValor(dados.list.max.saque_taxa_max),(root["saque"].x+(root["saque"].width/2)),(root["saque"].y+30),"BalaoInfo","0x"+corcancel);
			};
		}else{
			if(dados.list.max.disponivel_bloqueado>0){
				carteira_digital_saldo_bloqueado(dados.list.max.disponivel_bloqueado);
			}else{
				newbalaoInfo(conteudo,'Você não possui saldo disponível.',(root["saque"].x+(root["saque"].width/2)),(root["saque"].y+30),"BalaoInfo","0x"+corcancel);
			};
		};
	};
	// ----------------------
	// Antecipar pagamento:
	// ----------------------
	criaBt("antecipar","Antecipação de Saldo",conteudo,35,"saque",.95,"0x"+corbt2,"G");
	Tweener.addTween(root["antecipar"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
	root["antecipar"].addEventListener(MouseEvent.CLICK, function(){carteira_digital_antecipar();});
	root["antecipar"].buttonMode = true;
	function carteira_digital_antecipar(){
		pages_new("antecipacao","antecipacao");
	};
	// ----------------------
	// Ativa tela:
	// ----------------------
	tela.addChild(conteudo);
};
// ====================================================
// CARTEIRA DIGITAL - Aviso de saldo Bloqueado
// ====================================================
function carteira_digital_saldo_bloqueado(valor){
	var titulo = "Finalize seu Cadastro!";
	var texto = "Você possui um saldo bloqueado de "+convertValor(valor)+". Para realizar o saque deste valor é necessário que você finalize o seu cadastro na "+blast.list.nome+".";
	modal_abrir("sem_credenciamento",["texto",titulo,texto],"","",true,null,"M");
	img_load("sem_credenciamento_img",blast.list[app].paths.upload_path+"/"+cadastro_saque_bloqueado,root["sem_credenciamento"],["width",200],null,[85,180,"left"],[],0,null)
	root["modal_texto"].y+=140;
	criaBt("sem_credenciamento_cadastrar","Concluir Cadastro",root["sem_credenciamento"],105,450,.90,"0x"+corbt1,"MM");
	root["sem_credenciamento_cadastrar"].addEventListener(MouseEvent.CLICK, sem_credenciamento_iniciar);
	root["sem_credenciamento_cadastrar"].buttonMode = true;
	Tweener.addTween(root["sem_credenciamento_cadastrar"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
	function sem_credenciamento_iniciar(e:MouseEvent):void {
		modal_fecha_ultimo();
		pages_new("meusdados","meusdados_simples");
	};
};