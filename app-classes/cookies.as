//-----------------------------------------------------------------
// COOKIES: Gravação de infos no Dispositivo via SharedObjetc
var mySharedObject:SharedObject;
function cookieInit(appname){
	mySharedObject = SharedObject.getLocal(appname);
	//mySharedObject.clear();
}
function cookieDelete(){
	mySharedObject.clear();
}

