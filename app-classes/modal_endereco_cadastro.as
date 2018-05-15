//==============================
// MODAL ENDEREÇOS: CADASTRO
// > Modal que cadastra um novo endereço.
//==============================

if(tipo[0]=="modal_endereco_cadastro"){
	// ---------------------------------------
	// # Título e Texto:
	criaIcon("modal_icone",root[nome].conteudo,blast.list.server.server_path+"/com/icones/map.png",(365/2)-20,40,40,"normal",["0x"+coricon,"0x"+coricon],["alpha","easeOutExpo",1]);
	// ---------------------------------------
	// # Título e Texto:
	root["modal_titulo"] = new Titulo_Modal();
	root["modal_titulo"].y = 85; 
	root["modal_titulo"].titulo.htmlText="<font color='#"+corbt1+"'>"+titulo+"</font>";
	root["modal_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER;
	texto = "<font color='#"+cortexto+"'>"+texto+"</font>";
	root["modal_titulo"].texto.htmlText=texto;
	root["modal_titulo"].texto.selectable = false;
	root[nome].conteudo.addChild(root["modal_titulo"]);
	// ---------------------------------------
	// # Monta tela:
	criaInput("modal_cadEndRua", "Rua/Av",root[nome].conteudo, 45, root["modal_titulo"].y+root["modal_titulo"].height+10, .90, tipo[2], "0x202020", 100, false,"G");
	criaInput("modal_cadEndNumero", "Número",root[nome].conteudo, 45, "modal_cadEndRua", .90, tipo[2], "0x202020", 10, false,"P");
	criaInput("modal_cadEndBairro", "Bairro",root[nome].conteudo, 190, "modal_cadEndRua", .90, tipo[2], "0x202020", 10, false,"P");
	criaBt("modal_cadEnd_salvar","Cadastrar e Usar",root[nome].conteudo,45,"modal_cadEndNumero",.89,"0x"+corbt1,"G");
	root["modal_cadEnd_salvar"].addEventListener(MouseEvent.CLICK, function(){modal_cadEnd_salvar_click()});
	root["modal_cadEnd_salvar"].buttonMode = true;
	function modal_cadEnd_salvar_click(){
		/*
		tipo[3]();
		modal_fechar(realnome);
		*/
	}
}
/*
root["tipodeend"] = ""
function modalEndereco(tipo,callback,cepinicial){
	root["ModalEndTipo"] = tipo;
	trace("Tipo de POST de Endereço: "+root["ModalEndTipo"]);
	root["callbackModalEnd"] = callback;
	modalContent("modalEnd",true,"Cadastro de endereço");
	root["modalEnd"].texto.texto.htmlText = "";
	root["modalEnd"].texto.y-=10;
	root["modalEnd"].conteudo.y = root["modalEnd"].texto.y+root["modalEnd"].texto.height+10
	criaInput("cadEndCEP", "Informe o CEP",root["modalEnd"].conteudo, 0, 0, .80, "0xdeffff", "0x202020", 8, false);
	root["cadEndCEP"].texto.restrict = "0-9";
	root["cadEndCEP"].texto.addEventListener(FocusEvent.FOCUS_IN, addCepFocus);
	criaBt("cadEndBuscar","Buscar",root["modalEnd"].conteudo,0,"cadEndCEP",.80,"0x0098bf","0xffffff","G");
	root["cadEndBuscar"].addEventListener(MouseEvent.CLICK, function(){buscaCEP(root["modalEnd"]);});
	root["cadEndBuscar"].buttonMode = true;
	if(cepinicial!=null){
	root["cadEndCEP"].texto.text = cepinicial; //root["User"].user.cep;
		buscaCEP(root["modalEnd"]);
	}
	function buscaCEP(alvo){
		if(root["cadEndCEP"].texto.text!="Informe o CEP" && root["cadEndCEP"].texto.text.length==8){
			root["cadEndBuscar"].visible=false;
			root["cadEndCEP"].texto.removeEventListener(FocusEvent.FOCUS_IN, addCepFocus);
			carregandoON(root["modalEnd"].conteudo, 'loading', root["cadEndBuscar"].width/2, root["cadEndBuscar"].y,"0x23789E");
			connectServer(false,servidor+"busca_cep.php",[
			["email",root["loginInput"].getValue(),"texto"],
			["senha",root["CachePass"],"texto"],
			["cep",root["cadEndCEP"].texto.text,"texto"]
			],retornoCEP);
			root["cadEndCEP"].texto.selectable = false;
			root["cadEndCEP"].texto.type = TextFieldType.DYNAMIC;
		}else{
			newbalaoInfo(root["modalEnd"].conteudo,'Informe um CEP válido para busca.',(root["cadEndBuscar"].x+(root["cadEndBuscar"].width/2)),(root["cadEndBuscar"].y+40),"BalaoInfo");
		}
	}
}
function addCepFocus(e:FocusEvent) {
	root["cadEndCEP"].texto.text = "";
	if(root["enderecoConstruido"] == true){
		root["modalEnd"].conteudo.removeChild(root["cadEndRua"]);
		root["modalEnd"].conteudo.removeChild(root["cadEndNumero"]);
		root["modalEnd"].conteudo.removeChild(root["cadEndCompl"]);
		if(root["tipodeend"]=="subregiao"){
			root["modalEnd"].conteudo.removeChild(root["cadEndBairro"]);
		}
		if(root["tipodeend"]=="regiao"){
			carregandoOFF(root["modalEnd"].conteudo, 'loading');
			root["modalEnd"].conteudo.removeChild(root["CRegiao"]);
		}
		root["modalEnd"].conteudo.removeChild(root["cadEndCidade"]);
		root["modalEnd"].conteudo.removeChild(root["CadPorteiro"]);
		root["modalEnd"].conteudo.removeChild(root["CLocal"]);
		root["modalEnd"].conteudo.removeChild(root["CTurno"]);
		root["modalEnd"].conteudo.removeChild(root["cadEndereco"]);
		root["enderecoConstruido"] = false;
	};
	root["cadEndBuscar"].visible=true;
}
	
function retornoCEP(dados){
	trace(dados)
	root["tipodeend"];
	root["cadEndCEP"].texto.selectable = true;
	root["cadEndCEP"].texto.type = TextFieldType.INPUT;
	root["cadEndCEP"].texto.addEventListener(FocusEvent.FOCUS_IN, addCepFocus);
			
	if(dados.retorno=="cidade"){
		root["cadEndBuscar"].visible=true;
		carregandoOFF(root["modalEnd"].conteudo, 'loading');
		newbalaoInfo(root["modalEnd"].conteudo,'Você .',(root["cadEndBuscar"].x+(root["cadEndBuscar"].width/2)),(root["cadEndBuscar"].y+40),"BalaoInfo");	
	}
	if(dados.retorno=="erro"){
		root["cadEndBuscar"].visible=true;
		carregandoOFF(root["modalEnd"].conteudo, 'loading');
		newbalaoInfo(root["modalEnd"].conteudo,'Erro ao buscar CEP.',(root["cadEndBuscar"].x+(root["cadEndBuscar"].width/2)),(root["cadEndBuscar"].y+40),"BalaoInfo");	
	}
	if(dados.retorno=="cep"){
		root["cadEndBuscar"].visible=true;
		carregandoOFF(root["modalEnd"].conteudo, 'loading');
		newbalaoInfo(root["modalEnd"].conteudo,'CEP inválido. Tente novamente.',(root["cadEndBuscar"].x+(root["cadEndBuscar"].width/2)),(root["cadEndBuscar"].y+40),"BalaoInfo");	
	}
	if(dados.retorno=="ok"){
		carregandoOFF(root["modalEnd"].conteudo, 'loading');
		criaInput("cadEndRua", "Rua",root["modalEnd"].conteudo, 0, "cadEndCEP", .80, "0xffffff", "0x202020", 100, false);
		criaInputP("cadEndNumero", "Número",root["modalEnd"].conteudo, 0, "cadEndRua", .80, "0xffffff", "0x202020", 10, false);
		criaInputP("cadEndCompl", "Complemento",root["modalEnd"].conteudo, root["cadEndNumero"].x+root["cadEndNumero"].width+10, "cadEndRua", .80, "0xffffff", "0x202020", 20, false);
		if(dados.bairro!=""){
			root["tipodeend"] = "subregiao";
			criaInputP("cadEndBairro", "Bairro",root["modalEnd"].conteudo, 0, "cadEndCompl", .80, "0xffffff", "0x202020", 100, false);
		}else{
			root["tipodeend"] = "regiao";
			carregandoON(root["modalEnd"].conteudo, 'loading', 55, 175,"0x23789E");
			connectServer(false,servidor+"busca_regioes.php",[
			["email",root["User"].user.email,"texto"],
			["senha",root["CachePass"],"texto"],
			["estado",dados.estado,"texto"],
			["cidade",dados.cidade,"texto"]
			],retornoRegioes);
			function retornoRegioes(dados){
				trace(dados);
				criaCombobox("CRegiao","Região",root["modalEnd"].conteudo,0,175,dados.itens,.80,"attr","0xffffff","0x202020",root["escRegiao"],"P");
				criaCombobox("CTurno","Pref. de Turno",root["modalEnd"].conteudo,130,"CadPorteiro",dados.turnos.itens,.80,"attr","0xffffff","0x202020",root["escTurno"],"P");
			}
		}
			
		criaInputP("cadEndCidade", "Cidade",root["modalEnd"].conteudo, 135, "cadEndCompl", .80, "0xffffff", "0x202020", 100, false);
		criaCheckBox("CadPorteiro",0,"cadEndCidade",root["modalEnd"].conteudo,["Endereço com Porteiro"],"0x23789E",null);
		var locais = "<xml><itens><item id='1' nome='Casa'>Casa</item><item id='2' nome='Trabalho'>Trabalho</item><item id='3' nome='Outro'>Outro</item></itens></xml>"
		locais = new XML(locais);
		criaCombobox("CLocal","Local",root["modalEnd"].conteudo,-10,"CadPorteiro",locais.itens,.80,"attr","0xffffff","0x202020",root["escLocal"],"P");
		if(root["tipodeend"] == "subregiao"){
			criaCombobox("CTurno","Pref. de Turno",root["modalEnd"].conteudo,130,"CadPorteiro",dados.turnos.itens,.80,"attr","0xffffff","0x202020",root["escTurno"],"P");
		};
		criaBt("cadEndereco","Cadastrar",root["modalEnd"].conteudo,0,"CLocal",.80,"0x0098bf","0xffffff","G");
		if(dados.rua!=""){
			root["cadEndRua"].texto.text = dados.rua;
			root["cadEndRua"].texto.selectable = false;
			root["cadEndRua"].texto.type = TextFieldType.DYNAMIC;
			Tweener.addTween(root["cadEndRua"].fundo, {_color:0xdeffff, time: 1,transition: "easeOutExpo",delay:0});
		}
		if(dados.bairro!=""){
			root["cadEndBairro"].texto.text = dados.bairro;
			root["cadEndBairro"].texto.selectable = false;
			root["cadEndBairro"].texto.type = TextFieldType.DYNAMIC;
			Tweener.addTween(root["cadEndBairro"].fundo, {_color:0xdeffff, time: 1,transition: "easeOutExpo",delay:0});
		}
		if(dados.cidade!=""){
			root["cadEndCidade"].texto.text = dados.cidade;
			root["cadEndCidade"].texto.selectable = false;
			root["cadEndCidade"].texto.type = TextFieldType.DYNAMIC;
			Tweener.addTween(root["cadEndCidade"].fundo, {_color:0xdeffff, time: 1,transition: "easeOutExpo",delay:0});
		}
		root["estadoEsc"] = dados.estado;
		root["cadEndereco"].addEventListener(MouseEvent.CLICK, function(){cadastrarEnd(root["modalEnd"]);});
		root["cadEndereco"].buttonMode = true;
		root["enderecoConstruido"] = true;
	}
	
	function cadastrarEnd(alvo){
		//trace("Turno: "+root["CTurno"].valor)
		if(root["cadEndRua"].texto.text!="Rua"){
			if(root["cadEndNumero"].texto.text!="Número"){
				if(root["CLocal"].texto.text!="Selecione..."){
					if(root["CTurno"].texto.text!="Selecione..."){
					
						if(root["tipodeend"] == "subregiao"){
							//------------ SUBREGIÃO/BAIRRO:
							if(root["cadEndBairro"].texto.text!="Bairro"){
								desativaInput(root["cadEndCEP"]);
								desativaInput(root["cadEndRua"]);
								desativaInput(root["cadEndNumero"]);
								desativaInput(root["cadEndCompl"]);
								desativaInput(root["cadEndBairro"]);
								desativaInput(root["cadEndCidade"]);
								desativaInput(root["CLocal"]);
								desativaInput(root["CTurno"]);
								root["CadPorteiro"].visible = false;
								root["cadEndereco"].visible = false;
								carregandoON(root["modalEnd"].conteudo, 'loading', root["cadEndereco"].width/2, root["cadEndereco"].y,"0x23789E");
								Tweener.addTween(root["modaltextoFechar"], {scaleX:0, scaleY:0, time: .5,transition: "easeOutExpo",delay:0});
								connectServer(false,servidor+"cadastra_endereco.php",[
								["email",root["User"].user.email,"texto"],
								["senha",root["CachePass"],"texto"],
								["cep",root["cadEndCEP"].texto.text,"texto"],
								["rua",root["cadEndRua"].texto.text,"texto"],
								["numero",root["cadEndNumero"].texto.text,"texto"],
								["complemento",root["cadEndCompl"].texto.text,"texto"],
								["bairro",root["cadEndBairro"].texto.text,"texto"],
								["cidade",root["cadEndCidade"].texto.text,"texto"],
								["uf",root["estadoEsc"],"texto"],
								["porteiro",root["CadPorteiro"+(1)].valor,"texto"],
								["local",root["CLocal"].texto.text,"texto"],
								["turno",root["CTurno"].valor,"texto"],
								["tipo",root["ModalEndTipo"],"texto"]
								],cadastrando_endereco);
							}else{
								newbalaoInfo(root["modalEnd"].conteudo,'Informe o bairro.',(root["cadEndereco"].x+(root["cadEndereco"].width/2)),(root["cadEndereco"].y+40),"BalaoInfo");
							}
						}else{
							//------------ REGIÃO:
							if(root["CRegiao"].texto.text!="Selecione..."){
								desativaInput(root["cadEndCEP"]);
								desativaInput(root["cadEndRua"]);
								desativaInput(root["cadEndNumero"]);
								desativaInput(root["cadEndCompl"]);
								desativaInput(root["cadEndCidade"]);
								desativaInput(root["CRegiao"]);
								desativaInput(root["CLocal"]);
								desativaInput(root["CTurno"]);
								root["CadPorteiro"].visible = false;
								root["cadEndereco"].visible = false;
								carregandoON(root["modalEnd"].conteudo, 'loading', root["cadEndereco"].width/2, root["cadEndereco"].y,"0x23789E");
								Tweener.addTween(root["modaltextoFechar"], {scaleX:0, scaleY:0, time: .5,transition: "easeOutExpo",delay:0});
								connectServer(false,servidor+"cadastra_endereco.php",[
								["email",root["User"].user.email,"texto"],
								["senha",root["CachePass"],"texto"],
								["cep",root["cadEndCEP"].texto.text,"texto"],
								["rua",root["cadEndRua"].texto.text,"texto"],
								["numero",root["cadEndNumero"].texto.text,"texto"],
								["complemento",root["cadEndCompl"].texto.text,"texto"],
								["regiao",root["CRegiao"].valor,"texto"],
								["cidade",root["cadEndCidade"].texto.text,"texto"],
								["uf",root["estadoEsc"],"texto"],
								["porteiro",root["CadPorteiro"+(1)].valor,"texto"],
								["local",root["CLocal"].texto.text,"texto"],
								["turno",root["CTurno"].valor,"texto"],
								["tipo",root["ModalEndTipo"],"texto"]
								],cadastrando_endereco);
							}else{
								newbalaoInfo(root["modalEnd"].conteudo,'Informe sua região',(root["cadEndereco"].x+(root["cadEndereco"].width/2)),(root["cadEndereco"].y+40),"BalaoInfo");
							}
						}
					}else{
						newbalaoInfo(root["modalEnd"].conteudo,'Informe o turno de preferência.',(root["cadEndereco"].x+(root["cadEndereco"].width/2)),(root["cadEndereco"].y+40),"BalaoInfo");
					}
				}else{
					newbalaoInfo(root["modalEnd"].conteudo,'Informe o tipo do local.',(root["cadEndereco"].x+(root["cadEndereco"].width/2)),(root["cadEndereco"].y+40),"BalaoInfo");
				}
			}else{
				newbalaoInfo(root["modalEnd"].conteudo,'Informe o número.',(root["cadEndereco"].x+(root["cadEndereco"].width/2)),(root["cadEndereco"].y+40),"BalaoInfo");
			}
		}else{
			newbalaoInfo(root["modalEnd"].conteudo,'Informe a rua.',(root["cadEndereco"].x+(root["cadEndereco"].width/2)),(root["cadEndereco"].y+40),"BalaoInfo");
		}
	}
}

function cadastrando_endereco(dados){
	trace("Cadastro End: "+dados)
	if(dados.retorno=="ok"){
		root["callbackModalEnd"]();
		modalclose(root["modalEnd"]);
	}
	if(dados.retorno=="erro"){
		newbalaoInfo(root["modalEnd"].conteudo,'Erro ao cadastrar Endereço.',(root["cadEndereco"].x+(root["cadEndereco"].width/2)),(root["cadEndereco"].y+40),"BalaoInfo");
		carregandoOFF(root["modalEnd"].conteudo, 'loading');	
		root["cadEndereco"].visible = true;
		setTimeout(fechamodalend,2500);
	}
	if(dados.retorno=="sematendimento"){
		newbalaoInfo(root["modalEnd"].conteudo,'Infelizmente ainda não atendemos nesta área.',(root["cadEndereco"].x+(root["cadEndereco"].width/2)),(root["cadEndereco"].y+40),"BalaoInfo");
		carregandoOFF(root["modalEnd"].conteudo, 'loading');
		root["cadEndereco"].visible = true;
		setTimeout(fechamodalend,2500);
	}
	function fechamodalend(){
		modalclose(root["modalEnd"]);
	}
}
function cadastrando_endereco_retorno(){
	ativaInput(root["cadEndRua"]);
	ativaInput(root["cadEndNumero"]);
	ativaInput(root["cadEndCompl"]);
	ativaInput(root["cadEndBairro"]);
	ativaInput(root["cadEndCidade"]);
	root["CadPorteiro"].visible = true;
	root["cadEndereco"].visible = true;
	carregandoOFF(root["modalEnd"].conteudo, 'loading');			
}
*/