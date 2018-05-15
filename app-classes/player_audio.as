import flash.media.SoundChannel;

//-----------------------------------------------------------------
// PLAYER AUDIO MUSIC
// + 
// Variáveis Iniciais:
root["audio"] = new Sound();
root["audio_canal"] = new SoundChannel();

function play_mp3(local,arquivo_url,posx,posy){
	
	// # Cria local do Player:
	root["player_mp3"] = new Vazio();
	root["player_mp3"].x = posx;
	root["player_mp3"].y = posy;
	local.addChild(root["player_mp3"]);
	// # Cria Player:
	criaIcon("player_mp3_load", root["player_mp3"], blast.list.server.server_path+"/com/icones/refresh-page-option.png",0,0,100,"bullet",["0xffffff","0xc3c3c3"],["alpha","easeOutExpo",1]);
		
	// # Funções:
	var req:URLRequest = new URLRequest(blast.list[app].paths.upload_path+"/audios/"+arquivo_url); 
	root["audio"] = new Sound();
	
	var currentIndex:int = 0;
	root["audio"].addEventListener(Event.COMPLETE, onMp3LoadComplete);
	root["audio"].load(req);
	function onMp3LoadComplete(e:Event):void{
		root["audio"].removeEventListener(Event.COMPLETE, onMp3LoadComplete);
		player_play();
	};
	function onSoundChannelSoundComplete(e:Event):void{
		e.currentTarget.removeEventListener(Event.SOUND_COMPLETE, onSoundChannelSoundComplete);
		root["audio"].addEventListener(Event.COMPLETE, onMp3LoadComplete);
		player_stop();
	};
	// --------------------------------------
	function player_stop_click(e:MouseEvent):void {
		player_stop();
	}
	function player_stop(){
		root["audio_canal"].stop();
		root["player_mp3_stop"].removeEventListener(MouseEvent.CLICK, player_stop);
		destroir(root["player_mp3"],false);
		criaIcon("player_mp3_play", root["player_mp3"], blast.list.server.server_path+"/com/icones/player_play.png",0,0,100,"bullet",["0xffffff","0x"+corbt1],["alpha","easeOutExpo",1]);
		root["player_mp3_play"].addEventListener(MouseEvent.CLICK, player_play_click);
	};
	function player_play_click(e:MouseEvent):void {
		player_play();
	}
	function player_play(){
		destroir(root["player_mp3"],false);
		criaIcon("player_mp3_stop", root["player_mp3"], blast.list.server.server_path+"/com/icones/player_stop.png",0,0,100,"bullet",["0xffffff","0x"+corbt1],["alpha","easeOutExpo",1]);
		root["player_mp3_stop"].addEventListener(MouseEvent.CLICK, player_stop_click);
		root["audio_canal"] = root["audio"].play();
		root["audio_canal"].addEventListener(Event.SOUND_COMPLETE, onSoundChannelSoundComplete);
	}
};
