if(tipo[0]=="termos"){
	connectServer(false,"screen",servidor+"api/list/"+blast.list.table['termos']+"/produto="+blast.list.slug+",categoria="+tipo[1]+",order_column=versao,order_direct=DESC,page_limit=1",[
	],modal_termos);
	function modal_termos(dados){
		root["modal_titulo"] = new Titulo_Modal();
		root["modal_titulo"].y=40;
		root["modal_titulo"].titulo.htmlText="<font color='#"+corbt1+"'>"+dados.list[0].titulo+"</font>"
		root["modal_titulo"].texto.y+=20;
		root["modal_titulo"].texto.htmlText="<font color='#"+cortexto+"'><font color='#"+corcancel+"'>Versão: "+dados.list[0].versao+" ("+convertDataDiaMesHora(dados.list[0].cadastro)+")</font><br><br>"+dados.list[0].termo+"</font>";
		root["modal_titulo"].texto.selectable = true;
		root["modal_titulo"].texto.height = 470;
		root[nome].conteudo.addChild(root["modal_titulo"]);
	};
};