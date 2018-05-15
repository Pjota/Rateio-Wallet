

import com.milkmangames.nativeextensions.*;
import com.milkmangames.nativeextensions.events.*;

function easypushstart(onesignalappid,projectnumber){
	if(root["onesignal_init"]!=true){
		EasyPush.initOneSignal(onesignalappid,projectnumber,true);
		root["onesignal_init"]=true;
	};
};

function easypushinit(email, id){
	if(EasyPush.isSupported() && EasyPush.areNotificationsAvailable()){
		EasyPush.oneSignal.setTags({userEmail:email, userID:id});
		EasyPush.oneSignal.addEventListener(PNOSEvent.TOKEN_REGISTERED,onTokenRegistered);
	}else{
		trace("Não funciona em PC");
		try{root["retorno"].text = "Não funciona em PC";
		}catch(error:Error){}
	};
};

function onTokenRegistered(e:PNEvent):void{
	var device = e.token;
	atualizaToken(device)
};

function atualizaToken(tokenString){
	root["retorno"].text = "Token: "+tokenString;
	var json = '{"push_device_id":"'+tokenString+'"}';
	connectServer(false,"screen",servidor+"api/edit/blast_sessoes/id="+root["User"]['sessao']['id'],[
	["json",json,"texto"],
	["id", root["User"]['id'],"texto"]
	],device_token_atualizando);
	function device_token_atualizando(dados){
		root["retorno"].text = tokenString+" >>>> Retorno: "+dados.list.retorno;
		EasyPush.oneSignal.setTags({token:tokenString});
	};
}
