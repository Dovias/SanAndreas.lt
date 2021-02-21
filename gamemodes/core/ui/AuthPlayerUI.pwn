#include "core/player/PlayerAuth.pwn"
#include "utils/ChatUtils.pwn"

#define BUTTON_SELECT_COLOR 0xA3B4C5FF

enum authRenderOption {
	AUTH_NORMAL,
	AUTH_POLICY,
	AUTH_EMAIL,
	AUTH_INVALID_PASS,
	AUTH_INCORRECT_PASS
}

enum authUImetadata {
	PlayerText:authUIInfo,
	bool:policyAgreed,
	bool:verificated,
	loginAttempts
}

new metadata[MAX_PLAYERS][authUImetadata];


stock authUI_display(playerid) {
	new nickname[MAX_CPLAYER_NAME+1];
	if (!GetPlayerName(playerid, nickname, sizeof(nickname))) {
		return;
	}
	new text[MAX_CPLAYER_NAME+118] = "serveris perzengiantis limitus~n~~n~~n~         zaidejas slapyvardziu~n~         ~y~";
	strcat(text, nickname, sizeof(text));
	if (player_isRegistered(playerid)) {
		text[82] = 'g';
		strcat(text, "~s~ yra~n~         registruota!", sizeof(text));
		TextDrawShowForPlayer(playerid, authUI_login_button);
	} else {
		strcat(text, "~s~ nera~n~         registruotas!", sizeof(text));
		TextDrawShowForPlayer(playerid, authUI_register_button);
	}
	print(sPlayerData[playerid][hashedPass]);
	TextDrawShowForPlayer(playerid, authUI_sidebar);
	TextDrawShowForPlayer(playerid, authUI_logo);
	TextDrawShowForPlayer(playerid, authUI_excl_mark);
	TextDrawShowForPlayer(playerid, authUI_info_button);
	TextDrawShowForPlayer(playerid, authUI_quit_button);

	metadata[playerid][authUIInfo] = CreatePlayerTextDraw(playerid, 62.000000, 180.000000, text);
	PlayerTextDrawFont(playerid, metadata[playerid][authUIInfo], 2);
	PlayerTextDrawLetterSize(playerid, metadata[playerid][authUIInfo], 0.125000, 0.949998);
	PlayerTextDrawTextSize(playerid, metadata[playerid][authUIInfo], 152.000000, 0.000000);
	PlayerTextDrawSetOutline(playerid, metadata[playerid][authUIInfo], 1);
	PlayerTextDrawSetShadow(playerid, metadata[playerid][authUIInfo], 0);
	PlayerTextDrawAlignment(playerid, metadata[playerid][authUIInfo], 1);
	PlayerTextDrawColor(playerid, metadata[playerid][authUIInfo], -1);
	PlayerTextDrawBackgroundColor(playerid, metadata[playerid][authUIInfo], 255);
	PlayerTextDrawBoxColor(playerid, metadata[playerid][authUIInfo], 255);
	PlayerTextDrawUseBox(playerid, metadata[playerid][authUIInfo], 0);
	PlayerTextDrawSetProportional(playerid, metadata[playerid][authUIInfo], 1);
	PlayerTextDrawSetSelectable(playerid, metadata[playerid][authUIInfo], 0);
	PlayerTextDrawShow(playerid, metadata[playerid][authUIInfo]);

	SetPlayerTime(playerid, 20, 20);
	new Float:x, Float:y, Float:z;
	GetPlayerCameraPos(playerid, x, y, z);
	printf("%f, %f, %f", x, y, z);
	SetPlayerPos(playerid, 309.509094, 1500.099121, -25.101613);
	SetPlayerCameraPos(playerid, 309.509094, 1500.099121, 23.101613);
	SetPlayerCameraLookAt(playerid, 314.317901, 1489.738037, 23.252632, 0);
	SelectTextDraw(playerid, BUTTON_SELECT_COLOR);
	chatUtils_clearChat(playerid);
	//togglePlayerChatInput(playerid);
}

