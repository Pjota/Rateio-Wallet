// INICIO: Chama Json do Servidor para Montar o Arquivo:
var blast;
var layout;
var cor_bg1;
var cor_bg2;
var cortexto;
var cortitulos;
var corsubtitulos;
var corbt1;
var corbt2;
var coricon;
var corcancel;
var corbtnormalbg;
var corbtnormalicone;
var corbtcliquebg;
var corbtcliqueicone;
var corbtnormalmenuibg;
var corbtnormalmenuiicone;
var corbtovermenuibg;
var corbtovermenuiicone;
var cordetalhemenus;

// Variáveis Iniciais: {MENU SUPERIOR}
var cor_menu_superior_normal_bg;
var cor_menu_superior_normal_icone;
var cor_menu_superior_normal_texto;
var cor_menu_superior_over_bg;
var cor_menu_superior_over_icone;
var cor_menu_superior_over_texto;

// Layout:
var logonormal;
var logobranca;
var nome;
var capa;
var login_bg;
var login_icone;
var cadastro_img
var cadastro_bg;
var cadastro_pendente;
var cadastro_saque_bloqueado;
var cartao_prepago_foto;

// Inicia Projeto:
connectServer(false,"screen", servidorConfig, [
["masterkey", projectkey, "texto"],
["version", versaoapp, "texto"]
],retornoInit);

function retornoInit(dados) {
	blast = dados;
	// ========================
	// Existe uma configuração:
	// ========================
	root["layout_dinamico"] = "";
	var link = servidor+"api/list/"+blast.list.table['templates']+"/p_id="+clienteID;
	trace(link)
	connectServer(false,"screen", link, [
	
	["free", "true", "texto"]
	],retornoLayout);
	function retornoLayout(dados){
		// Chama tudo para layout:
		layout = dados.list[0];
		// # Cores destinadas ao App:
		cor_bg1 = dados.list[0].cor_bg1;
		cor_bg2 = dados.list[0].cor_bg2;
		cortexto = dados.list[0].cor_texto;
		cortitulos = dados.list[0].cor_titulo;
		corsubtitulos = dados.list[0].cor_subtitulo;
		corbt1 = dados.list[0].cor_bt1;
		corbt2 = dados.list[0].cor_bt2;
		coricon = dados.list[0].cor_icon;
		corcancel = dados.list[0].cor_cancel;
		// # Cored destinadas ao Submenu:
		corbtnormalbg = dados.list[0].cor_menu_normal_bg;
		corbtnormalicone = dados.list[0].cor_menu_normal_icone;
		corbtcliquebg = dados.list[0].cor_menu_over_bg;
		corbtcliqueicone = dados.list[0].cor_menu_over_icone;
		// # Cores do Menu Inferior:
		corbtnormalmenuibg = dados.list[0].cor_menu_inferior_normal_bg;
		corbtnormalmenuiicone = dados.list[0].cor_menu_inferior_normal_icone;
		corbtovermenuibg = dados.list[0].cor_menu_inferior_over_bg;
		corbtovermenuiicone = dados.list[0].cor_menu_inferior_over_icone;
		// # Cores do Menu Superior (Hamburguer)
		cor_menu_superior_normal_bg = dados.list[0].cor_menu_superior_normal_bg;
		cor_menu_superior_normal_icone = dados.list[0].cor_menu_superior_normal_icone;
		cor_menu_superior_normal_texto = dados.list[0].cor_menu_superior_normal_texto;
		cor_menu_superior_over_bg = dados.list[0].cor_menu_superior_over_bg;
		cor_menu_superior_over_icone = dados.list[0].cor_menu_superior_over_icone;
		cor_menu_superior_over_texto = dados.list[0].cor_menu_superior_over_texto;
		// # Extras:
		cordetalhemenus = dados.list[0].cor_menus_detalhe;
		// # Nome + Logo + Imagens
		nome = dados.list[0].nome;
		logonormal = dados.list[0].logo;
		logobranca = dados.list[0].logo_branca;
		capa = dados.list[0].capa;
		cadastro_bg = dados.list[0].shop_app_cadastro_bg;
		// # Login
		login_bg = dados.list[0].login_bg;
		login_icone = dados.list[0].login_icone;
		// # Cadastro
		cadastro_img = dados.list[0].cadastro_img;
		cadastro_pendente = dados.list[0].cadastro_pendente;
		cadastro_saque_bloqueado = dados.list[0].cadastro_saque_bloqueado;
		// # Cartão Pre-Pago
		cartao_prepago_foto = dados.list[0].cartao_prepago;
		// # Init:
		iniciaBlast();
	}
};