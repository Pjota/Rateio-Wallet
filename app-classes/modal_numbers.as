if(tipo[0]=="numbers"){
	// -----------------
	// # Título e Texto:
	root["modal_titulo"] = new Titulo_Modal();
	root["modal_titulo"].y = 40; 
	root["modal_titulo"].titulo.htmlText="<font color='#"+corbt1+"'>"+titulo+"</font>";
	root["modal_titulo"].texto.autoSize =  TextFieldAutoSize.CENTER;
	texto = "<font color='#"+cortexto+"'>"+texto+"</font>";
	root["modal_titulo"].texto.htmlText=texto;
	root["modal_titulo"].texto.selectable = true;
	root[nome].conteudo.addChild(root["modal_titulo"]);
	// -----------------
	// # Display
	var valorDisplay = "0";
	criaInput("numbers_valor", "R$ 0,00", root[nome].conteudo, 95, 110, 1.2, "0x1D1D1D", "0xffffff", 50, false,"P");
	root["numbers_valor"].feedback.visible=false;
	root["numbers_valor"].show()
	desativaInputView(root["numbers_valor"]);
	function atualizaDisplay(numero){
		if(numero=="x"){
			valorDisplay = "0";
			root["numbers_valor"].texto.text = convertValor(Number(0));
		}else{
			valorDisplay = valorDisplay+""+numero;
			if(centavos(Number(valorDisplay))>=tipo[1]){
				valorDisplay = tipo[1]*100;
				root["numbers_valor"].texto.text = convertValor(tipo[1]);
			}else{
				root["numbers_valor"].texto.text = convertValor(centavos(Number(valorDisplay)));
			}
		}
	}
	// -----------------
	// # Teclado Virtual:
	var numbers_tv = new Vazio();
	numbers_tv.x = 77;
	numbers_tv.y = 195;
	root[nome].conteudo.addChild(numbers_tv);
	var numbers_count = 0;
	var number_perline = 3;
	var number_qwerty = ["QZ","ABC","DEF","GHI","JKL","MNO","PRS","TUV","WXY"]
	for(var n=1; n<=9; n++){
		root["numbers_"+n] = new Calendario_item();
		root["numbers_"+n].name = "numbers_"+n;
		Tweener.addTween(root["numbers_"+n].fundo, {_color:"0xEDEDED", time: 0,transition: "linear",delay: 0});
		root["numbers_"+n].textos.dia_mes.htmlText = "<font color='#303030'>"+n+"</font>";
		root["numbers_"+n].textos.dia_semana.htmlText = "<font color='#"+cortexto+"'>"+number_qwerty[n-1]+"</font>";
		root["numbers_"+n].valor = n;
		numbers_count++;
		if(n==1){
			root["numbers_"+n].x = 0;
			root["numbers_"+n].y = 0;
		}else{
			if(numbers_count>number_perline){
				numbers_count=1;
				root["numbers_"+n].y = root["numbers_"+(n-1)].y + root["numbers_"+(n-1)].height + 10;
				root["numbers_"+n].x = 0;
			}else{
				root["numbers_"+n].x = root["numbers_"+(n-1)].x + root["numbers_"+(n-1)].width + 10;
				root["numbers_"+n].y = root["numbers_"+(n-1)].y;
			}
		}
		root["numbers_"+n].addEventListener(MouseEvent.CLICK, numbers_clique);
		numbers_tv.addChild(root["numbers_"+n]);
	}
	root["numbers_10"] = new Calendario_item();
	root["numbers_10"].name = "numbers_10";
	Tweener.addTween(root["numbers_10"].fundo, {_color:"0xEDEDED", time: 0,transition: "linear",delay: 0});
	root["numbers_10"].textos.dia_mes.htmlText = "<font color='#303030'>0</font>";
	root["numbers_10"].textos.dia_semana.htmlText = "";
	root["numbers_10"].valor = "0";
	root["numbers_10"].x = root["numbers_8"].x;
	root["numbers_10"].y = root["numbers_8"].y + root["numbers_8"].height + 10;
	root["numbers_10"].addEventListener(MouseEvent.CLICK, numbers_clique);
	numbers_tv.addChild(root["numbers_10"]);
	// -----------------
	// # Limpa
	root["numbers_limpa"] = new Calendario_item();
	root["numbers_limpa"].name = "numbers_limpa";
	Tweener.addTween(root["numbers_limpa"].fundo, {_color:"0x"+corcancel, time: 0,transition: "linear",delay: 0});
	root["numbers_limpa"].textos.dia_mes.htmlText = "";
	root["numbers_limpa"].textos.dia_semana.htmlText = "";
	root["numbers_limpa"].x = root["numbers_7"].x
	root["numbers_limpa"].y = root["numbers_7"].y + root["numbers_7"].height + 10;
	numbers_tv.addChild(root["numbers_limpa"]);
	criaIcon("numbers_limpa_icon",root["numbers_limpa"],blast.list.server.server_path+"/com/icones/close.png",18,17,30,"normal",["0xffffff","0xffffff"],["alpha","easeOutExpo",1]);
	root["numbers_limpa"].addEventListener(MouseEvent.CLICK, numbers_limpa_clique);
	function numbers_limpa_clique(e:MouseEvent):void {
		atualizaDisplay("x");
	}
	// -----------------
	// # Confirma
	root["numbers_confirma"] = new Calendario_item();
	root["numbers_confirma"].name = "numbers_confirma";
	Tweener.addTween(root["numbers_confirma"].fundo, {_color:"0x"+corbt1, time: 0,transition: "linear",delay: 0});
	root["numbers_confirma"].textos.dia_mes.htmlText = "";
	root["numbers_confirma"].textos.dia_semana.htmlText = "";
	root["numbers_confirma"].x = root["numbers_9"].x
	root["numbers_confirma"].y = root["numbers_9"].y + root["numbers_9"].height + 10;
	numbers_tv.addChild(root["numbers_confirma"]);
	criaIcon("numbers_confirma_icon",root["numbers_confirma"],blast.list.server.server_path+"/com/icones/correct-symbol.png",18,15,30,"normal",["0xffffff","0xffffff"],["alpha","easeOutExpo",1]);
	root["numbers_confirma"].addEventListener(MouseEvent.CLICK, numbers_confirma_clique);
	function numbers_confirma_clique(e:MouseEvent):void {
		if(Number(valorDisplay)>=1){
			tipo[2](centavos(Number(valorDisplay)));
			modal_fechar(realnome);
		}else{
			newbalaoInfo(numbers_tv,'Informe um valor acima de R$ 1,00',(root["numbers_confirma"].x+(root["numbers_confirma"].width/2)),(root["numbers_confirma"].y+30),"BalaoInfo","0x"+corcancel);
		}
	}
	// -----------------
	// # Clica + Muda Aparência:
	function numbers_clique(e:MouseEvent):void {
		atualizaDisplay(e.currentTarget.valor)
		numbers_clique_view(e.currentTarget)
	}
	function numbers_clique_view(alvo){
		Tweener.addTween(alvo.fundo, {_color:"0x"+corbt1, time: 0,transition: "linear",delay: 0});
		Tweener.addTween(alvo.textos,{_color:"0xffffff", time: 0,transition: "linear",delay: 0});
		Tweener.addTween(alvo.fundo, {_color:"0xEDEDED", time: .5,transition: "easeOutExpo",delay: .2});
		Tweener.addTween(alvo.textos,{_color:null, time: .5,transition: "easeOutExpo",delay: .2});
	}
};