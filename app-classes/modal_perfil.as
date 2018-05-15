if(tipo[0]=="perfil"){
	connectServer(false,"screen",servidor+"api/list/usuarios/id="+tipo[1],[
	],modal_perfil);
	function modal_perfil(dados){
		
		// ---------------------------------------------
		// INFORMAÇÕES FIXAS
		// ---------------------------------------------
		
		// # Fundo Modal
		if(tipo[3][0]=="bgtopcolor"){
			matrix.createGradientBox(ScreenSizeWOriginal, tipo[3][2], Math.PI/2, 0, 0); 
			square.graphics.beginGradientFill(
			GradientType.LINEAR, ["0x"+tipo[3][1][0], "0x"+tipo[3][1][1]], 
			[1, 1], [0, 255], matrix, SpreadMethod.PAD,  
			InterpolationMethod.LINEAR_RGB, 0); 
			square.graphics.drawRect(0, 0, ScreenSizeWOriginal, tipo[3][2]); 
			root[nome].conteudo_fundo.addChild(square);
		};
		
		// # Perfil pessoal ou de outra pessoa?:
		if(dados.list[0]['id']!=root["User"]['id']){
			// # Chat:
			criaIcon("perfil_chat_icone",root[nome],blast.list.server.server_path+"/com/icones/chat.png",55,135,50,"bullet",["0xffffff","0x"+corbt1],["alpha","easeOutExpo",1]);
			root["perfil_chat_icone"].addEventListener(MouseEvent.CLICK, function(){perfil_chat_icone_click()});
			root["perfil_chat_icone"].buttonMode = true;
			function perfil_chat_icone_click(){
				modal_abrir("chat",["chat_whatsapp","simples_slim","usuarios",dados.list[0]['id']],blast.list[app].pages.chat['label'],"",true,modal_fechar_timer,"G");
			};
			// # Adicionar ou Remover Amigos:
			social_addFriend("perfilModal_addFriend",root[nome],265,135,1,dados.list[0]['id'],tipo[7],null);
		}
		// # Usuário: Avatar
		if(tipo[2]=="avatar_bola"){  
			root["perfilModal_thumb"] = new avatar_bola();
			root["perfilModal_thumb"].x = (365/2);
			root["perfilModal_thumb"].y = (150);
			Tweener.addTween(root["perfilModal_thumb"].fundo, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
			img_load("modalperfil_avatar",dados.list[0]['avatar'],root["perfilModal_thumb"].conteudo,["width",113,"resize"],null,[0,0,"center2"],[],0,null)
			root[nome].addChild(root["perfilModal_thumb"]);	
		};
		root["perfilModal_thumb"].addEventListener(MouseEvent.CLICK, function(){modal_perfil_lightboxAvatar()});
		root["perfilModal_thumb"].buttonMode = true;
		function modal_perfil_lightboxAvatar(){
			lightbox_open("lightboxperfil",["0x000000",.95],dados.list[0]['avatar'])
		};
		
		// # Usuário: Nome
		root["perfilModal_nome"] = new Titulo_Modal();
		root["perfilModal_nome"].x=5;
		root["perfilModal_nome"].y=215;
		root["perfilModal_nome"].titulo.htmlText = "<font color='#"+corbt1+"'>"+dados.list[0].nome+"</font>";
		root["perfilModal_nome"].texto.htmlText = "<font color='#"+cortexto+"'>"+dados.list[0].status_frase+"</font>";
		root["perfilModal_nome"].texto.autoSize =  TextFieldAutoSize.CENTER;
		root["perfilModal_nome"].texto.selectable = true;
		
		// Carrega Perfil
		root[nome].addChild(root["perfilModal_nome"]);	

		// ---------------------------------------------
		// INFORMAÇÕES DINÂMICAS: MENU
		// ---------------------------------------------
		var menuPosY = root["perfilModal_nome"].y+root["perfilModal_nome"].height+10;
		root["perfil_submenu"] = new Vazio();
		var tamanhoItem = (root[nome].mascara.width/tipo[4].length);
		for(var n=0; n<tipo[4].length; n++){
			root["perfil_submenu"+(n+1)] = new perfil_submenu_item();
			root["perfil_submenu"+(n+1)].fundo.width = tamanhoItem;
			root["perfil_submenu"+(n+1)].x = 32+(tamanhoItem*n);
			root["perfil_submenu"+(n+1)].y = menuPosY;
			root["perfil_submenu"+(n+1)].num = (n+1);
			root["perfil_submenu"+(n+1)].funcClique = modal_perfil_submenu_clique;
			root["perfil_submenu"+(n+1)].itens = tipo[4];
			root["perfil_submenu"+(n+1)].sessao = tipo[4][n][0];
			root["perfil_submenu"+(n+1)].fundoover = "0x"+blast.list[app].pages.submenus.cores.btcliquebg;
			root["perfil_submenu"+(n+1)].iconeover = "0x"+blast.list[app].pages.submenus.cores.btcliqueicone;
			root["perfil_submenu"+(n+1)].fundoout = "0x"+blast.list[app].pages.submenus.cores.btnormalbg;
			root["perfil_submenu"+(n+1)].iconeout = "0x"+blast.list[app].pages.submenus.cores.btnormalicone;			
			criaIcon("perfil_submenu"+(n+1)+"_icone",root["perfil_submenu"+(n+1)],blast.list.server.server_path+"/com/icones/"+tipo[4][n][1],((tamanhoItem/2)-(35/2)),18,35,"normal",["0x"+blast.list[app].pages.submenus.cores.btnormalicone,null],["alpha","easeOutExpo",1]);
			Tweener.addTween( root["perfil_submenu"+(n+1)].fundo, {_color:"0x"+blast.list[app].pages.submenus.cores.btnormalbg, time: 0,transition: "linear",delay: 0});
			root["perfil_submenu"].addChild(root["perfil_submenu"+(n+1)]);
		};
		root[nome].addChild(root["perfil_submenu"]);
		//Alteração Visual
		function modal_perfil_submenu_clique(num,sessao,itens){
			for(var n=0; n<itens.length; n++){
				if(itens[n][0]==sessao){
					modal_perfil_submenu_clique_visual(n+1,itens);
					modal_perfil_conteudo(sessao);
				}
			};
		};
		function modal_perfil_submenu_clique_visual(num,itens){
			for(var i=1; i<=itens.length; i++){
				if(i==num){
					root["perfil_submenu"+(i)].ativa();
				}else{
					root["perfil_submenu"+(i)].desativa();
				};
			};
		};
		var alvoInit = root["perfil_submenu"+(1)];
		root["perfil_submenu_conteudo"] = new Vazio();
		root["perfil_submenu_conteudo"].y = menuPosY+90;
		root[nome].addChild(root["perfil_submenu_conteudo"]);
		modal_perfil_submenu_clique(alvoInit.num,alvoInit.sessao,alvoInit.itens)
		
		// ---------------------------------------------
		// INFORMAÇÕES DINÂMICAS: CONTEÚDO MENU
		// ---------------------------------------------
		function modal_perfil_conteudo(sessao){
			// destroir
			var i;
			destroir(root["perfil_submenu_conteudo"],true);
			
			var liberaVisualizacao = false;
			if(dados.list[0].amizade_aceite!=null){
				liberaVisualizacao = true;
			}else{
				if(dados.list[0].d_feed_privado==null){
					liberaVisualizacao = true;
				}
			}
			
			if(liberaVisualizacao==true){
				// ---------------------------------------------
				// # 1) DADOS PESSOAIS
				// ---------------------------------------------
				if(sessao=="dados_pessoais"){
					var label_sexo_icone = "";
					var label_sexo_cor = "";
					if(dados.list[0].sexo=="M"){
						label_sexo_icone = "male.png";
						label_sexo_cor = "66ccff";	
					}
					if(dados.list[0].sexo=="F"){
						label_sexo_icone = "female.png";
						label_sexo_cor = "ff7ceb";	
					}
					if(dados.list[0].sexo=="O"){
						label_sexo_icone = "mark.png";
						label_sexo_cor = "8570ed";	
					}
					criaIcon("label_sexo",root["perfil_submenu_conteudo"],blast.list.server.server_path+"/com/icones/"+label_sexo_icone,50,0,50,"bullet",["0xffffff","0x"+label_sexo_cor],["alpha","easeOutExpo",1]);
					var idade = diffAnos("2017-04-25 00:42:00",dados.list[0].nascimento);
					criaLabel("label_idade","Idade",idade,root["perfil_submenu_conteudo"],115,0,1,corbtcliquebg,cortexto,"P");
					criaLabel("label_cidade","Cidade",capitalize(dados.list[0].id_local_cidades.nome.toLowerCase()),root["perfil_submenu_conteudo"],50,"label_sexo",1,corbtcliquebg,cortexto,"M");
					criaLabel("label_estado","Estado",dados.list[0].id_local_estados.nome,root["perfil_submenu_conteudo"],190,"label_sexo",1,corbtcliquebg,cortexto,"M");
					if(dados.list[0].instagram_id!=""){
						criaIcon("label_instagram",root["perfil_submenu_conteudo"],blast.list.server.server_path+"/com/icones/instagram-symbol.png",150,135,70,"bullet",["0xffffff","0x"+corbt1],["alpha","easeOutExpo",1]);
						root["label_instagram"].addEventListener(MouseEvent.CLICK, function(){label_instagram_click()});
						root["label_instagram"].buttonMode = true;
						function label_instagram_click(){
							if(dados.list[0].instagram_id.indexOf("http")>=0){
								navigateToURL(new URLRequest(dados.list[0].instagram_id));
							}else{
								navigateToURL(new URLRequest("https://instagram.com/"+dados.list[0].instagram_id));
							};
						};
					};
					connectServer(false,"screen",servidor+"api/list/d_modalidades_usuarios/ativado=1,id_usuarios="+dados.list[0]['id'],[
					],modal_perfil_modalidades);
					function modal_perfil_modalidades(dados){
						if(dados.list.length>0){
							var espacos = (128/dados.list.length)
							var offset = (50-espacos)/dados.list.length;
							for(i=0; i<dados.list.length; i++){
								criaIcon("esporte_interesses"+(i+1),root["perfil_submenu_conteudo"],blast.list.server.upload_path+"/"+dados.list[i].id_d_modalidades.icone,190+(i*(espacos-offset)),0,50,"bullet",["0xffffff","0x"+dados.list[i].id_d_modalidades.cor],["alpha","easeOutExpo",1]);
							};
						}else{
							criaLabel("esporte_interesses","Modalidades","Sem Interesse Atual",root["perfil_submenu_conteudo"],190,0,1,"0x"+corcancel,"0xffffff","M")
							
						}
					}
				};
				// ---------------------------------------------
				// # 2) FOTOS PESSOAIS
				// ---------------------------------------------
				if(sessao=="fotos_pessoais"){
					var fotos_pessoais_porlinha = 3;
					tamanhoItem = (root[nome].mascara.width/fotos_pessoais_porlinha);
					root["perfil_submenu_conteudo_slide"] = new Vazio();
					connectServer(false,"screen",servidor+"api/list/d_postagens/id_usuarios="+dados.list[0]['id']+",order_column=cadastro,order_direct=DESC",[
					],modal_perfil_fotos_pessoais);
					function modal_perfil_fotos_pessoais(dados){
						if(dados.list.length>0){
							var countx = 0;
							var county = 0;
							trace("Todos: "+dados.list.length)
							for(i=0; i<dados.list.length; i++){
								root["fotos_pessoais"+(i+1)] = new Quadrado();
								root["fotos_pessoais"+(i+1)].fundo.width = (tamanhoItem-2);
								root["fotos_pessoais"+(i+1)].fundo.height = (tamanhoItem-2);
								root["fotos_pessoais"+(i+1)].infos = dados.list[i];
								root["fotos_pessoais"+(i+1)].x = 32+(((tamanhoItem+2)*countx))
								root["fotos_pessoais"+(i+1)].y = ((tamanhoItem+2)*county);
								root["fotos_pessoais"+(i+1)].foto = dados.list[i]['foto'];
								root["fotos_pessoais"+(i+1)].buttonMode = true;
								root["fotos_pessoais"+(i+1)].addEventListener(MouseEvent.CLICK, modal_perfil_fotos_pessoais_click);
								Tweener.addTween( root["fotos_pessoais"+(i+1)].fundo, {_color:"0xefefef", time: 0,transition: "linear",delay: 0});
								img_load("fotos_pessoais"+(i+1)+"_img",dados.list[i]['foto'],root["fotos_pessoais"+(i+1)],["width",tamanhoItem,"crop"],null,[0,0,"left"],[],0,null)
								if(countx!=(fotos_pessoais_porlinha-1)){ countx++; }else{ countx=0; county++; }
								root["perfil_submenu_conteudo_slide"].addChild(root["fotos_pessoais"+(i+1)]);
							};
							setScroller("scroller",root["perfil_submenu_conteudo_slide"],root["perfil_submenu_conteudo"],339,220,0,0,0,0,false,"VERTICAL");
						}else{
							semConteudo("perfil_semfotos","Sem Fotos","Este usuário ainda não compartilhou nenhuma foto de suas atividades.",150,"sc_fotos.png",280,root["perfil_submenu_conteudo"],0,0,null);
						};
					};
					function modal_perfil_fotos_pessoais_click(e:MouseEvent):void {
						lightbox_open("lightboxperfil",["0x000000",.95],e.currentTarget.foto)
					};
				};
				// ---------------------------------------------
				// # 3) ATIVIDADES PESSOAIS
				// ---------------------------------------------
				if(sessao=="atividades_pessoais"){
					semConteudo("perfil_semfotos","Sem Atividades","Este usuário ainda não praticou nenhuma atividade.",150,"sc_atividades.png",280,root["perfil_submenu_conteudo"],0,0,null);
				};
			}else{
				semConteudo("modal_perfil_oculto","Perfil Oculto","Para visualizar as informações deste usuário é necessário que ele aceite sua solicitação de amizade.",120,"sc_perfiloculto.png",220,root["perfil_submenu_conteudo"],0,0,null);
				root["modal_perfil_oculto_infos"].texto.width=280;
				root["modal_perfil_oculto_infos"].texto.x=45;
			}
			
			
			
		};
		
		// ----------------------------------------------
		
	};
};