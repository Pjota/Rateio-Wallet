// -------------------------------------
// MODAIS DE COMUNICAÇÃO
// -------------------------------------
function modal_comunicacao_start(dados,callback){
	var total_modals = dados.list.length;
	if(total_modals>0){
		var actual_modal  = 0;
		var link;
		// -----------
		// Abre Modal:
		function open(){
			actual_modal++;
			// # Verifica a quantidade que o cliente já viu este Modal:
			link = servidor+"api/list/blast_modals_confirmacao/tabela="+root["User"]['table']+",id_responsavel="+root["User"]['id']+",id_blast_modals="+dados.list[actual_modal-1]['id'];
			connectServer(false,"screen",link,[
			],verifica_modal_view);
		};
		function verifica_modal_view(retorno){
			if(retorno.list.length==0){
				// # Cálculo para Tamanho do modal:
				var tam = "G";
				// # Abre modal de notificação:
				modal_abrir("modal_popup",["111"],"Título de Modal","Descrição é aqui",true,proximo,"G");
			}else{
				proximo();
			}
		};
		open();
		// --------------------------
		// # Carrega o Próximo Modal:
		function proximo(){
			if(actual_modal<total_modals){
				open();
			}else{
				callback();
			}
		};
	}else{
		callback();
	}
	// 
};