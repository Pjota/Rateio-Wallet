if(tipo[0]=="social_search_gps_users"){
	
	connectServer(false,"screen",servidor+"api/list/d_modalidades/id="+tipo[1],[
	],social_search_gps_users_load);
	function social_search_gps_users_load(dados){
		
		//==============================
		//  VARIÁVEIS INICIAIS:
		//==============================
		root["modal_endereco_esc"] = 0;
		root["modal_data_esc"] = "";
		
		//==============================
		//  INFORMAÇÕES DO TOPO:
		//==============================
		// # Imagem (BG):
		if(dados.list[0]['background']!="" && dados.list[0]['background']!=undefined){
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(ScreenSizeWOriginal, 182, Math.PI/2, 0, 0); 
			var square:Shape = new Shape; 
			square.graphics.beginGradientFill(
			GradientType.LINEAR, ["0x000000", "0x000000"], 
			[1, 1], [0, 255], matrix, SpreadMethod.PAD,  
			InterpolationMethod.LINEAR_RGB, 0); 
			square.graphics.drawRect(0, 0, 345, 140); 
			root[nome].conteudo_fundo.addChild(square);
			img_load("modal_BG",blast.list.server.upload_path+"/"+dados.list[0]['background'],root[nome].conteudo_fundo,["width",345,"resize"],null,[0,0],[],0,null);
			root["modal_BG"].mask = square;
		};
		// # Ícone:
		criaIcon("modal_icone_contorno",root[nome].conteudo,blast.list.server.upload_path+"/"+dados.list[0].icone,(ScreenSizeWOriginal/2)-34,71,68,"bullet",["0xffffff","0xffffff"],["alpha","easeOutExpo",0]);
		criaIcon("modal_icone_bullet",root[nome].conteudo,blast.list.server.upload_path+"/"+dados.list[0].icone,(ScreenSizeWOriginal/2)-30,75,60,"bullet",["0xffffff","0x"+dados.list[0].cor],["alpha","easeOutExpo",0]);
		//criaIcon("modal_icone",root[nome].conteudo,blast.list.server.upload_path+"/"+dados.list[0].icone,260,25,80,"normal",["0xffffff","0xffffff"],["alpha","easeOutExpo",0]);
		
		//==============================
		//  FORMULÁRIO DE CADASTRO:
		//==============================
		// # Clipe:
		root["modal_form"] = new Vazio();
		root["modal_form"].y = 140;
		root[nome].conteudo.addChild(root["modal_form"]);
		// # Título e Texto:
		root["modal_titulo"] = new Titulo_Modal();
		root["modal_titulo"].y = 0;
		root["modal_titulo"].x = 4;
		root["modal_titulo"].titulo.htmlText="<font color='#"+corbt1+"'>"+titulo+"</font>";
		root["modal_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER;
		texto = "<font color='#"+cortexto+"'>"+texto+"</font>";
		root["modal_titulo"].texto.htmlText=texto
		root["modal_titulo"].texto.selectable = false;
		root["modal_form"].addChild(root["modal_titulo"]);
		// # Configurações:
		// > # 1) Endereço:
		root["modal_endTitulo"] = new titulo_simples();
		root["modal_endTitulo"].y = root["modal_titulo"].y+root["modal_titulo"].height+10;
		root["modal_endTitulo"].texto.width=365;
		root["modal_endTitulo"].texto.htmlText = "<font color='#"+corbt1+"' size='16'>Local da Atividade:</font>";
		root["modal_form"].addChild(root["modal_endTitulo"]);
		criaInput("Atividade_local", "Informe o Local", root["modal_form"], 50,root["modal_endTitulo"].y+25, .85, "0xFFFFFF", "0x"+cortexto, 60, false,"G");
		desativaInputView(root["Atividade_local"]);
		root["Atividade_local"].addEventListener(MouseEvent.CLICK, function(){Atividade_local_modal_open();});
		// > # 2) Horário:
		root["modal_endHorario"] = new titulo_simples();
		root["modal_endHorario"].y=root["Atividade_local"].y+root["Atividade_local"].height+10;
		root["modal_endHorario"].texto.width=365;
		root["modal_endHorario"].texto.htmlText = "<font color='#"+corbt1+"' size='16'>Horário da Atividade:</font>";
		root["modal_form"].addChild(root["modal_endHorario"]);
		root["modal_hora_ajustada"] = meia_em_meia_hora(root["AGORA"],"yyyy-MM-dd HH:mm:ss");
		root["modal_data_esc"] = root["modal_hora_ajustada"];
		trace("ajuste: "+root["modal_hora_ajustada"])
		criaHora("Atividade_horario",root["modal_hora_ajustada"],root["modal_form"],102,root["modal_endHorario"].y+28,1,['0x'+corbt1]);
		criaCombobox("Atividade_hora","Modal_","Hora","",root["modal_form"],30,190,1,"objeto","","","",["0xc9fff5","0x202020"],null,montaHorarios,setHorario);
		Tweener.removeTweens(root["Modal_Hora"]);
		root["Modal_Hora"].alpha=0;
		function montaHorarios(){
			var combo:Object = new Object();
			combo.list = [];
			var item:Object = new Object();
			var listagem = meia_em_meia_hora_list(root["AGORA"],null,"yyyy-MM-dd HH:mm:ss")
			for(var i=0; i<listagem.length; i++){
				item = {id:listagem[i], nome:listagem[i].substr(11,5)}
				combo.list[i];
				combo.list[i] = item;
			};
			return combo;
		}
		function setHorario(){
			root["Atividade_horario"].setHorario(root["Modal_Hora"].valor);
			root["modal_data_esc"] = root["Modal_Hora"].valor;
		}
		// > # 3) Buscar:
		criaBtEspecial("Atividade_buscar",blast.list.server.upload_path+"/"+dados.list[0].icone,"Sair de Casa!",root["modal_form"],74,root["Atividade_horario"].y+root["Atividade_horario"].height+20,1,["ffffff",cortexto,dados.list[0].cor],true)
		root["Atividade_buscar"].addEventListener(MouseEvent.CLICK, function(){Atividade_buscar_click();});
		root["Atividade_buscar"].buttonMode = true;
		//==============================
		//  ETAPAS:
		//==============================
		criaWizard("Atividade_wizard",root[nome].conteudo,"bullet",3,130,120,520,.8,corbt1,corbt2);
		root["Atividade_wizard"].changeWizard(1);
	};
	
	//==============================
	//  MODAIS: CONFIGURAÇÕES
	//==============================
	// # 1) Endereço:
	function Atividade_local_atualiza(txt,id){
		root["Atividade_local"].setText(txt);
	}
	function Atividade_local_modal_open(){
		modal_abrir("modal_social_search_gps_enderecos",["modal_endereco_listagem",root["modal_endereco_esc"],Atividade_local_atualiza,"cadastro-gps"],"Favoritos","Algum local preferido?",true,null,"G");
	};
	//================================================
	//  ATIVIDADE: SAIR DE CASA AGORA! BUSCAR PESSOAS
	//================================================
	function Atividade_buscar_click(){
		if(root["modal_endereco_esc"]==0){
			newbalaoInfo(root["modal_form"],'Informe a localização para iniciar a busca.',(root["Atividade_buscar"].x+(root["Atividade_buscar"].width/2)),(root["Atividade_buscar"].y+30),"BalaoInfo","0x"+corcancel);
		}else{
			if(root["modal_data_esc"]==""){
				newbalaoInfo(root["modal_form"],'Informe um horário para iniciar a busca.',(root["Atividade_buscar"].x+(root["Atividade_buscar"].width/2)),(root["Atividade_buscar"].y+30),"BalaoInfo","0x"+corcancel);
			}else{
				trace("Escolhas: "+root["modal_endereco_esc"]+" / "+root["modal_data_esc"])
			}
		}
	};
};