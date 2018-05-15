//-----------------------------------------------------------------
// GMAPS - GEOLOCALIZAÇÃO
// # GEOCODE (Endereço <-> Coordenada)
//-----------------------------------------------------------------
function gmaps_componentes(valor,json){
	var qnt_componentes = json.list.localizacao.address_components.length;
	var info = null;
	for(var i=0; i<qnt_componentes; i++){
		if(json.list.localizacao.address_components[i]['types'].indexOf(valor)>=0){
			info = json.list.localizacao.address_components[i].long_name;
			break;
		}
	}
	return info;
};
