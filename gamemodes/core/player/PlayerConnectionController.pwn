#include "utils/StringUtils.pwn"

public OnPlayerConnect(playerid) {
	new username[MAX_CPLAYER_NAME+1];
	if (GetPlayerName(playerid, username, sizeof(username)) && !stringUtils_isValidUsername(username)) {
		SendClientMessage(playerid, 0xA9C4E4FF, "Ryðys su þaidimo serveriu nutruko. Netinkamas þaidimo slapyvardþio formatas.");
		SendClientMessage(playerid, 0xA9C4E4FF, "Slapyvardá turi sudaryti lotyniðkos raidës su apatiniu brukðneliu, perskiriantis þaidimo ásivaizduojamà vardà bei pavardæ.");
		SendClientMessage(playerid, 0xA9C4E4FF, "PAVYZDYS: {B9C9BF}Vardas_Pavarde");
		Kick(playerid);
		return;
	}
	player_loadData(playerid, dataOption:DATA_AUTH);
}

public OnPlayerDisconnect(playerid, reason) {
	player_saveData(playerid);
	//authUI_hide(playerid); Seems to be unused leftover for now.
}