//-----------------------------------------------------------------
// LISTAGEM DE THUMBS (Vários por linha)
//-----------------------------------------------------------------
// + nome
// + local
// + posx
// + posy
// + largura
// + objeto [Movie,movimento,animate,corBorda] 
// + alinhamento [quantidade por linha, tipo]
// + jsonlist
// + idscheck [(Array de IDS ue serão selecionados),callback de visualização ativada]
// + callback
// + markerDate [campo,true]

function criaLista(nome,local,posx,posy,largura,objeto,alinhamento,jsonlist,idscheck,callback,markerDate){
	
	// VARIÁVEIS INICIAS
	var itemClass:Class;
	var count = 0;
	var qntporlinha = alinhamento[0];
	var dif = 0;
	var altura = 0;
	var timeDelay = 0;
	
	// MONTAGEM DA LISTAGEM
	if(jsonlist.length==0){
		// 1) Em caso de: "Sem Retorno"
		//criaIcon(nome+"_semresultado_icone",local,blast.list.server.server_path+"/com/icones/zoom_detail.png",(365/2)-(40),30,50,"bullet",["0xffffff","0x"+corcancel],["alpha","easeOutExpo",1]);
		root[nome+"_semresultado"] = new Titulo();
		root[nome+"_semresultado"].x = -20;
		root[nome+"_semresultado"].y=30;
		root[nome+"_semresultado"].titulo.htmlText="<font color='#"+corcancel+"'>Sem Resultados</font>"
		root[nome+"_semresultado"].texto.htmlText="<font color='#"+cortexto+"'>Sua pesquisa não encontrou resultados.<br>Pesquise novamente.</font>";
		root[nome+"_semresultado"].texto.autoSize =  TextFieldAutoSize.CENTER ;
		local.addChild(root[nome+"_semresultado"]);
		
	}else{
		// 2) Em caso de: "Retornos"
		for(var i=0; i<jsonlist.length; i++){
			count++;
			
			// [ OBJETOS ]
			if(objeto[0]=="thumb_bola"){ 		root[nome+"_item"+(i+1)] = new thumb_bola(); 		}
			
			// [ APARÊNCIA ]
			root[nome+"_item"+(i+1)].arco.alpha=0;
			root[nome+"_item"+(i+1)].ativo=false;
			root[nome+"_item"+(i+1)].n=(i+1);
			root[nome+"_item"+(i+1)]['id']=jsonlist[i]['id'];
			root[nome+"_item"+(i+1)].attr = jsonlist[i];
			root[nome+"_item"+(i+1)].nome.alpha=0;
			root[nome+"_item"+(i+1)].nome.texto.htmlText="<font color='#"+blast.list[app].cores.texto+"'>"+jsonlist[i].nome+"</font>";
			
			// [ APARÊNCIA : ÍCONES ]
			if(objeto[1]=="icones"){
				Tweener.addTween(root[nome+"_item"+(i+1)].fundo, {_color:"0x"+objeto[2], time: 0,transition: "linear",delay: 0});
				Tweener.addTween(root[nome+"_item"+(i+1)].molde, {_color:"0x"+objeto[3], time: 0,transition: "linear",delay: 0});
				criaIcon(nome+"_item"+(i+1)+"_icone",root[nome+"_item"+(i+1)].conteudo,blast.list.server.upload_path+"/"+jsonlist[i].icone,-35,-35,70,"normal",["0x"+objeto[4],null],["alpha","easeOutExpo",0]);
				root[nome+"_item"+(i+1)].icone = root[nome+"_item"+(i+1)+"_icone"];
				root[nome+"_item"+(i+1)].iconeLocalImagem = root[nome+"_item"+(i+1)+"_icone"].localimagem;
			}
			// [ APARÊNCIA : AVATAR ]
			if(objeto[1]=="avatar"){
				Tweener.addTween(root[nome+"_item"+(i+1)].fundo, {_color:"0x"+objeto[2], time: 0,transition: "linear",delay: 0});
				img_load("list_avatar"+(i+1),jsonlist[i]['avatar'],root[nome+"_item"+(i+1)].conteudo,["width",85,"resize"],null,[0,0,"center2"],[],0,null)
			};
			
			// [ APARÊNCIA : MARKERDATE ]
			if(markerDate!=null && markerDate[1]==true){
				if(jsonlist[i][markerDate[0]]!="0000-00-00 00:00:00"){
					trace("Todos amigos!");
					root[nome+"_item"+(i+1)].fundo.scaleX = root[nome+"_item"+(i+1)].fundo.scaleY = .9; 
					Tweener.addTween(root[nome+"_item"+(i+1)].fundo, {_color:"0x"+corbt1, time: 0,transition: "linear",delay: 0});
				};
			};
			
			
			
			// -----------------------------------------------------
			// [ ALINHAMENTO ]
			// [ OBJETOS : DIMENSÕES ]
			if(i==0){ 
				altura = root[nome+"_item"+(i+1)].height;
			}
			
			// [ ALINHAMENTO ] :: CENTER
			if(alinhamento[1] == "center"){
				if(i==0){
					if((jsonlist.length-i)<qntporlinha){
						qntporlinha = jsonlist.length-i;
						if(qntporlinha==1){
							dif = ((largura/qntporlinha)/2);
							root[nome+"_item"+(i+1)].x = Math.ceil(((largura/qntporlinha)*count)-dif);
						}
						if(qntporlinha==2){
							dif = 0;
							root[nome+"_item"+(i+1)].x = Math.ceil(((largura/alinhamento[0])*count)-dif);
						}
					}else{
						dif = ((largura/alinhamento[0])/2);
						qntporlinha = alinhamento[0];
						root[nome+"_item"+(i+1)].x = Math.ceil(((largura/alinhamento[0])*count)-dif);
					}
					root[nome+"_item"+(i+1)].y = Math.ceil(altura/2);
				}else{
					if(count>alinhamento[0]){
						count=1;
						root[nome+"_item"+(i+1)].y = Math.ceil(root[nome+"_item"+(i)].y+altura+5);
						if((jsonlist.length-i)<qntporlinha){
							qntporlinha = jsonlist.length-i;
							if(qntporlinha==1){
								dif = ((largura/qntporlinha)/2);
								root[nome+"_item"+(i+1)].x = Math.ceil(((largura/qntporlinha)*count)-dif);
							}
							if(qntporlinha==2){
								dif = 0;
								root[nome+"_item"+(i+1)].x = Math.ceil(((largura/alinhamento[0])*count)-dif);
							}
						}else{
							dif = ((largura/alinhamento[0])/2);
							qntporlinha = alinhamento[0];
							root[nome+"_item"+(i+1)].x = Math.ceil(((largura/alinhamento[0])*count)-dif);
						}
					}else{
						root[nome+"_item"+(i+1)].x = Math.ceil(((largura/alinhamento[0])*count)-dif);
						root[nome+"_item"+(i+1)].y = Math.ceil(root[nome+"_item"+(i)].y);
					};
				};
			};
			// [ ALINHAMENTO ] :: CENTER DESIGN
			if(alinhamento[1] == "centerDesign"){
				
			};
			// -----------------------------------------------------
			
			// [ AÇÕES ]
			root[nome+"_item"+(i+1)].addEventListener(MouseEvent.CLICK, callback);
			root[nome+"_item"+(i+1)].buttonMode = true;
			
			// [ APLICAÇÃO c/ ANIMAÇÃO ]
			/*
			root[nome+"_item"+(i+1)].scaleX = root[nome+"_item"+(i+1)].scaleY = 0;
			timeDelay = .3+((1 + (100 - 1) * Math.random())/100);
			root[nome+"_item"+(i+1)].rotation = ((1 + (100 - 1) * Math.random())-50)/2
			Tweener.addTween(root[nome+"_item"+(i+1)], {scaleX:1, scaleY:1, rotation:0, time: 1,transition: "easeOutElastic",delay: timeDelay});
			*/
			Tweener.addTween(root[nome+"_item"+(i+1)].nome, {alpha:1, time: 1,transition: "easeOutExpo",delay: 2});
			local.addChild(root[nome+"_item"+(i+1)]);
			
			// [ ATIVAÇÃO ]
			if(array_search(jsonlist[i]['id'],idscheck[0])>=0){
				idscheck[1](root[nome+"_item"+(i+1)],true);
				trace("Testando")
			};
			
		};
	};
};

