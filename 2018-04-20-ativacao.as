import flash.text.engine.BreakOpportunity;

// ====================================================
// ATIVAÇÃO
// ====================================================

// # INICIAL:
function ativacao_start(){
	// Cria Fundo braanco por trás:
	root["ativacao_box"] = new Vazio();
	root["ativacao_box"].name = nome;
	var fundo = new Vazio();
	var matrix:Matrix = new Matrix();
	matrix.createGradientBox(ScreenSizeW2, ScreenSizeH2, Math.PI/2, 0, 0); 
	var square:Shape = new Shape;
	var color1:uint = uint("0xffffff");
	var color2:uint = uint("0xD7F8FF");
	square.graphics.beginGradientFill(
	GradientType.LINEAR, [color1, color2], 
	[1, 1], [0, 255], matrix, SpreadMethod.PAD,  
	InterpolationMethod.LINEAR_RGB, 0); 
	square.graphics.drawRect(0, 0, ScreenSizeW2, ScreenSizeH2); 
	fundo.addChild(square);
	fundo.alpha=.97;
	root["ativacao_box"].addChild(fundo);
	root["ativacao_conteudo"] = new Vazio();
	root["ativacao_box"].addChild(root["ativacao_conteudo"]);
	bgSup.alpha=0;
	bgSup.addChild(root["ativacao_box"]);
	root["ativacao_box"].scaleX = root["ativacao_box"].scaleY = scalaFixa;
	Tweener.addTween(bgSup, {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	// Topo LOGO:
	img_load("ativacao_logo",blast.list[app].paths.upload_path+"/"+logonormal,root["ativacao_box"],["width",170],null,[100,20,"left"],[],0,null)
	// Botão Fechar:
	root["ativacao_fechar"] = new Botao_Fechar();
	root["ativacao_fechar"].name = "ativacao_fechar";
	root["ativacao_fechar"].scaleX = root["ativacao_fechar"].scaleY = .7;
	root["ativacao_fechar"].x = (365-40);
	root["ativacao_fechar"].y = 40;
	root["ativacao_fechar"].scaleX = root["ativacao_fechar"].scaleY = 0;
	Tweener.addTween(root["ativacao_fechar"], {scaleX:.7, scaleY:.7, time: .5,transition: "easeOutElastic",delay: .4});
	Tweener.addTween(root["ativacao_fechar"].fundo, {_color:"0x"+corcancel, time: 0,transition: "linear",delay: 0});
	root["ativacao_conteudo"].addChild(root["ativacao_fechar"]);
	root["ativacao_fechar"].addEventListener(MouseEvent.CLICK, fechar_click);
	root["ativacao_fechar"].buttonMode = true;
	function fechar_click(event:MouseEvent):void{
		modal_abrir("ativacao_fechar_confirmacao",['confirmacaoAlert',"Sim",corbt1,.8,ativacao_fechar_confirmacao_ok],"Sair","Deseja voltar a página inicial?",true,null,"P");
		Tweener.addTween(root["confirmAlertbt"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
		function ativacao_fechar_confirmacao_ok(){
			root["autologinBlock"] = true;
			rebootBlast();
		};
	};
	
	// Verifica em que estágio está esta ativação:
	// 1) Ele já trocou a senha?
	if(root["User"]['senha']==root["User"]['auth_codigo']){
		ativacao_etapa1();
	}else{
		connectServer(false,"screen",servidor+"api/list/local_enderecos/tabela="+root['User']['table']+",id_responsavel="+root['User']['id']+",principal=1",[
		],ativacao_consulta_endereco);
		function ativacao_consulta_endereco(dados){
			if(dados.list.length>0){
				connectServer(false,"screen",servidor+"api/list/r_contas/tabela="+root['User']['table']+",id_responsavel="+root['User']['id']+",page_limit=1,order_column=cadastro,order_direct=DESC",[
				],ativacao_consulta_conta);
				function ativacao_consulta_conta(dados){
					if(dados.list.length>0){
						// ===========================================
						// AVALIAÇÃO DA ATIVAÇÃO:
						// ===========================================
						// Variáveis Iniciais:
						root["ativacao_status"] = "";
						root["ativacao_porcentagem"] = 0;
						connectServer(false,"screen",servidor+"api/list/r_wallets/tabela="+root['User']['table']+",id_responsavel="+root['User']['id'],[
						],ativacao_consulta_wallet);
						function ativacao_consulta_wallet(dados){
							// Calculo da porcentagem de Ativação:
							root["cts"] = (100/dados.list.length)/2;
							if(dados.list.length>0){
								for(var i=0; i<dados.list.length; i++){
									if(dados.list[i]['token']!="0"){ root["ativacao_porcentagem"]+=root["cts"]; }
									if(dados.list[i]['senha']!="0"){ root["ativacao_porcentagem"]+=root["cts"]; }
								};
								root["ativacao_porcentagem"] = Math.ceil(root["ativacao_porcentagem"]);
								ativacao_etapa4();
							}else{
								ativacao_etapa3();
							}
						};
						// ===========================================
					}else{
						ativacao_etapa3();
					};
				};
			}else{
				ativacao_etapa2();
			};
		};
	};
};

// ------------------------
// # DADOS PESSOAIS: 
function ativacao_etapa1(){
	var posy = 100;
	// -> Nome Completo + CPF:
	root["ativa_txt_dadospessoais"] = new Titulo();
	root["ativa_txt_dadospessoais"].y=posy;
	root["ativa_txt_dadospessoais"].titulo.htmlText = "<font color='#"+corbt1+"'>Olá, seja bem vindo!</font>";
	root["ativa_txt_dadospessoais"].texto.autoSize = TextFieldAutoSize.CENTER;
	root["ativa_txt_dadospessoais"].texto.htmlText = "<font color='#"+cortexto+"'>Para iniciarmos a ativação da sua Carteira Digital RD, é muito importante que você confira seus dados pessoais:</font>"
	root["ativacao_conteudo"].addChild(root["ativa_txt_dadospessoais"]);
	criaInput("ativa_nome", "Nome Completo", root["ativacao_conteudo"], 35, "ativa_txt_dadospessoais", .95, "0xFFFFFF", "0x"+cortexto, 100, false,"G");
	criaInput("ativa_cpf", "CPF", root["ativacao_conteudo"], 35, "ativa_nome", .95, "0xFFFFFF", "0x"+cortexto, 18, false,"G");	
	criaInput("ativa_celular", "Celular", root["ativacao_conteudo"], 35, "ativa_cpf", .95, "0xFFFFFF", "0x"+cortexto, 12, false,"G");	
	root["ativa_nome"].labelShow("33cc33");
	root["ativa_cpf"].labelShow("33cc33");
	root["ativa_celular"].labelShow("33cc33");
	root["ativa_nome"].setText(root["User"]['nome']);
	root["ativa_cpf"].setText(root["User"]['cpf']);
	root["ativa_celular"].setText(root["User"]['celular']);
	root["ativa_cpf"].texto.restrict = "0-9";
	root["ativa_celular"].texto.restrict = "0-9";
	// -> Mude a sua Senha:
	root["ativa_txt_mudeasenha"] = new Titulo();
	root["ativa_txt_mudeasenha"].y=root["ativa_celular"].y+root["ativa_celular"].height+20;
	root["ativa_txt_mudeasenha"].titulo.htmlText = "<font color='#"+corbt1+"'>Defina sua nova Senha</font>";
	root["ativa_txt_mudeasenha"].texto.autoSize = TextFieldAutoSize.CENTER;
	root["ativa_txt_mudeasenha"].texto.htmlText = "<font color='#"+cortexto+"'>Por medidas de segurança é necessário que<br>você defina uma nova senha de acesso:</font>"
	root["ativacao_conteudo"].addChild(root["ativa_txt_mudeasenha"]);
	criaInput("ativa_senha", "Nova Senha", root["ativacao_conteudo"], 35, "ativa_txt_mudeasenha", .95, "0xFFFFFF", "0x"+cortexto, 12, true,"P");
	criaInput("ativa_senhaConfirma", "Repetir Senha", root["ativacao_conteudo"], 190, "ativa_txt_mudeasenha", .95, "0xFFFFFF", "0x"+cortexto, 12, true,"P");
	// -> Confirmação:
	criaBt("ativacao_etapa1_ok","Ok! Próximo Passo (2/3)",root["ativacao_conteudo"],35,"ativa_senhaConfirma",.95,"0x"+corbt1,"G");
	Tweener.addTween(root["ativacao_etapa1_ok"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay:0});
	criaIcon("ativacao_etapa1_ok_icon",root["ativacao_etapa1_ok"],servidor+"com/icones/right-chevron.png",270,15,27,"normal",["0xffffff",null],["alpha","easeOutExpo",1]);			
	root["ativacao_etapa1_ok"].addEventListener(MouseEvent.CLICK, function(){ativacao_etapa1_confirma();});
	root["ativacao_etapa1_ok"].buttonMode = true;
	function ativacao_etapa1_confirma(){
		var alvo = root["ativacao_etapa1_ok"];
		var local = root["ativacao_conteudo"];
		var array = [];
		// Validação de Campos:
		if(root["ativa_nome"].texto.text!="" && root["ativa_nome"].texto.text!="Nome Completo" && root["ativa_nome"].texto.text.indexOf(" ")>1){
			if(root["ativa_cpf"].texto.text!="" && root["ativa_cpf"].texto.text!="CPF" && root["ativa_cpf"].texto.length>=9){
				if(root["ativa_celular"].texto.text!="" && root["ativa_celular"].texto.text!="Celular" && root["ativa_celular"].texto.length>=10){
					if(root["ativa_senha"].texto.text!="" && root["ativa_senha"].texto.text!="Nova Senha"){
						if(root["ativa_senha"].texto.length>=6){
							if(root["ativa_senhaConfirma"].texto.text == root["ativa_senha"].texto.text){
								if(root["CachePass2"]!="123456"){
									// --------------------------------------
									// [VALIDAÇÃO DE CAMPOS]
									// CPF - VALIDAÇÃO
									array = [];
									array.push(["cpf",root["ativa_cpf"].texto.text]);
									connectServer(false,"screen",servidor+"api/extras/validacao_de_cpf",[
									["json",json(array),"texto"],
									],ativacao_consulta_cpf);
									function ativacao_consulta_cpf(dados){
										if(dados.list.retorno=="ok"){
											// CPF - EM USO?
											array = [];
											array.push(["cpf",root["ativa_cpf"].texto.text]);
											array.push(["tabela",root["User"]["table"]]);
											array.push(["id",root["User"]["id"]]);
											connectServer(false,"screen",servidor+"api/extras/uso_de_cpf",[
											["json",json(array),"texto"],
											],ativacao_consulta_usodecpf);
											function ativacao_consulta_usodecpf(dados){
												if(dados.list.retorno=="ok"){
													// EDIÇÃO DOS DADOS:
													array = [];
													array.push(["cpf",root["ativa_cpf"].texto.text]);
													array.push(["cpf_cnpj",root["ativa_cpf"].texto.text]);
													array.push(["celular",root["ativa_celular"].texto.text]);
													array.push(["nome",root["ativa_nome"].texto.text]);
													array.push(["senha",root["CachePass2"]]);
													connectServer(false,"screen",servidor+"api/edit/"+root["User"]['table']+"/id="+root["User"]['id'],[
													["id", root["User"]['id'],"texto"],
													["json",json(array),"texto"],
													],ativacao_edicao_de_dados_pessoais);
													function ativacao_edicao_de_dados_pessoais(dados){
														if(dados.list.retorno=="ok"){
															root["User"]['nome'] = root["ativa_nome"].texto.text;
															root["User"]['cpf'] = root["ativa_cpf"].texto.text;
															root["User"]['celular'] = root["ativa_celular"].texto.text;
															// ENVIO DO EMAIL DE TROCA DE SENHA:
															destroir(root["ativacao_conteudo"],true);
															ativacao_etapa2();
														}else{
															newbalaoInfo(local,dados.list['info'],(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
														}
													}
												}else{
													newbalaoInfo(local,dados.list['info'],(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
												}
											};
										}else{
											newbalaoInfo(local,dados.list['info'],(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
										}
									};
								}else{
									newbalaoInfo(local,"Informe uma senha válida.",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
								};
								// --------------------------------------
							}else{
								newbalaoInfo(local,"Sua confirmação de senha está errada.",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
							}
						}else{
							newbalaoInfo(local,"Sua senha deve ter no mínimo 6 Caracteres.",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
						}
					}else{
						newbalaoInfo(local,"Necessário criar uma nova senha de acesso.",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
					}
				}else{
					newbalaoInfo(local,"Informe seu número de celular (com DDD).",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
				}
			}else{
				newbalaoInfo(local,"Informe um CPF válido para cadastro.",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
			}
		}else{
			newbalaoInfo(local,"Informe o seu nome completo.",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
		};
	};
};

// ------------------------
// # ENDEREÇO COMPLETO: 
function ativacao_etapa2(){
	var posy = 100;
	// -> Endereço Completo:
	root["ativa_txt_end"] = new Titulo();
	root["ativa_txt_end"].y=posy;
	root["ativa_txt_end"].titulo.htmlText = "<font color='#"+corbt1+"'>Onde você mora?</font>";
	root["ativa_txt_end"].texto.autoSize = TextFieldAutoSize.CENTER;
	root["ativa_txt_end"].texto.htmlText = "<font color='#"+cortexto+"'>Informe o seu endereço completo:</font>"
	root["ativacao_conteudo"].addChild(root["ativa_txt_end"]);
	criaInput("ativa_cep", "CEP", root["ativacao_conteudo"], 35, "ativa_txt_end", .95, "0xFFFFFF", "0x"+cortexto, 8, false,"G");
	root["ativa_cep"].texto.restrict = "0-9";
	criaBt("ativa_cep_ok","Buscar",root["ativacao_conteudo"],35,"ativa_cep",.95,"0x"+corbt1,"G");
	Tweener.addTween(root["ativa_cep_ok"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
	criaIcon("ativa_cep_ok_icon",root["ativa_cep_ok"],servidor+"com/icones/zoom_detail.png",200,15,27,"normal",["0xffffff",null],["alpha","easeOutExpo",1]);		
	root["ativa_cep_ok"].addEventListener(MouseEvent.CLICK, function(){ativa_cep_busca();});
	root["ativa_cep_ok"].buttonMode = true;
	root["ativacao_campo"] = new Vazio();
	root["ativacao_conteudo"].addChild(root["ativacao_campo"]);
	function ativa_cep_busca(){
		//ativa_cep_activado();
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
					root["ativa_id_local_estados"].texto.text = dados.list.endereco.estadoNome;
					root["ativa_id_local_estados"].valor = dados.list.endereco.estadoID;
					root["ativa_id_local_cidades"].texto.text = dados.list.endereco.localidade;
					root["ativa_id_local_cidades"].valor = dados.list.endereco.cidadeID;
					root["ativa_id_local_cidades"].infos[10] = dados.list.endereco.estadoID;
					root["ativa_id_local_cidades"].infos[11] = "id_local_estados";
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
	};
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
		estrutura.push(["Estado","id_local_estados","combobox","","edit","required", []]);
		estrutura.push(["Cidade","id_local_cidades","combobox","id_local_estados","edit","required", []]);
		criaCombobox(1,"ativa_","id_local_estados","Informe seu Estado:",root["ativacao_campo"],35,"ativa_bairro",.95,"banco","id_local_estados","","",["0xffffff","0x202020"],estrutura,null,null);
		criaCombobox(2,"ativa_","id_local_cidades","Informe sua Cidade:",root["ativacao_campo"],35,"ativa_id_local_estados",.95,"banco","id_local_cidades","","id_local_estados",["0xffffff","0x202020"],estrutura,null,null);
		
		Tweener.removeTweens(root["ativa_id_local_estados"]);
		Tweener.removeTweens(root["ativa_id_local_cidades"]);
		root["ativa_id_local_estados"].alpha=.4;
		root["ativa_id_local_cidades"].alpha=.4;
		root["ativa_id_local_estados"].ativo=false;
		root["ativa_id_local_cidades"].ativo=false;
		
		// # Mudar:
		criaBt("ativacao_etapa2_troca","Limpar",root["ativacao_campo"],40,"ativa_id_local_cidades",1,"0x"+corbt2,"M");
		Tweener.addTween(root["ativacao_etapa2_troca"].texto, {_color:"0x"+cortexto, time: 0,transition: "easeOutExpo",delay: 0});
		root["ativacao_etapa2_troca"].addEventListener(MouseEvent.CLICK, function(){ativacao_etapa2_trocar();});
		root["ativacao_etapa2_troca"].buttonMode = true;
		function ativacao_etapa2_trocar(){
			ativa_cep_retorno_act();
		};
		
		// -> Confirmação:
		criaBt("ativacao_etapa2_ok","Ok! (3/3)",root["ativacao_campo"],190,"ativa_id_local_cidades",1,"0x"+corbt1,"M");
		Tweener.addTween(root["ativacao_etapa2_ok"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay:0});
		criaIcon("ativacao_etapa2_ok_icon",root["ativacao_etapa2_ok"],servidor+"com/icones/right-chevron.png",110,17,20,"normal",["0xffffff",null],["alpha","easeOutExpo",1]);		
		root["ativacao_etapa2_ok"].addEventListener(MouseEvent.CLICK, function(){ativacao_etapa2_confirma();});
		root["ativacao_etapa2_ok"].buttonMode = true;
		function ativacao_etapa2_confirma(){
			var alvo = root["ativacao_etapa2_ok"];
			var local = root["ativacao_conteudo"];
			var array = [];
			if(root["ativa_rua"].texto.text!="" && root["ativa_rua"].texto.text!= root["ativa_rua"].valor){
				if(root["ativa_numero"].texto.text!="" && root["ativa_numero"].texto.text!= root["ativa_numero"].valor){
					if(root["ativa_bairro"].texto.text!="" && root["ativa_bairro"].texto.text!= root["ativa_bairro"].valor){
						if(root["ativa_id_local_estados"].valor>0){
							if(root["ativa_id_local_cidades"].valor>0){
								//--------------------------------------------
								// CADASTRO DE ENDEREÇO:
								array = [];
								array.push(["nome","Residência"]);
								array.push(["id_local_estados",root["ativa_id_local_estados"].valor]);
								array.push(["id_local_cidades",root["ativa_id_local_cidades"].valor]);
								array.push(["cep",root["ativa_cep"].texto.text]);
								array.push(["rua",root["ativa_rua"].texto.text]);
								array.push(["numero",root["ativa_numero"].texto.text]);
								array.push(["complemento",root["ativa_complemento"].texto.text]);
								array.push(["bairro",root["ativa_bairro"].texto.text]);
								array.push(["principal","1"]);
								connectServer(false,"screen",servidor+"api/add/local_enderecos",[
								["id", root["User"]['id'],"texto"],
								["json",json(array),"texto"],
								],ativacao_adicao_de_endereco);
								function ativacao_adicao_de_endereco(dados){
									if(dados.list.retorno=="ok"){
										destroir(root["ativacao_conteudo"],true);
										ativacao_etapa3();
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
};
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


// ------------------------
// # Conta Bancária: 
function ativacao_etapa3(){
	var posy = 100;
	
	// Dados Bancários:
	root["ativa_txt_dadosbancarios"] = new Titulo();
	root["ativa_txt_dadosbancarios"].y=posy;
	root["ativa_txt_dadosbancarios"].titulo.htmlText = "<font color='#"+corbt1+"'>Seus Dados Bancários</font>";
	root["ativa_txt_dadosbancarios"].texto.autoSize = TextFieldAutoSize.CENTER;
	root["ativa_txt_dadosbancarios"].texto.htmlText = "<font color='#"+cortexto+"'>Para finalizar a ativação de sua Carteira Digital RD é necessário que preencha corretamente seus dados bancários:</font>"
	root["ativacao_conteudo"].addChild(root["ativa_txt_dadosbancarios"]);
	
	// Define Estrutura do Formulário:
	var estrutura = [];
	estrutura.push(["Informe qual é o seu Banco","id_r_bancos","combobox","","edit","required", []]);
	estrutura.push(["Titular","titular","texto","60","block","required", []]);
	estrutura.push(["CPF ou CNPJ","cpf_cnpj","numero","20","block","required", []]);
	estrutura.push(["Agência","agencia","numero","","edit","required", [ "minLgh|4|Informe sua Agência corretamente." ]]);
	estrutura.push(["Ag. Dígito","agencia_digito","numero","2","edit","required", [ ]]);
	estrutura.push(["Conta","conta","texto","15","edit","required", [ "minLgh|4|Informe sua conta corretamente." ]]);
	estrutura.push(["Conta Dígito","conta_digito","numero","2","edit","required", [ ]]);
	//estrutura.push(["Poupanca","conta_poupanca","checkbox","","edit","required", [ "Sua conta é uma Conta Poupança?" ]]);
	
	// Monta Combos e Inputs:
	criaCombobox(1,"ativa_",estrutura[0][1],estrutura[0][0],root["ativacao_conteudo"],35,"ativa_txt_dadosbancarios",.95,"banco",estrutura[0][1],"","",["0xffffff","0x202020"],estrutura,null,null);
	criaInput("ativa_"+estrutura[1][1], estrutura[1][0], root["ativacao_conteudo"], 35, "ativa_"+estrutura[0][1], .95, "0xFFFFFF", "0x"+cortexto, 100, false,"P");
	criaInput("ativa_"+estrutura[2][1], estrutura[2][0], root["ativacao_conteudo"], 190, "ativa_"+estrutura[0][1], .95, "0xFFFFFF", "0x"+cortexto, 100, false,"P");
	criaInput("ativa_"+estrutura[3][1], estrutura[3][0], root["ativacao_conteudo"], 35, "ativa_"+estrutura[2][1], .95, "0xFFFFFF", "0x"+cortexto, 100, false,"P");
	criaInput("ativa_"+estrutura[4][1], estrutura[4][0], root["ativacao_conteudo"], 190, "ativa_"+estrutura[2][1], .95, "0xFFFFFF", "0x"+cortexto, 100, false,"P");
	criaInput("ativa_"+estrutura[5][1], estrutura[5][0], root["ativacao_conteudo"], 35, "ativa_"+estrutura[4][1], .95, "0xFFFFFF", "0x"+cortexto, 100, false,"P");
	criaInput("ativa_"+estrutura[6][1], estrutura[6][0], root["ativacao_conteudo"], 190, "ativa_"+estrutura[4][1], .95, "0xFFFFFF", "0x"+cortexto, 100, false,"P");
	criaCombobox("IC","ativa_","TipodeConta","Tipo de Conta Bancária:",root["ativacao_conteudo"],35, "ativa_"+estrutura[6][1],.95,"objeto","","","",["0xffffff","0x202020"],null,getTiposConta,setTiposConta);
	root["ativ3_tipodeconta"] = "";
	function getTiposConta(){
		var combo:Object = new Object();
		combo.list = [];
		combo.list[0] = {id:"X", 	 nome:"Corrente"}
		combo.list[1] = {id:"{AGORA}", nome:"Poupança"}
		return combo;
	};
	function setTiposConta(info){
		root["ativ3_tipodeconta"] = root["ativa_TipodeConta"].valor;
	};
	
	//criaCheckBox("ativa_"+estrutura[7][1],50,"ativa_"+estrutura[6][1],root["ativacao_conteudo"],[["Sua conta é uma Conta Poupança?",0]],corbt1,null);
	Tweener.addTween(root["ativa_"+estrutura[1][1]].texto, {_color:"0x"+corbt1, time: 1,transition: "easeOutExpo",delay: 0});
	Tweener.addTween(root["ativa_"+estrutura[2][1]].texto, {_color:"0x"+corbt1, time: 1,transition: "easeOutExpo",delay: 0});
	root["ativa_"+estrutura[1][1]].addEventListener(MouseEvent.CLICK, function(){ativa_titular_click();});
	function ativa_titular_click(){
		var alvo = root["ativa_titular"];
		var local = root["ativacao_conteudo"];
		newbalaoInfo(local,root["ativa_titular"].texto.text,(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+cortexto);
	}

	// Camposs Pré-Definidos:
	root["ativa_titular"].texto.text = root["User"]["nome"];
	root["ativa_cpf_cnpj"].texto.text = root["User"]['cpf'];
	desativaInputSemAlpha(root["ativa_titular"]);
	desativaInputSemAlpha(root["ativa_cpf_cnpj"])
	root["ativa_titular"].show();
	root["ativa_cpf_cnpj"].show();
	root["ativa_agencia"].texto.restrict = "0-9";
	root["ativa_agencia_digito"].texto.restrict = "0-9";
	root["ativa_conta"].texto.restrict = "0-9";
	root["ativa_conta_digito"].texto.restrict = "0-9";
	
	// Confirmação:
	criaBt("ativacao_etapa3_ok","Solicitar Ativação",root["ativacao_conteudo"],35,525,.95,"0x"+corbt1,"G");
	Tweener.addTween(root["ativacao_etapa3_ok"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay:0});
	criaIcon("ativacao_etapa3_ok_icon",root["ativacao_etapa3_ok"],servidor+"com/icones/checked-symbol.png",270,15,27,"normal",["0xffffff",null],["alpha","easeOutExpo",1]);		
	root["ativacao_etapa3_ok"].addEventListener(MouseEvent.CLICK, function(){ativacao_etapa3_confirma();});
	root["ativacao_etapa3_ok"].buttonMode = true;
	function ativacao_etapa3_confirma(){
		var alvo = root["ativacao_etapa3_ok"];
		var local = root["ativacao_conteudo"];
		var array = [];
		if(root["ativa_id_r_bancos"].valor>0){
			if(root["ativa_agencia"].texto.text!="" && root["ativa_agencia"].texto.text!= root["ativa_agencia"].valor){
				if(root["ativa_conta"].texto.text!="" && root["ativa_conta"].texto.text!= root["ativa_conta"].valor){
					if(root["ativ3_tipodeconta"]!=""){
						//--------------------------------------------
						// CADASTRO DE CONTA BANCÁRIA:
						array = [];
						array.push(["id_r_bancos",root["ativa_id_r_bancos"].valor]);
						array.push(["titular",root["ativa_titular"].texto.text]);
						array.push(["cpf_cnpj",root["ativa_cpf_cnpj"].texto.text]);
						array.push(["agencia",root["ativa_agencia"].texto.text]);
						if(root["ativa_agencia_digito"].texto.text!=root["ativa_agencia_digito"].valor){
							array.push(["agencia_digito",root["ativa_agencia_digito"].texto.text]);
						};
						array.push(["conta",root["ativa_conta"].texto.text]);
						array.push(["conta_digito",root["ativa_conta_digito"].texto.text]);
						if(root["ativ3_tipodeconta"]!="X"){
							array.push(["conta_poupanca","{AGORA}"]);
						};
						
						connectServer(false,"screen",servidor+"api/add/r_contas",[
						["id", root["User"]['id'],"texto"],
						["json",json(array),"texto"],
						],ativacao_adicao_de_endereco);
						function ativacao_adicao_de_endereco(dados){
							if(dados.list.retorno=="ok"){
								// -----------------------------
								// CADASTRO DE WALLET:
								array = [];
								array.push(["tabela","r_wallets"]);
								connectServer(false,"screen",servidor+"api/max/wallet_add",[
								["id", root["User"]['id'],"texto"],
								["sub", "pago","texto"],
								["json",json(array),"texto"],
								],ativacao_adicao_de_wallet);
								function ativacao_adicao_de_wallet(dados){
									if(dados.list['max'].retorno=="ok"){
										destroir(root["ativacao_conteudo"],true);
										ativacao_etapa4();
									}else{
										newbalaoInfo(local,dados.list['max']['info'],(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
									};
								};
							}else{
								newbalaoInfo(local,dados.list['info'],(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
							};
						};
						//--------------------------------------------
					}else{
						newbalaoInfo(local,"Informe o tipo da sua conta bancária",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
					}
				}else{
					newbalaoInfo(local,"Informe o número da sua conta (sem dígito)",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
				}
			}else{
				newbalaoInfo(local,"Informe a sua agência (sem dígito)",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
			}
		}else{
			newbalaoInfo(local,"Informe qual banco você possui conta.",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
		}
	};
	
	// Não tenho Conta Bancária:
	connectServer(false,"screen",servidor+"api/list/r_solicitacoes/tabela="+root["User"]['table']+",id_responsavel="+root["User"]['id']+",like_column=solicitacao,like_string=[1],level=1",[
	],ativacao_status_solicitacao);
	function ativacao_status_solicitacao(dados){
		if(dados.list.length==0){
			criaBt("ativacao_etapa3_semconta","Não tenho Conta Bancária",root["ativacao_conteudo"],60,"ativacao_etapa3_ok",.8,"0xEB3B54","G");
			Tweener.addTween(root["ativacao_etapa3_semconta"].texto, {_color:"0xffffff", time: 0,transition: "easeOutExpo",delay: 0});
			root["ativacao_etapa3_semconta"].addEventListener(MouseEvent.CLICK, function(){ativacao_etapa3_semconta_click();});
			root["ativacao_etapa3_semconta"].buttonMode = true;
		}else{
			ativacao_etapa3_semconta_clickOK();
		};
	};
	function ativacao_etapa3_semconta_click(){
		var alvo = root["ativacao_etapa3_semconta"];
		var local = root["ativacao_conteudo"];
		var array = [];
		array = [];
		array.push(["nome",root["User"]['nome']]);
		array.push(["email",root["User"]['email']]);
		array.push(["celular",root["User"]['celular']]);
		array.push(["tema","Sem Conta Bancária"]);
		array.push(["solicitacao","Não possuo conta bancária. Como faço? [1]"]);
		connectServer(false,"screen",servidor+"api/add/r_solicitacoes",[
		["id", root["User"]['id'],"texto"],
		["json",json(array),"texto"],
		],ativacao_adicao_solicitacao);
		function ativacao_adicao_solicitacao(dados){
			if(dados.list.retorno=="ok"){
				root["ativacao_etapa3_semconta"].visible = false;
				ativacao_etapa3_semconta_clickOK();
			}else{
				newbalaoInfo(local,"Não foi possível contactar a Rateio Digital.",(alvo.x+(alvo.width/2)),(alvo.y+30),"BalaoInfo","0x"+corcancel);
			}
		}
	};
	function ativacao_etapa3_semconta_clickOK(){
		root["ativacao_etapa3_semconta_ok"] = new Titulo();
		root["ativacao_etapa3_semconta_ok"].y= root["ativacao_etapa3_ok"].y + root["ativacao_etapa3_ok"].height + 7;
		root["ativacao_etapa3_semconta_ok"].titulo.htmlText = "<font color='#EB3B54' size='20'>Usuário Sem Conta Bancária</font>";
		root["ativacao_etapa3_semconta_ok"].texto.y -= 5;
		root["ativacao_etapa3_semconta_ok"].texto.autoSize = TextFieldAutoSize.CENTER;
		root["ativacao_etapa3_semconta_ok"].texto.htmlText = "<font color='#'>A Rateio Digital já foi notificada e entrará em contato com você.</font>"
		root["ativacao_conteudo"].addChild(root["ativacao_etapa3_semconta_ok"]);
		root["ativacao_etapa3_semconta_ok"].alpha=0;
		Tweener.addTween(root["ativacao_etapa3_semconta_ok"], {alpha:1, time: 1,transition: "easeOutExpo",delay: 0});
	}
};



// ---------------------------
// # Aguardando Ativação:
function ativacao_etapa4(){
	// Super Preloader:
	criaIcon("ativacao_etapa4_superpreloader",root["ativacao_conteudo"],servidor+"com/icones/time-count.png",(365/2)-64,220-64,128,"bullet",["0x"+corbt1,"0xffffff"],["alpha","easeOutExpo",1]);
	/*
	root["ativacao_etapa4_superpreloader"] = new Preloader_Super();
	root["ativacao_etapa4_superpreloader"].x= 365/2;
	root["ativacao_etapa4_superpreloader"].y= 220;
	root["ativacao_etapa4_superpreloader"].scaleX = root["ativacao_etapa4_superpreloader"].scaleY = 0;
	Tweener.addTween(root["ativacao_etapa4_superpreloader"], {scaleX:1, scaleY:1, time: 1,transition: "easeOutExpo",delay: .3});
	Tweener.addTween(root["ativacao_etapa4_superpreloader"], {_color:"0x"+corbt1, time: 0,transition: "easeOutExpo",delay: 0});
	root["ativacao_conteudo"].addChild(root["ativacao_etapa4_superpreloader"]);
	var inicial = 0;
	var preloader:uint = setInterval (preloader_count, 50);
	var randomNumber;
	function preloader_count():void {
		inicial++;
		if(inicial<=root["ativacao_porcentagem"]){
			var texto = "";
			var inicialTxt = inicial+"";
			texto += "<font color='#"+corbt1+"' size='"+(60+Math.round(Math.random()*10))+"'>"+inicialTxt.slice(0,1)+"</font>";
			texto += "<font color='#"+corbt1+"' size='"+(60+Math.round(Math.random()*10))+"'>"+inicialTxt.slice(1,2)+"</font>";
			texto += "<font color='#"+corbt1+"' size='20'>%</font>";
			root["ativacao_etapa4_superpreloader"].texto.htmlText = texto;
		}else{
			clearInterval(preloader);
		};
	};
	*/
	
	// Etapa:
	root["ativacao_etapa4_bullet"] = new Bullet_Number();
	root["ativacao_etapa4_bullet"].x= 130;
	root["ativacao_etapa4_bullet"].y= 360;
	root["ativacao_etapa4_bullet"].scaleX = root["ativacao_etapa4_bullet"].scaleY = .8;
	root["ativacao_conteudo"].addChild(root["ativacao_etapa4_bullet"]);
	root["ativacao_etapa4_etapa"] = new label_ttitulo_simples();
	root["ativacao_etapa4_etapa"].texto.autoSize = TextFieldAutoSize.LEFT;
	root["ativacao_etapa4_etapa"].texto.width = 200;
	trace("Porcentagem do Carregando: "+root["ativacao_porcentagem"])
	if(root["ativacao_porcentagem"]<50){
		root["ativacao_etapa4_bullet"].textos.texto.text = "1/2";
		root["ativacao_etapa4_etapa"].texto.htmlText = "<font color='#"+cortexto+"'>Em Análise</font>";
	}else{
		root["ativacao_etapa4_bullet"].textos.texto.text = "2/2";
		root["ativacao_etapa4_etapa"].texto.htmlText = "<font color='#"+cortexto+"'>Configurando</font>";
	};
	root["ativacao_etapa4_etapa"].x= 150;
	root["ativacao_etapa4_etapa"].y= 350;
	root["ativacao_conteudo"].addChild(root["ativacao_etapa4_etapa"]);
	
	// Título de Aguarde:
	root["ativacao_etapa4_titulo"] = new Titulo();
	root["ativacao_etapa4_titulo"].y= 400
	root["ativacao_etapa4_titulo"].titulo.htmlText = "<font color='#"+corbt1+"'>Pronto! Agora é só Aguardar...</font>";
	root["ativacao_etapa4_titulo"].texto.autoSize = TextFieldAutoSize.CENTER;
	root["ativacao_etapa4_titulo"].texto.htmlText = "<font color='#"+cortexto+"'>Seus dados serão analisados e em caso de aprovação você será notificado pelo celular. Em breve você já poderá receber valores através dos pagamentos realizados na Rateio Digital.</font>"
	root["ativacao_conteudo"].addChild(root["ativacao_etapa4_titulo"]);
	root["ativacao_etapa4_titulo"].alpha=0;
	Tweener.addTween(root["ativacao_etapa4_titulo"], {alpha:1, time: 1,transition: "easeOutExpo",delay: 0});

	/*
	criaBt("ativacao_etapa4_saibamais","Saiba mais",root["ativacao_conteudo"],150,500,.5,"0xffffff","M");
	root["ativacao_etapa4_saibamais"].addEventListener(MouseEvent.CLICK, function(){ativacao_etapa4_saibamais_click();});
	root["ativacao_etapa4_saibamais"].buttonMode = true;
	function ativacao_etapa4_saibamais_click(){
		modal_abrir("ativacao_fechar_confirmacao",['texto',"Como funciona a<br>Aprovação/Ativação?","Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer eget gravida tellus. Nam mollis lacinia risus at varius. Lorem ipsum dolor sit amet, consectetur adipiscing elit.<br><br>Proin nisi augue, maximus sed pellentesque a, ultrices quis nibh. Nam urna nisl, dictum eu nunc ac, viverra mollis enim. Vivamus est neque, consequat at elit sit amet, sodales viverra lectus. Sed eget nisi eget ligula luctus sollicitudin id sit amet sem. Donec molestie purus urna. Morbi posuere posuere efficitur.<br><br>Proin ut consectetur odio Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer eget gravida tellus. Nam mollis lacinia risus at varius. Lorem ipsum dolor sit amet, consectetur adipiscing elit.<br><br>Proin nisi augue, maximus sed pellentesque a, ultrices quis nibh. Nam urna nisl, dictum eu nunc ac, viverra mollis enim. Vivamus est neque, consequat at elit sit amet, sodales viverra lectus. Sed eget nisi eget ligula luctus sollicitudin id sit amet sem. Donec molestie purus urna. Morbi posuere posuere efficitur."],"","",true,null,"BS-G");
		root["modal_texto"].texto.height = 430;
	};
	*/
	
	// Atualizar + Aproveite e veja como Funciona:
	criaBt("ativacao_etapa4_atualizar","Atualizar",root["ativacao_conteudo"],50,550,.95,"0x"+corbt1,"M");
	Tweener.addTween(root["ativacao_etapa4_atualizar"].texto, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
	root["ativacao_etapa4_atualizar"].addEventListener(MouseEvent.CLICK, function(){ativacao_etapa4_atualizar_click();});
	root["ativacao_etapa4_atualizar"].buttonMode = true;
	function ativacao_etapa4_atualizar_click(){
		rebootBlast();
	};
	criaBt("ativacao_etapa4_conheca","Conheça!",root["ativacao_conteudo"],190,550,.95,"0xffffff","M");
	Tweener.addTween(root["ativacao_etapa4_conheca"].texto, {_color:"0x"+cortexto, time: 0,transition: "easeOutExpo",delay: 0});
	root["ativacao_etapa4_conheca"].addEventListener(MouseEvent.CLICK, function(){ativacao_etapa4_conheca_click();});
	root["ativacao_etapa4_conheca"].buttonMode = true;
	function ativacao_etapa4_conheca_click(){
		navigateToURL(new URLRequest(blast.list[app].pages.como_funciona['url']), "_blank");
	};
};