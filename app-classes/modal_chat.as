if(tipo[0]=="chat_whatsapp"){
	
	// ===============================
	//    	    __          __ 
	//    _____/ /_  ____ _/ /_
	//   / ___/ __ \/ __ `/ __/
	//  / /__/ / / / /_/ / /_  
	//  \___/_/ /_/\__,_/\__/ by level.EXPERT
	//								
	// Como usar:
	// ============================
	// Variáveis iniciais:
	root["timer_blast"] = new Timer(8000, 1); 
	root["chat_whatsapp_firstclick"] = false;
	root["chat_whatsapp_userCache"] = null;
	// Título:
	root["chat_whatsapp_titulo"] = new Titulo_Modal();
	root["chat_whatsapp_titulo"].x=0;
	root["chat_whatsapp_titulo"].y=38;
	root["chat_whatsapp_titulo"].titulo.htmlText = "<font color='#"+corbt1+"'>"+titulo+"</font>";
	root["chat_whatsapp_titulo"].texto.htmlText = "";
	root[nome].conteudo.addChild(root["chat_whatsapp_titulo"]);
	// Barra de tipo de Usuário: ( Amigos/Outros )
	root["chat_whatsapp_tipos"] = new Vazio();
	root["chat_whatsapp_tipos"].x = 35;
	root["chat_whatsapp_tipos"].y = 80;
	root["chat_whatsapp_tipos"].inicial = "amigos";
	root["chat_whatsapp_tipos_texto"] = ["Amigos","Outros"];
	root["chat_whatsapp_tipos_icones"] = ["friends2.png","globe.png"];
	root["chat_whatsapp_tipos"].total = root["chat_whatsapp_tipos_texto"].length;
	root[nome].conteudo.addChild(root["chat_whatsapp_tipos"]);
	//  Listagem de usuários:
	root["chat_whatsapp_users"] = new Vazio();
	root["chat_whatsapp_users"].x = 35;
	root["chat_whatsapp_users"].y = 130;
	root[nome].conteudo.addChild(root["chat_whatsapp_users"]);
	//  Listagem de usuários:
	root["chat_whatsapp_chats"] = new Vazio();
	root["chat_whatsapp_chats"].x = 35;
	root["chat_whatsapp_chats"].y = 225;
	root["chat_whatsapp_chats"].totalMsg = 0;
	root["chat_whatsapp_chats"].lastDate = "";
	root[nome].conteudo.addChild(root["chat_whatsapp_chats"]);
	// Carrega o input de mensagem escolhido
	var inputPosY = 0;
	if(tipo[1]=="simples_slim"){ root["chat_whatsapp_input"] = new Chat_Msg_Simples_Slim(); inputPosY=520; }
	root["chat_whatsapp_input"].texto.text = "";
	root["chat_whatsapp_input"].x = 42;
	root["chat_whatsapp_input"].y = inputPosY;
	Tweener.addTween(root["chat_whatsapp_input"].btok.fundo, {_color:"0x"+cortexto, time:0,transition: "linear",delay: 0});			
	root[nome].conteudo.addChild(root["chat_whatsapp_input"]);
	root["chat_whatsapp_input"].btok.buttonMode = true;
	root["chat_whatsapp_input"].btok.addEventListener(MouseEvent.CLICK, chat_whatsapp_enviar_msg);
	Android_MovieStage_add(root["chat_whatsapp_input"]);
	
	
	
	// ==============================================================
	// BARRA DE TIPO DE MENSAGEM: "Amigo" OU "Outros"
	// ==============================================================
	function chat_loadType(){
		// Remove Avatar Alvo:
		try{root[nome].conteudo.removeChild(root["chat_whatsapp_userAvatar_alvo"]);
		}catch(error:Error){}
		// Inicia Listagem
		var tamanhoItem = (303/root["chat_whatsapp_tipos"].total);
		for(var n=0; n<root["chat_whatsapp_tipos"].total; n++){
			root["chat_whatsapp_tipo"+(n+1)] = new submenuVisual_item();
			root["chat_whatsapp_tipo"+(n+1)].fundo.width = tamanhoItem;
			root["chat_whatsapp_tipo"+(n+1)].fundo.height = 50;
			root["chat_whatsapp_tipo"+(n+1)].x = (tamanhoItem*n);
			root["chat_whatsapp_tipo"+(n+1)].num = (n+1);
			root["chat_whatsapp_tipo"+(n+1)].tipo = root["chat_whatsapp_tipos_texto"][n];
			root["chat_whatsapp_tipo"+(n+1)].fundoover = "0x"+blast.list[app].pages.submenus.cores.btcliquebg;
			root["chat_whatsapp_tipo"+(n+1)].iconeover = "0x"+blast.list[app].pages.submenus.cores.btcliqueicone;
			root["chat_whatsapp_tipo"+(n+1)].fundoout = "0x"+blast.list[app].pages.submenus.cores.btnormalbg;
			root["chat_whatsapp_tipo"+(n+1)].iconeout = "0x"+blast.list[app].pages.submenus.cores.btnormalicone;
			criaIcon("chat_whatsapp_tipo"+(n+1)+"_icone",root["chat_whatsapp_tipo"+(n+1)],blast.list.server.server_path+"/com/icones/"+root["chat_whatsapp_tipos_icones"][n],25,10,30,"normal",["0x"+blast.list[app].pages.submenus.cores.btnormalicone,null],["alpha","easeOutExpo",1]);
			root["chat_whatsapp_tipo"+(n+1)].icone = root["chat_whatsapp_tipo"+(n+1)+"_icone"]
			Tweener.addTween( root["chat_whatsapp_tipo"+(n+1)].fundo, {_color:"0x"+blast.list[app].pages.submenus.cores.btnormalbg, time: 0,transition: "linear",delay: 0});
			root["chat_whatsapp_tipo"+(n+1)+"_label"] = new label_ttitulo_simples();
			root["chat_whatsapp_tipo"+(n+1)+"_label"].x = 60;
			root["chat_whatsapp_tipo"+(n+1)+"_label"].y= 12;
			root["chat_whatsapp_tipo"+(n+1)+"_label"].texto.text=root["chat_whatsapp_tipos_texto"][n];
			root["chat_whatsapp_tipo"+(n+1)].addChild(root["chat_whatsapp_tipo"+(n+1)+"_label"]);
			Tweener.addTween( root["chat_whatsapp_tipo"+(n+1)+"_label"], {_color:"0x"+corbt1, time: 0,transition: "linear",delay: 0});
			root["chat_whatsapp_tipos"].addChild(root["chat_whatsapp_tipo"+(n+1)]);
			root["chat_whatsapp_tipo"+(n+1)].buttonMode = true;
			root["chat_whatsapp_tipo"+(n+1)].addEventListener(MouseEvent.CLICK, chat_typeClick);
		};
		function chat_typeClick(e:MouseEvent):void {
			root["chat_whatsapp_firstclick"] = true;
			chat_changeType(e.currentTarget.tipo,e.currentTarget.num)
		};
		chat_changeType("Amigos","1");
	};
	function chat_changeType(tipo,num){
		for(var i=0; i<root["chat_whatsapp_tipos"].total; i++){
			if((i+1)==num){
				root["chat_whatsapp_tipo"+(i+1)].ativa();
			}else{
				root["chat_whatsapp_tipo"+(i+1)].desativa();
			};
		};
		chat_listUsers(tipo);
	};
	
	// ==============================================================
	// USUÁRIOS: Pressionar sobre o usuário:
	// ==============================================================
	// # VISITAR PERFIL
	function chat_whatsapp_visitar_perfil(){
		var user = root["chat_whatsapp_userAvatar"+(root["chat_whatsapp_users"].holded)].user;
		var bg = [ "bgtopcolor",["e9f9f6","cdf2eb"],160];
		var menu = [
			["dados_pessoais","user-shape.png"],
			["fotos_pessoais","photo-camera.png"],
			["atividades_pessoais","atividades.png"]
		]
		var config = ["addFriend"]
		var social = [
			["instagram",user['instagram_id']],
			["chat",user['id']]
		]
		var addFriend = ["Desfazer Amizade", "Deseja realmente desefazer amizade com este usuário?", "Desfazer"]
		modal_abrir("chat_visitarPerfil",["perfil",user['id'],"avatar_bola",bg,menu,config,social,addFriend],"","",true,null,"G");
	}
	// # APAGAR MENSAGENS
	function chat_whatsapp_apagar_mensagens(){
		modal_abrir("chat_apagarMensagens",["confirmacaoAlert","Apagar Agora",corcancel,1],"Apagar","Para apagar todas as mensagens confirme abaixo:",true,apagando,"P");
		function apagando(){
			
		};
		//newbalaoInfo(root["chat_menupress"].conteudo,"Não é possível apagar a mensagem.",(root["bt_apagarmensagens"].x+(root["bt_apagarmensagens"].width/2)),root["bt_apagarmensagens"].y+20,"BalaoInfo","0x"+corcancel);
	}
	function chat_whatsapp_bloquear_usuarios(){
		newbalaoInfo(root["chat_menupress"].conteudo,"Não é possível bloquear este usuário.",(root["bt_bloquearusuario"].x+(root["bt_bloquearusuario"].width/2)),root["bt_bloquearusuario"].y+20,"BalaoInfo","0x"+corcancel);
	}
	var botoes = [
		["bt_visitarperfil","Perfil",["efefef",cortexto],chat_whatsapp_visitar_perfil],
		["bt_apagarmensagens","Apagar",["efefef",cortexto],chat_whatsapp_apagar_mensagens],
		["bt_bloquearusuario","Bloquear",[corcancel,"ffffff"],chat_whatsapp_bloquear_usuarios]
	];
	// ==============================================================
	// LISTAGEM DE USUÁRIOS: "Amigo" OU "Outros"
	// ==============================================================
	function chat_listUsers(tipoList){
		root["chat_whatsapp_users"].hold = false;
		root["chat_whatsapp_users_conteudo"] = new Vazio();
		destroir(root["chat_whatsapp_users"],true);
		var tipoChat;
		//=======================================================
		if(tipo[2]!=null && tipo[3]!=null){
			//----------------------------
			// CHAT: User ou Group "alvo"
			//----------------------------
			tipoChat = "chat-alvo";
			connectServer(false,"screen",servidor+"api/chat/"+tipoList.toLowerCase()+"/ativado=1,remove_user_id="+tipo[3]+",id_usuarios="+root["User"]['id'],[
			],chat_listUsers_load);
		}else{
			//----------------------------
			// CHAT: Abertura Normal
			//----------------------------
			tipoChat = "pagina";
			connectServer(false,"screen",servidor+"api/chat/"+tipoList.toLowerCase()+"/ativado=1,id_usuarios="+root["User"]['id'],[
			],chat_listUsers_load);
		}
		//=======================================================
		function chat_listUsers_load(dados){
			// Remove Avatar Alvo:
			try{root[nome].conteudo.removeChild(root["chat_whatsapp_userAvatar_alvo"]);
			}catch(error:Error){}
			// Inicia listagem:
			if(dados.list.length>0){
				root["chat_whatsapp_users"].total = dados.list.length;
				for(var n=0; n<root["chat_whatsapp_users"].total; n++){
					root["chat_whatsapp_userAvatar"+(n+1)] = new avatar_bola();
					root["chat_whatsapp_userAvatar"+(n+1)].num = (n+1);
					root["chat_whatsapp_userAvatar"+(n+1)].iduser = dados.list[n]["id"];
					root["chat_whatsapp_userAvatar"+(n+1)].user = dados.list[n];
					Tweener.addTween(root["chat_whatsapp_userAvatar"+(n+1)].fundo, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
					img_load("chat_whatsapp_userAvatar"+(n+1)+"_foto",dados.list[n]["avatar"],root["chat_whatsapp_userAvatar"+(n+1)].conteudo,["width",113,"resize"],null,[0,0,"center2"],[],0,null)
					root["chat_whatsapp_userAvatar"+(n+1)].scaleX = root["chat_whatsapp_userAvatar"+(n+1)].scaleY = .5
					root["chat_whatsapp_userAvatar"+(n+1)].y = 15+(root["chat_whatsapp_userAvatar"+(n+1)].height/2);
					root["chat_whatsapp_userAvatar"+(n+1)].x = 35+(n*(root["chat_whatsapp_userAvatar"+(n+1)].width+5))
					root["chat_whatsapp_userAvatar"+(n+1)].buttonMode = true;
					root["chat_whatsapp_userAvatar"+(n+1)].addEventListener(MouseEvent.MOUSE_DOWN, chat_listUserClick_Down);
					root["chat_whatsapp_userAvatar"+(n+1)].addEventListener(MouseEvent.MOUSE_UP, chat_listUserClick_Up);
					root["chat_whatsapp_userAvatar"+(n+1)].addEventListener(MouseEvent.MOUSE_MOVE, chat_listUserClick_Move);
					root["chat_whatsapp_users_conteudo"].addChild(root["chat_whatsapp_userAvatar"+(n+1)]);	
				};
				if(tipo[2]!=null && tipo[3]!=null){
					//---------------------------
					// CHAT: User ou Group "alvo"
					root["chat_whatsapp_userAvatar_alvo"] = new avatar_bola();
					root["chat_whatsapp_userAvatar_alvo"].x = 80;
					root["chat_whatsapp_userAvatar_alvo"].y = 180;
					Tweener.addTween(root["chat_whatsapp_userAvatar_alvo"].fundo, {_color:"0x"+corbt1, time: 0,transition: "linear",delay: 0});
					root["chat_whatsapp_userAvatar_alvo"].scaleX = root["chat_whatsapp_userAvatar_alvo"].scaleY = .5
					root[nome].conteudo.addChild(root["chat_whatsapp_userAvatar_alvo"]);
					setScroller("scroller",root["chat_whatsapp_users_conteudo"],root["chat_whatsapp_users"],200,90,90,0,0,0,false,"HORIZONTAL");
					chat_listUserLoad(0,tipo[3]);
				}else{
					//----------------------------
					// CHAT: Abertura Normal
					setScroller("scroller",root["chat_whatsapp_users_conteudo"],root["chat_whatsapp_users"],302,90,0,0,0,0,false,"HORIZONTAL");
					if(root["chat_whatsapp_userCache"]!=null){
						chat_listUserLoad(root["chat_whatsapp_userCache"][0]+1,root["chat_whatsapp_userCache"][1]);
					}else{
						chat_listUserLoad(1,root["chat_whatsapp_userAvatar"+1].iduser);
					}
					
				};
			}else{
				
			}
		};
	};
	function chat_listUserClick_Down(e:MouseEvent):void {
		root["chat_whatsapp_users"].xclicked1 = mouseX;
		root["chat_whatsapp_users"].hold = true;
		root["chat_whatsapp_users"].holded = e.currentTarget.num;
		e.currentTarget.fundo.alpha=0;
		e.currentTarget.fundoX = e.currentTarget.fundo.scaleX;
		e.currentTarget.fundo.scaleX = e.currentTarget.fundo.scaleY = 1;
		stage.addEventListener(MouseEvent.MOUSE_UP, chat_listUserClick_Up);
		root["chat_whatsapp_users"].timer = new Timer(2, 100);
		root["chat_whatsapp_users"].timer.addEventListener(TimerEvent.TIMER, chat_whatsapp_users_timer_release_tick); 
		root["chat_whatsapp_users"].timer.addEventListener(TimerEvent.TIMER_COMPLETE, chat_whatsapp_users_timer_release_complete);
		root["chat_whatsapp_users"].timer.reset();
		root["chat_whatsapp_users"].timer.start();
		Tweener.addTween(e.currentTarget.fundo, {_color:"0x"+corcancel, time: 0,transition: "linear",delay: 0});
	}
	function chat_whatsapp_users_timer_release_tick(event:TimerEvent):void {
		root["chat_whatsapp_userAvatar"+(root["chat_whatsapp_users"].holded)].fundo.alpha = (event.target.currentCount/100);
		root["chat_whatsapp_userAvatar"+(root["chat_whatsapp_users"].holded)].fundo.scaleX = root["chat_whatsapp_userAvatar"+(root["chat_whatsapp_users"].holded)].fundo.scaleY =1+(event.target.currentCount/150);
	}
	function chat_whatsapp_users_timer_release_complete(event:TimerEvent):void {
		var scala = root["chat_whatsapp_userAvatar"+(root["chat_whatsapp_users"].holded)].fundoX
		root["chat_whatsapp_users"].timer.stop();
		root["chat_whatsapp_users"].timer.removeEventListener(TimerEvent.TIMER, chat_whatsapp_users_timer_release_tick); 
		root["chat_whatsapp_users"].timer.removeEventListener(TimerEvent.TIMER_COMPLETE, chat_whatsapp_users_timer_release_complete);
		Tweener.addTween(root["chat_whatsapp_userAvatar"+(root["chat_whatsapp_users"].holded)].fundo, {scaleX:scala, scaleY:scala, time: 1,transition: "easeOutElastic",delay: .5});
		Tweener.addTween(root["chat_whatsapp_userAvatar"+(root["chat_whatsapp_users"].holded)].fundo, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
		root["chat_whatsapp_userAvatar"+(root["chat_whatsapp_users"].holded)].fundo.alpha = 0;
		stage.removeEventListener(MouseEvent.MOUSE_UP, chat_listUserClick_Up);
		modal_abrir("chat_menupress",["botoes",botoes],root["chat_whatsapp_userAvatar"+(root["chat_whatsapp_users"].holded)].user.nome,"Menu de Ações:",true,null,"P");
	}
	function chat_listUserClick_Up(e:MouseEvent):void {
		var scala = root["chat_whatsapp_userAvatar"+(root["chat_whatsapp_users"].holded)].fundoX
		root["chat_whatsapp_users"].hold = false;
		root["chat_whatsapp_users"].timer.stop();
		root["chat_whatsapp_users"].timer.removeEventListener(TimerEvent.TIMER, chat_whatsapp_users_timer_release_tick); 
		root["chat_whatsapp_users"].timer.removeEventListener(TimerEvent.TIMER_COMPLETE, chat_whatsapp_users_timer_release_complete);
		Tweener.addTween(root["chat_whatsapp_userAvatar"+(root["chat_whatsapp_users"].holded)].fundo, {scaleX:scala, scaleY:scala, time: 1,transition: "easeOutElastic",delay: .5});		
		root["chat_whatsapp_userAvatar"+(root["chat_whatsapp_users"].holded)].fundo.alpha = 0;
		Tweener.addTween(root["chat_whatsapp_userAvatar"+(root["chat_whatsapp_users"].holded)].fundo, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
		root["chat_whatsapp_users"].hold = true;
		stage.removeEventListener(MouseEvent.MOUSE_UP, chat_listUserClick_Up);
		var limite = 10;
		if((root["chat_whatsapp_users"].xclicked2-root["chat_whatsapp_users"].xclicked1)<limite && (root["chat_whatsapp_users"].xclicked2-root["chat_whatsapp_users"].xclicked1)>(limite*-1)){
			trace("Puxou1: "+e.currentTarget.iduser)
			root["chat_whatsapp_firstclick"] = true;
			chat_listUserLoad(e.currentTarget.num,e.currentTarget.iduser);
		}
	}
	function chat_listUserClick_Move(e:MouseEvent):void {
		root["chat_whatsapp_users"].xclicked2 = mouseX;
	}
	
	function chat_listUserLoad(num,id){
		if(tipo[2]!=null && tipo[3]!=null && root["chat_whatsapp_firstclick"] == true){
			tipo[2]=null;
			tipo[3]=null;
			root["chat_whatsapp_userCache"] = [num,id];
			chat_loadType();
		}else{
			for(var i=0; i<root["chat_whatsapp_users"].total; i++){
				if((i+1)==num){
					root["chat_whatsapp_userAvatar"+(i+1)].fundo.alpha=1;
					Tweener.addTween( root["chat_whatsapp_userAvatar"+(i+1)].fundo, {_color:"0x"+corbt1, time: 1,transition: "easeOutExpo",delay: 0});
				}else{
					root["chat_whatsapp_userAvatar"+(i+1)].fundo.alpha=1;
					Tweener.addTween( root["chat_whatsapp_userAvatar"+(i+1)].fundo, {_color:"0xffffff", time: 1,transition: "easeOutExpo",delay: 0});
				};
			};
			chat_listChat(id);
		};
	};
	
	// ==============================================================
	// LISTAGEM DAS MENSAGENS TROCADAS
	// ==============================================================
	function chat_listChat(id){
		root["timer_blast"].reset();
		root["timer_blast"].start(); 
		root["chat_whatsapp_chats_idUser"] = id;
		root["chat_whatsapp_chats"].totalMsg = 0;
		root["chat_whatsapp_input"].texto.text = "";
		root["chat_whatsapp_chats_conteudo"] = new Vazio();
		destroir(root["chat_whatsapp_chats"],true);
		connectServer(false,"screen",servidor+"api/chat/list/ativado=1",[
		["id_usuarios", root["User"]['id'],"texto"],
		["id_usuarios__alvo", root["chat_whatsapp_chats_idUser"],"texto"]
		],chat_listChat_load);
		function chat_listChat_load(dados){
			for(var n=0; n<dados.list.length; n++){
				chat_addMsg(dados.list[n].id_usuarios__remetente,dados.list[n].mensagem,convertDataHoraMinuto(dados.list[n].cadastro),false);
			};
			root["chat_whatsapp_chats"].lastDate = dados.head['print'];
			setScroller("scroller",root["chat_whatsapp_chats_conteudo"],root["chat_whatsapp_chats"],302,284,0,0,0,100,false,"VERTICAL");
			chat_loadMsg_start();
		};
	};
	
	// ==============================================================
	// ENVIAR: Enviando mensagem para o usuário:
	// ==============================================================
	function chat_whatsapp_enviar_msg(e:MouseEvent):void {
		if(root["chat_whatsapp_input"].texto.length > 0){
			if(root["chat_whatsapp_input"].texto.text.indexOf("<")==-1 && root["chat_whatsapp_input"].texto.text.indexOf(">")==-1){
				connectServer(false,"screen",servidor+"api/chat/add/",[
				["id_usuarios", root["User"]['id'],"texto"],
				["id_usuarios__alvo", root["chat_whatsapp_chats_idUser"],"texto"],
				["mensagem", root["chat_whatsapp_input"].texto.text,"texto"]
				],chat_whatsapp_enviou_msg);
				function chat_whatsapp_enviou_msg(dados){
					if(dados.list.retorno=="ok"){
						// Existe alguma mensagem esperando carregar?
						
						// Input de nova Mensagem:
						root["chat_whatsapp_chats"].lastDate = dados.head['print'];
						chat_addMsg(root["User"]['id'],root["chat_whatsapp_input"].texto.text,convertDataHoraMinuto(dados.list.cadastro),true);
						root["chat_whatsapp_input"].texto.text = "";
					}else{
						newbalaoInfo(root["chat_whatsapp_input"],dados.list['label'],(root["chat_whatsapp_input"].btok.x+(root["chat_whatsapp_input"].btok.width/2)),root["chat_whatsapp_input"].btok.y+20,"BalaoInfo","0x"+corcancel);
					}
				}
			}else{
				newbalaoInfo(root["chat_whatsapp_input"],"Caracteres especiais não suportados.",(root["chat_whatsapp_input"].btok.x+(root["chat_whatsapp_input"].btok.width/2)),root["chat_whatsapp_input"].btok.y+20,"BalaoInfo","0x"+corcancel);
			}
		}else{
			newbalaoInfo(root["chat_whatsapp_input"],"Digite uma mensagem antes de enviar.",(root["chat_whatsapp_input"].btok.x+(root["chat_whatsapp_input"].btok.width/2)),root["chat_whatsapp_input"].btok.y+20,"BalaoInfo","0x"+corcancel);
		};
	};
	function chat_whatsapp_enviou_msg(dados){
		
	};
	// ==============================================================
	// ATUALIZAÇÂO DE CHAT: Adicionar mensagens ao chat atual:
	// ==============================================================
	function chat_addMsg(user_id,texto,data,animation){
		// Cria objeto 
		root["chat_whatsapp_chats"].totalMsg++
		var num = root["chat_whatsapp_chats"].totalMsg
		root["chat_ballon"+(num)] = new ChatBallon();
		// Monta Mensagem:
		root["chat_ballon"+(num)].texto.autoSize =  TextFieldAutoSize.LEFT
		root["chat_ballon"+(num)].texto.htmlText = texto;
		root["chat_ballon"+(num)].fundo_meio.height = root["chat_ballon"+(num)].texto.height+15;
		root["chat_ballon"+(num)].fundo_rodape.y = (root["chat_ballon"+(num)].fundo_meio.y+root["chat_ballon"+(num)].fundo_meio.height)-1
		root["chat_ballon"+(num)].cadastro.y = (root["chat_ballon"+(num)].fundo_rodape.y+root["chat_ballon"+(num)].fundo_rodape.height)-5
		root["chat_ballon"+(num)].cadastro.texto.text = data;
		// Define Posições:
		if(num==1){
			root["chat_ballon"+(num)].y = 0;
		}else{
			root["chat_ballon"+(num)].y = (root["chat_ballon"+(num-1)].y+root["chat_ballon"+(num-1)].height+5);
		};
		// define Layout e posições:
		var tipo = "";
		if(user_id==root["User"]['id']){
			tipo = "pessoal";
			root["chat_ballon"+(num)].x = 40;
		}else{
			tipo = "usuarios";
			root["chat_ballon"+(num)].x = 10;
			root["chat_ballon"+(num)].seta.scaleX = -1;
			root["chat_ballon"+(num)].seta.x = 0;
		}
		Tweener.addTween(root["chat_ballon"+(num)].cadastro, {_color:"0x"+blast.list.chat.cores[tipo]['data'], time:0,transition: "linear",delay: 0});
		Tweener.addTween(root["chat_ballon"+(num)].texto, {_color:"0x"+blast.list.chat.cores[tipo].texto, time:0,transition: "linear",delay: 0});
		Tweener.addTween(root["chat_ballon"+(num)].seta, {_color:"0x"+blast.list.chat.cores[tipo].balao, time:0,transition: "linear",delay: 0});
		Tweener.addTween(root["chat_ballon"+(num)].fundo_topo, {_color:"0x"+blast.list.chat.cores[tipo].balao, time:0,transition: "linear",delay: 0});
		Tweener.addTween(root["chat_ballon"+(num)].fundo_meio, {_color:"0x"+blast.list.chat.cores[tipo].balao, time:0,transition: "linear",delay: 0});
		Tweener.addTween(root["chat_ballon"+(num)].fundo_rodape.fundo, {_color:"0x"+blast.list.chat.cores[tipo].balao, time:0,transition: "linear",delay: 0});
		// Animação de entrada:
		if(animation==true){
			root["chat_ballon"+(num)].scaleX = root["chat_ballon"+(num)].scaleY = 0;
			Tweener.addTween(root["chat_ballon"+(num)], {scaleX:1, scaleY:1, time:.2,transition: "easeOutExpo",delay: 0});
		}
		// Aplicação no Layout:
		root["chat_whatsapp_chats_conteudo"].addChild(root["chat_ballon"+(num)]);
	}
	
	// ======================================================================
	// ATUALIZAÇÂO DE CHAT: Verificar nova mensagem de terceiros no server
	// ======================================================================
	//
	function chat_loadMsg_start(){
		root["timer_blast"].addEventListener(TimerEvent.TIMER, chat_loadMsg); 
		root["timer_blast"].addEventListener(TimerEvent.TIMER_COMPLETE, chat_loadMsg_complete);
		root["timer_blast"].start();
	};
	function chat_loadMsg(event:TimerEvent):void{
		connectServer(false,"screen",servidor+"api/chat/list/",[
		["id_usuarios", root["User"]['id'],"texto"],
		["id_usuarios__alvo", root["chat_whatsapp_chats_idUser"],"texto"],
		["data_alvo", root["chat_whatsapp_chats"].lastDate,"texto"]
		],chat_listChat_load);
		function chat_listChat_load(dados){
			for(var n=0; n<dados.list.length; n++){
				chat_addMsg(dados.list[n].id_usuarios__remetente,dados.list[n].mensagem,convertDataHoraMinuto(dados.list[n].cadastro),true);
			};
			root["chat_whatsapp_chats"].lastDate = dados.head['print'];
		}
	};
	function chat_loadMsg_complete(event:TimerEvent):void{ 
		root["timer_blast"].reset();
		root["timer_blast"].start(); 
	};
	
	// ========================
	chat_loadType();
}