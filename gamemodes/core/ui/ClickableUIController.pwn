#include "core/player/PlayerManagement.pwn"
#include "core/ui/AuthPlayerUI.pwn"

public OnPlayerClickTextDraw(playerid, Text:clickedid) {
	if (clickedid == authUI_login_button) {
		authUI_promptAuthDialog(playerid);
	} else if (clickedid == authUI_register_button) {
		if (!sPlayerData[playerid][policyAgreed]) {
			authUI_promptAuthDialog(playerid, authRenderOption:AUTH_POLICY);
			return;
		}
		authUI_promptAuthDialog(playerid);
	} else if (clickedid == authUI_quit_button) {
		authUI_promptQuitDialog(playerid);
	} else if (clickedid == authUI_info_button) {
		authUI_promptInfoDialog(playerid);
	} else if (_:clickedid == INVALID_TEXT_DRAW && player_isAuthenticating(playerid)) {
		SelectTextDraw(playerid, BUTTON_SELECT_COLOR);
	}
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch (dialogid) {
	case DIALOG_AUTH: {
		if (response) {
			if (isNull(inputtext)) {
				authUI_promptAuthDialog(playerid);
				return;
			}
			if (!player_auth(playerid, inputtext)) {
				authUI_promptAuthDialog(playerid, authRenderOption:AUTH_INVALID_PASS);
				return;
			}
			if (player_hasEmail(playerid)) {
				authUI_promptAuthDialog(playerid, authRenderOption:AUTH_EMAIL);
				return;
			}
			authUI_close(playerid);
			player_loadData(playerid, dataOption:DATA_GAME);
		}
	} case DIALOG_AUTH_POLICY: {
		if (!response) {
			return;
		}
		sPlayerData[playerid][policyAgreed] = true;
		authUI_promptAuthDialog(playerid);
	} case DIALOG_AUTH_EMAIL: {
		if (!response) {
			return;
		}
		if (isNull(inputtext)) {
			authUI_promptAuthDialog(playerid, authRenderOption:AUTH_EMAIL);
			return;
		}
		if (!stringUtils_isValidMail(inputtext)) {
			authUI_promptAuthDialog(playerid, authRenderOption:AUTH_EMAIL_INVALID);
			return;
		}

		SHA256_PassHash(inputtext, ":LG=?eS,8EvJjl@", sPlayerData[playerid][hashedEmail], MAX_HASH_LENGTH+1);
		authUI_close(playerid);
		player_loadData(playerid, dataOption:DATA_GAME);
	} case DIALOG_AUTH_QUIT: {
		if (response == 1) {
			player_kick(playerid);
		}
	}}
}

//Fix for AUTHUI class selection
public OnPlayerRequestSpawn(playerid) {
	if (player_isAuthenticating(playerid)) {
		SelectTextDraw(playerid, BUTTON_SELECT_COLOR);
	}
	return 0;
}