function desativaInput(alvo){
	alvo.texto.selectable = false;
	alvo.texto.type = TextFieldType.DYNAMIC;
	alvo.texto.removeEventListener(FocusEvent.FOCUS_IN, alvo.addFocus);
	alvo.texto.removeEventListener(FocusEvent.FOCUS_OUT, alvo.removeFocus);
	Tweener.addTween(alvo, {alpha:.3, time: .6,transition: "easeOutExpo",delay: 0});
};
function desativaInputSemAlpha(alvo){
	alvo.texto.selectable = false;
	alvo.texto.type = TextFieldType.DYNAMIC;
	alvo.texto.removeEventListener(FocusEvent.FOCUS_IN, alvo.addFocus);
	alvo.texto.removeEventListener(FocusEvent.FOCUS_OUT, alvo.removeFocus);
};
function desativaCombo(alvo){
 alvo.alpha=.2;
}
function ativaInput(alvo){
	alvo.texto.selectable = true;
	alvo.texto.type = TextFieldType.INPUT;
	try{
	alvo.texto.addEventListener(FocusEvent.FOCUS_IN, alvo.addFocus);
	alvo.texto.addEventListener(FocusEvent.FOCUS_OUT, alvo.removeFocus);
	}catch(error:Error){}
	Tweener.addTween(alvo, {alpha:1, time: .6,transition: "easeOutExpo",delay: 0});
};
function desativaInputView(alvo){
	alvo.texto.selectable = false;
	alvo.texto.type = TextFieldType.DYNAMIC;
	try{
	alvo.texto.removeEventListener(FocusEvent.FOCUS_IN, alvo.addFocus);
	alvo.texto.removeEventListener(FocusEvent.FOCUS_OUT, alvo.removeFocus);
	}catch(error:Error){}
}