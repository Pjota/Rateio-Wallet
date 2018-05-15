function comparaDatas(data1,data2,retorno){
	return "x";
}
function data_atraso(data,retorno){
	data = data.split("-").join("/");
	var date1:Date = new Date(data);
}
function diffAnos(maior,menor){
	var dateMaior:Date = StringToDate(maior);
	var dateMenor:Date = StringToDate(menor);
	var one_day:Number = 1000 * 60 * 60 * 24
	var date1_ms:Number = dateMaior.getTime();
	var date2_ms:Number = dateMenor.getTime();		    
	var difference_ms:Number = Math.abs(date1_ms - date2_ms)		    
	return Math.round((difference_ms/one_day)/365);
}
function diffSeconds(maior,menor){
	var pattern:RegExp = / /g;
	var maior = maior.replace(pattern,"");
	var menor = menor.replace(pattern,"");
	pattern = /:/g;
	maior = maior.replace(pattern,"");
	menor = menor.replace(pattern,"");
	pattern = /-/g;
	maior = maior.replace(pattern,"");
	menor = menor.replace(pattern,"");
	trace(maior+" / "+menor)
	return (maior-menor);
}
function StringToDate(dataStr) {
    var full = dataStr.split(" ");
	var year = full[0].split("-");
	var hour = full[1].split(":");
	var data:Date = new Date(year[0],year[1],year[2],hour[0],hour[1]);
	return data;
}
function meia_em_meia_hora(data,formatter){
	var dataFinal
	var minutos = int(data.substr(14,2));
	if(minutos<=30){
		dataFinal = data.substr(0,13)+":30:00";
	}else{
		dataFinal = data.substr(0,13)+":00:00";
		var date = StringToDate(dataFinal);
		var date1_ms:Number = date.getTime();
		var novo_horario = new Date(date1_ms);
		novo_horario.month-=1;
		novo_horario.hours+=1;
		var dtf:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);
		dtf.setDateTimePattern(formatter);
		dataFinal = dtf.format(novo_horario);
	}
	return dataFinal;
}
function meia_em_meia_hora_list(data,regra,formatter){
	// Variáveis Iniciais:
	var lista = [];
	// Informações e formatações do Horário Atual:
	var somentehora:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);
	somentehora.setDateTimePattern("HHmm");
	var dataAtual = StringToDate(data);
	var dataAtual_number:Number = dataAtual.getTime();
	var dataAtual_date = new Date(dataAtual_number);
	var horario = somentehora.format(dataAtual_date);
	// Informações e formatações da listagem de Horários:
	var dtf:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);
	dtf.setDateTimePattern(formatter);
	var datas = StringToDate(meia_em_meia_hora(data,"yyyy-MM-dd HH:mm:ss"));
	var datas_number:Number = datas.getTime();
	var datas_date = new Date(datas_number);
	datas_date.month-=1;
	var total = Math.floor((2400-horario)/50);
	lista.push(dtf.format(datas_date))
	for(var i=0; i<(total-2); i++){
		datas_date.minutes+=30;
		lista.push(dtf.format(datas_date))
	};
	return lista;
}