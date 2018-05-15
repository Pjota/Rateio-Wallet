if(tipo[0]=="cupom"){
	connectServer(false,"screen",servidor+"api/list/d_usuarios_cupons/id="+tipo[2]['id'],[
	],modal_cupons);
	function modal_cupons(dados){
		
		// Variáveis Iniciais:
		root["page_refresh_in_modal_close"] = true;
		
		// ================
		// TOPO C/ FOTO
		// ================
		// # Cores de Fundo:
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox(ScreenSizeWOriginal, 182, Math.PI/2, 0, 0); 
		var square:Shape = new Shape; 
		square.graphics.beginGradientFill(
		GradientType.LINEAR, ["0x"+tipo[5], "0x"+tipo[5]], 
		[1, 1], [0, 255], matrix, SpreadMethod.PAD,  
		InterpolationMethod.LINEAR_RGB, 0); 
		square.graphics.drawRect(0, 0, ScreenSizeWOriginal, 182); 
		root[nome].conteudo_fundo.addChild(square);
		// # Carrega a foto:
		if(dados.list[0].id_d_cupom.foto!="" && dados.list[0].id_d_cupom.foto!=undefined){
			img_load("modal_cupom_foto",blast.list.server.upload_path+"/"+dados.list[0].id_d_cupom.foto,root[nome].conteudo_fundo,["width",310,"resize"],null,[30,30],[],0,null);
			root["modal_cupom_foto"].addEventListener(MouseEvent.CLICK, function(){modal_bg_zoom()});
			root["modal_cupom_foto"].buttonMode = true;
			function modal_bg_zoom(){
				lightbox_open("lightboxmodalcupom",["0x000000",.95],dados.list[0].id_d_cupom.foto)
			};
		};
		
		
		// ================
		// ÍCONE
		// ================
		root["modal_cupom_logo"] = new avatar_bola();
		root["modal_cupom_logo"].x = (365/2);
		root["modal_cupom_logo"].y = (140);
		Tweener.addTween(root["modal_cupom_logo"].fundo, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
		img_load("modal_cupom_logoFoto",dados.list[0].id_d_cupom.id_d_parceiros.logo,root["modal_cupom_logo"].conteudo,["width",113,"resize"],null,[0,0,"center2"],[],0,null)
		root["modal_cupom_logo"].scaleX = root["modal_cupom_logo"].scaleY = .6; 
		root[nome].conteudo.addChild(root["modal_cupom_logo"]);
		root["modal_cupom_logo"].addEventListener(MouseEvent.CLICK, function(){modal_logo_zoom()});
		root["modal_cupom_logo"].buttonMode = true;
		function modal_logo_zoom(){
			lightbox_open("lightboxmodalcupom",["0x000000",.95],dados.list[0].id_d_cupom.id_d_parceiros.logo)
		};
		
		// ==========================
		// CUPOM: Título + Descrição
		// ==========================
		root["modal_cupom_titulo"] = new Titulo_Modal();
		root["modal_cupom_titulo"].y= 175;
		root["modal_cupom_titulo"].titulo.htmlText='<font color="#'+tipo[7][0]+'">"'+dados.list[0].id_d_cupom.nome+'"</font>';
		root["modal_cupom_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER;
		root["modal_cupom_titulo"].texto.htmlText=dados.list[0].id_d_cupom.descricao;
		root["modal_cupom_titulo"].texto.selectable = true;
		root[nome].conteudo.addChild(root["modal_cupom_titulo"]);
		
		// ==========================
		// CUPOM: Informações
		// ==========================
		criaLabel("label_loja","Loja",dados.list[0].id_d_cupom.id_d_parceiros.nome,root[nome].conteudo,50,"modal_cupom_titulo",1,tipo[3],tipo[4],"M");
		//criaLabel("label_modalidade","Modalidade",dados.list[0].id_d_modalidades.nome,root[nome].conteudo,190,"modal_cupom_titulo",1,"0x"+dados.list[0].id_d_modalidades.cor,"0xffffff","M");
		//criaLabel("label_categorias","Categorias",dados.list[0].id_d_parceiros.categoria,root[nome].conteudo,50,"label_loja",1,tipo[3],tipo[4],"M");
		criaLabel("label_validade","Validade",convertData(dados.list[0].id_d_cupom.validade),root[nome].conteudo,190,"modal_cupom_titulo",1,tipo[3],tipo[4],"M");
		criaLabel("label_Desconto","Desconto",ajustaDecimal(dados.list[0].id_d_cupom.desconto,0)+"%",root[nome].conteudo,50,"label_validade",1,tipo[3],tipo[4],"M");
		
		// ==============================================
		// CUPOM: Localização + Telefone + Site
		// ==============================================
		criaLabel("label_Contato","Contatos da Loja","",root[nome].conteudo,190,"label_validade",1,tipo[3],tipo[4],"M");
		root["label_Contato"].fundo.visible=false;
		var altura = root["label_validade"].y+root["label_validade"].height+28;
		// # 1) LOCALIZAÇÃO:
		criaIcon("modal_cupom_icone_localizacao",root[nome].conteudo,blast.list.server.server_path+"/com/icones/map-marker.png",190,altura,35,"bullet",["0xffffff","0x"+tipo[6][0]],["alpha","easeOutExpo",1]);
		root["modal_cupom_icone_localizacao"].addEventListener(MouseEvent.CLICK, localizacao);
		function localizacao(e:MouseEvent):void {
			navigateToURL(new URLRequest(dados.list[0].id_d_parceiros.gmaps));
		};
		// # 2) TELEFONE:
		criaIcon("modal_cupom_icone_telefone",root[nome].conteudo,blast.list.server.server_path+"/com/icones/telephone-handle-silhouette.png",235,altura,35,"bullet",["0xffffff","0x"+tipo[6][1]],["alpha","easeOutExpo",1]);
		root["modal_cupom_icone_telefone"].addEventListener(MouseEvent.CLICK, ligar);
		function ligar(e:MouseEvent):void {
			navigateToURL(new URLRequest("tel:+55"+dados.list[0].id_d_parceiros.telefone));
		};
		// # 3) SITE:
		criaIcon("modal_cupom_icone_site",root[nome].conteudo,blast.list.server.server_path+"/com/icones/desktop-monitor.png",280,altura,35,"bullet",["0xffffff","0x"+tipo[6][2]],["alpha","easeOutExpo",1]);
		root["modal_cupom_icone_site"].addEventListener(MouseEvent.CLICK, linkSite);
		function linkSite(e:MouseEvent):void {
			navigateToURL(new URLRequest(dados.list[0].id_d_parceiros.site));
		};
		
		// ==============================================
		// CUPOM: Utilização
		// ==============================================
		root["modal_cupom_utilizacao_infos"] = new Titulo_Modal();
		root["modal_cupom_utilizacao_infos"].y = root["label_Desconto"].y+root["label_Desconto"].height+20;
		root["modal_cupom_utilizacao_infos"].titulo.htmlText='<font color="#'+tipo[7][0]+'" size="18">'+tipo[7][1]+'</font>';
		root["modal_cupom_utilizacao_infos"].texto.autoSize =  TextFieldAutoSize.CENTER;
		root["modal_cupom_utilizacao_infos"].texto.htmlText=tipo[7][2];
		root["modal_cupom_utilizacao_infos"].texto.selectable = true;
		root[nome].conteudo.addChild(root["modal_cupom_utilizacao_infos"]);
		// CUPOM: Utilização Status
		codigoAtivacao("cupom_codigo_ativacao","Código","Tempo",tipo[8],root[nome].conteudo,59,"modal_cupom_utilizacao_infos",1,[tipo[7][0],tipo[9][0],tipo[9][1],tipo[9][2],tipo[9][3]],dados.list[0]);
		
	};
};