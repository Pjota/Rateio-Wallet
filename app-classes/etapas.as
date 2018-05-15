//-----------------------------------------------------------------
// ETAPAS: Wizard
//-----------------------------------------------------------------
function criaWizard(nome,local,tipo,quantidade,largura,posx,posy,scala,cor,cortxt){
	// Criação da listagem dos números do Wizard:
	var distancias = largura/(quantidade-1);
	root[nome] = new Vazio();
	root[nome].name = nome;
	root[nome].x = posx;
	root[nome].y = posy;
	local.addChild(root[nome]);
	// Linha Branca:
	root[nome+"_linha_cinza"] = new Quadrado();
	root[nome+"_linha_cinza"].height = 5;
	root[nome+"_linha_cinza"].width = (largura);
	Tweener.addTween(root[nome+"_linha_cinza"], {_color:"0x"+coricon, alpha:.1, time:0, transition: "linear",delay: 0});
	root[nome].addChild(root[nome+"_linha_cinza"]);
	// Linha Cinza:
	root[nome+"_linha_cor"] = new Quadrado();
	root[nome+"_linha_cor"].height = 5;
	Tweener.addTween(root[nome+"_linha_cor"], {_color:"0x"+corbt1, time:0, transition: "linear",delay: 0});
	root[nome].addChild(root[nome+"_linha_cor"]);
	// Adiciona pontos:
	for(var i=0; i<quantidade; i++){
		root[nome+"_item"+(i+1)] = new Bullet_Number();
		root[nome+"_item"+(i+1)].x = i*distancias;
		root[nome+"_item"+(i+1)].textos.texto.htmlText="<font color='#"+corbt1+"'>"+(i+1)+"</font>";
		root[nome+"_item"+(i+1)].scaleX = root[nome+"_item"+(i+1)].scaleY = 0;
		Tweener.addTween(root[nome+"_item"+(i+1)].fundo, {_color:"0xffffff", time:0, transition: "linear",delay: 0});
		Tweener.addTween(root[nome+"_item"+(i+1)].textos, {_color:"0x"+corbt1, time:0, transition: "linear",delay: 0});
		Tweener.addTween(root[nome+"_item"+(i+1)], {scaleX:scala, scaleY:scala, time: .5,transition: "easeOutExpo",delay: 1+(i/50)});
		root[nome].addChild(root[nome+"_item"+(i+1)]);
	};
	// Muda etapa:
	root[nome].changeWizard = function (numero){
		Tweener.addTween(root[nome+"_linha_cor"], {width:(distancias*(numero-1)), time:1, transition: "easeOutExpo",delay: 0});
		for(var i=1; i<=quantidade; i++){
			if(i==numero){
				Tweener.addTween(root[nome+"_item"+(i)].fundo, {_color:"0x"+coricon, time:1, transition: "easeOutExpo",delay: 0});
				Tweener.addTween(root[nome+"_item"+(i)].textos, {_color:"0xffffff", time:1, transition: "easeOutExpo",delay: 0});
			}else{
				Tweener.addTween(root[nome+"_item"+(i)].fundo, {_color:"0xffffff", time:1, transition: "easeOutExpo",delay: 0});
				Tweener.addTween(root[nome+"_item"+(i)].textos, {_color:"0x"+corbt1, time:1, transition: "easeOutExpo",delay: 0});
			}
		};
		
	};
};