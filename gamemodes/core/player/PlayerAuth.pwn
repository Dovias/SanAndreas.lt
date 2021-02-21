#include "core/player/PlayerData.pwn"


stock player_isRegistered(playerid) {
	return isNull(sPlayerData[playerid][hashedPass]) ? false : true;
}

stock player_isAuthenticating(playerid) {
	return serverWorld:GetPlayerVirtualWorld(playerid) == serverWorld:WORLD_AUTH ? true : false;
}

stock player_auth(playerid, password[]) {
	new length = strlen(password);
	if (isNull(password) || length < MIN_PASSWORD || length > MAX_PASSWORD || !IsPlayerConnected(playerid)) {
		return false;
	}
	new hash[MAX_HASH_LENGTH];
	SHA256_PassHash(password, "2&[:`I&<T<}/YtS", hash, sizeof(hash));
	if (player_isRegistered(playerid)) {
		if (strcmp(sPlayerData[playerid][hashedPass], hash, true, sizeof(hash)) == 0) {
			return true;
		}
		return false;
	}
	if (!player_createData(playerid, hash)) {
		return false;
	}
	return true;
	//todo register
}

