//-----------------------------------------------------------------
// CHECKBOX ( True/False )
//-----------------------------------------------------------------
function criaCheckBox(nome,posx,posy,local,infos,cor,funcao){
	var posInit;
	root[nome] =  new CheckBoxConteudo();
	root[nome].x = posx;
	root[nome].valor = false;
	root[nome].cor = cor;
	root[nome].ativo = true;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	local.addChild(root[nome]);
	function nada(){}
	root[nome].changeActive = function(status){
		for(var i=0; i<infos.length; i++){
			root[nome+(i+1)].ativo = status;
		}
	}
	for(var i=0; i<infos.length; i++){
		var guia = infos[i]
		root[nome+(i+1)] = new CheckBoxInput();
		root[nome+(i+1)].name = nome;
		root[nome+(i+1)].cor = cor;
		if(funcao==null){
			funcao = nada;
		}
		root[nome+(i+1)].funcao = funcao;
		root[nome+(i+1)].x = 0;
		if(i==0){
			root[nome+(i+1)].y = 0;
		}else{
			root[nome+(i+1)].y = (root[nome+(i)].y+root[nome+(i)].height)+5;
		};
		root[nome+(i+1)].texto.autoSize =  TextFieldAutoSize.LEFT 
		root[nome+(i+1)].texto.htmlText = infos[i][0];
		
		if(infos[i][1]=="1"){
			root[nome+(i+1)].gotoAndStop(1);
			root[nome+(i+1)].valor=true;
			root[nome+(i+1)].valor2="{AGORA}";
			Tweener.addTween(root[nome+(i+1)].check1.fundo, {_color:"0x"+cor,time: 0,transition: "easeOutExpo",delay: 0});
		}else{
			root[nome+(i+1)].gotoAndStop(2);
			root[nome+(i+1)].valor=false;
			root[nome+(i+1)].valor2="null";
			Tweener.addTween(root[nome+(i+1)].check1.fundo, {_color:null,time: 0,transition: "easeOutExpo",delay: 0});
		}
		root[nome].addChild(root[nome+(i+1)]);
		root[nome+(i+1)].alpha=0;
		Tweener.addTween(root[nome+(i+1)], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	}
}