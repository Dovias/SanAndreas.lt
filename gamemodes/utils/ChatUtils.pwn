stock chatUtils_clearChat(playerid) {
	if (!IsPlayerConnected(playerid)) {
		return;
	}
	for (new i = 0; i < 100; i++) {
		SendClientMessage(playerid, 0xFFFFFFF, "");
	}
}