stock authUI_promptAuthDialog(playerid, authRenderOption:error=AUTH_NORMAL) {
	if (!player_isAuthenticating(playerid)) {
		return;
	}
	static caption[] = "{000000} ";
	static button2[] = "Gr��ti";
	switch (error) {
	case AUTH_NORMAL: {
		if (!player_isRegistered(playerid)) {
			ShowPlayerDialog(playerid,
							 serverDialog:DIALOG_AUTH,
							 DIALOG_STYLE_PASSWORD,
							 caption,
							 "\n\
			 				  {E9E9F0}A�i�, kad pasirinkote �aisti {D6B65E}"#SERVER_NAME"{E9E9F0} serveryje!\n\n\
			 				  Prie� pradedant savo �aidimo progres� {D6B65E}"#SERVER_NAME"{E9E9F0} serveryje, jums reikia {D6B65E}u�siregistruoti{E9E9F0}.\n\
			 				  T� galite padaryti sugalvoj� paskyros slapta�od�, kur� tur�site naudoti kas kart prisijungiant � server�.\n\n\
			 				  Pra�ome �vesti savo sugalvot� slapta�od� � �emiau esant� slapta�od�io teksto lauk�:",
			 				 "Registruoti", button2
			);
			return;
		}
		ShowPlayerDialog(playerid,
						 serverDialog:DIALOG_AUTH,
						 DIALOG_STYLE_PASSWORD,
						 caption,
						 "\n\
						  {E9E9F0}Sveiki! Kadangi j�s� slapyvardis yra {D6B65E}u�registruotas{E9E9F0},\n\
						  mums reikia j�s� prie� tai sugalvoto slapta�od�io, kad gal�tum�te t�sti savo �aidimo\n\
						  progres� {D6B65E}"#SERVER_NAME"{E9E9F0} serveryje.\
						  \n\n\
						  Pra�ome �vesti savo slapta�od� � �emiau esant� slapta�od�io teksto lauk�:",
						  "Prisijungti", button2
		);
	} case AUTH_POLICY: {
		ShowPlayerDialog(playerid,
						 serverDialog:DIALOG_AUTH,
						 DIALOG_STYLE_MSGBOX,
						 caption,
						 "\n\
						  {E9E9F0}Prie� jums pradedant �aidim� {D6B65E}"#SERVER_NAME"{E9E9F0} serveryje, norime\n\
						  prane�ti, kad j�s� asmeniniai duomenys (el. pa�to adresas, slapta�odis, pirkini� duomenys)\n\
						  bus saugiai saugomi serverio duomen� baz�je, siekiant u�tikrinti {D6B65E}"#SERVER_NAME"{E9E9F0}\n\
						  serverio �aidimo kokyb� bei jo �aid�j� saugum�.\
						  \n\n\
						  Paspausdami mygtuk� {D6B65E}�Supratau�{E9E9F0} bei susikurdami serveryje �aidimo paskyr�, j�s\n\
						  sutinkate su �ia nurodyta privatumo taisykli� s�lyga.",
						  "Sutinku", button2
		);
	} case AUTH_EMAIL: {
		ShowPlayerDialog(playerid,
						 serverDialog:DIALOG_AUTH,
						 DIALOG_STYLE_INPUT,
						 caption,
						 "\n\
						  {E9E9F0}Prie� pradedant �aidim� {D6B65E}"#SERVER_NAME"{E9E9F0} serveryje, mums reikalingas j�s� {D6B65E}el. pa�to adresas{E9E9F0}.\n\
						  �is el. pa�to adresas bus naudojamas �aidimo paskyros saugumo naudai.\n\
						  Su �iuo el. pa�to adresu, svetain�je {D6B65E}"#SERVER_WEBSITE"/paskyra{E9E9F0} gal�site pasikeisti\n\
						  savo paskyros pamir�t� slapta�od�.\
						  \n\n\
						  Pra�ome �vesti savo naudojam� el. pa�to adres� � �emiau esant� teksto lauk�:",
						 "�aisti", button2
		);
	} case AUTH_INVALID_PASS: {
		if (metadata[playerid][loginAttempts]++ == 3) {
			SendClientMessage(playerid, 0xA9C4E4FF, "Kadangi �ved�te 3 kartus neteising� paskyros slapta�od�, ry�ys su �aidimo serveriu nutr�ko.");
			ClosePlayerDialog(playerid);
			player_kick(playerid);
			return;
		}
		PlayerPlaySound(playerid, 1055, 0.0, 0.0, 0.0);
		ShowPlayerDialog(playerid,
						 serverDialog:DIALOG_AUTH,
						 DIALOG_STYLE_PASSWORD,
						 caption,
						 "\n\
						  {E36056}Slapta�odis, kur� �ved�te yra neteisingas!{E9E9F0}\n\
						  �is slapyvaris yra registruotas bei j�s� nurodytas slapta�odis n�ra teisingas �ios �aidimo\n\
						  paskyros slapta�odis. Pra�ome �vesti teising� �ios paskyros slapta�od�. Saugumo sumetimais,\n\
						  �vedus 3 kartus neteising� slapta�od�, j�s b�site i�mestas i� �aidimo serverio sesijos.\
						  \n\n\
						  � Pamir�ote slapta�od�? Apsilankykite svetain�je {E36056}"#SERVER_WEBSITE"/paskyra{E9E9F0} bei sekite\n\
						  nurodymus, kaip pasikeisti savo �aidimo paskyros pamir�t� slapta�od�.\
						  \n\n\
						  Pra�ome �vesti teising� slapta�od� � �emiau esant� slapta�od�io teksto lauk�:",
						 "Prisijungti", button2
		);	
	} case AUTH_INCORRECT_PASS: {
		ShowPlayerDialog(playerid,
						 serverDialog:DIALOG_AUTH,
						 DIALOG_STYLE_PASSWORD,
						 caption,
						 "\n\
						  {E36056}Slapta�odis, kur� sugalvojote neatitinka saugumo standart�!{E9E9F0}\n\
						  \n\
						  Siekiant apsaugoti �aid�jus nuo paskyr� �silau�in�jim�, {E36056}"#SERVER_NAME"{E9E9F0} serveris,\n\
						  turi slapta�od�i� saugumo standartus, kurie leid�ia piktadariams sunkiau patekti �\n\
						  �aid�j� paskyras.\
						  \n\n\
						  {E36056}Paskyros slapta�odis turi atitikti:\n\
						  {E36056}�{E9E9F0} Minimal� simboli� reikalavim� {E36056}("#MIN_PASSWORD" simboliai){E9E9F0}\n\
						  {E36056}�{E9E9F0} Maksimal� simboli� reikalavim� {E36056}("#MAX_PASSWORD" simboliai){E9E9F0}\n\
						  \n\
						  Pra�ome �vesti nauj� sugalvot� slapta�od� � �emiau esant� slapta�od�io teksto lauk�:",
						 "Registruoti", button2
		);
	}} 
}

