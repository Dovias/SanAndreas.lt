#include "core/player/PlayerAuth.pwn"
#include "utils/ChatUtils.pwn"

#define BUTTON_SELECT_COLOR 0xA3B4C5FF

enum authRenderOption {
	AUTH_NORMAL,
	AUTH_POLICY,
	AUTH_EMAIL,
	AUTH_EMAIL_INVALID,
	AUTH_INVALID_PASS
}

stock authUI_display(playerid) {
	new nickname[MAX_CPLAYER_NAME+1];
	if (!GetPlayerName(playerid, nickname, sizeof(nickname))) {
		return;
	}
	new text[MAX_CPLAYER_NAME+118] = "serveris perzengiantis limitus~n~~n~~n~         zaidejas slapyvardziu~n~         ~y~";
	strcat(text, nickname, sizeof(text));
	if (player_isRegistered(playerid)) {
		text[82] = 'g';
		strcat(text, "~s~ yra~n~         registruotas!", sizeof(text));
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

	sPlayerData[playerid][authUIInfo] = CreatePlayerTextDraw(playerid, 62.000000, 180.000000, text);
	PlayerTextDrawFont(playerid, sPlayerData[playerid][authUIInfo], 2);
	PlayerTextDrawLetterSize(playerid, sPlayerData[playerid][authUIInfo], 0.125000, 0.949998);
	PlayerTextDrawTextSize(playerid, sPlayerData[playerid][authUIInfo], 152.000000, 0.000000);
	PlayerTextDrawSetOutline(playerid, sPlayerData[playerid][authUIInfo], 1);
	PlayerTextDrawSetShadow(playerid, sPlayerData[playerid][authUIInfo], 0);
	PlayerTextDrawAlignment(playerid, sPlayerData[playerid][authUIInfo], 1);
	PlayerTextDrawColor(playerid, sPlayerData[playerid][authUIInfo], -1);
	PlayerTextDrawBackgroundColor(playerid, sPlayerData[playerid][authUIInfo], 255);
	PlayerTextDrawBoxColor(playerid, sPlayerData[playerid][authUIInfo], 255);
	PlayerTextDrawUseBox(playerid, sPlayerData[playerid][authUIInfo], 0);
	PlayerTextDrawSetProportional(playerid, sPlayerData[playerid][authUIInfo], 1);
	PlayerTextDrawSetSelectable(playerid, sPlayerData[playerid][authUIInfo], 0);
	PlayerTextDrawShow(playerid, sPlayerData[playerid][authUIInfo]);

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
	static button2[] = "Gráþti";
	switch (error) {
	case AUTH_NORMAL: {
		if (!player_isRegistered(playerid)) {
			ShowPlayerDialog(playerid,
							 serverDialog:DIALOG_AUTH,
							 DIALOG_STYLE_PASSWORD,
							 caption,
							 "\n\
			 				  {E9E9F0}Aèiû, kad pasirinkote þaisti {D6B65E}"#SERVER_NAME"{E9E9F0} serveryje!\n\n\
			 				  Prieð pradedant savo þaidimo progresà {D6B65E}"#SERVER_NAME"{E9E9F0} serveryje, jums reikia {D6B65E}uþsiregistruoti{E9E9F0}.\n\
			 				  Tà galite padaryti sugalvojæ paskyros slaptaþodá, kurá turësite naudoti kas kart prisijungiant á serverá.\n\n\
			 				  Praðome ávesti savo sugalvotà slaptaþodá á þemiau esantá slaptaþodþio teksto laukà:",
			 				 "Registruoti", button2
			);
			return;
		}
		ShowPlayerDialog(playerid,
						 serverDialog:DIALOG_AUTH,
						 DIALOG_STYLE_PASSWORD,
						 caption,
						 "\n\
						  {E9E9F0}Sveiki! Kadangi jûsø slapyvardis yra {D6B65E}uþregistruotas{E9E9F0},\n\
						  mums reikia jûsø prieð tai sugalvoto slaptaþodþio, kad galëtumëte tæsti savo þaidimo\n\
						  progresà {D6B65E}"#SERVER_NAME"{E9E9F0} serveryje.\
						  \n\n\
						  Praðome ávesti savo slaptaþodá á þemiau esantá slaptaþodþio teksto laukà:",
						  "Prisijungti", button2
		);
	} case AUTH_POLICY: {
		ShowPlayerDialog(playerid,
						 serverDialog:DIALOG_AUTH_POLICY,
						 DIALOG_STYLE_MSGBOX,
						 caption,
						 "\n\
						  {E9E9F0}Prieð jums pradedant þaidimà {D6B65E}"#SERVER_NAME"{E9E9F0} serveryje, norime\n\
						  praneðti, kad jûsø asmeniniai duomenys (el. paðto adresas, slaptaþodis, pirkiniø duomenys)\n\
						  bus saugiai saugomi serverio duomenø bazëje, siekiant uþtikrinti {D6B65E}"#SERVER_NAME"{E9E9F0}\n\
						  serverio þaidimo kokybæ bei jo þaidëjø saugumà.\
						  \n\n\
						  Paspausdami mygtukà {D6B65E}„Supratau“{E9E9F0} bei susikurdami serveryje þaidimo paskyrà, jûs\n\
						  sutinkate su ðia nurodyta privatumo taisykliø sàlyga.",
						  "Sutinku", button2
		);
	} case AUTH_EMAIL: {
		ShowPlayerDialog(playerid,
						 serverDialog:DIALOG_AUTH_EMAIL,
						 DIALOG_STYLE_INPUT,
						 caption,
						 "\n\
						  {E9E9F0}Prieð pradedant þaidimà {D6B65E}"#SERVER_NAME"{E9E9F0} serveryje, mums reikalingas jûsø {D6B65E}el. paðto adresas{E9E9F0}.\n\
						  ðis el. paðto adresas bus naudojamas þaidimo paskyros saugumo naudai.\n\
						  Su ðiuo el. paðto adresu, svetainëje {D6B65E}"#SERVER_WEBSITE"/paskyra{E9E9F0} galësite pasikeisti\n\
						  savo paskyros pamirðtà slaptaþodá.\
						  \n\n\
						  Praðome ávesti savo naudojamà el. paðto adresà á þemiau esantá teksto laukà:",
						 "Þaisti", button2
		);
	} case AUTH_EMAIL_INVALID: {
		ShowPlayerDialog(playerid,
						 serverDialog:DIALOG_AUTH_EMAIL,
						 DIALOG_STYLE_INPUT,
						 caption,
						 "\n\
						  {E36056}El. paðto adresas, kurá ávedëte yra neteisingas arba negali bûti naudojamas!{E9E9F0}\n\
						  El. paðtas, kurá ávedete nëra tinkamas naudoti {E36056}"#SERVER_NAME"{E9E9F0} serveryje. el. paðto adresas susidaro ið\n\
						  minimaliai 3 simboliø bei gale adreso turi turëti domenà {E36056}(PAVYZDYS: @inbox.lt){E9E9F0}. Jei esate ásitikinæ, kad\n\
						  el. paðto adresas teisingas, tai reiðkia, kad jis dël serverio kokybës ir saugumo uþtikrinimo, negali bûti\n\
						  naudojamas. Pateikdami paskyros el. paðto adresà bûtina pateikti asmeniná, ne privatø el. paðto adresà,\n\
						  kuris yra tinkamas naudoti.\
						  \n\n\
						  • Neturite arba negalite susikurti el. paðto adreso? Apsilankykite svetainëje {E36056}"#SERVER_WEBSITE"{E9E9F0}\n\
						  bei susisiekite su {E36056}"#SERVER_NAME"{E9E9F0} serverio administracija, kuri jums mielai padës su ðia situacija.\
						  \n\n\
						  Praðome ávesti savo naudojamà el. paðto adresà, á þemiau esantá teksto laukà:",
						  "Þaisti", button2
		);
	} case AUTH_INVALID_PASS: {
		if (player_isRegistered(playerid)) {
			if (sPlayerData[playerid][loginAttempts]++ == 3) {
				SendClientMessage(playerid, 0xA9C4E4FF, "Kadangi ávedëte 3 kartus neteisingà paskyros slaptaþodá, ryðys su þaidimo serveriu nutrûko.");
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
							{E36056}Slaptaþodis, kurá ávedëte yra neteisingas!{E9E9F0}\n\
							ðis slapyvardis yra registruotas bei jûsø nurodytas slaptaþodis nëra teisingas ðios þaidimo\n\
							paskyros slaptaþodis. Praðome ávesti teisingà ðios paskyros slaptaþodá. Saugumo sumetimais,\n\
							ávedus 3 kartus neteisingà slaptaþodá, jûs bûsite iðmestas ið þaidimo serverio sesijos.\
							\n\n\
							• Pamirðote slaptaþodá? Apsilankykite svetainëje {E36056}"#SERVER_WEBSITE"/paskyra{E9E9F0} bei sekite\n\
							nurodymus, kaip pasikeisti savo þaidimo paskyros pamirðtà slaptaþodá.\
							\n\n\
							Praðome ávesti teisingà slaptaþodá á þemiau esantá slaptaþodþio teksto laukà:",
							"Prisijungti", button2
			);	
			return;
		}
		ShowPlayerDialog(playerid,
						 serverDialog:DIALOG_AUTH,
						 DIALOG_STYLE_PASSWORD,
						 caption,
						 "\n\
						  {E36056}Slaptaþodis, kurá sugalvojote neatitinka saugumo standartø!{E9E9F0}\n\
						  \n\
						  Siekiant apsaugoti þaidëjus nuo paskyrø ásilauþinëjimø, {E36056}"#SERVER_NAME"{E9E9F0} serveris,\n\
						  turi slaptaþodþiø saugumo standartus, kurie leidþia piktadariams sunkiau patekti á\n\
						  þaidëjø paskyras.\
						  \n\n\
						  {E36056}Paskyros slaptaþodis turi atitikti:\n\
						  {E36056}•{E9E9F0} Minimalø simboliø reikalavimà {E36056}("#MIN_PASSWORD" simboliai){E9E9F0}\n\
						  {E36056}•{E9E9F0} Maksimalø simboliø reikalavimà {E36056}("#MAX_PASSWORD" simboliai){E9E9F0}\n\
						  \n\
						  Praðome ávesti naujà sugalvotà slaptaþodá á þemiau esantá slaptaþodþio teksto laukà:",
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
					 "{E9E9F0}Ar jûs esate ásitikinæs iðeiti\n\
					  ið {D6B65E}"#SERVER_NAME"{E9E9F0} þaidimo\n\
					  serverio?",
					  "Taip", "Gráþti"
	);
}


stock authUI_close(playerid) {
	if (!player_isAuthenticating(playerid)) {
		return;
	}
	sPlayerData[playerid][loginAttempts] = 0;
	sPlayerData[playerid][policyAgreed] = false;

	SetPlayerTime(playerid, 12, 0);
	SetPlayerPos(playerid, 1133.0504,-2038.4034, -50.0000);
	SetPlayerCameraPos(playerid, 1093.0, -2036.0, 90.0);
	SetPlayerCameraLookAt(playerid, 384.0, -1557.0, 20.0);
	SetPlayerVirtualWorld(playerid, serverWorld:WORLD_GAMEPLAY);

	CancelSelectTextDraw(playerid);
	PlayerTextDrawHide(playerid, sPlayerData[playerid][authUIInfo]);
	TextDrawHideForPlayer(playerid, authUI_sidebar);
	TextDrawHideForPlayer(playerid, authUI_logo);
	TextDrawHideForPlayer(playerid, authUI_excl_mark);
	TextDrawHideForPlayer(playerid, authUI_info_button);
	TextDrawHideForPlayer(playerid, authUI_quit_button);
	TextDrawHideForPlayer(playerid, authUI_register_button);
	TextDrawHideForPlayer(playerid, authUI_login_button);
}