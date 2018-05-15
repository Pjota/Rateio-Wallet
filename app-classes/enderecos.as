//-----------------------------------------------------------------
// ENDEREÇOS:
//-----------------------------------------------------------------
function criaEnderecoSimples(nome,icone,titulo,texto,local,posx,posy,scala,cores){
	root[nome] = new endereco_BoxSimples();
	root[nome].name = nome;
	root[nome].x = posx;
	root[nome].titulo.htmlText = "<font color='#"+cores[0]+"'>"+titulo+"</font>";
	root[nome].titulo.width=190;
	root[nome].texto.htmlText = "<font color='#"+cores[1]+"'>"+texto+"</font>";
	root[nome].texto.width=190;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].scaleX = root[nome].scaleY = scala;
	Tweener.addTween(root[nome].linha, {_color:"0x"+cores[2], alpha:.1, time: 0,transition: "linear",delay: 0});
	local.addChild(root[nome]);
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	criaIcon(nome+"_icone_local",root[nome],blast.list.server.server_path+"/com/icones/"+icone,12,11,40,"normal",["0x"+coricon,"0x"+coricon],["alpha","easeOutExpo",1]);
	criaIcon(nome+"_icone_map",root[nome],blast.list.server.server_path+"/com/icones/map-marker.png",260,11,40,"bullet",["0x"+coricon,"0x"+corbt1],["alpha","easeOutExpo",1]);
};