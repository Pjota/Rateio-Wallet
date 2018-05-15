//-----------------------------------------------------------------
// SEARCH BOX - Cria Busca
// Dependências de Classes: CriaInput + CriaIcon
//-----------------------------------------------------------------
function criaSearchBox(nome,texto,local,posx,posy,scala,cor,callbacksearch,tamanho,palavra){
	var busca = new Vazio();
	busca.x = posx;
	busca.y = posy;
	local.addChild(busca);
	// Campo de Input
	criaInput(nome+"_texto", texto, busca, 0, 0, .8, "0xFFFFFF", "0x"+blast.list[app].cores.texto, 20, false,tamanho);
	// Buscar
	criaIcon(nome+"_icone",busca,blast.list.server.server_path+"/com/icones/zoom_detail.png",(root[nome+"_texto"].x+root[nome+"_texto"].width+5),0,50,"bullet",["0xffffff","0x"+cor],["alpha","easeOutExpo",1]);
	root[nome+"_icone"].buttonMode = true;
	root[nome+"_icone"].addEventListener(MouseEvent.CLICK, criaSearchBox_buscar);
	function criaSearchBox_buscar(e:MouseEvent):void {
		if(root[nome+"_texto"].texto.text!=texto){
			callbacksearch(root[nome+"_texto"].texto.text);
			if(root[nome+"_fechar"].visible==false){search_active();}
		}else{
			newbalaoInfo(busca,'Digite aqui o<br>que deseja buscar.',(root[nome+"_texto"].x+(root[nome+"_texto"].width/2)),(root[nome+"_texto"].y+30),"BalaoInfo","0x"+corcancel);
		}
	}
	// Fechar
	criaIcon(nome+"_fechar",busca,blast.list.server.server_path+"/com/icones/remove-symbol.png",(root[nome+"_icone"].x+root[nome+"_icone"].width+5),10,30,"bullet",["0xffffff","0x"+corcancel],["alpha","easeOutExpo",1]);
	root[nome+"_fechar"].visible=false;
	function search_active(){
		root[nome+"_fechar"].visible=true;
		root[nome+"_fechar"].alpha= root[nome+"_fechar"].scaleX= root[nome+"_fechar"].scaleY=0;
		Tweener.addTween(root[nome+"_fechar"], {alpha:1, scaleX:1, scaleY:1, time: 1,transition: "easeOutExpo",delay: 0});
		Tweener.addTween(busca, {x:(posx-17), time: 1,transition: "easeOutExpo",delay: 0});
	}
	root[nome+"_fechar"].buttonMode = true;
	root[nome+"_fechar"].addEventListener(MouseEvent.CLICK, search_desactive);
	function search_desactive(e:MouseEvent):void {
		root[nome+"_texto"].texto.text = texto;
		root[nome+"_fechar"].alpha= root[nome+"_fechar"].scaleX= root[nome+"_fechar"].scaleY=0;
		Tweener.addTween(busca, {x:(posx), time: 1,transition: "easeOutExpo",delay: 0});
		callbacksearch(null);
	};
	// Cria com busca Realizada:
	if(palavra!=null){
		root[nome+"_texto"].setText(palavra);
		search_active();
	};
};