//-----------------------------------------------------------------
// LISTAGEM (Único po linha)
//-----------------------------------------------------------------
// + nome
// + local
// + posx
// + posy
// + largura
// + objeto [Movie,movimento,animate,corBorda] 
// + alinhamento [quantidade por linha, tipo]
// + jsonlist
// + idscheck [(Array de IDS ue serão selecionados),callback de visualização ativada]
// + callback

function criaListaComum(nome,local,posx,posy,largura,objeto,jsonlist,idscheck,callback){
	
	// [ VARIÁVEIS INICIAS ]
	var itemClass:Class;
	var count = 0;
	var timeDelay = 0;
	
	// [ MONTAGEM DA LISTA ]
	if(jsonlist.length==0){
		
	}else{
		for(var i=0; i<jsonlist.length; i++){
			count++;
			// ----------------------------------------
			// [ OBJETOS : Thumb_listagem_arredondado ]
			if(objeto[0]=="Thumb_listagem_arredondado"){ 
				root[nome+"_item"+(i+1)] = new Thumb_listagem_arredondado();
				if(objeto[1][0]=="icone"){
					criaIcon(nome+"_item"+(i+1)+"_icone",root[nome+"_item"+(i+1)],blast.list.server.server_path+"/com/icones/"+objeto[1][1],10,12,50,"bullet",["0x"+objeto[1][2],"0x"+objeto[1][3]],["alpha","easeOutExpo",0]);
				};
			}
			// ----------------------------------------
			// [ OBJETOS : Thumb_listagem_arredondado ]
			if(objeto[0]=="Thumb_listagem_atividades"){ 
				root[nome+"_item"+(i+1)] = new Thumb_listagem_atividades();
				if(objeto[1][0]=="icone"){
					criaIcon(nome+"_item"+(i+1)+"_icone",root[nome+"_item"+(i+1)],blast.list.server.server_path+"/com/icones/"+objeto[1][1],10,12,50,"bullet",["0x"+objeto[1][2],"0x"+objeto[1][3]],["alpha","easeOutExpo",0]);
				};
				Tweener.addTween(root[nome+"_item"+(i+1)].linha, {_color:"0x"+coricon, time: 0,transition: "linear",delay: 0});
				Tweener.addTween(root[nome+"_item"+(i+1)].linha, {_color:"0x"+coricon, time: 0,transition: "linear",delay: 0});
			};
			
			// [ APARÊNCIA ]
			root[nome+"_item"+(i+1)].n = (i+1);
			root[nome+"_item"+(i+1)]['id'] = jsonlist[i]['id'];
			root[nome+"_item"+(i+1)].attr = jsonlist[i];
			//root[nome+"_item"+(i+1)].nome.htmlText = "<font color='#"+blast.list[app].cores.titulos+"'>"+jsonlist[i].id_d_cupom.nome+"</font>";
			//root[nome+"_item"+(i+1)].descricao.htmlText = "Loja: level.expert - Desconto: 5%<br>Validade: 18/04/2017";
			//Tweener.addTween(root[nome+"_item"+(i+1)].fundo, {_color:"0x"+objeto[2], time: .5,transition: "easeOutExpo",delay: 0});
			
			// [ ALINHAMENTO ]
			root[nome+"_item"+(i+1)].x=0;
			root[nome+"_item"+(i+1)].y = (root[nome+"_item"+(i+1)].height+5)*i;
			
			// [ APLICAÇÃO c/ ANIMAÇÃO ]
			local.addChild(root[nome+"_item"+(i+1)]);
		}
	}
}

