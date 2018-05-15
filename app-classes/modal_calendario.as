if(tipo[0]=="calendario"){
	
	// ===========================
	// CALENDÁRIO: Título e Texto
	// ===========================
	root["modal_titulo"] = new Titulo_Modal();
	root["modal_titulo"].y = 40; 
	root["modal_titulo"].titulo.htmlText="<font color='#"+corbt1+"'>"+titulo+"</font>";
	root["modal_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER;
	texto = "<font color='#"+cortexto+"'>"+texto+"</font>";
	root["modal_titulo"].texto.htmlText=texto;
	root["modal_titulo"].texto.selectable = true;
	root[nome].conteudo.addChild(root["modal_titulo"]);
	
	// ====================================
	// CALENDÁRIO: Setas de Troca Mês e Ano
	// ====================================
	
	root["calendario_ano_inicial"] = tipo[2].substr(0,4);
	root["calendario_mes_inicial"] = tipo[2].substr(5,2);
	root["calendario_mes"];
	root["calendario_ano"];
	root["calendario_trocames"] = new titulo_simples();
	root["calendario_trocames"].y = 125;
	root["calendario_trocames"].x = 87;
	root["calendario_trocames"].texto.htmlText="<font color='#"+cortexto+"'>Carregando...</font>";
	root[nome].conteudo.addChild(root["calendario_trocames"]);
	criaIcon("calendario_trocames_voltar",root[nome].conteudo,blast.list.server.server_path+"/com/icones/direction.png",50,122,40,"bullet",["0xffffff","0x"+corbt1],["alpha","easeOutExpo",1]);
	root["calendario_trocames_voltar"].buttonMode = true;
	// ----------------
	// # Regras: Load
	if(tipo[3].indexOf("futuro")>=0){
		root["calendario_trocames_voltar"].alpha=.2;
	}
	// ----
	root["calendario_trocames_voltar"].addEventListener(MouseEvent.CLICK, calendario_trocames_voltar_click);
	function calendario_trocames_voltar_click(e:MouseEvent):void {
		// ----------------
		// # Configurações iniciais + Calculo de próximo dia:
		var liberado = true;
		Tweener.addTween(root["calendario_trocames_passar"], {alpha:1, time: .5,transition: "easeOutExpo",delay: 0});
		var ano = root["calendario_ano"];
		var mes = root["calendario_mes"];
		var mesString;
		mes--;
		if(mes==0){ mes = 12; ano--;}
		if(mes<10){ mesString="0"+mes; }else{ mesString = mes; }
		// ----------------
		// # Regras: Click
		if(tipo[3].indexOf("futuro")>=0){
			trace("--> "+ano+""+mesString+" // "+root["calendario_ano_inicial"]+""+root["calendario_mes_inicial"])
			if(Number(ano+""+mesString)<Number(root["calendario_ano_inicial"]+""+root["calendario_mes_inicial"])){
				liberado = false;
			}
		}
		// ----------------
		// # Liberação:
		if(liberado == true){
			root["calendario_ano"] = ano;
			root["calendario_mes"] = mes;
			calendarioCreate(ano+"-"+mesString+"-01 00:00:00");
		}
	};
	criaIcon("calendario_trocames_passar",root[nome].conteudo,blast.list.server.server_path+"/com/icones/share-option.png",280,122,40,"bullet",["0xffffff","0x"+corbt1],["alpha","easeOutExpo",1]);
	// ----------------
	// # Regras: Load	
	root["calendario_trocames_passar"].buttonMode = true;
	root["calendario_trocames_passar"].addEventListener(MouseEvent.CLICK, calendario_trocames_passar_click);
	function calendario_trocames_passar_click(e:MouseEvent):void {
		// ----------------
		// # Configurações iniciais + Calculo de próximo dia:
		var liberado = true;
		Tweener.addTween(root["calendario_trocames_voltar"], {alpha:1, time: .5,transition: "easeOutExpo",delay: 0});
		// ----------------
		// # Regras: Click
		// ----
		if(liberado == true){
			root["calendario_mes"]++;
			if(root["calendario_mes"]==13){
				root["calendario_mes"] = 1;
				root["calendario_ano"]++;
			}
			var mes;
			if(root["calendario_mes"]<10){ mes="0"+root["calendario_mes"]; }else{ mes = root["calendario_mes"]; }
			calendarioCreate(root["calendario_ano"]+"-"+mes+"-01 00:00:00");
		}
	};	
	
	// ===========================
	// CALENDÁRIO: Inicia Calendario
	// ===========================
	root["calendario_listagem"] = new Vazio();
	root["calendario_listagem"].y = 180;
	root["calendario_listagem"].x = 50
	root["calendario_listagem"].qntLinha = 4;
	root[nome].conteudo.addChild(root["calendario_listagem"]);
	root["calendario_daysCache"] = []
	root["calendario_daysESC"] = []
	calendarioCreate(tipo[2]);
	// ---------------------
	// # Interface Inferior:
	if(tipo[1]=="range"){
		criaLabel("calendario_data1","De:","",root[nome].conteudo,50,458,1,"E8E8E8",cortexto,"M");
		criaLabel("calendario_data2","Até:","",root[nome].conteudo,190,458,1,"E8E8E8",cortexto,"M");
	}
	if(tipo[1]=="data"){
		criaLabel("calendario_data1","Data Escolhida:","",root[nome].conteudo,50,458,1,"E8E8E8",cortexto,"G");
	}
	
	// ===========================
	// CALENDÁRIO: Aplicar Data (ok!)
	// ===========================
	criaBt("calendario_ok","Aplicar",root[nome].conteudo,120,520,.95,"0x"+cortexto,"M");
	root["calendario_ok"].addEventListener(MouseEvent.CLICK, calendario_selecionado);
	root["calendario_ok"].buttonMode = true;
	function calendario_selecionado(e:MouseEvent):void{
		if(tipo[1]=="range"){
			if(root["calendario_daysESC"].length==2){
				tipo[4](root["calendario_daysESC"][0][1],root["calendario_daysESC"][1][1]);
				modal_fechar(nome+"_mv_"+modalRegistro);
			}else{
				newbalaoInfo(root[nome].conteudo,'Selecione datas de inicio e fim.',(root["calendario_ok"].x+(root["calendario_ok"].width/2)),(root["calendario_ok"].y+30),"BalaoInfo","0x"+corcancel);
			}
		}
		if(tipo[1]=="data"){
			if(root["calendario_daysESC"].length==1){
				tipo[4](root["calendario_daysESC"][0][0],root["calendario_daysESC"][0][1]);
				modal_fechar(nome+"_mv_"+modalRegistro);
			}else{
				newbalaoInfo(root[nome].conteudo,'Selecione uma data válida.',(root["calendario_ok"].x+(root["calendario_ok"].width/2)),(root["calendario_ok"].y+30),"BalaoInfo","0x"+corcancel);
			}
		}
	};
	
	// ==============================================
	// CALENDÁRIO: Buscando um calendário de Mês/Ano
	// ==============================================
	function calendarioCreate(data){
		trace("Data: "+data)
		connectServer(false,"screen",servidor+"api/calendar/days/",[
		["data",data,"texto"],
		],calendarioGetDate);
		function calendarioGetDate(dados){
			
			// Atualiza informações de Calendario:
			root["calendario_mes"] = dados.list[0].mes_numero;
			root["calendario_ano"] = dados.list[0].ano;
			// Remove Calendario anterior:
			destroir(root["calendario_listagem"],true);
			// Atualiza Count do for:
			root["calendario_listagem"].count =0;
			// Cria Clipe de rolagem: 
			root["calendario_rolagem"] = new Vazio();
			root["calendario_trocames"].texto.htmlText="<font color='#"+cortexto+"'>"+dados.list[0].mes+"/"+dados.list[0].ano+"</font>";
			//  # Montagem dos Dias Selecionados
			root["calendario_dias"] = dados.list.length
			for(var p=0; p<root["calendario_dias"]; p++){
				// Cria Item:
				root["calendario_day"+(p+1)] = new Calendario_item();
				root["calendario_day"+(p+1)].n = p+1;
				// Aparencia:
				var corDia;
				var corSemana;
				var corFundo;
				if(dados.list[p]['status']=="passado"){
					corDia = "C4C4C4";
					corSemana = "C4C4C4";
					corFundo = "ffffff";
					root["calendario_day"+(p+1)]['status'] = "passado";
				}
				if(dados.list[p]['status']=="presente"){
					if(tipo[3].indexOf("hoje")>=0){
						corDia = "ffffff";
						corSemana = cortexto;
						corFundo = corbt1;
						root["calendario_day"+(p+1)]['status'] = "presente";
					}else{
						corDia = "C4C4C4";
						corSemana = "C4C4C4";
						corFundo = "ffffff";
						root["calendario_day"+(p+1)]['status'] = "passado";
					}
				}
				if(dados.list[p]['status']=="futuro"){
					corDia = "494949";
					corSemana = cortexto;
					corFundo = "F7F7F7";
					root["calendario_day"+(p+1)]['status'] = "futuro";
				}
				root["calendario_day"+(p+1)].corfundo = corFundo;
				root["calendario_day"+(p+1)]['d'] = dados.list[p]['d'];
				root["calendario_day"+(p+1)].dia = dados.list[p].dia;
				root["calendario_day"+(p+1)].diadasemana = dados.list[p].dia_semana;
				root["calendario_day"+(p+1)].textos.dia_mes.htmlText = "<font color='#"+corDia+"'>"+dados.list[p].dia_numero+"</font>";
				root["calendario_day"+(p+1)].textos.dia_semana.htmlText = "<font color='#"+corSemana+"'>"+dados.list[p].dia_semana+"</font>";
				root["calendario_day"+(p+1)].addEventListener(MouseEvent.CLICK, calendario_clique_dia);
				Tweener.addTween(root["calendario_day"+(p+1)].fundo, {_color:"0x"+corFundo, time: 0,transition: "linear",delay: 0});
				// Poiscionamento:
				root["calendario_listagem"].count++
				if(root["calendario_listagem"].count>root["calendario_listagem"].qntLinha){
					root["calendario_listagem"].count =1;
					root["calendario_day"+(p+1)].x = 0
					root["calendario_day"+(p+1)].y = root["calendario_day"+(p)].y + root["calendario_day"+(p)].height + 5
				}else{
					if(p==0){
						root["calendario_day"+(p+1)].x = 0;
						root["calendario_day"+(p+1)].y = 0;
					}else{
						root["calendario_day"+(p+1)].x = root["calendario_day"+(p)].x + root["calendario_day"+(p)].width + 5
						root["calendario_day"+(p+1)].y = root["calendario_day"+(p)].y
					}
				}
				// Aplica:
				root["calendario_rolagem"].addChild(root["calendario_day"+(p+1)]);
			}
			// Rolagem:
			setScroller("scroller",root["calendario_rolagem"],root["calendario_listagem"],300,277,0,0,0,0,false,"VERTICAL")
			
		};
		
	}

	// =====================================================
	// CALENDÁRIO: Escolhendo uma Data (Clique sobre a Data)
	// =====================================================
	function calendario_clique_dia(e:MouseEvent):void {
		
		// # Variáveis Iniciais:
		var corDia;
		var corSemana;
		var corFundo;
		
		// # Quando: "DATA"
		if(tipo[1]=="data"){
			root["calendario_data1"].texto.text = "";
			root["calendario_daysCache"] = [];
			root["calendario_daysESC"] = [];
			Tweener.addTween(root["calendario_ok"].fundo, {_color:"0x"+cortexto, time: 0,transition: "easeOutExpo",delay: 0});
			for(var m=0; m<root["calendario_dias"]; m++){
				if((m+1)==e.currentTarget.n){
					// ----------------
					// # Regras: Click
					if(tipo[3].indexOf("futuro")!==false){
						trace(e.currentTarget['status'])
						if(e.currentTarget['status']!="futuro"){
							Tweener.addTween(root["calendario_day"+(m+1)].fundo, {_color:"0x"+corcancel, time: .3,transition: "easeOutExpo",delay: 0});
							Tweener.addTween(root["calendario_day"+(m+1)].textos, {_color:"0xffffff", time: .3,transition: "easeOutExpo",delay: 0});
							Tweener.addTween(root["calendario_day"+(m+1)].fundo, {_color:"0x"+root["calendario_day"+(m+1)].corfundo, time: .5,transition: "easeOutExpo",delay: .4});
							Tweener.addTween(root["calendario_day"+(m+1)].textos, {_color:null, time: .5,transition: "easeOutExpo",delay: .4});
							newbalaoInfo(root[nome].conteudo,'Selecione uma data válida.',(root["calendario_ok"].x+(root["calendario_ok"].width/2)),(root["calendario_ok"].y+30),"BalaoInfo","0x"+corcancel);
						}else{
							Tweener.addTween(root["calendario_ok"].fundo, {_color:"0x"+corbt1, time: 1,transition: "easeOutExpo",delay: 0});
							Tweener.addTween(root["calendario_day"+(m+1)].fundo, {_color:"0x"+cortexto, time: 1,transition: "easeOutExpo",delay: 0});
							Tweener.addTween(root["calendario_day"+(m+1)].textos, {_color:"0xffffff", time: 1,transition: "easeOutExpo",delay: 0});
							root["calendario_daysCache"][0] = root["calendario_daysESC"][0] = [e.currentTarget.dia, e.currentTarget.diadasemana]
							root["calendario_data1"].texto.text = convertDataDiaMes(root["calendario_daysCache"][0][0]);
						};
					};
				}else{
					Tweener.addTween(root["calendario_day"+(m+1)].fundo, {_color:"0x"+root["calendario_day"+(m+1)].corfundo, time: .5,transition: "easeInOut",delay: 0});
					Tweener.addTween(root["calendario_day"+(m+1)].textos, {_color:null, time: .5,transition: "easeInOut",delay: 0});
				}
			}
		}
		
		// # Quando: "RANGE"
		if(tipo[1]=="range"){
			root["calendario_daysCache"].push([e.currentTarget['d'],e.currentTarget.dia]);
			if(root["calendario_daysCache"].length>1){
				root["calendario_data2"].texto.text = convertDataDiaMes(root["calendario_daysCache"][1][1]);
				for(var p=0; p<root["calendario_dias"]; p++){
					if(root["calendario_day"+(p+1)]['d']>=root["calendario_daysCache"][0][0] && root["calendario_day"+(p+1)]['d']<=root["calendario_daysCache"][1][0]){
						Tweener.addTween(root["calendario_day"+(p+1)].fundo, {_color:"0x"+cortexto, time: 1,transition: "easeOutExpo",delay: 0});
						Tweener.addTween(root["calendario_day"+(p+1)].textos, {_color:"0xffffff", time: 1,transition: "easeOutExpo",delay: 0});
					}
				}
				Tweener.addTween(root["calendario_ok"].fundo, {_color:"0x"+corbt1, time: 1,transition: "easeOutExpo",delay: 0});
				root["calendario_daysESC"]=root["calendario_daysCache"]
				root["calendario_daysCache"]=[]
			}else{
				root["calendario_daysESC"] = []
				root["calendario_data1"].texto.text = convertDataDiaMes(root["calendario_daysCache"][0][1]);
				root["calendario_data2"].texto.text = "";
				Tweener.addTween(root["calendario_ok"].fundo, {_color:"0x"+cortexto, time: 1,transition: "easeOutExpo",delay: 0});
				for(var n=0; n<root["calendario_dias"]; n++){
					Tweener.addTween(root["calendario_day"+(n+1)].fundo, {_color:"0x"+root["calendario_day"+(n+1)].corfundo, time: .5,transition: "easeInOut",delay: 0});
					Tweener.addTween(root["calendario_day"+(n+1)].textos, {_color:null, time: .5,transition: "easeInOut",delay: 0});
				};
				Tweener.addTween(root["calendario_day"+(e.currentTarget.n)].fundo, {_color:"0x"+cortexto, time: 1,transition: "easeOutExpo",delay: 0});
				Tweener.addTween(root["calendario_day"+(e.currentTarget.n)].textos, {_color:"0xffffff", time: 1,transition: "easeOutExpo",delay: 0});
			}
		};
	};
};