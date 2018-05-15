import flash.events.MouseEvent;

//-----------------------------------------------------------------
// NOTIFICAÇÕES
//-----------------------------------------------------------------
// imagem = [tipo:(icone,imagem),url]
// botos = Array()   ->   Item = ["url_icone","cor_de_fundo","callback_function"]
function notificacao_Modal(nome,local,imagem,data,titulo,texto,botoes,infos){
	
	// 1) Cria Notifiação:
	root[nome] = new Vazio();
	root[nome].n;
	local.addChild(root[nome]);
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	//--------------------------------------------
	connectServer(false,"screen",servidor+"api/list/usuarios/id="+infos.id_usuarios["id"],[
	],notificacoes_userVerify);
	function notificacoes_userVerify(dados){
		//----------------------------------
		// 2) Cria Imagem:
		if(imagem[0]=="icone"){
			//criaIcon(nome,local,blast.list.server.server_path+"/com/icones/"+imagem[1],0,0,50,"bullet",["0x","0x"+corbt1],["alpha","easeOutExpo",1]);
		};
		if(imagem[0]=="imagem"){
			root[nome+"_imagem"] = new avatar_bola();
			root[nome+"_imagem"].x = 80;
			root[nome+"_imagem"].y = 52;
			Tweener.addTween(root[nome+"_imagem"].fundo, {_color:"0x"+corbt1, time: 0,transition: "linear",delay: 0});
			img_load(nome+"_img",imagem[1],root[nome+"_imagem"].conteudo,["width",113,"resize"],null,[0,0,"center"],[],0,null)
			root[nome+"_imagem"].scaleX = root[nome+"_imagem"].scaleY = .5;
			root[nome].addChild(root[nome+"_imagem"]);
			
			root[nome+"_imagem"].n = dados.list[0]['id'];
			root[nome+"_imagem"].instagram_id = dados.list[0]['instagram_id'];
			root[nome+"_imagem"].buttonMode = true;
			root[nome+"_imagem"].addEventListener(MouseEvent.CLICK, notificacao_openPerfil);
			function notificacao_openPerfil(e:MouseEvent):void{
				var bg = [
					"bgtopcolor",
					["e9f9f6","cdf2eb"],
					160
				];
				var menu = [
					["dados_pessoais","user-shape.png"],
					["fotos_pessoais","photo-camera.png"],
					["atividades_pessoais","atividades.png"]
				]
				var config = [
					"addFriend"
				]
				var social = [
					["instagram",e.currentTarget.instagram_id],
					["chat",e.currentTarget.n]
				]
				var addFriend = [
					"Desfazer Amizade",
					"Deseja realmente desefazer amizade com este usuário?",
					"Desfazer"
				]
				modal_abrir("perfilModal",["perfil",e.currentTarget.n,"avatar_bola",bg,menu,config,social,addFriend],"","",true,null,"G");
			};
		};
		//----------------------------------
		// 3) Inseri textos:
		root[nome+"_txt"] = new label_data_titulo_texto();
		root[nome+"_txt"].x = 120;
		root[nome+"_txt"].y = 10;
		root[nome+"_txt"].datahora.htmlText = "<font color='#"+corbt1+"'>"+convertDataDiaMesHora(data)+"</font>";
		root[nome+"_txt"].titulo.htmlText = "<font color='#"+cortexto+"'>"+titulo+"</font>";
		root[nome+"_txt"].texto.htmlText = "<font color='#"+cortexto+"'>"+texto+"</font>";
		root[nome].addChild(root[nome+"_txt"]);	
		//----------------------------------
		// 4) Ícones:
		for(var i=0; i<botoes.length; i++){
			criaIcon(nome+"_icone"+(i+1),root[nome],blast.list.server.server_path+"/com/icones/"+botoes[i][0],(290-(40*i)),30,35,"bullet",["0x"+botoes[i][2],"0x"+botoes[i][1]],["alpha","easeOutExpo",.5]);
			root[nome+"_icone"+(i+1)].n = i;
			root[nome+"_icone"+(i+1)].addEventListener(MouseEvent.CLICK, notificacao_Modal_Click);
			root[nome+"_icone"+(i+1)].buttonMode = true;
		};
		function notificacao_Modal_Click(e:MouseEvent):void {
			var n = e.currentTarget.n;
			botoes[n][3](dados,infos["id"],e.currentTarget,root[nome].n);
		};
		
		var addFriend = [
			"Desfazer Amizade",
			"Deseja realmente desefazer amizade com este usuário?",
			"Desfazer"
		]
		social_addFriend(nome+"_aceitar",root[nome],230,20,1,infos.id_usuarios["id"],addFriend,moveIcone);
		function moveIcone(){
			for(var i=0; i<botoes.length; i++){
				Tweener.addTween(root[nome+"_icone"+(i+1)], {alpha:0,time: 1,transition: "easeOutExpo",delay: 0});
			};
		};
		//----------------------------------
		// 5) Some Tudo:
		root[nome].sometudo = function(){
			root[nome+"_aceitar_bt"].visible = false;
			for(var i=0; i<botoes.length; i++){
				root[nome+"_icone"+(i+1)].visible = false;
			};
		}
		
	}
}