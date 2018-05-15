function oblength(objeto){
	var total:uint = 0;
	for (var s:* in objeto)
	total++;
	return total;
}
function objlist(objeto){
	for (var x in objeto) {
		trace(x + ":  " + objeto[x]);
	}
}
function objToJson(objeto){
	var texto = "{";
	var value:Object;
	var qnt = oblength(objeto);
	var count = 0;
	for (var item in objeto) {
		count++;
		value = objeto[item];
		texto += '"'+item+'":"'+value+'"';
		if(count<qnt){texto += ','}
	} 
	texto += "}";
	return texto;
};