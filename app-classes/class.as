// =============================================================
//                 ____  __           __ 
//                / __ )/ /___ ______/ /_
//               / __  / / __ `/ ___/ __/
//              / /_/ / / /_/ (__  ) /_  
//             /_____/_/\__,_/____/\__/  by level.EXPERT!
//             
// =============================================================
// B L A S T - Versão 1.0 // CLASSES


// =========================================
// # CARREGA CLASSES
// =========================================
// Stage / Display
include "stage.as";
include "pages.as";
include "caurina.as";
include "destroir.as";
include "protecao.as";

// Armazenamento:
include "cookies.as";

// Serviços Externos (Servidor):
include "connectserver.as";
include "controle_de_versao.as";
include "img_load.as";

// Componentes Simples:
include "titulos.as";
include "avatar.as";
include "buttons.as";
include "click.as";
include "inputs.as";
include "numbers.as";
include "labels.as";
include "localizacao.as";
include "icon_flag.as";
include "dragbar.as";
include "sexo.as";
include "textos.as";
include "data.as";
include "enderecos.as";
include "rangedate.as";
include "checkbox.as";
include "combobox.as";
include "lightbox.as";
include "icones.as";
include "inputs_ativa_desativa.as";
include "form_validate.as";
include "balao_infos.as";
include "listagem.as";
include "pagina_sem_conteudo.as";
include "notificacoes.as";
include "etapas.as";
include "cores.as";
include "thumbs.as";

// Componentes Avançados:
include "search_box.as";
include "codigo_ativacao.as";
include "gmaps.as";
include "camera_roll.as";

// Extras:
include "qrcode.as";

// Players + Previewers:
include "player_audio.as";
include "player_video.as";

// Modais:
include "modal.as";
include "modal_comunicacao.as";

// BG Functions:
include "bg_panel.as";
include "bg_waiting.as";

// Serviços Mobile
include "gestureworks.as";
include "swipe.as";

// Conversores de String:
include "string_decimal.as";
include "string_unidade.as";
include "string_valorreal.as";
include "string_data.as";
include "string_format.as";
include "string_time.as";

// Utilidades:
include "array.as"; // Conversões e funcionalidade ARRAY
include "datas.as"; // Comparação, diminuição
include "json.as"; // Conversões e funcionalidade JSON

// Tricks:
include "object.as";
include "var_dump.as";

// Android Componentes:
include "android.as";

// ::::::::::::::::::::::::::::::::::
// # TEMPLATES / MODULARES
// ::::::::::::::::::::::::::::::::::
// # SOCIAL
include "social_addFriend.as";
include "social_filterSearch.as";
include "social_likeButton.as";
include "social_shareButton.as";

// ::::::::::::::::::::::::::::::::::
// # TEMPLATES / BÁSICOS
// ::::::::::::::::::::::::::::::::::
include "../app-templates/login_simples.as";
include "../app-templates/cadastro_simples.as";
include "../app-templates/passoapasso_simples.as";
include "../app-templates/menu_superior_simples.as";
include "../app-templates/meusdados_simples.as";
include "../app-templates/meuendereco_simples.as";
include "../app-templates/sair_simples.as";
include "../app-templates/conta_bancaria.as";
include "../app-templates/chat_simples.as";
include "../app-templates/cartoes.as";
include "../app-templates/cartao_prepago.as";

// ::::::::::::::::::::::::::::::::::
// # TEMPLATES / ESPECÍFICOS
// ::::::::::::::::::::::::::::::::::
// Login
// Cadastro
// Passo a Passo
include "../app-templates/passoapasso_imgpanel.as";
// Menu Superior
// Menu Inferior
include "../app-templates/menu_inferior_instagram.as";
// Meus dados:
// Listagem
include "../app-templates/listagem_simples.as";

// ::::::::::::::::::::::::::::::::::
// # TEMPLATES / RECURSOS AVANÇADOS / Ferramentas
// ::::::::::::::::::::::::::::::::::
include "../app-templates/chat_whatsapp.as";

// =========================================
// # INICIA BLAST
// =========================================
include "init.as";
var onesignalappactive = false;
function iniciaBlast(){
	stage_bg();
	cookieInit(blast.list.infos.app_name_slug);
	controle_de_versao();
	//cookieDelete(); // <---- Deleta todas as informações salvadas em {SharedObject}
}
function rebootBlast(){
	stopServer();
	rebootBlastClear();
	stage_bg();
	controle_de_versao();
	root["menu_superior_alpha_status"] = false;
	root["menu_superior_alpha_logostatus"] = "";	
};





