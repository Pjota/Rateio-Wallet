function corEscura(colour):Number{
    var rgb:Array = HexToRGB(colour);
	trace(Math.sqrt((rgb[0] * rgb[0] * 0.241) + (rgb[1] * rgb[1] * 0.691) + (rgb[2] * rgb[2] * 0.068) ) / 255)
    return Math.sqrt((rgb[0] * rgb[0] * 0.241) + (rgb[1] * rgb[1] * 0.691) + (rgb[2] * rgb[2] * 0.068) ) / 255;
}

function HexToRGB(hex:uint):Array{
    var rgb:Array = [];
    var r:uint = hex >> 16 & 0xFF;
    var g:uint = hex >> 8 & 0xFF;
    var b:uint = hex & 0xFF;
    rgb.push(r, g, b);
    return rgb;
}

function detectaCor(alvo){
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	var threshhold:Number = 0x77;
	var imagem:BitmapData = new BitmapData(alvo.width, alvo.height);
	imagem.draw(alvo);
	var pixel:Number;
	var r:Number;
	var g:Number;
	var b:Number;
	var numDark:int = 0;
	var numLight:int = 0;
	for (var row:int = 0; row < imagem.height; row++){
		for (var col:int = 0; col < imagem.width; col++){
			pixel = imagem.getPixel(col,row);
			r = (pixel & 0xFF0000) >> 16;
			g = (pixel & 0x00FF00) >> 8;
			b = pixel & 0x0000FF;
			if ((r < threshhold)&&(g < threshhold)&&(b < threshhold)){
				numDark++;
			}else{
				numLight++; 
			}
		}
	}
	if (numDark > numLight){
		return "escuro";
	}else{
		return "claro";
	}
}