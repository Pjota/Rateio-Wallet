//==============================
// MODAL ENDEREÇOS: LISTAGEM
// > Modal que demostra todos os endereços cadastros deste usuário
//==============================

if(tipo[0]=="modal_endereco_listagem"){
	
	// ---------------------------------------
	// Variáveis iniciais:
	root["modal_endereco_total"] = 0;
	root["modal_endereco_endSearch"] = false;
	// ---------------------------------------
	// # Variáveis iniciais:
	if(tipo[3]==null){
		// # 1) Sem opção de cadastro na mesma tela:
		img_load("modal_foto","sc_enderecos.png",root[nome].conteudo,["width",365,"resize"],null,[0,30],[],0,null);
		root["modal_offset"]=0;
		root["modal_lista_mask"]=242;
	}else{
		// # 2) Com opção de cadastro na mesma tela:
		img_load("modal_foto","sc_enderecos.png",root[nome].conteudo,["width",120,"resize"],null,[120,30],[],0,null);
		root["modal_offset"] = 110;
		root["modal_lista_mask"]=180;
		// # Título e Texto de Cadastrar Endereço:
		root["modal_titulo_cadastro"] = new Titulo_Modal();
		root["modal_titulo_cadastro"].y = 100; 
		root["modal_titulo_cadastro"].titulo.htmlText="<font color='#"+corbt1+"'>Novo Local</font>";
		root["modal_titulo_cadastro"].texto.htmlText="";
		root["modal_titulo_cadastro"].texto.selectable = false;
		root[nome].conteudo.addChild(root["modal_titulo_cadastro"]);
		// # Digite o Endereço:
		criaInput("modal_cadastro_input_end", "Informe a localização", root[nome].conteudo, 50,130, .85, "0xFFFFFF", "0x"+cortexto, 60, false,"G");
		criaBt("modal_cadastro_end_Search","Buscar",root[nome].conteudo,50,185,.85,"0x"+cortexto,"G");
		root["modal_cadastro_end_Search"].addEventListener(MouseEvent.CLICK, buscando_endereco);
		root["modal_cadastro_end_Search"].buttonMode = true;
		root["modal_cadastro_end_Search"].posy = root["modal_cadastro_end_Search"].y;
		function buscando_endereco(e:MouseEvent):void {
			if(root["modal_endereco_endSearch"]==false){
				// # Em caso de Endereço não buscado:
				if(root["modal_cadastro_input_end"].texto.text!="Informe a localização"){
					array = '{"endereco":"'+root["modal_cadastro_input_end"].texto.text+'"}';
					connectServer(false,"screen",servidor+"api/geo/endereco",[
					["endereco",root["modal_cadastro_input_end"].texto.text,"texto"],
					["json",array,"texto"],
					],buscando_endereco_gmaps);
					function buscando_endereco_gmaps(dados){
						root["modal_endereco_json"] = dados;
						if(dados.list.localizacao.geometry.location_type!="APPROXIMATE"){
							root["modal_endereco_item_0"] = new Endereco();
							root["modal_endereco_item_0"].name = "modal_endereco_item_0";
							root["modal_endereco_item_0"].y = 180;
							root["modal_endereco_item_0"].x = 45;
							root["modal_endereco_item_0"].checkbox.visible=false;
							criaIcon("modal_endereco_item_0_icone",root["modal_endereco_item_0"],blast.list.server.server_path+"/com/icones/map-marker.png",15,15,25,"normal",["0x"+coricon,"0x"+coricon],["alpha","easeOutExpo",1]);
							root["modal_endereco_item_0"].deletar.gotoAndStop(1);
							root["modal_endereco_item_0"]['id'] = 1;
							root["modal_endereco_item_0"].texto.htmlText = "<font color='#"+cortexto+"'>"+dados.list.localizacao.formatted_address+"</font>";
							Tweener.addTween(root["modal_endereco_item_0"].deletar, {_color:"0x"+corcancel, alpha:1,time: 0,transition: "linear",delay: 0});
							Tweener.addTween(root["modal_endereco_item_0"].fundo, {_color:"0x"+corbt1, alpha:.1,time: 0,transition: "linear",delay: 0});
							root["modal_endereco_item_0"].deletar.addEventListener(MouseEvent.CLICK, modal_endereco_listagem_fecharEndereco);
							function modal_endereco_listagem_fecharEndereco(){
								root[nome].conteudo.removeChild(root["modal_endereco_item_0"]);
								root["modal_cadastro_input_end"].setText("Informe a localização");
								modal_endereco_listagem_cadastroEnd_Fechar()
							}
							root["modal_endereco_item_0"].hit.n = 1;
							root["modal_endereco_item_0"].hit['endereco'] = "End"
							root["modal_endereco_item_0"].hit['id'] = 1;
							root["modal_endereco_item_0"].alpha=0;
							Tweener.addTween(root["modal_endereco_item_0"], {alpha:1,time:.5,transition: "easeOutExpo",delay: 0});
							Tweener.addTween(root["modal_endereco_item_0"], {y:190,time:.5,transition: "easeOutElastic",delay: 0});
							root[nome].conteudo.addChild(root["modal_endereco_item_0"]);
							modal_endereco_listagem_cadastroEnd_Open();
						}else{
							newbalaoInfo(root[nome].conteudo,'Informe uma localização válida',(root["modal_cadastro_end_Search"].x+(root["modal_cadastro_end_Search"].width/2)),(root["modal_cadastro_end_Search"].y+30),"BalaoInfo","0x"+corcancel);
						}
					}
				}else{
					newbalaoInfo(root[nome].conteudo,'Você esqueceu de informar a localização',(root["modal_cadastro_end_Search"].x+(root["modal_cadastro_end_Search"].width/2)),(root["modal_cadastro_end_Search"].y+30),"BalaoInfo","0x"+corcancel);
				}
			}else{
				// ---------------------------------
				// # Em caso de Endereço já buscado:
				var dados = root["modal_endereco_json"];
				array = '{';
				array += '"tipo" : "'+root["User"]['table']+'",';
				array += '"busca" : "'+root["modal_cadastro_input_end"].texto.text+'",';
				array += '"completo" : "'+dados.list.localizacao.formatted_address+'",';
				array += '"nome" : "Endereço Simples",';
				array += '"cep":"'+limpa_numeros(gmaps_componentes("postal_code",dados))+'",';
				array += '"rua" : "'+gmaps_componentes("route",dados)+'",';
				array += '"numero" : "'+gmaps_componentes("street_number",dados)+'",';
				array += '"complemento":"'+gmaps_componentes("subpremise",dados)+'",';
				array += '"observacao":"'+gmaps_componentes("premise",dados)+'",';
				array += '"bairro":"'+gmaps_componentes("sublocality",dados)+'",';
				array += '"id_local_estados":"'+gmaps_componentes("administrative_area_level_1",dados)+'",';
				array += '"id_local_cidades":"'+gmaps_componentes("administrative_area_level_2",dados)+'",';			
				array += '"latitude":"'+dados.list.localizacao.geometry['location'].lat+'",';
				array += '"longitude":"'+dados.list.localizacao.geometry['location'].lng+'",';
				array += '"principal" : "1"';
				array += '}';
				// ----------------------------
				// # Gravação de novo endereço:
				connectServer(false,"screen",servidor+"api/add/local_enderecos/",[
				["id_usuarios",root["User"]['id'],"texto"],
				["json",array,"texto"],
				],endereco_salvo);
				function endereco_salvo(dados){
					root["modal_endereco_esc"] = dados.list['id'];
					tipo[2](dados.list.completo, dados.list['id'])
					setTimeout(modal_fechar,400,realnome)
				}
			}
		}
		// Fecha e abre endereço selecionado:
		function modal_endereco_listagem_cadastroEnd_Open(){
			root["modal_endereco_endSearch"] = true;
			desativaInputView(root["modal_cadastro_input_end"]);
			root["modal_cadastro_input_end"].addEventListener(MouseEvent.CLICK, modal_cadastro_input_end_click);
			Tweener.addTween(root["modal_cadastro_end_Search"], {y:(root["modal_cadastro_end_Search"].posy+70), time: .5,transition: "easeOutExpo",delay: 0});
			root["modal_cadastro_end_Search"].texto.htmlText = "Selecionar Localização";
			Tweener.addTween(root["modal_cadastro_end_Search"].texto, {_color:"0xffffff", time: .5,transition: "easeOutExpo",delay: 0});
			Tweener.addTween(root["modal_cadastro_end_Search"].fundo, {_color:"0x"+corbt1, time: .5,transition: "easeOutExpo",delay: 0});
		}
		function modal_endereco_listagem_cadastroEnd_Fechar(){
			root["modal_endereco_endSearch"] = false;
			ativaInput(root["modal_cadastro_input_end"]);
			root["modal_cadastro_input_end"].removeEventListener(MouseEvent.CLICK, modal_cadastro_input_end_click);
			Tweener.addTween(root["modal_cadastro_end_Search"], {y:(root["modal_cadastro_end_Search"].posy), time: .5,transition: "easeOutExpo",delay: 0});
			root["modal_cadastro_end_Search"].texto.htmlText = "Buscar";
			Tweener.addTween(root["modal_cadastro_end_Search"].texto, {_color:"0xffffff", time: .5,transition: "easeOutExpo",delay: 0});
			Tweener.addTween(root["modal_cadastro_end_Search"].fundo, {_color:"0x"+cortexto, time: .5,transition: "easeOutExpo",delay: 0});
		}
		function modal_cadastro_input_end_click(){
			root[nome].conteudo.removeChild(root["modal_endereco_item_0"]);
			modal_endereco_listagem_cadastroEnd_Fechar()
		}
	}
	
	// ---------------------------------------
	// # Título e Texto de Listagem de Conteúdo:
	root["modal_titulo"] = new Titulo_Modal();
	root["modal_titulo"].y = root["modal_offset"]+210; 
	root["modal_titulo"].titulo.htmlText="<font color='#"+corbt1+"'>"+titulo+"</font>";
	root["modal_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER;
	texto = "<font color='#"+cortexto+"'>"+texto+"</font>";
	root["modal_titulo"].texto.htmlText=texto;
	root["modal_titulo"].texto.selectable = false;
	root[nome].conteudo.addChild(root["modal_titulo"]);
	// # Área de Conteúdo:
	root["modal_end_conteudo"] = new Vazio();
	root["modal_end_conteudo"].y = root["modal_offset"]+280;
	root["modal_end_conteudo"].x = 45;
	root[nome].conteudo.addChild(root["modal_end_conteudo"]);
	// # Busca Endereços:
	function modal_endereco_listagem_init(){
		connectServer(false,"screen",servidor+"api/list/local_enderecos/tipo="+root["User"]['table']+",id_responsavel="+root["User"]['id']+",order_direct=DESC",[
		],modal_endereco_listagem_start);
	}
	modal_endereco_listagem_init()
	// # Monta Endereços:
	function modal_endereco_listagem_start(dados){
		try{
		destroir(root["modal_end_conteudo"],true);
		}catch(error:Error){}
		root["modal_endereco_total"] = dados.list.length
		root["modal_end_listagem"] = new Vazio();
		for(var i=0; i<dados.list.length; i++){
			root["modal_endereco_item"+(i+1)] = new Endereco();
			root["modal_endereco_item"+(i+1)].name = "modal_endereco_item"+(i+1);
			root["modal_endereco_item"+(i+1)].y = ((root["modal_endereco_item"+(i+1)].height+5)*i);
			root["modal_endereco_item"+(i+1)].deletar.gotoAndStop(2);
			root["modal_endereco_item"+(i+1)]['id'] = dados.list[i]['id']
			root["modal_endereco_item"+(i+1)].texto.htmlText = "<font color='#"+cortexto+"'>"+dados.list[i].rua+" "+dados.list[i].numero+" "+dados.list[i].complemento+" "+dados.list[i].bairro+" "+capitalize(caixaBaixa(dados.list[i].id_local_cidades.nome))+"</font>";
			Tweener.addTween(root["modal_endereco_item"+(i+1)].deletar, {_color:"0x"+corcancel, alpha:1,time: 0,transition: "linear",delay: 0});
			Tweener.addTween(root["modal_endereco_item"+(i+1)].fundo, {_color:"0x"+corbt1, alpha:.1,time: 0,transition: "linear",delay: 0});
			root["modal_endereco_item"+(i+1)].deletar.addEventListener(MouseEvent.CLICK, modal_endereco_deletar);
			root["modal_endereco_item"+(i+1)].hit.n = root["modal_endereco_item"+(i+1)].deletar.n = (i+1);
			root["modal_endereco_item"+(i+1)].hit['endereco'] = dados.list[i].rua+" "+dados.list[i].numero+" "+dados.list[i].complemento+" "+dados.list[i].bairro+" "+capitalize(caixaBaixa(dados.list[i].id_local_cidades.nome))
			root["modal_endereco_item"+(i+1)].hit['id'] = root["modal_endereco_item"+(i+1)].deletar['id'] = dados.list[i]['id']
			root["modal_endereco_item"+(i+1)].hit.addEventListener(MouseEvent.CLICK, modal_endereco_seleciona);
			root["modal_end_listagem"].addChild(root["modal_endereco_item"+(i+1)]);
		}
		setScroller("scroller",root["modal_end_listagem"],root["modal_end_conteudo"],300,root["modal_lista_mask"],0,0,0,0,false,"VERTICAL");
		modal_endereco_seleciona_Visual(root["modal_endereco_esc"])
	}
	// # Seleciona Endereço:
	function modal_endereco_seleciona(e:MouseEvent):void {
		root["modal_endereco_esc"] = e.currentTarget['id'];
		modal_endereco_seleciona_Visual(root["modal_endereco_esc"]);
		tipo[2](e.currentTarget['endereco'],e.currentTarget['id'])
		setTimeout(modal_fechar,400,realnome);
	};
	function modal_endereco_seleciona_Visual(alvo) {
		for(var i=1; i<=root["modal_endereco_total"]; i++){
			if(root["modal_endereco_item"+(i)]['id']==alvo){
				Tweener.addTween(root["modal_endereco_item"+(i)].fundo, {_color:"0x23db6d",time:1,transition: "easeOutExpo",delay: 0});
				Tweener.addTween(root["modal_endereco_item"+(i)].checkbox.fundo, {_color:"0x23db6d",time:1,transition: "easeOutExpo",delay: 0});
			}else{
				Tweener.addTween(root["modal_endereco_item"+(i)].fundo, {_color:"0x"+corbt1,time:1,transition: "easeOutExpo",delay: 0});
				Tweener.addTween(root["modal_endereco_item"+(i)].checkbox.fundo, {_color:null,time:1,transition: "easeOutExpo",delay: 0});
			}
		}
	}
	// # Botão de Cadastrar Novo Endereço:
	if(tipo[3]==null){
		criaBt("modal_endereco_cadastrar","Cadastrar Novo Endereço",root[nome].conteudo,45,500,.89,"0x"+corbt1,"G");
		root["modal_endereco_cadastrar"].addEventListener(MouseEvent.CLICK, function(){modal_endereco_cadastrar_click()});
		root["modal_endereco_cadastrar"].buttonMode = true;
		function modal_endereco_cadastrar_click(){
			modal_abrir("modal_social_search_gps_enderecos_add",["modal_endereco_cadastro","gps","0xf8f8f8",modal_endereco_cadastrou],"Novo Endereço","Cadastre a localização de sua próxima atividade:<br>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at fermentum sapien, sed convallis dolor.",true,null,"M");
		};
		function modal_endereco_cadastrou(){
			modal_fechar(realnome);
		};
	};
	// # Deletar Endereço:
	function modal_endereco_deletar(e:MouseEvent):void {
		var alvo = e.currentTarget.n;
		var alvoID = e.currentTarget['id'];
		modal_abrir("modal_endereco_deletar_confirma",["confirmacaoAlert","Remover",corcancel,1,modal_endereco_deletar_confirmar],"Remover","Tem certeza que deseja remover este endereço?",true,null,"P");
		function modal_endereco_deletar_confirmar(){
			root["modal_endereco_item"+(alvo)].deletar.gotoAndStop(3);
			Tweener.addTween(root["modal_endereco_item"+(alvo)].deletar, {_color:"0xffffff", alpha:1,time: 0,transition: "linear",delay: 0});
			Tweener.addTween(root["modal_endereco_item"+(alvo)].fundo, {_color:"0x"+corcancel, alpha:1,time: 0,transition: "linear",delay: 0});
			var array = '{"ativo":"0"}';
			connectServer(false,"screen",servidor+"api/edit/local_enderecos/",[
			["id",alvoID,"texto"],
			["json",array,"texto"],
			],modal_endereco_deletar_ok);
		};
		function modal_endereco_deletar_ok(dados){
			if(dados.list.retorno=="ok"){
				if(root["modal_endereco_esc"]==dados.list['id']){
					root["modal_endereco_esc"] =0;
					tipo[2]("Endereço Completo","");
				}
				modal_endereco_listagem_init();
			};
		};
	};
};