//-----------------------------------------------------------------
// LISTAGEM DE THUMBS SIMPLES
//-----------------------------------------------------------------
// + nome
function criaListaDeThumb(nome,local,posx,posy,larguradostage,larguradoobjeto,margem,dados,clique,objeto){
	var count = 0;
	var totalperline = Math.floor(larguradostage/larguradoobjeto);
	for(var i=0; i<dados[0].length; i++){
		count++;
		criaThumb(nome+"_"+(i+1),dados[0][i][dados[1]][dados[2][0]],local,blast.list.server.upload_path+"/"+dados[0][i][dados[1]][dados[2][1]],0,0,1,"ffffff",corbt1,objeto);
		root[nome+"_"+(i+1)].dados = dados[0][i];
		root[nome+"_"+(i+1)].m = (i+1);
		if(i==0){
			root[nome+"_"+(i+1)].x = posx;
			root[nome+"_"+(i+1)].y = posy;
		}else{
			root[nome+"_"+(i+1)].x = root[nome+"_"+(i)].x + root[nome+"_"+(i)].width + margem[0];
			root[nome+"_"+(i+1)].y = root[nome+"_"+(i)].y;
		}
		if(count>totalperline){
			root[nome+"_"+(i+1)].x = posx;
			root[nome+"_"+(i+1)].y = root[nome+"_"+(i)].y +root[nome+"_"+(i)].height + margem[1];
			count=1;
		};
		root[nome+"_"+(i+1)].idX = count;
		root[nome+"_"+(i+1)].addEventListener(MouseEvent.CLICK, clique);
		
	}
}
//-----------------------------------------------------------------
// LISTAGEM DE LABELS
//-----------------------------------------------------------------
// + nome
function criaListagem(tipo,tamanho,nome,local,posx,posy,larguradostage,margem,dados,clique){
	var count = 0;
	for(var i=0; i<dados.length; i++){
		count++;
		// ----------------------
		// Conversões de String:
		var valor = dados[i][1];
		if(dados[i][2]=="data-DiaMesAno"){ valor = convertDataDiaMesAno(valor) };
		if(dados[i][2]=="data-DiaMes"){ valor = convertDataDiaMes(valor) };
		
		// ----------------------
		//  Tipos de Thumb:
		if(tipo=="Labels"){
			criaLabel(nome+"_"+(i+1),dados[i][0],valor,local,190,"modal_det_titulo",1,dados[i][3],dados[i][4],"M");
		}
		// ----------------------
		//  Aplicação:
		root[nome+"_"+(i+1)].m = (i+1);
		root[nome+"_"+(i+1)].dados = dados[0][i];
		if(i==0){
			root[nome+"_"+(i+1)].x = posx;
			root[nome+"_"+(i+1)].y = posy;
		}else{
			root[nome+"_"+(i+1)].x = root[nome+"_"+(i)].x + root[nome+"_"+(i)].width + margem[0];
			root[nome+"_"+(i+1)].y = root[nome+"_"+(i)].y;
		}
		if((root[nome+"_"+(i+1)].x)>larguradostage){
			root[nome+"_"+(i+1)].x = posx;
			root[nome+"_"+(i+1)].y = root[nome+"_"+(i)].y +root[nome+"_"+(i)].height + margem[1];
			count=1;
		};
		root[nome+"_"+(i+1)].idX = count;
		// ----------------------
		//  Clique:
		if(clique!=null){root[nome+"_"+(i+1)].addEventListener(MouseEvent.CLICK, clique);}
		
	}
}
//-----------------------------------------------------------------
// LISTAGEM DE RESPOSTAS
//-----------------------------------------------------------------
// + nome
function criaRespostas(tipo,nome,local,posx,posy,dados,respostaString,clique){
	for(var i=0; i<dados.length; i++){
		// Define Objeto:
		if(tipo=="Resposta"){root["resposta"+(i+1)] = new Resposta()};
		// Monta as Respostas
		root[nome+(i+1)].name = nome+(i+1);
		root[nome+(i+1)].n = i+1;
		root[nome+(i+1)].m = dados[i]['id'];
		root[nome+(i+1)].texto.autoSize =  TextFieldAutoSize.CENTER ;
		root[nome+(i+1)].texto.htmlText="<font color='#"+cortexto+"'>"+dados[i][respostaString]+"</font>";
		root[nome+(i+1)].texto.y = 30-(root[nome+(i+1)].texto.height/2);
		if(root[nome+(i+1)].texto.height>50){
			root[nome+(i+1)].texto.y = 5;
			root[nome+(i+1)].meio.height = root[nome+(i+1)].texto.height-12;
			root[nome+(i+1)].rodape.y = (root[nome+(i+1)].meio.y+root[nome+(i+1)].meio.height);
			root[nome+(i+1)].rodape_sombra.y = root[nome+(i+1)].rodape.y+7;
		}
		if(i==0){
			root[nome+(i+1)].y = 0;
		}else{
			root[nome+(i+1)].y = (root[nome+(i)].y+root[nome+(i)].height+6);
		}
		local.addChild(root[nome+(i+1)]);
		root[nome+(i+1)].addEventListener(MouseEvent.CLICK, resposta_clique);
		function resposta_clique(e:MouseEvent):void {
			atualizaVisual(e.currentTarget.n);
			clique(e.currentTarget.n,e.currentTarget.m);
		}
	};
	function atualizaVisual(n){
		for(var i=1; i<=dados.length; i++){
			if(i==n){
				Tweener.addTween(root[nome+(i)].checkbox.fundo, {_color:"0x34C873", time: 1,transition: "easeOutExpo",delay: 0});
				Tweener.addTween(root[nome+(i)].topo, {_color:"0x"+corbt1, alpha:.2, time: 1,transition: "easeOutExpo",delay: 0});
				Tweener.addTween(root[nome+(i)].meio, {_color:"0x"+corbt1, alpha:.2, time: 1,transition: "easeOutExpo",delay: 0});
				Tweener.addTween(root[nome+(i)].rodape, {_color:"0x"+corbt1, alpha:.2, time: 1,transition: "easeOutExpo",delay: 0});
			}else{
				Tweener.addTween(root[nome+(i)].checkbox.fundo, {_color:null, time: 1,transition: "easeOutExpo",delay: 0});
				Tweener.addTween(root[nome+(i)].topo, {_color:null, alpha:1, time: 1,transition: "easeOutExpo",delay: 0});
				Tweener.addTween(root[nome+(i)].meio, {_color:null, alpha:1, time: 1,transition: "easeOutExpo",delay: 0});
				Tweener.addTween(root[nome+(i)].rodape, {_color:null, alpha:1, time: 1,transition: "easeOutExpo",delay: 0});
			};
		};
	};
};
