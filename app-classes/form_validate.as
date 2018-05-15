//-----------------------------------------------------------------
// VALIDAÇÃO DE CAMPOS / FORM
//-----------------------------------------------------------------
function validaCampos(nome,object,local){
	//trace("Valida - Total de campos: "+object.length)
	var itens = new Array();
	var item;
	var validacoes = new Array();
	for(var i=0; i<(object.length); i++){
		
		// required?
		if(object[i][5]=="required"){
			//trace(i+") tipo: "+object[i][0]);
			validacoes = new Array();
			for(var p=0; p<(object[i][6].length); p++){
				item = object[i][6][p].split("|");
				validacoes.push(item);
			}
			item = [nome+object[i][1],"Campo obrigatório:<br>"+object[i][0],validacoes,object[i][2]]
			itens.push(item);
			
		};
	};
	return validaCamposFunc(itens,local)
}
/*
	Exemplo de uso:
	var itens =[
		["CadNome","Informe seu Nome Completo",[
			["ContemString"," ","Informe seu nome completo"],
		],""]
	];
	var resposta = validaCampos(itens,localbalao)
*/
function validaCamposFunc(itens:Array,local){
	//trace("----------------------");
	var retorno = true;
	ForInit: for(var i=0; i<itens.length; i++){
		//trace(itens.length+") + Item: "+itens[i][3]);
		//------------ TEXTO + NUMERO
		if(itens[i][3]=="texto" || itens[i][3]=="numero" || itens[i][3]=="senha"){
			if(root[itens[i][0]].texto.text != root[itens[i][0]].valor){
				if(itens[i][2].length>0){
					for(var p=0; p<itens[i][2].length; p++){
						if(itens[i][2][p][0] == "minLgh" && root[itens[i][0]].texto.length<Number(itens[i][2][p][1])){
							newbalaoInfo(local[0],itens[i][2][p][2],local[1],local[2],"BalaoInfo","0x"+corcancel);
							retorno = false;
							return retorno;
							break ForInit;
							break;
						};
						if(itens[i][2][p][0] == "string" && root[itens[i][0]].texto.text.indexOf(itens[i][2][p][1])==-1){
							newbalaoInfo(local[0],itens[i][2][p][2],local[1],local[2],"BalaoInfo","0x"+corcancel);
							retorno = false;
							return retorno;
							break ForInit;
							break;
						};
					};
				};
			}else{
				newbalaoInfo(local[0],itens[i][1],local[1],local[2],"BalaoInfo","0x"+corcancel);
				retorno = false;
				return retorno;
				break;
			}
		}
		//------------ COMBOBOX / DRAGBAR
		if(itens[i][3]=="combobox" || itens[i][3]=="dragbar" || itens[i][3]=="localizacao"){
			if(root[itens[i][0]].valor>=1){
			}else{
				newbalaoInfo(local[0],itens[i][1],local[1],local[2],"BalaoInfo","0x"+corcancel);
				retorno = false;
				return retorno;
				break;
			}
		}
		
		//------------ DATAHORA
		if(itens[i][3]=="datahora"){
			if(root[itens[i][0]].getValue()!=null){
			}else{
				newbalaoInfo(local[0],itens[i][1],local[1],local[2],"BalaoInfo","0x"+corcancel);
				retorno = false;
				return retorno;
				break;
			}
		}
		
		//------------ CHECKBOX
		if(itens[i][3]=="checkbox"){
			if(root[itens[i][0]+"1"].valor==false){
				newbalaoInfo(local[0],itens[i][1],local[1],local[2],"BalaoInfo","0x"+corcancel);
				retorno = false;
				return retorno;
				break;
			}
		}
	}
	if(retorno == true){return retorno;}
}
//-----------------------------------------------------------------
// FORM / ARRAY
//-----------------------------------------------------------------
function formtoArray(dados,nome,compare){
	var review = false;
	if(compare!=null){
		var jsoncompare:Object;
		jsoncompare = JSON.parse(compare);
	}
	var array = [];
	var item = [];
	var valor = "";
	for(var i=0; i<dados.length; i++){
		if(review==true){trace("-------> "+dados[i][2])}
		if(dados[i][2]=="combobox" || dados[i][2]=="sexo" || dados[i][2]=="dragbar" || dados[i][2]=="localizacao"){
			valor = root[nome+dados[i][1]].valor
			if(compare==null){
				changeVerify([dados[i][1],valor]);
			}else{
				if(valor!=jsoncompare[dados[i][1]]){
					changeVerify([dados[i][1],valor]);
				}
			}
		}
		if(dados[i][2]=="checkbox"){
			valor = root[nome+dados[i][1]+"1"].valor2
			if(compare==null){
				changeVerify([dados[i][1],valor]);
			}else{
				if(String(valor)!=String(jsoncompare[dados[i][1]])){
					changeVerify([dados[i][1],valor]);
				}
			}
		}
		if(dados[i][2]=="datahora"){
			valor = root[nome+dados[i][1]].getValue();
			if(compare==null){
				changeVerify([dados[i][1],valor]);
			}else{
				if(String(valor)!=String(jsoncompare[dados[i][1]])){
					changeVerify([dados[i][1],valor]);
				}
			}
		}
		if(dados[i][2]=="texto" || dados[i][2]=="numero"){
			valor = root[nome+dados[i][1]].getValue()
			if(compare==null){
				changeVerify([dados[i][1],valor]);
			}else{
				if(valor!=jsoncompare[dados[i][1]]){
					changeVerify([dados[i][1],valor]);
				}
			}
		}
		if(dados[i][2]=="senha"){
			valor = root["CachePass2"];
			if(compare==null){
				changeVerify([dados[i][1],valor]);
			}else{
				trace("Tem senha? "+dados[i][2]+"//"+root["CachePass2"]);
				if(valor!=jsoncompare[dados[i][1]]){
					changeVerify([dados[i][1],valor]);
				}
			}
		}
	};
	function changeVerify(item){
		if(review==true){trace("Puxou: "+item);}
		array.push(item)
	}
	return array;
}