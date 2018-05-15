// ====================================================
// CÓDIGO DE VALIDAÇÃO: BARCODE128 / QRCODE
// ====================================================
function qrcode_view(local,codigoQR,posx,posy,size){
	var array = [];
	array.push(["codigo",codigoQR])
	connectServer(false,"screen",servidor+"api/qrcode/google",[
	["json",json(array),"texto"],
	],getQR);
	function getQR(dados){
		root["qrcode"] = new square_button_center();
		root["qrcode"].x = posx;
		root["qrcode"].y = posy;
		root["qrcode"].alpha=0;
		root["qrcode"].scaleX = root["qrcode"].scaleY = 0;
		local.addChild(root["qrcode"]);
		Tweener.addTween(root["qrcode"], {width:size, height:size, time: 1,transition: "easeOutElastic",delay: 0});
		Tweener.addTween(root["qrcode"], {alpha:1, time: 1,transition: "easeOutExpo",delay: 0});
		img_load("qrcode_imagem",dados.list[0].qrcode_absolute,root["qrcode"],["width",72],null,[-36,-38,"center"],[],0,null);
		root["qrcode"].addEventListener(MouseEvent.MOUSE_DOWN,qrcode_zoom);
		function qrcode_zoom(e:MouseEvent):void {
			lightbox_open("qrcode_lightbox",["0x"+cortexto,.95],dados.list[0].qrcode_absolute)
		};
	};
};