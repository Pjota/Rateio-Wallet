var valor;
var pass;
var senha;
var input = this;
var corinicial;
var alphaText = .4

texto.addEventListener(FocusEvent.FOCUS_IN, addFocus);
texto.addEventListener(FocusEvent.FOCUS_OUT, removeFocus);

function addCor(){
	texto.alpha = alphaText;
}
function show(){
	texto.alpha = 1;
}
function newFont(qual){
	gotoAndStop(qual);
}
function desactive(){
	texto.removeEventListener(FocusEvent.FOCUS_IN, addFocus);
	texto.removeEventListener(FocusEvent.FOCUS_OUT, removeFocus);
}

function addFocus(e:FocusEvent) {
	texto.alpha = 1;
	if(MovieClip(root).dispositivo=="android"){
		trace("Android Ativo")
		MovieClip(root).Android_MovieStage(input,true);
	}
	if(texto.text == valor){
		if(pass==true){
			texto.displayAsPassword = true;
		}
		texto.text = "";
	}else{
		if(pass==true){
			texto.text = "";
			texto.displayAsPassword = true;
		}
	}
}
function removeFocus(e:FocusEvent) {
	if(MovieClip(root).dispositivo=="android"){
		MovieClip(root).Android_MovieStage(input,false);
	}
	if(texto.text == ""){
		if(pass==true){
			if(root["CachePass2"]!="" && root["CachePass2"]!=undefined){
				texto.text = root["CachePass2"];
				texto.displayAsPassword = true;
			}else{
				texto.text = valor;
				texto.alpha = alphaText;
				texto.displayAsPassword = false;
			}
		}else{
			texto.text = valor;
			texto.alpha = alphaText;
			texto.displayAsPassword = false;
		}
		
	}else{
		if(pass==true){
			removeFocusPassword();
		}
	}
}
function removeFocusPassword(){
	root["CachePass2"] = texto.text;
	senha = texto.text;
	texto.displayAsPassword = false;
	var novasenha=""
	for(var i=0; i<texto.text.length; i++){
		novasenha = novasenha+"*";
	}
	texto.text=novasenha;
}
function invisible(){
	feedback.visible=false;
	relevo.visible=false;
}
function setText(text){
	if(text == valor){
		texto.alpha = alphaText;
		texto.text = text;
	}else{
		if(text==""){
			texto.alpha = alphaText;
			texto.text = text;
		}else{
			texto.alpha = 1;
			texto.text = text;
		}
	}
}
function getValue(){
	if(texto.text != valor){
		return texto.text;
	}else{
		return "";
	}
}