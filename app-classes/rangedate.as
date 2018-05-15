//-----------------------------------------------------------------
// INPUT: RANGE DATE
//-----------------------------------------------------------------
function criaRangeDate(nome,textos,local,posx,posy,scala,cores,datasInit,regras,active,callback,size){
	// ------------------
	// # Cria Date Range:
	if(size=="GG"){ root[nome] = new Input_RangeDate(); }
	if(size=="G"){}
	root[nome].ativo = false;
	root[nome].d_inicio = null;
	root[nome].d_final = null;
	root[nome].name = nome;
	root[nome].x = posx;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].scaleX = root[nome].scaleY = scala;
	Tweener.addTween(root[nome].fundo, {_color:"0x"+cores[0],time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].linha, {_color:"0x"+cores[1],time: 0,transition: "linear",delay: 0});
	root[nome].data_inicio_label.htmlText = "<font color='#"+cores[1]+"'>"+textos[0]+"</font>";
	root[nome].data_final_label.htmlText = "<font color='#"+cores[1]+"'>"+textos[1]+"</font>";
	criaIcon(nome+"_calendario",root[nome],blast.list.server.server_path+"/com/icones/calendar-with-spring-binder-and-date-blocks.png",18,18,25,"normal",["0x"+cores[3],null],["alpha","easeOutExpo",1]);
	if(datasInit!=null){
		setDatesRange(datasInit[0],datasInit[1]);
	}
	// ------------------
	// # Funções do Componente:
	root[nome].desativar = function (){
		Tweener.removeTweens(root[nome]);
		root[nome].alpha=.1;
	}
	root[nome].ativar = function (){
		var posy = root[nome].y;
		root[nome].y-=10;
		Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
		Tweener.addTween(root[nome], {y:posy,time: 1,transition: "easeOutElastic",delay: 0});
	}
	// ------------------
	// # Atualiza Datas:
	root[nome].setDates = function (data1,data2){
		setDatesRange(data1,data2)
	};
	function setDatesRange(data1,data2){
		if(data1!=undefined && data2!=undefined){
			trace(data1+"//"+data2);
			root[nome].d_inicio = data1;
			root[nome].d_final = data2;
			root[nome].data_inicio.htmlText = "<font color='#"+cores[2]+"'>"+convertDataDiaMes(data1)+"</font>";
			root[nome].data_final.htmlText = "<font color='#"+cores[2]+"'>"+convertDataDiaMes(data2)+"</font>";
		}
	}
	// ------------------
	// # Capturar Datas:
	root[nome].getDates = function (){
		return [root[nome].d_inicio,root[nome].d_final];
	};	
	// ------------------
	// # Cria Date Range:
	local.addChild(root[nome]);
	root[nome].alpha=0;
	Tweener.addTween(root[nome], {alpha:1,time: 1,transition: "easeOutExpo",delay: 0});
	// --------------------
	// # Click e Seleciona
	root[nome].addEventListener(MouseEvent.CLICK, criaRangeDate_Show);
	root[nome].buttonMode = true;
	function criaRangeDate_Show(e:MouseEvent):void {
		//trace("ABRE CALENDARIO")
		modal_abrir("criaRangeDate_ShowMV",["calendario","range",datasInit[0],regras,selecionaRageDate],"Calendário","Informe o intervalo entre data de início e fim para consultar suas atividades:",true,null,"G")
	}
	function selecionaRageDate(data1,data2){
		setDatesRange(data1,data2);
		callback(data1,data2);
	}
	
}