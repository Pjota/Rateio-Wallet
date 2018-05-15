function objeto(array){
	var o:Object = new Object();
	for(var i:int = 0; i < array.length; i++) {
		o[array[i][0]] = array[i][1];	
	} 
	return o;
};
function json(array){
	var texto = "{";
	for(var i:int = 0; i < array.length; i++) {
		texto += '"'+array[i][0]+'":"'+array[i][1]+'"';
		if(i<(array.length-1)){texto += ','}
	} 
	texto += "}";
	return texto;
};
function json_ids(lista,sub,alvo){
	var array = [];
	for(var i=0; i < lista.length; i++) {
		if(sub==""){
			array.push(lista[i][alvo]);
		}else{
			if(sub.indexOf("id_usuarios__alvo")>=0){
				if(lista[i][sub][alvo]==root["User"]['id']){
					array.push(lista[i]["id_usuarios"][alvo]);
				}else{
					array.push(lista[i][sub][alvo]);
				}
			}else{
				array.push(lista[i][sub][alvo]);
			}
			
		}
		
	}
	return array;
}
