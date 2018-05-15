// ==============================================
// DATA: INPUT : DataInput
// ==============================================
function criaData(nome,titulo,local,posx,posy,scala){
	root[nome] = new Input_Data();
	root[nome].name = nome;
	root[nome].diaValor = null;
	root[nome].valor = null;
	root[nome].x = posx;
	root[nome].titulo = titulo;
	root[nome].infos['line'].visible=false;
	root[nome].infos.nome1.width=242;
	root[nome].infos.dia.width=242;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].scaleX = root[nome].scaleY = scala;
	// Configuração Inicial
	Tweener.addTween(root[nome].molde, {_color:"0x"+corbt1, time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].icone, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
	root[nome].infos.nome1.htmlText="<font color='#"+corbt1+"'>"+titulo+"</font>";
	root[nome].infos.nome2.htmlText="";
	root[nome].infos.dia.htmlText="<font color='#"+cortexto+"'>Selecione</font>";
	root[nome].infos.hora.htmlText="";
	root[nome].infos.nome = nome;
	local.addChild(root[nome]);
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	root[nome].infos.addEventListener(MouseEvent.CLICK, criaData_open);
	function criaData_open(e:Event):void {
		connectServer(false,"screen",servidor+"api/time",[
		],criaData_open_getHour);
	}
	function criaData_open_getHour(dados){
		var datasInit = [dados.head['print']]
		modal_abrir("criaRangeDate_ShowMV",["calendario","data",datasInit[0],"futuro",criaData_esc],"Calendário","Selecione a data desejada:",true,null,"G")
	};
	function criaData_esc(data,diadasemana){
		root[nome].diaValor = data;
		root[nome].infos.dia.htmlText="<font color='#"+cortexto+"'>"+convertDataDiaMes(data)+" ("+diadasemana+")</font>";
	};
	root[nome].getValue = function(){
		if(root[nome].diaValor!=null){
			root[nome].valor = removeHoras(root[nome].diaValor)+" 00:00:00";
		}else{
			root[nome].valor = null;
		}
		return root[nome].valor;
	}
}
// ==============================================
// DATA e HORA: INPUT : DataHoraInput
// ==============================================
function criaDataHora(nome,titulo,local,posx,posy,scala){
	root[nome] = new Input_Data();
	root[nome].name = nome;
	root[nome].diaValor = null;
	root[nome].horaValor = null;
	root[nome].valor = null;
	root[nome].x = posx;
	root[nome].titulo = titulo;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].scaleX = root[nome].scaleY = scala;
	// Configuração Inicial
	Tweener.addTween(root[nome].molde, {_color:"0x"+corbt1, time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].icone, {_color:"0xffffff", time: 0,transition: "linear",delay: 0});
	root[nome].infos.nome1.htmlText="<font color='#"+corbt1+"'>"+titulo[0]+"</font>";
	root[nome].infos.nome2.htmlText="<font color='#"+corbt1+"'>"+titulo[1]+"</font>";
	root[nome].infos.dia.htmlText="<font color='#"+cortexto+"'>Selecione</font>";
	root[nome].infos.hora.htmlText="<font color='#"+cortexto+"'>--/--</font>";
	root[nome].infos.nome = nome;
	root[nome].infos.addEventListener(MouseEvent.CLICK, criaData_open);
	// Carrega Combobox de horários:
	function montaHorarios(){
		var combo:Object = new Object();
		combo.list = [];
		var item:Object = new Object();
		var horaString;
		for(var i=0; i<24; i++){
			if(i<10){
				horaString = "0"+i;
			}else{
				horaString = i;
			}
			item = {id:horaString+":00", nome:horaString+":00"}
			combo.list[i];
			combo.list[i] = item;
		};
		return combo;
	}
	criaCombobox(nome+"_hora","Modal_","Hora","",root[nome],0,0,1,"objeto","","","",["0xc9fff5","0x202020"],null,montaHorarios,criaHora_atualiza);
	root["Modal_Hora"].width=root[nome].infos.hora.width
	root["Modal_Hora"].x=root[nome].infos.hora.x+root[nome].infos.x
	Tweener.removeTweens(root["Modal_Hora"]);
	root["Modal_Hora"].alpha=0;
	local.addChild(root[nome]);
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	// Funções: DATA
	function criaData_open(e:Event):void {
		connectServer(false,"screen",servidor+"api/time",[
		],criaData_open_getHour);
	}
	function criaData_open_getHour(dados){
		var datasInit = dados.head['print']
		trace(datasInit);
		modal_abrir("criaRangeDate_ShowMV",["calendario","data",datasInit,"futuro",criaData_esc],"Calendário","Selecione a data desejada:",true,null,"G")
		
	};
	function criaData_esc(data,diadasemana){
		root[nome].diaValor = data;
		root[nome].infos.dia.htmlText="<font color='#"+cortexto+"'>"+convertDataDiaMes(data)+" ("+diadasemana+")</font>";
	};
	// Funções: HORA
	function criaHora_atualiza(info){
		root[nome].horaValor = root["Modal_Hora"].valor;
		root[nome].infos.hora.htmlText="<font color='#"+cortexto+"'>"+root["Modal_Hora"].valor+"</font>";
	}
	// Busca valor:
	root[nome].getValue = function(){
		if(root[nome].diaValor!=null && root[nome].horaValor!= null){
			root[nome].valor = removeHoras(root[nome].diaValor)+" "+root[nome].horaValor+":00";
		}else{
			root[nome].valor = null;
		}
		return root[nome].valor;
	}
	
};
// ==============================================
// HORA: Com estilo relógio Digital
// ==============================================
function criaHora(nome,data_valor,local,posx,posy,scala,cores){
	root[nome] = new Input_Hora();
	root[nome].name = nome;
	root[nome].x = posx;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].scaleX = root[nome].scaleY = scala;
	// Configuração Inicial :  Aparência
	Tweener.addTween(root[nome].bolas, {_color:"0x"+corbt1, time: 0,transition: "linear",delay: 0});
	for(var i=1; i<=4; i++){
		Tweener.addTween(root[nome]['numero_'+i].fundo, {_color:"0x"+corbt1, alpha:.3, time: 0,transition: "linear",delay: 0});
		root[nome]['numero_'+i].posy = root[nome]['numero_'+i].y;
		root[nome]['numero_'+i].y+=10;
		root[nome]['numero_'+i].alpha=0;
		Tweener.addTween(root[nome]['numero_'+i], {y:root[nome]['numero_'+i].posy, alpha:1, time: 1,transition: "easeOutElastic",delay: 0});
	}
	local.addChild(root[nome]);
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	// COnfigurações de Horário:
	root[nome].setHorario = function(data){
		var numeros = [
			data.substr(11,1),
			data.substr(12,1),
			data.substr(14,1),
			data.substr(15,1)
		]
		for(var i=1; i<=4; i++){
			root[nome]['numero_'+i].texto.htmlText = "<font color='#"+cortexto+"'>"+numeros[i-1]+"</font>"
		}
	}
	root[nome].setHorario(data_valor)
}
