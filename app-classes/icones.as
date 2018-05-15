//-----------------------------------------------------------------
// ÍCONES:  Contrução de um ícone (imagem externa)
//-----------------------------------------------------------------
function criaIcon(nome,local,icone,posx,posy,tamanho,estilo,cores,animacao){
	
	// # 1) Cria clipe principal:
	root[nome] = new Vazio;
	root[nome].name = nome;
	root[nome].x = posx;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	// # 2) Clia Clipe do ìcone:
	root[nome+"_icone"] = new Vazio;
	
	// # 2) Estilo de Icone:
	var imageSize;
	var imagePosition;
	var circle:Sprite = new Sprite();
	root[nome+"_fundo"] = new Vazio();
	
	if(estilo=="normal"){
		imageSize = tamanho;
		imagePosition = 0;
		root[nome].addChild(root[nome+"_icone"]);
	};
	
	if(estilo=="bullet"){
		imageSize = tamanho-((tamanho/100)*50);
		imagePosition = (tamanho/2)-(imageSize/2)
        circle.graphics.beginFill(cores[1]);
		circle.graphics.drawEllipse(0, 0, tamanho, tamanho);
		circle.graphics.endFill();
		root[nome+"_fundo"].addChild(circle);
		root[nome+"_icone"].addChild(root[nome+"_fundo"]);
		root[nome].addChild(root[nome+"_icone"]);
	};
	
	// # 3) Carrega Ícone (Imagem Externa)
	root[nome+"_iconeImg"]  = new Vazio;
	Tweener.addTween(root[nome+"_iconeImg"], {_color:cores[0], time: 0,transition: "linear",delay: 0});
		
	var imageLoader:Loader;
	imageLoader = new Loader();
	imageLoader.load(new URLRequest(icone));
	imageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, imageLoading);
	imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
	imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, imageError);
	
	function imageLoading(e:ProgressEvent):void {
	}
	function imageLoaded(e:Event):void {
		var image:Bitmap = Bitmap(imageLoader.content);
		image.width = imageSize;
		image.height = imageSize;
		image.x = image.y =(imagePosition)-(imageSize/2);
		image.smoothing=true;
		root[nome+"_iconeImg"].addChild(image);
		root[nome+"_iconeImg"].x = root[nome+"_iconeImg"].y =(imageSize/2);
		if(animacao.length>=1){
			if(animacao[0]=="scale"){
				root[nome+"_iconeImg"].scaleY = root[nome+"_iconeImg"].scaleX = 0;
				Tweener.addTween(root[nome+"_iconeImg"], {scaleX:1, scaleY:1, time: animacao[2],transition: animacao[1],delay: 0});
			};
			if(animacao[0]=="alpha"){
				root[nome+"_iconeImg"].alpha=0
				Tweener.addTween(root[nome+"_iconeImg"], {alpha:1, time: animacao[2],transition: animacao[1],delay: 0});
			}
		};
	};
	function imageError(event:IOErrorEvent):void {
		trace("Erro (load): "+icone +" ("+ event+")");
	};
	root[nome+"_icone"].addChild(root[nome+"_iconeImg"]);
	
	// # 4) Aplica ícone no Stage:
	local.addChild(root[nome]);
	
}
