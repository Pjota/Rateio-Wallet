function array_search(str,array) {
    for(var i=0; i < array.length; i++){
        if(array[i] == str){
            return i;
        }
    }
    return -1;
}
function array_string(strInit,array,strEnd,divisor) {
	var texto = strInit;
    for(var i=0; i < (array.length-1); i++){
       texto+=array[i]+divisor;
    };
	texto += array[i]+strEnd;
    return texto;
}

