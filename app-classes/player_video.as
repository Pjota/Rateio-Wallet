
// # Arquivos para Player de Vídeo MP4 (iOS + Android)
import flash.filesystem.*;
import com.myflashlab.air.extensions.player.VideoPlayer;
import com.myflashlab.air.extensions.player.VideoType;

// # Importação do Youtube Parser Link:
import com.doitflash.remote.youtube.YouTubeLinkParser;
import com.doitflash.remote.youtube.YouTubeLinkParserEvent;
import com.doitflash.remote.youtube.VideoType;
import com.doitflash.remote.youtube.VideoQuality;

function play_mp4(local,arquivo_url,posx,posy,acao){
	
	// # Variáveis Iniciais: 
	var _ex:VideoPlayer = new VideoPlayer();
	var vid:File = File.documentsDirectory.resolvePath("exVideoPlayer.mp4");

	// # Cria local do Player:
	root["player_mp4"] = new Vazio();
	root["player_mp4"].x = posx;
	root["player_mp4"].y = posy;
	local.addChild(root["player_mp4"]);
	
	// # Cria Player:
	criaIcon("player_mp4_load", root["player_mp4"], blast.list.server.server_path+"/com/icones/youtube-logo.png",0,0,100,"normal",["0x"+corbt1,"0x"+corbt1],["alpha","easeOutExpo",1]);
	root["player_mp4_load"].addEventListener(MouseEvent.CLICK, player_play_click);
	function player_play_click(e:MouseEvent):void {
		player_play();
	};
	function player_play(){
		_ex = new VideoPlayer();
		vid = File.documentsDirectory.resolvePath("exVideoPlayer.mp4");
		_ex.play(blast.list[app].paths.upload_path+"/videos/"+arquivo_url, VideoType.ON_LINE);
	};
	if(acao=="play"){
		player_play()
	};
	
};