//-----------------------------------------------------------------
// SEXO: 
//-----------------------------------------------------------------
var escolhasCriaSexo;
function criaSexo(nome,local,posx,posy,scala,num){
	// Cria Modelo
	if(num==3){
		root[nome] = new Input_sexo_outros();
		escolhasCriaSexo = ["M","F","O"]
	}
	if(num==2){
		root[nome] = new Input_sexo();
		escolhasCriaSexo = ["M","F"]
	}
	root[nome].name = nome;
	root[nome].valor = "";
	root[nome].x = posx;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].scaleX = root[nome].scaleY = scala;
	local.addChild(root[nome]);
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	// Botões
	
	for(var i=0; i<escolhasCriaSexo.length; i++){
		root[nome]["fundo"+escolhasCriaSexo[i]].alpha=.2;
		root[nome]["hit"+escolhasCriaSexo[i]].valor = escolhasCriaSexo[i];
		root[nome]["hit"+escolhasCriaSexo[i]].parentName = nome;
		root[nome]["hit"+escolhasCriaSexo[i]].buttonMode = true;
		root[nome]["hit"+escolhasCriaSexo[i]].addEventListener(MouseEvent.CLICK, criaSexoEsc);
	
	};
}
function criaSexoEsc(event:MouseEvent):void{
	var nome = event.currentTarget.parentName;
	var valor = event.currentTarget.valor;
	for(var i=0; i<escolhasCriaSexo.length; i++){
		if(valor==escolhasCriaSexo[i]){
			root[nome].valor = escolhasCriaSexo[i];
			Tweener.addTween(root[nome]["fundo"+escolhasCriaSexo[i]], {alpha:1, time: 1,transition: "easeOutExpo",delay: 0});
		}else{
			Tweener.addTween(root[nome]["fundo"+escolhasCriaSexo[i]], {alpha:.2, time: 1,transition: "easeOutExpo",delay: 0});
		}
	}
}
function criaSexoPreEsc(alvo,valor){
	for(var i=0; i<escolhasCriaSexo.length; i++){
		if(valor==escolhasCriaSexo[i]){
			alvo.valor = escolhasCriaSexo[i];
			Tweener.addTween(alvo["fundo"+escolhasCriaSexo[i]], {alpha:1, time: 1,transition: "easeOutExpo",delay: 0});
		}else{
			Tweener.addTween(alvo["fundo"+escolhasCriaSexo[i]], {alpha:.2, time: 1,transition: "easeOutExpo",delay: 0});
		}
	}
}