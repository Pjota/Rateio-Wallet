//-----------------------------------------------------------------
// CLICK: Adiciona clique, integrado ao sistema de SWIPE
//-----------------------------------------------------------------
function addClick(alvo,callback,parametros){
	if(parametros!=null){
		alvo.addEventListener(MouseEvent.CLICK, function(){callback(parametros)});
	}else{
		alvo.addEventListener(MouseEvent.CLICK, function(){callback()});
	}
	alvo.buttonMode = true;
}