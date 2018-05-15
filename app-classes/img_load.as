//-----------------------------------------------------------------
// IMAGENS EXTERNAS - Carregamento de Imagens Externas
//-----------------------------------------------------------------
function img_load(nome,url,local,tamanho,color,ajustPos,animacao,delay,callback){
	root[nome] = new Vazio();
	local.addChild(root[nome]);
	root[nome+"_load"] = new Loader();
	// ========================
	// CONSTRUÇÃO DE URL c/ OTIMIZAÇÃO
	var origem = "";
	var larguraImg = 0;
	if(url==""){
		url=blast.list.server.id_path+"/logo/semfoto.jpg";
		url = blast.list[app].paths.upload_path+"/resize.php?url="+url+"&type="+tamanho[2]+"&"+tamanho[0]+"="+Math.ceil(Number(tamanho[1])*scalaFixa);
	}else{
		if(url.indexOf("http://",0)>=0 || url.indexOf("https://",0)>=0 ){
			url = url;
			origem = "externa";
		}else{
			larguraImg = Number(tamanho[1]);
			if(url.indexOf(".png",0)>=0){
			url = blast.list[app].paths.upload_path+"/"+url;	
			}else{
			url = blast.list[app].paths.upload_path+"/resize.php?url="+url+"&type="+tamanho[2]+"&"+tamanho[0]+"="+Math.ceil(Number(tamanho[1])*scalaFixa);
			}
			origem = "interna";
		};
	}
	// INFORMAÇÕES
	// ========================
	root[nome+"_load"].load(new URLRequest(url));
	root[nome+"_load"].contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, imageLoading);
	root[nome+"_load"].contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
	root[nome+"_load"].contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadError);
	function imageLoading(e:ProgressEvent):void {
	}
	function imageLoaded(e:Event):void {
		var image:Bitmap = Bitmap(root[nome+"_load"].content);
		image.smoothing=true;
		// ============================
		// Tamanho:
		if(tamanho[0]=="scale"){
			image.scaleX = image.scaleY = tamanho[1];
		};
		if(tamanho[0]=="width"){
			image.width = tamanho[1];
			image.scaleY = image.scaleX;
			if(tamanho[3]=="auto"){
				// Encaixou maior na Altura:
				//  + trace("Height: "+image.height+" // "+tamanho[4]);
				//  + trace("Width: "+image.width+" // "+tamanho[1]);
				if(image.height>tamanho[4]){
					image.y = -(Math.ceil((image.height-tamanho[4])/2));
				}else{
					image.height = tamanho[4];
					image.scaleX = image.scaleY;
					image.x = -(Math.ceil((image.width-tamanho[1])/2));
				};
			};
		};
		// ============================
		// Posição:
		if(ajustPos[2]=="left"){
			image.x = 0;
			image.y = 0;
		}
		/*
		if(ajustPos[2]=="center"){
			if(tamanho[0]=="width"){image.x = - Math.ceil((image.width-tamanho[1])/2);}
			if(tamanho[0]=="height"){image.y = - Math.ceil((image.height-tamanho[1])/2);}
		}
		if(ajustPos[2]=="center2"){
			if(tamanho[0]=="width"){image.x = - Math.ceil((image.width)/2);}
			if(tamanho[0]=="height"){image.y = - Math.ceil((image.height)/2);}
		}
		*/
		root[nome].x = ajustPos[0];
		root[nome].y = ajustPos[1];
		root[nome].addChild(image);
		
		Tweener.addTween(root[nome], {_color:color, time: 0,transition: "easeOutExpo",delay: 0});
		if(animacao.length>0){
			Tweener.addTween(root[nome], {x:animacao[0],y:animacao[1], time:animacao[3],transition: animacao[2],delay: animacao[4]});
		};
		root[nome].alpha=0;
		Tweener.addTween(root[nome], {alpha:1, time: 1,transition: "easeOutExpo",delay:animacao[4]});
		if(local.preloader){
			local.preloader.stop();
			local.preloader.visible=false;
		}
		if(callback!=null){
			callback();
		}
		if(consoleAPI==true){
			trace(" + Imagem carregada: "+url)
		}
	}
	function loadError(e:IOErrorEvent):void {
		trace("Não foi possível carregar: "+url)
	}
}