if(tipo[0]=="notificacoes"){
	// ==============================================================
	// NOTIFICAÇÕES: Título Dinâmico
	// ==============================================================
	root["modal_titulo"] = new Titulo_Modal();
	root["modal_titulo"].y = 35;
	function modal_notificacoes_trocaTitulo(titulo,add){
		titulo = "<font color='#"+corbt1+"'>"+titulo+":</font> "+add;
		root["modal_titulo"].titulo.htmlText=titulo;
	}
	modal_notificacoes_trocaTitulo(titulo+":","")
	root["modal_titulo"].texto.text = "";
	root[nome].conteudo.addChild(root["modal_titulo"]);
	root[nome].posymax+=root["modal_titulo"].y+root["modal_titulo"].height+15;
	
	// ==============================================================
	// NOTIFICAÇÕES: Barra de tipo de Notificação:
	// ==============================================================
	root["modal_notificacoes_tipos"] = new Vazio();
	root["modal_notificacoes_tipos"].x = 35;
	root["modal_notificacoes_tipos"].y = 80;
	root["modal_notificacoes_tipos"].inicial = "avisos";
	root["modal_notificacoes_tipos"].tipos = ["Avisos","Amizades","Eventos"];
	root["modal_notificacoes_tipos"].icones = ["turn-notifications-on-button.png","friends.png","loud-speaker.png"];
	root["modal_notificacoes_tipos"].total = root["modal_notificacoes_tipos"].tipos.length;
	root[nome].conteudo.addChild(root["modal_notificacoes_tipos"]);
	function modal_notificacoes_loadTypes(){
		var tamanhoItem = (303/root["modal_notificacoes_tipos"].total);
		trace("Menu: "+root["modal_notificacoes_tipos"].total)
		for(var n=0; n<root["modal_notificacoes_tipos"].total; n++){
			root["modal_notificacoes_tipo"+(n+1)] = new submenuVisual_item();
			root["modal_notificacoes_tipo"+(n+1)].fundo.width = tamanhoItem;
			root["modal_notificacoes_tipo"+(n+1)].fundo.height = 50;
			root["modal_notificacoes_tipo"+(n+1)].x = (tamanhoItem*n);
			root["modal_notificacoes_tipo"+(n+1)].num = (n+1);
			root["modal_notificacoes_tipo"+(n+1)].tipo = root["modal_notificacoes_tipos"].tipos[n];
			root["modal_notificacoes_tipo"+(n+1)].fundoover = "0x"+blast.list[app].pages.submenus.cores.btcliquebg;
			root["modal_notificacoes_tipo"+(n+1)].iconeover = "0x"+blast.list[app].pages.submenus.cores.btcliqueicone;
			root["modal_notificacoes_tipo"+(n+1)].fundoout = "0x"+blast.list[app].pages.submenus.cores.btnormalbg;
			root["modal_notificacoes_tipo"+(n+1)].iconeout = "0x"+blast.list[app].pages.submenus.cores.btnormalicone;
			criaIcon("modal_notificacoes_tipo"+(n+1)+"_icone",root["modal_notificacoes_tipo"+(n+1)],blast.list.server.server_path+"/com/icones/"+root["modal_notificacoes_tipos"].icones[n],(tamanhoItem/2)-15,10,30,"normal",["0x"+blast.list[app].pages.submenus.cores.btnormalicone,null],["alpha","easeOutExpo",1]);
			root["modal_notificacoes_tipo"+(n+1)].icone = root["modal_notificacoes_tipo"+(n+1)+"_icone"]
			Tweener.addTween( root["modal_notificacoes_tipo"+(n+1)].fundo, {_color:"0x"+blast.list[app].pages.submenus.cores.btnormalbg, time: 0,transition: "linear",delay: 0});
			root["modal_notificacoes_tipos"].addChild(root["modal_notificacoes_tipo"+(n+1)]);
			root["modal_notificacoes_tipo"+(n+1)].addEventListener(MouseEvent.CLICK, modal_notificacoes_typeClick);
		};
		function modal_notificacoes_typeClick(e:MouseEvent):void {
			modal_notificacoes_changeType(e.currentTarget.tipo,e.currentTarget.num)
		};
		modal_notificacoes_changeType("Avisos",1);
	};
	modal_notificacoes_loadTypes()
	function modal_notificacoes_changeType(tipo,num){
		modal_notificacoes_trocaTitulo(titulo,root["modal_notificacoes_tipos"].tipos[num-1]);
		modal_notificacoes_list(tipo)
		for(var i=0; i<root["modal_notificacoes_tipos"].total; i++){
			// Atualiza o visual do botão pós clique:
			if((i+1)==num){
				root["modal_notificacoes_tipo"+(i+1)].ativa();
			}else{
				root["modal_notificacoes_tipo"+(i+1)].desativa();
			};
		};
		menu_superior_simples_refresh();
		modal_notificacoes_refreshAlerts();
	}
	function modal_notificacoes_refreshAlerts(){
		// Busca informações de Notificação para cada aba:
		for(var i=0; i<root["modal_notificacoes_tipos"].total; i++){
			try{root["modal_notificacoes_tipos"].removeChild(root["modal_notificacoes_tipo"+(i+1)+"_alert"]);
			}catch(error:Error){}		
			if(root["notificacoes_"+root["modal_notificacoes_tipos"].tipos[i]]>0){
				icon_flag_alert("modal_notificacoes_tipo"+(i+1)+"_alert",root["modal_notificacoes_tipos"],root["modal_notificacoes_tipo"+(i+1)].x+root["modal_notificacoes_tipo"+(i+1)].width-25,root["modal_notificacoes_tipo"+(i+1)].y+21,1,"E74B4B","ffffff",root["notificacoes_"+root["modal_notificacoes_tipos"].tipos[i]],false);
			}
		};
	}
	
	// ==============================================================
	// NOTIFICAÇÕES: Carrega Conteúdo
	// ==============================================================
	// Cria clipe de Conteúdo:
	root["modal_notificacoes_lista"] = new Vazio();
	root["modal_notificacoes_lista"].y = 130;
	root[nome].conteudo.addChild(root["modal_notificacoes_lista"]);
	// --------------------------------
	// Em caso de sem conteúdo:
	function modal_notificacoes_semconteudo(){
		root["notificaoes_retorno"] = new Titulo_Modal();
		root["notificaoes_retorno"].y=80;
		root["notificaoes_retorno"].titulo.htmlText="<font color='#"+corbt1+"' size='18'>Sem Notificações</font>"
		root["notificaoes_retorno"].texto.htmlText="<font color='#"+cortexto+"'>Você não possui nenhuma notificação<br>até este exato momento.</font>";
		root["notificaoes_retorno"].texto.autoSize =  TextFieldAutoSize.CENTER ;
		root["modal_notificacoes_lista"].addChild(root["notificaoes_retorno"]);
	}
		
	// Cria clipe de Conteúdo:
	root["modal_notificacoes_conteudo"] = new Vazio();
	function modal_notificacoes_list(tipo){
		try{
		destroir(root["modal_notificacoes_lista"],false);
		destroir(root["modal_notificacoes_conteudo"],false);
		}catch(error:Error){}
		// --------------------------------
		// (1) Em caso de "Avisos":
		if(tipo=="Avisos"){
			connectServer(false,"screen",servidor+"api/list/d_amizades/teste=3,id_usuarios__alvo="+root["User"]['id']+",aceite=null,order_column=cadastro,order_direct=DESC",[
			],modal_notificacoes_load_avisos);
			function modal_notificacoes_load_avisos(dados){
				if(dados.list.length>0){
					
				}else{
					modal_notificacoes_semconteudo();
				}
			}
		}
		// --------------------------------
		// (2) Em caso de "Amizades":
		if(tipo=="Amizades"){
			connectServer(false,"screen",servidor+"api/list/d_amizades/id_usuarios__alvo="+root["User"]['id']+",aceite=null,order_column=cadastro,order_direct=DESC",[
			],modal_notificacoes_load_amizades);
			function modal_notificacoes_load_amizades(dados){
				if(dados.list.length>0){
					root['modal_notificacoes_amizade'] = dados;
					var botoes = [
						["remove-symbol.png",corcancel,"ffffff",remover_solicitacao,dados]
					]
					for(var n=0; n<dados.list.length; n++){
						notificacao_Modal("modal_notificacoes_amizade"+(n+1),root["modal_notificacoes_conteudo"],["imagem",blast.list.server.upload_path+"/"+dados.list[n].id_usuarios['avatar']],dados.list[n].cadastro,dados.list[n].id_usuarios.nome,"Você possui uma nova solicitação de amizade.",botoes,dados.list[n])
						root["modal_notificacoes_amizade"+(n+1)].n = (n+1)
						root["modal_notificacoes_amizade"+(n+1)].y=(80*n)
					};
					setScroller("scroller",root["modal_notificacoes_conteudo"],root["modal_notificacoes_lista"],339,259,0,0,0,0,false,"VERTICAL");
				}else{
					modal_notificacoes_semconteudo();
				}
			}
			function remover_solicitacao(dados,amizadeId,alvo,num){
				root["modal_notificacoes_amizadeId"] = amizadeId;
				root["modal_notificacoes_btAlvo"] = alvo;
				root["modal_notificacoes_btNum"] = num;
				modal_abrir("confirmacaoAlert",["confirmacaoAlert","Recusar",corcancel],"Recusar Solicitação?","Recusar solicitação de amizade de <font cor='#"+corbt1+"'>"+dados.list[0].nome+"</font>?",true,removendo_solicitacao,"P");
			}
			function removendo_solicitacao(){
				trace("Desfazendo amizade: "+root["modal_notificacoes_amizadeId"])
				var array = '{"ativo":"0"}';
				connectServer(false,"screen",servidor+"api/edit/d_amizades/id="+root["modal_notificacoes_amizadeId"],[
				["json",array,"texto"],
				["id_usuarios__alvo",root["User"]['id'],"texto"],
				["id",root["modal_notificacoes_amizadeId"],"texto"]
				],modal_notificacoes_remove);
				function modal_notificacoes_remove(dados){
					if(dados.list.retorno=="ok"){
						root["modal_notificacoes_amizade"+root["modal_notificacoes_btNum"]].sometudo()
						criaIcon("modal_notificacoes_removeReturn",root["modal_notificacoes_amizade"+root["modal_notificacoes_btNum"]],blast.list.server.server_path+"/com/icones/correct-symbol.png",230,20,50,"bullet",["0xffffff","0x"+corcancel],["alpha","easeOutExpo",1]);
					}else{
						newbalaoInfo(root["modal_notificacoes_amizade"+root["modal_notificacoes_btNum"]],'Erro!',(root["modal_notificacoes_btAlvo"].x),(root["modal_notificacoes_btAlvo"].y+(root["modal_notificacoes_btAlvo"].height/2)),"BalaoLateralEsq","0x"+corcancel);
					};
				};
			};
		};
		// --------------------------------
		// (3) Em caso de "Eventos":
		if(tipo=="Eventos"){
			connectServer(false,"screen",servidor+"api/list/d_amizades/teste=3,id_usuarios__alvo="+root["User"]['id']+",aceite=null,order_column=cadastro,order_direct=DESC",[
			],modal_notificacoes_load_eventos);
			function modal_notificacoes_load_eventos(dados){
				if(dados.list.length>0){
					
				}else{
					modal_notificacoes_semconteudo();
				}
			}
		};
	};
	
	
};