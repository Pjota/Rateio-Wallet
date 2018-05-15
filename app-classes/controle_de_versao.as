//-----------------------------------------------------------------
// CONTROLE DE VERSÃO
//-----------------------------------------------------------------
function controle_de_versao(){
	connectServer(false,"screen",servidor+"api/version",[
	["produto",blast.list.slug,"texto"],
	["id_projeto",clienteID,"texto"],
	["dispositivo",dispositivo,"texto"],
	["aplicacao","app_mobile","texto"]
	],controle_de_versao_retorno);
};
function controle_de_versao_retorno(dados) {
	if(versaoapp>=dados.versao){
		pages_new("login",blast.list[app].pages.login.template);
	}else{
		controle_de_versao_erro(dados);
	};
};
function controle_de_versao_erro(dados) {
	// Ícone de Atualização:
	var iconW = 80;
	var iconY = 80;
	criaIcon("controle_de_versao_icone",tela,servidor+"com/icones/warning.png",0,iconY,iconW,"bullet",["0xffffff","0x"+corbt1],["alpha","easeOutExpo",1]);		
	root["controle_de_versao_icone"].x = (365/2)-(root["controle_de_versao_icone"].width/2)
	// Logo:
	var logoW = 190;
	img_load("controle_de_versao_logo",blast.list[app].paths.upload_path+"/"+logonormal,tela,["width",logoW],null,[(365/2)-(logoW/2),205],[],0,null)
	// Informações de Controle de Versão:
	var posY = 300
	root["versao_erro"] = new versao_erro();
	root["versao_erro"].y = posY+20;
	root["versao_erro"].alpha=0;
	root["versao_erro"].texto.autoSize = TextFieldAutoSize.LEFT;
	root["versao_erro"].texto.htmlText = "<font color='#"+cortexto+"'>"+dados.melhorias+"</font>";
	root["versao_erro"].titulo.htmlText = "<font color='#"+cortitulos+"'>Atualize seu aplicativo</font>";
	root["versao_erro"].tituloversao.htmlText = "<font color='#"+corsubtitulos+"'>"+"Nova versão: "+dados.versao+" ("+dados.dispositivo+")</font>"
	Tweener.addTween(root["versao_erro"], {y:posY, alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	tela.addChild(root["versao_erro"]);
	// Botão de Atualizar:
	criaBt("novaversao","Atualizar",tela,0,root["versao_erro"].y+root["versao_erro"].height+20,.95,"0x"+corbt1,"M");
	root["novaversao"].x = (365/2)-(root["novaversao"].width/2)
	Tweener.addTween(root["novaversao"].texto, {_color:0xffffff, time: 0,transition: "linear",delay: 0});
	root["novaversao"].addEventListener(MouseEvent.CLICK, function(){controle_de_versao_linkstore(dados);});
	root["novaversao"].buttonMode = true;
	// Rodapé:
	root["app_assinatura"] = new app_assinatura();
	tela.addChild(root["app_assinatura"]);
	root["app_assinatura"].y = (root["novaversao"].y + root["novaversao"].height+10)
	root["app_assinatura"].texto.htmlText=blast.list.infos['year']+" © Copyright "+blast.list.nome;
};
function controle_de_versao_linkstore(dados){
	navigateToURL(new URLRequest(blast.list[app].stores[dispositivo]));
};
