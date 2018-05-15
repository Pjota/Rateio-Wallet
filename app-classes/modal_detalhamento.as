if(tipo[0]=="detalhamento"){
	connectServer(false,"screen",servidor+"api/list/"+tipo[1]+"/id="+tipo[2],[
	],modal_detalhamento_init);
	function modal_detalhamento_init(dados){
		
		// ================
		// ÍCONE
		// ================
		root["modal_det_logo"] = new avatar_bola();
		root["modal_det_logo"].x = (365/2);
		root["modal_det_logo"].y = (105);
		Tweener.addTween(root["modal_det_logo"].fundo, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
		img_load("modal_det_logoFoto",blast.list.server.upload_path+"/"+dados.list[0].logo,root["modal_det_logo"].conteudo,["width",113,"resize"],null,[0,0,"center2"],[],0,null)
		root["modal_det_logo"].scaleX = root["modal_det_logo"].scaleY = 1; 
		root[nome].conteudo.addChild(root["modal_det_logo"]);
		root["modal_det_logo"].addEventListener(MouseEvent.CLICK, function(){modal_logo_zoom()});
		root["modal_det_logo"].buttonMode = true;
		function modal_logo_zoom(){
			lightbox_open("lightboxmodalcupom",["0x000000",.95],blast.list.server.upload_path+"/"+dados.list[0].logo)
		};
		
		// ==========================
		// CUPOM: Título + Descrição
		// ==========================
		root["modal_det_titulo"] = new Titulo_Modal();
		root["modal_det_titulo"].y= 175;
		root["modal_det_titulo"].titulo.htmlText='<font color="#'+corbt2+'">"'+titulo+'"</font>';
		root["modal_det_titulo"].titulo.autoSize =  TextFieldAutoSize.CENTER;
		root["modal_det_titulo"].texto.y = root["modal_det_titulo"].titulo.y+root["modal_det_titulo"].titulo.height+5;
		root["modal_det_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER;
		root["modal_det_titulo"].texto.htmlText='<font color="#'+cortexto+'">"'+texto+'"</font>';
		root["modal_det_titulo"].texto.selectable = false;
		root[nome].conteudo.addChild(root["modal_det_titulo"]);
		
		// ==========================
		// CAMPOS: Informações
		// ==========================
		criaListagem("Labels","M","modal_detLabel",root[nome].conteudo,45,360,314,[25,5],tipo[3],null);
		
		// ==========================
		// BOTÃO: 
		// ==========================
		if(tipo[4]!=null){
			criaBt("modal_det_botao",tipo[4][1],root[nome].conteudo,45,430,.9,"0x"+tipo[4][2],tipo[4][0]);
			root["modal_det_botao"].addEventListener(MouseEvent.CLICK,modal_det_botao_clique);
			root["modal_det_botao"].buttonMode = true;
			function modal_det_botao_clique(e:MouseEvent):void {
				tipo[4][3](tipo[2],tipo[4][4]);
				modal_fechar(realnome);
			};
		};
	};
};