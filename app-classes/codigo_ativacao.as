//-----------------------------------------------------------------
// CÓDIGO DE ATIVAÇÃO: "Com Tempo"
//-----------------------------------------------------------------
function codigoAtivacao(nome,titulo,tipo,status,local,posx,posy,scala,cores,infos){
	
	var diferencaAtivacao;
	root["page_refresh_cancel_prevent_timer_close"] = true;
	
	// --------------
	// Configurações:
	if(tipo=="Tempo"){ root[nome] = new Codigo_Ativacao_Time();}
	root[nome].name = nome;
	root[nome].x = posx;
	if(posy is Number){
		root[nome].y = posy;
	}else{
		root[nome].y = (root[posy].y+root[posy].height)+10;
	}
	root[nome].scaleX = root[nome].scaleY = scala;
	Tweener.addTween(root[nome].borda, {_color:"0x"+cores[0], time: 0,transition: "linear",delay: 0});
	Tweener.addTween(root[nome].relogio, {_color:"0x"+cores[0], time: 0,transition: "linear",delay: 0});
	root[nome]['label'].htmlText = "<font color='#"+cores[0]+"'>"+titulo+"</font>";
	// ---------------------------
	// Status do código: "vencido":
	
	if(status=="valido"){
		root[nome].relogio.visible=false;
		root[nome].expira.htmlText="";
		root[nome].tempo.htmlText="";
		root[nome].x = posx+22;
		root[nome].codigo.htmlText = "<font color='#"+cores[1]+"'>"+blast.list[app].pages.meus_cupons.utilizacao[status]['status']+"</font>";
		root[nome].addEventListener(MouseEvent.CLICK, codigo_ativacao_ativar);
		root[nome].buttonMode = true;
		function codigo_ativacao_ativar(){
			root["page_refresh_cancel_prevent_timer_close"]=false;
			modal_abrir("codigo_ativacao_ativarAlert",["confirmacaoAlert","Ativar Cupom",corbt1,.8,codigo_ativacao_ativou],"Ativar Cupom","Ative o seu código no momento do pagamento na loja.<br>(O código ficará visível por 10 minutos)",true,codigo_ativacao_fechou,"PM")
		};
		function codigo_ativacao_fechou(){
			root["page_refresh_cancel_prevent_timer_close"]=true;
		}
		function codigo_ativacao_ativou(){
			var array = '{"uso":"{AGORA}"}';
			connectServer(false,"screen",servidor+"api/edit/d_usuarios_cupons/",[
			["id",infos['id'],"texto"],
			["json",array,"texto"],
			],ativandoCupom);
		}
	};
	if(status=="ativado"){
		connectServer(false,"screen",servidor+"api/list/d_usuarios_cupons/id="+infos['id'],[
		],ativandoCupom);
	};
	if(status=="vencido"){
		root[nome].relogio.visible=false;
		root[nome].expira.htmlText="";
		root[nome].tempo.htmlText="";
		root[nome].x = posx+22;
		root[nome].codigo.htmlText = "<font color='#"+cores[2]+"'>"+blast.list[app].pages.meus_cupons.utilizacao[status]['status']+"</font>";
	};
	if(status=="usado"){
		root[nome].codigo.htmlText = "<font color='#"+cores[3]+"'>"+blast.list[app].pages.meus_cupons.utilizacao[status]['status']+"</font>";
		root[nome].expira.htmlText="Usado:";
		root[nome].tempo.htmlText=convertDataDiaMesHora(infos['uso']);
	};
	
	// ---------------------------
	// Configura Animação Inicial:
	root[nome].borda.scaleX = 0
	root[nome].sombra.scaleX = 0
	root[nome]['label'].alpha=0
	root[nome].codigo.alpha=0;
	Tweener.addTween(root[nome].borda, {scaleX:1, time: 1,transition: "easeOutElastic",delay: 0});
	Tweener.addTween(root[nome].sombra, {scaleX:1, time: 1,transition: "easeOutElastic",delay: 0});
	Tweener.addTween(root[nome]['label'], {alpha:1, time: 1,transition: "easeOutExpo",delay: 1});
	Tweener.addTween(root[nome].codigo, {alpha:1, time: 1,transition: "easeOutExpo",delay: 1});
	// ----------
	// Aplicação:
	local.addChild(root[nome]);
	
	// =================================
	// ATIVAÇÃO: Função de Ativar cupom:
	// =================================
	function ativandoCupom(dados){
		
		// # Guarda informações de gravação:
		root["cupom_ativado"] = dados;
		
		// # Desativa botões da tela:
		try{
		root[nome].removeEventListener(MouseEvent.CLICK, codigo_ativacao_ativar);
		root[nome].buttonMode = false;
		}catch(error:Error){}
		
		// # Calculo de tempo diferenciado para: "Ativado Agora" + "Já ativado"
		if(status=="valido"){
			diferencaAtivacao = (infos.id_d_cupom['duracao_minutos']*60)-diffSeconds(root["AGORA"],dados.list['uso']);
		};
		if(status=="ativado"){
			diferencaAtivacao = infos['ativacao_prazo_segundos'];
		};
		
		// # Se já expirou "Fecha Cupom", caso não ativa contagem:
		trace("diferencaAtivacao: "+diferencaAtivacao)
		if(diferencaAtivacao>0){
			if(root["timer_blast"]){root["timer_blast"].stop();}
			root["timer_blast"] = new Timer(1000, diferencaAtivacao); 
			root["timer_blast"].addEventListener(TimerEvent.TIMER, codigo_contagem); 
			root["timer_blast"].addEventListener(TimerEvent.TIMER_COMPLETE, codigo_contagem_complete);
			root["timer_blast"].start();
			root[nome].relogio.visible=true;
			root[nome].codigo.htmlText = "<font color='#"+cores[4]+"'>"+infos['codigo']+"</font>";
			root[nome]['label'].htmlText = "<font color='#"+cores[4]+"'>"+titulo+"</font>";
			root[nome].expira.htmlText = "<font color='#"+cores[4]+"'>Expira:</font>";
			Tweener.addTween(root[nome], {x:posx, time: .5,transition: "easeOutExpo",delay: 0});
			Tweener.addTween(root[nome].relogio, {_color:"0x"+cores[4], time: 1,transition: "easeOutExpo",delay: 0});
			Tweener.addTween(root[nome].borda, {_color:"0x"+cores[4], time: 1,transition: "easeOutExpo",delay: 0});
		}else{
			completou(dados);
		}
		root[nome].tempo.htmlText=convertSecondsToTime(diferencaAtivacao-root["timer_blast"].currentCount);
	};
	// =================================
	// TIMER: Configurações de Contagem:
	// =================================
	// # Contagem "Ticker"
	function codigo_contagem(event:TimerEvent):void{
		root[nome].tempo.htmlText=convertSecondsToTime(diferencaAtivacao-root["timer_blast"].currentCount);
	};
	// # Completou "Acesso"
	function codigo_contagem_complete(event:TimerEvent):void{ 
		completou()
	};
	// # Completou "Função de Expirar" {Fecha Código de Cupom}
	function completou(){
		
		root[nome].codigo.htmlText = "<font color='#"+cores[3]+"'>USADO</font>";
		root[nome].expira.htmlText="Usado:";
		if(status=="valido"){
			root[nome].tempo.htmlText=convertDataDiaMesHora(root["cupom_ativado"].list['uso']);
		};
		if(status=="ativado"){
			root[nome].tempo.htmlText=convertDataDiaMesHora(infos['uso']);
		};
		root[nome]['label'].htmlText = "<font color='#"+cores[3]+"'>"+titulo+"</font>";
		Tweener.addTween(root[nome].borda, {_color:"0x"+cores[3], time: 1,transition: "easeOutExpo",delay: 0});
		Tweener.addTween(root[nome].relogio, {_color:"0x"+cores[3], time: 1,transition: "easeOutExpo",delay: 0});
		root["page_refresh_in_modal_close"]=true;
	};
}