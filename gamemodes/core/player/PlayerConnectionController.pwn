#include "utils/StringUtils.pwn"

public OnPlayerConnect(playerid) {
	new username[MAX_CPLAYER_NAME+1];
	if (GetPlayerName(playerid, username, sizeof(username)) && !stringUtils_isValidUsername(username)) {
		SendClientMessage(playerid, 0xA9C4E4FF, "Ry�ys su �aidimo serveriu nutruko. Netinkamas �aidimo slapyvard�io formatas.");
		SendClientMessage(playerid, 0xA9C4E4FF, "Slapyvard� turi sudaryti lotyni�kos raid�s su apatiniu bruk�neliu, perskiriantis �aidimo �sivaizduojam� vard� bei pavard�.");
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