stock authUI_promptInfoDialog(playerid) {
	if (!player_isAuthenticating(playerid)) {
		return;
	}
	ShowPlayerDialog(playerid,
					 serverDialog:DIALOG_AUTH_INFO,
					 DIALOG_STYLE_MSGBOX,
					 "{D6B65E} ",
					 "Bus pildoma... Coming soon..",
					 "Gerai", ""
	);
}

stock authUI_promptQuitDialog(playerid) {
	if (!player_isAuthenticating(playerid)) {
		return;
	}
	ShowPlayerDialog(playerid,
					 serverDialog:DIALOG_AUTH_QUIT,
					 DIALOG_STYLE_MSGBOX,
					 "{D6B65E} ",
					 "{E9E9F0}Ar j�s esate �sitikin�s i�eiti\n\
					  i� {D6B65E}"#SERVER_NAME"{E9E9F0} �aidimo\n\
					  serverio?",
					  "Taip", "Gr��ti"
	);
}


stock authUI_close(playerid) {
	if (!player_isAuthenticating(playerid)) {
		return;
	}
	metadata[playerid][loginAttempts] = 0;
	metadata[playerid][policyAgreed] = false;
	metadata[playerid][verificated] = false;

	SetPlayerTime(playerid, 12, 0);
	SetPlayerPos(playerid, 1133.0504,-2038.4034, -50.0000);
	SetPlayerCameraPos(playerid, 1093.0, -2036.0, 90.0);
	SetPlayerCameraLookAt(playerid, 384.0, -1557.0, 20.0);
	SetPlayerVirtualWorld(playerid, serverWorld:WORLD_GAMEPLAY);

	CancelSelectTextDraw(playerid);
	PlayerTextDrawHide(playerid, metadata[playerid][authUIInfo]);
	TextDrawHideForPlayer(playerid, authUI_sidebar);
	TextDrawHideForPlayer(playerid, authUI_logo);
	TextDrawHideForPlayer(playerid, authUI_excl_mark);
	TextDrawHideForPlayer(playerid, authUI_info_button);
	TextDrawHideForPlayer(playerid, authUI_quit_button);
	TextDrawHideForPlayer(playerid, authUI_register_button);
	TextDrawHideForPlayer(playerid, authUI_login_button);
}