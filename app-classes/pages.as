//-----------------------------------------------------------------
// TROCA DE PÁGINAS
//-----------------------------------------------------------------
var pages_history =  new Array();
var page_actual = []
root["submenuAtual"] = "";
function pages_new(sessao,classe){
	
	page_actual = [sessao,classe];
	
	// ===================
	// Na troca de página 
	// ===================
	// # Para qualquer "TIMER"
	if(root["timer_blast"]){root["timer_blast"].stop();}
	// # Para qualquer "SOM"
	try{root["audio_canal"].stop();}catch(error:Error){}
	
	// -----------------------------------------
	// # 1) Carrega Submenu (caso houver):
	
	if(blast.list[app].pages[sessao].submenu){
		var submenuitemalvo = 0;
		var totalsubmenus = blast.list[app].pages.submenus[blast.list[app].pages[sessao].submenu].length;
		
		if(root["submenuAtual"]!=blast.list[app].pages[sessao].submenu){
			
			// Existe um Submenu ativo? Delete
			destroir(telamenu,true);
			
			// Montagem do Menu:
			root["submenu"] = new Vazio();
			var tamanhoItem = (ScreenSizeW2/totalsubmenus);
			for(var n=0; n<totalsubmenus; n++){
				root["submenu"+(n+1)] = new submenu_item();
				root["submenu"+(n+1)].fundo.width = tamanhoItem;
				root["submenu"+(n+1)].fundo.scaleY = scalaFixa;
				root["submenu"+(n+1)].x = (tamanhoItem*n);
				root["submenu"+(n+1)].num = (n+1);
				root["submenu"+(n+1)].sessao = blast.list[app].pages.submenus[blast.list[app].pages[sessao].submenu][n]
				root["submenu"+(n+1)].submenu = blast.list[app].pages[sessao].submenu;
				root["submenu"+(n+1)].fundoover = "0x"+corbtcliquebg;
				root["submenu"+(n+1)].iconeover = "0x"+corbtcliqueicone;
				root["submenu"+(n+1)].fundoout = "0x"+corbtnormalbg;
				root["submenu"+(n+1)].iconeout = "0x"+corbtnormalicone;
				criaIcon("submenu"+(n+1)+"_icone",root["submenu"+(n+1)],blast.list[app].paths.icon_master_path+"/"+blast.list[app].pages[blast.list[app].pages.submenus[blast.list[app].pages[sessao].submenu][n]].icone,((tamanhoItem/2)-((35*scalaFixa)/2)),(18*scalaFixa),(35*scalaFixa),"normal",["0x"+corbtnormalicone,null],["alpha","easeOutExpo",1]);
				Tweener.addTween( root["submenu"+(n+1)].fundo, {_color:"0x"+corbtnormalbg, time: 0,transition: "linear",delay: 0});
				root["submenu"].addChild(root["submenu"+(n+1)]);
				//trace(root["submenu"+(n+1)].sessao+"//"+sessao);
				if(root["submenu"+(n+1)].sessao==sessao){
					submenuitemalvo = (n+1);
				};
			};
			// Configurações de Posicionamento e Animação:
			root["submenu"].alpha=0;
			Tweener.addTween( root["submenu"], {alpha:1, time: .5,transition: "easeOutExpo",delay: 1});
			Tweener.addTween( root["submenu"], {y:root["MenuSuperior"].height-(root["MenuSuperior"].linha.height), time: .5,transition: "easeOutExpo",delay: 1});
			telamenu.addChild(root["submenu"]);
			// Ativa o Submenu que estiver selecionado:
			if(submenuitemalvo!=0){submenu_clique_visual(submenuitemalvo,blast.list[app].pages[sessao].submenu);}
			// Guarda em cache o último submenu:
			root["submenuAtual"] = blast.list[app].pages[sessao].submenu;
		}else{
			for(var m=0; m<totalsubmenus; m++){
				if(root["submenu"+(m+1)].sessao==sessao){
					submenuitemalvo = (m+1);
				};
			}
			if(submenuitemalvo!=0){
				submenu_clique_visual(submenuitemalvo,blast.list[app].pages[sessao].submenu);
			}
		}
	}else{
		if(root["submenuAtual"]!=""){
			Tweener.addTween( root["submenu"], {y:0, time: .5,transition: "easeOutExpo",delay: 0, onComplete:somesubmenu});
		}else{
			somesubmenu();
		};
		function somesubmenu(){
			destroir(telamenu,true);
			root["submenuAtual"] = "";
		};
	}
	
	
	// -----------------------------------------
	// # 2) Carrega Classe Alvo:
	Tweener.addTween(tela, {alpha:0, time: .5,transition: "easeOutExpo",delay: 0, onComplete:troca});
	Tweener.addTween(bgPanel, {alpha:0, time: .5,transition: "easeOutExpo",delay: 0});
	function troca(){
		destroir(tela,true);
		tela.alpha=1;
		Tweener.removeTweens(bgPanel);
		destroir(bgPanel,true);
		bgPanel.alpha=1;
		print_bg(null,1,0);
		if(root["MenuSuperior"] && sessao!="login"){
			menu_superior_simples_refresh();
		}
		if(root["video-ns"]){
			root["video-ns"].close();
		}
		var array = new Array(sessao,classe);
		pages_history.push(array);
		root[classe](sessao);
	};
	
	//------------------------------------------
	if(sessao!="login" && sessao!="cadastro"){
		if(!blast.list[app].pages.menu['custom'] || blast.list[app].pages.menu['custom']==false){
			for(var i=0; i<(blast.list[app].pages.menu["config_"+root["User"]['table']].length); i++){
				if(blast.list[app].pages.menu["config_"+root["User"]['table']][i] == sessao){
					root[blast.list[app].pages.menu.template+"_clique"](i+1,false);
				}
			};
		};
	};
};
function submenu_clique(num,submenu,sessao){
	var itens = blast.list[app].pages.submenus[submenu];
	submenu_clique_visual(num,submenu);
	var menuItens = blast.list[app].pages.menu["config_"+root["User"]['table']];
	for(var n=0; n<menuItens.length; n++){
		if(menuItens[n]==sessao){
			root[blast.list[app].pages.menu.template+"_clique"](n+1,false)
		}
	};
	pages_new(sessao,blast.list[app].pages[sessao].template);
}
function submenu_clique_visual(num,submenu){
	var itens = blast.list[app].pages.submenus[submenu];
	for(var i=1; i<=itens.length; i++){
		if(i==num){
			root["submenu"+(i)].ativa();
		}else{
			root["submenu"+(i)].desativa();
		}
	}
}