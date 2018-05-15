// ==============================================
// NUMEROS - NÚMERO
// ==============================================
function criaNumero(nome,titulo,texto,local,posx,posy,scala){
	// -----------
	// Cria input:
	root[nome] = new input_Bar();
	root[nome].name = nome;
	root[nome].x = posx;
	root[nome].labeltxt.htmlText = "<font color='#"+corbt1+"'>"+titulo+"</font>";
	root[nome].texto.htmlText = "<font color='#"+cortexto+"'>"+texto+"</font>";
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].valor = "";
	root[nome].scaleX = root[nome].scaleY = scala;
	Tweener.addTween(root[nome].molde, {_color:"0x"+corbt1, time: 0,transition: "linear",delay: 0});
	criaIcon(nome+"_icone",root[nome],blast.list.server.server_path+"/com/icones/map.png",14,14,30,"normal",["0xffffff","0xffffff"],["alpha","easeOutExpo",0]);
	local.addChild(root[nome]);
	// ------------------------
	// Clique para abrir Modal:
	root[nome].addEventListener(MouseEvent.CLICK, function(){criaLocalizacao_Modal();});
	function criaLocalizacao_Modal(){
		modal_abrir("modal_social_search_gps_enderecos",["modal_endereco_listagem",root["modal_endereco_esc"],criaLocalizacao_Atualiza,"cadastro-gps"],"Favoritos","Algum local preferido?",true,null,"G");
	};
	function criaLocalizacao_Atualiza(txt,id){
		root[nome].texto.htmlText = "<font color='#"+cortexto+"'>"+txt+"</font>";
		root[nome].valor = id;
	};
};
// ==============================================
// NUMEROS - VALOR FINANCEIRO
// ==============================================
function criaValor(nome,titulo,texto,local,posx,posy,scala,tamanho){
	if(tamanho=="G"){root[nome] = new input_Bar();}
	if(tamanho=="M"){root[nome] = new input_Bar_M();}
	root[nome].name = nome;
	root[nome].x = posx;
	if(texto.indexOf("$")>=0){
		root[nome].gotoAndStop(2);
	}else{
		root[nome].gotoAndStop(1);
	}
	root[nome].labeltxt.htmlText = "<font color='#"+corbt1+"'>"+titulo+"</font>";
	root[nome].texto.htmlText = "<font color='#"+cortexto+"'>"+texto+"</font>";
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].valor = "";
	root[nome].scaleX = root[nome].scaleY = scala;
	Tweener.addTween(root[nome].molde, {_color:"0x"+corbt1, time: 0,transition: "linear",delay: 0});
	criaIcon(nome+"_icone",root[nome],blast.list.server.server_path+"/com/icones/dinheiro.png",14,14,30,"normal",["0xffffff","0xffffff"],["alpha","easeOutExpo",0]);
	local.addChild(root[nome]);
	// ------------------------
	// Clique para abrir Modal:
	/*
	root[nome].addEventListener(MouseEvent.CLICK, function(){criaLocalizacao_Modal();});
	function criaLocalizacao_Modal(){
		modal_abrir("modal_social_search_gps_enderecos",["modal_endereco_listagem",root["modal_endereco_esc"],criaLocalizacao_Atualiza,"cadastro-gps"],"Favoritos","Algum local preferido?",true,null,"G");
	};
	function criaLocalizacao_Atualiza(txt,id){
		root[nome].texto.htmlText = "<font color='#"+cortexto+"'>"+txt+"</font>";
		root[nome].valor = id;
	};
	*/
}