if(tipo[0]=="eventos"){

	//==============================
	//  VARIÁVEIS INICIAIS:
	//==============================
	root["modal_endereco_esc"] = 0;
	root["modal_data_esc"] = "";
	
	//==============================
	//  INFORMAÇÕES DO TOPO:
	//==============================
	// # Imagem (BG):
	var imagem_topo = tipo[1][tipo[2]];
	var tamanho_topo = tipo[4];
	var imagem_item = tipo[1][tipo[3]];
	if(imagem_topo!="" && imagem_topo!=undefined){
		matrix = new Matrix();
		matrix.createGradientBox(ScreenSizeWOriginal, tamanho_topo, Math.PI/2, 0, 0); 
		square = new Shape; 
		square.graphics.beginGradientFill(
		GradientType.LINEAR, ["0xff0000", "0xff0000"], 
		[1, 1], [0, 255], matrix, SpreadMethod.PAD,  
		InterpolationMethod.LINEAR_RGB, 0); 
		square.graphics.drawRect(0, 0, 345, tamanho_topo); 
		root[nome].conteudo_fundo.addChild(square);
		img_load("modal_Desc",blast.list[app].paths.upload_path+"/"+imagem_topo,root[nome].conteudo_fundo,["width",310,"resize","auto",tamanho_topo],null,[31,33],[],0,null);
		root["modal_Desc"].mask = square;
		root["modal_Desc"].addEventListener(MouseEvent.CLICK, function(){modal_bg_zoom()});
		root["modal_Desc"].buttonMode = true;
		function modal_bg_zoom(){
			lightbox_open("lightboxBG",["0x000000",.95],imagem_topo)
		};
	};
	
	// # Usuário: Avatar
	trace("Tipo de Layout de Thumb: "+tipo[7])
	var tamanho_avatar = 0;
	if(tipo[7]=="1"){
		root["modal_desc_foto"] = new avatar_bola();
		tamanho_avatar = (root["modal_desc_foto"].height/2)-30;
		root["modal_desc_foto"].x = (365/2);
		root["modal_desc_foto"].y = (tamanho_topo-20);
		Tweener.addTween(root["modal_desc_foto"].fundo, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
		img_load("modal_desc_foto_imagem",imagem_item,root["modal_desc_foto"].conteudo,["height",113,"resize"],null,[0,0,"center2"],[],0,null)
		root[nome].addChild(root["modal_desc_foto"]);	
		root["modal_desc_foto"].addEventListener(MouseEvent.CLICK, function(){modal_lightboxFoto()});
		root["modal_desc_foto"].buttonMode = true;
		function modal_lightboxFoto(){
			lightbox_open("lightboxFoto",["0x000000",.95],imagem_item)
		};
	}
	
	// Título + Descrição
	root["modal_desc_titulo"] = new Titulo_Modal();
	root["modal_desc_titulo"].y= (tamanho_topo+tamanho_avatar)-20;
	root["modal_desc_titulo"].titulo.htmlText='<font color="#'+tipo[5]+'">"'+titulo+'"</font>';
	root["modal_desc_titulo"].titulo.autoSize =  TextFieldAutoSize.CENTER;
	root["modal_desc_titulo"].texto.y = root["modal_desc_titulo"].titulo.y+root["modal_desc_titulo"].titulo.height+5;
	root["modal_desc_titulo"].texto.htmlText=limpa_html(texto);
	root["modal_desc_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER;
	root["modal_desc_titulo"].texto.selectable = false;
	root["modal_desc_titulo"].addEventListener(MouseEvent.CLICK, modal_eventos_desc_clique);
	root[nome].conteudo.addChild(root["modal_desc_titulo"]);	
	//criaIcon("modal_desc_titulo_more",root[nome].conteudo,blast.list.server.server_path+"/com/icones/etc.png",(365/2)-10,"modal_desc_titulo",20,"bullet",["0xffffff","0x"+tipo[6]],["alpha","easeOutExpo",1]);
	root["modal_desc_titulo"].addEventListener(MouseEvent.CLICK, modal_eventos_desc_clique);
	
	function modal_eventos_desc_clique(){
		modal_abrir("modal_desc_etc",["texto",titulo,tipo[1]['infos']],"","",true,null,"G")
	};			
	
		
};