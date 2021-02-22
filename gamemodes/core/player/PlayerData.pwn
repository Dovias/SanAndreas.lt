enum dataOption {
	DATA_AUTH,
	DATA_GAME
}

enum playerData {
	//UI metadata
	PlayerText:authUIInfo,
	bool:policyAgreed,
	loginAttempts,

	sqlID,
	hashedPass[MAX_HASH_LENGTH+1],
	hashedEmail[MAX_HASH_LENGTH+1],
	Float:xLoc,
	Float:yLoc,
	Float:zLoc,
	Float:angle
}

new sPlayerData[MAX_PLAYERS][playerData];

forward player_saveData(playerid);

forward onPlayerDataLoaded(playerid, dataOption:data);
forward onPlayerDataSave(playerid);
forward onPlayerDataCreate(playerid);

stock player_loadData(playerid, dataOption:data) {
	new username[MAX_CPLAYER_NAME+1];
	if (!GetPlayerName(playerid, username, sizeof(username))) {
		return false;
	}
	new length = strlen(username);
	if (data == dataOption:DATA_AUTH) {
		// There's no need for escaping strings for SQL, since usernames are rejected by server with illegal symbols.
		new query[79+MAX_CPLAYER_NAME] = "SELECT `password`, `email` FROM `server_userdata` WHERE `username`='";
		memcpy(query, username, 272, length*4, sizeof(query));
		memcpy(query, "' LIMIT 1;", (68+length)*4, 44, sizeof(query));
		return mysql_pquery(g_sql, query, "onPlayerDataLoaded", "dd", playerid, dataOption:DATA_AUTH);
	}
	// There's no need for escaping strings for SQL, since usernames are rejected by server and client with illegal symbols.
	new query[100+MAX_CPLAYER_NAME] = "SELECT `id`, `x-loc`, `y-loc`, `z-loc`, `angle` FROM `server_userdata` WHERE `username`='";
	memcpy(query, username, 356, length*4, sizeof(query));
	memcpy(query, "' LIMIT 1;", (89+length)*4, 44, sizeof(query));
	print(query);
	return mysql_pquery(g_sql, query, "onPlayerDataLoaded", "dd", playerid, dataOption:DATA_GAME);
}

stock player_createData(playerid, const hashed_pass[]) {
	new username[MAX_CPLAYER_NAME+1];
	if (!GetPlayerName(playerid, username, sizeof(username)) || !isNull(sPlayerData[playerid][hashedPass])) {
		return false;
	}
	new query[71+MAX_CPLAYER_NAME+MAX_HASH_LENGTH] = "INSERT INTO `server_userdata` (`username`, `password`) VALUES ('";
	mysql_escape_string(username, query[64], sizeof(query)-64);
	strcat(query, "','", sizeof(query));
	mysql_escape_string(hashed_pass, query[strlen(query)], sizeof(query));
	strcat(query, "');", sizeof(query));
	return mysql_pquery(g_sql, query, "onPlayerDataCreate", "d", playerid);

}

stock player_deserializeData(playerid) {
	SetSpawnInfo(playerid, 0, 0, sPlayerData[playerid][xLoc], sPlayerData[playerid][zLoc], sPlayerData[playerid][yLoc], sPlayerData[playerid][angle], 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);

}

public player_saveData(playerid) {
	if (!player_isRegistered(playerid)) {
		return false;
	}
	new Float:x, Float:y, Float:z, Float:ang;
	GetPlayerPos(playerid, x, z, y);
	GetPlayerFacingAngle(playerid, ang);

	new query[123];
	mysql_format(g_sql, query, sizeof(query), "UPDATE `server_userdata` SET `x-loc`=%.2f, `y-loc`=%.2f, `z-loc`=%.2f, `angle`=%.2f WHERE `id`=%i;", x, y, z, ang, sPlayerData[playerid][sqlID]);
	return mysql_pquery(g_sql, query, "onPlayerDataSave", "d", playerid);
}

stock player_clearData(playerid) {
	if (!player_isRegistered(playerid)) {
		return;
	}
	sPlayerData[playerid][sqlID] = 0;
	sPlayerData[playerid][hashedPass][0] = '\0'; 
	sPlayerData[playerid][hashedEmail][0] = '\0';
	sPlayerData[playerid][xLoc] = 0.0;
	sPlayerData[playerid][yLoc] = 0.0;
	sPlayerData[playerid][zLoc] = 0.0;
	sPlayerData[playerid][angle] = 0.0;
}

public onPlayerDataLoaded(playerid, dataOption:data) {
	if (!cache_is_any_active()) {
		return;
	}
	if (data == dataOption:DATA_GAME) {
		cache_get_value_index_int(0, 0, sPlayerData[playerid][sqlID]);
		cache_get_value_index_float(0, 1, sPlayerData[playerid][xLoc]);
		cache_get_value_index_float(0, 2, sPlayerData[playerid][yLoc]);
		cache_get_value_index_float(0, 3, sPlayerData[playerid][zLoc]);
		cache_get_value_index_float(0, 4, sPlayerData[playerid][angle]);
		player_deserializeData(playerid);
		return;
	}
	cache_get_value_index(0, 0, sPlayerData[playerid][hashedPass], MAX_HASH_LENGTH+1);
	cache_get_value_index(0, 1, sPlayerData[playerid][hashedEmail], MAX_HASH_LENGTH+1);

	authUI_display(playerid);

}

public onPlayerDataSave(playerid) {
	print("Lokacija isaugota!");
}

public onPlayerDataCreate(playerid) {
	cache_get_value_name(0, "password", sPlayerData[playerid][hashedPass], MAX_HASH_LENGTH+1);
	OnDialogResponse(playerid, DIALOG_AUTH, 1, 0, sPlayerData[playerid][hashedPass]);
}
