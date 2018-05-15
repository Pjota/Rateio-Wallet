// ====================================================
// ATIVAÇÃO: #2) SEU ENDEREÇO
// ====================================================
root["ativacao_seu_endereco"] = function(){
	// -------------------
	// Variáveis Iniciais:
	var posy = 0;
	root["atv_retorno"].visible=true;
	// --------------------
	// Título:
	criaTitulo("atv_titulo",root["ativacao_conteudo"],0,posy,"Seu Endereço","Texto descritivo aqui.");
	posy += root["atv_titulo"].y+root["atv_titulo"].height+10
	// --------------------
	// Busca por CEP:
	criaInput("ativa_cep", "CEP", root["ativacao_conteudo"], 35, posy, .95, "0xFFFFFF", "0x"+cortexto, 8, false,"G");
	root["ativa_cep"].texto.restrict = "0-9";
	criaBt("ativa_cep_ok","Buscar",root["ativacao_conteudo"],35,"ativa_cep",.95,"0x"+corbt1,"G");
	Tweener.addTween(root["ativa_cep_ok"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
	criaIcon("ativa_cep_ok_icon",root["ativa_cep_ok"],servidor+"com/icones/zoom_detail.png",200,15,27,"normal",["0xffffff",null],["alpha","easeOutExpo",1]);		
	root["ativa_cep_ok"].addEventListener(MouseEvent.CLICK, function(){ativa_cep_busca();});
	root["ativa_cep_ok"].buttonMode = true;
	root["ativacao_campo"] = new Vazio();
	root["ativacao_conteudo"].addChild(root["ativacao_campo"]);
	function ativa_cep_busca(){
		var alvo = root["ativa_cep_ok"];
		var local = root["ativacao_conteudo"];
		var array = [];
		if(root["ativa_cep"].texto.text!="" && root["ativa_cep"].texto.text!="CEP" && root["ativa_cep"].texto.length>=8){
			array = [];
			array.push(["cep",root["ativa_cep"].texto.text]);
			connectServer(false,"screen",servidor+"api/extras/cep",[
			["json",json(array),"texto"],
			],ativacao_consulta_cep);
			function ativacao_consulta_cep(dados){
				if(dados.list.retorno=="ok"){
					//--------------------------------------------
					// [ATIVA BOX DE ENDEREÇO]
					ativa_cep_activado();
					if(dados.list.endereco.logradouro!=""){root["ativa_rua"].texto.text = dados.list.endereco.logradouro;}
					if(dados.list.endereco.bairro!=""){
						root["ativa_bairro"].texto.text = dados.list.endereco.bairro;
						desativaInput(root["ativa_bairro"]);
					}
					root["ativa_id_bl_local_estados"].texto.text = dados.list.endereco.estadoNome;
					root["ativa_id_bl_local_estados"].valor = dados.list.endereco.estadoID;
					root["ativa_id_bl_local_cidades"].texto.text = dados.list.endereco.localidade;
					root["ativa_id_bl_local_cidades"].valor = dados.list.endereco.cidadeID;
					root["ativa_id_bl_local_cidades"].infos[10] = dados.list.endereco.estadoID;
					root["ativa_id_bl_local_cidades"].infos[11] = "id_bl_local_estados";
					root["ativa_rua"].show();
					root["ativa_numero"].show();
					root["ativa_complemento"].show();
					root["ativa_bairro"].show();
					//--------------------------------------------
				}else{
					newbalaoInfo(local,dados.list['info'],(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
				};
			};
		}else{
			newbalaoInfo(local,"Informe um CEP válido para a busca.",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
		}
	}
	// -----------------------------
	// Monta Formulário de Endereço:
	function ativa_cep_activado(){
		// Prepara todo o Layout:
		destroir(root["ativacao_campo"],true);
		root["ativa_cep_ok"].visible=false;
		// Transforma INPUT CEP em Botão de recarregar:
		desativaInputSemAlpha(root["ativa_cep"]);
		Tweener.addTween(root["ativa_cep"].texto, {_color:"0xffffff", time: 1,transition: "easeOutExpo",delay: 0});
		Tweener.addTween(root["ativa_cep"].fundo, {_color:"0x"+cortexto, time: 1,transition: "easeOutExpo",delay: 0});
		root["ativa_cep"].addEventListener(MouseEvent.CLICK, ativa_cep_retorno);
		// Cria novos campos para cadastro completo do Endereço:
		criaInput("ativa_rua", "Rua/Av", root["ativacao_campo"], 35, "ativa_cep", .95, "0xFFFFFF", "0x"+cortexto, 100, false,"G");
		criaInput("ativa_numero", "Número", root["ativacao_campo"], 35, "ativa_rua", .95, "0xFFFFFF", "0x"+cortexto, 10, false,"P");
		criaInput("ativa_complemento", "Complemento", root["ativacao_campo"], 190, "ativa_rua", .95, "0xFFFFFF", "0x"+cortexto, 10, false,"P");
		criaInput("ativa_bairro", "Bairro", root["ativacao_campo"], 35, "ativa_complemento", .95, "0xFFFFFF", "0x"+cortexto, 100, false,"G");
		var estrutura = [];
		estrutura.push(["Estado","id_bl_local_estados","combobox","","edit","required", []]);
		estrutura.push(["Cidade","id_bl_local_cidades","combobox","id_bl_local_estados","edit","required", []]);
		criaCombobox(1,"ativa_","id_bl_local_estados","Informe seu Estado:",root["ativacao_campo"],35,"ativa_bairro",.95,"banco","id_bl_local_estados","","",["0xffffff","0x202020"],estrutura,null,null);
		criaCombobox(2,"ativa_","id_bl_local_cidades","Informe sua Cidade:",root["ativacao_campo"],35,"ativa_id_bl_local_estados",.95,"banco","id_bl_local_cidades","","id_bl_local_estados",["0xffffff","0x202020"],estrutura,null,null);
		Tweener.removeTweens(root["ativa_id_bl_local_estados"]);
		Tweener.removeTweens(root["ativa_id_bl_local_cidades"]);
		root["ativa_id_bl_local_estados"].alpha=.4;
		root["ativa_id_bl_local_cidades"].alpha=.4;
		root["ativa_id_bl_local_estados"].ativo=false;
		root["ativa_id_bl_local_cidades"].ativo=false;
		// # Mudar:
		var limpar_posy = root["ativa_id_bl_local_cidades"].y + root["ativa_id_bl_local_cidades"].height + 10;
		criaIcon("ativacao_etapa2_troca",root["ativacao_campo"],servidor+"com/icones/lixo.png",40,limpar_posy,45,"bullet",["0xffffff","0x"+corbt2],["alpha","easeOutExpo",1]);		
		root["ativacao_etapa2_troca"].addEventListener(MouseEvent.CLICK, function(){ativacao_etapa2_trocar();});
		root["ativacao_etapa2_troca"].buttonMode = true;
		function ativacao_etapa2_trocar(){
			ativa_cep_retorno_act();
		};
		// -> Confirmação:
		criaBt("ativacao_etapa2_ok","Salvar",root["ativacao_campo"],190,"ativa_id_bl_local_cidades",1,"0x"+corbt1,"M");
		Tweener.addTween(root["ativacao_etapa2_ok"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay:0});
		root["ativacao_etapa2_ok"].addEventListener(MouseEvent.CLICK, function(){ativacao_etapa2_confirma();});
		root["ativacao_etapa2_ok"].buttonMode = true;
		function ativacao_etapa2_confirma(){
			var alvo = root["ativacao_etapa2_ok"];
			var local = root["ativacao_conteudo"];
			var array = [];
			if(root["ativa_rua"].texto.text!="" && root["ativa_rua"].texto.text!= root["ativa_rua"].valor){
				if(root["ativa_numero"].texto.text!="" && root["ativa_numero"].texto.text!= root["ativa_numero"].valor){
					if(root["ativa_bairro"].texto.text!="" && root["ativa_bairro"].texto.text!= root["ativa_bairro"].valor){
						if(root["ativa_id_bl_local_estados"].valor>0){
							if(root["ativa_id_bl_local_cidades"].valor>0){
								//--------------------------------------------
								// CADASTRO DE ENDEREÇO:
								array = [];
								array.push(["nome","Residência"]);
								array.push(["id_bl_local_estados",root["ativa_id_bl_local_estados"].valor]);
								array.push(["id_bl_local_cidades",root["ativa_id_bl_local_cidades"].valor]);
								array.push(["cep",root["ativa_cep"].texto.text]);
								array.push(["rua",root["ativa_rua"].texto.text]);
								array.push(["numero",root["ativa_numero"].texto.text]);
								array.push(["complemento",root["ativa_complemento"].texto.text]);
								array.push(["bairro",root["ativa_bairro"].texto.text]);
								array.push(["principal","1"]);
								connectServer(false,"screen",servidor+"api/add/enderecos",[
								["id", root["User"]['id'],"texto"],
								["json",json(array),"texto"],
								],ativacao_adicao_de_endereco);
								function ativacao_adicao_de_endereco(dados){
									if(dados.list.retorno=="ok"){
										destroir(root["ativacao_conteudo"],true);
										trace("!!!!!!!!!!!!!!")
									}else{
										newbalaoInfo(local,dados.list['info'],(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
									};
								};
								//--------------------------------------------
							}else{
								newbalaoInfo(local,"Informe a cidade onde mora.",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
							}
						}else{
							newbalaoInfo(local,"Informe o estado onde mora.",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
						}
					}else{
						newbalaoInfo(local,"Informe o bairro onde mora.",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
					}
				}else{
					newbalaoInfo(local,"Informe o número da sua residência.",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
				}
			}else{
				newbalaoInfo(local,"Informe o nome da Rua onde mora.",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
			}
			
		};
	};
	// =======================
	// 
	function ativa_cep_retorno(e:MouseEvent):void {
		root["ativa_cep"].removeEventListener(MouseEvent.CLICK, ativa_cep_retorno);
		ativa_cep_retorno_act();
	};
	function ativa_cep_retorno_act(){
		destroir(root["ativacao_campo"],true);
		root["ativa_cep_ok"].visible=true;
		ativaInput(root["ativa_cep"]);
		Tweener.addTween(root["ativa_cep"].texto, {_color:"0x"+cortexto, time: 1,transition: "easeOutExpo",delay: 0});
		Tweener.addTween(root["ativa_cep"].fundo, {_color:null, time: 1,transition: "easeOutExpo",delay: 0});
		root["ativa_cep"].texto.text = "";
	}
};