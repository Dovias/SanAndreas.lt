new Text:authUI_sidebar,
	Text:authUI_logo,
	Text:authUI_excl_mark,
	Text:authUI_info_button,
	Text:authUI_quit_button,
	Text:authUI_register_button,
	Text:authUI_login_button;

stock staticUI_init() {
	authUI_sidebar = TextDrawCreate(108.000000, 0.000000, "_");
	TextDrawFont(authUI_sidebar, 0);
	TextDrawLetterSize(authUI_sidebar, 0.000000, 50.000000);
	TextDrawTextSize(authUI_sidebar, 183.500000, 133.500000);
	TextDrawSetOutline(authUI_sidebar, 1);
	TextDrawSetShadow(authUI_sidebar, 0);
	TextDrawAlignment(authUI_sidebar, 2);
	TextDrawColor(authUI_sidebar, -1);
	TextDrawBackgroundColor(authUI_sidebar, 255);
	TextDrawBoxColor(authUI_sidebar, 215);
	TextDrawUseBox(authUI_sidebar, 1);
	TextDrawSetProportional(authUI_sidebar, 1);
	TextDrawSetSelectable(authUI_sidebar, 0);

	authUI_logo = TextDrawCreate(48.000000, 153.000000, SERVER_NAME);
	TextDrawFont(authUI_logo, 0);
	TextDrawLetterSize(authUI_logo, 0.679166, 2.699999);
	TextDrawTextSize(authUI_logo, 168.000000, 0.000000);
	TextDrawSetOutline(authUI_logo, 1);
	TextDrawSetShadow(authUI_logo, 0);
	TextDrawAlignment(authUI_logo, 1);
	TextDrawColor(authUI_logo, -1);
	TextDrawBackgroundColor(authUI_logo, 255);
	TextDrawBoxColor(authUI_logo, -741092353);
	TextDrawUseBox(authUI_logo, 0);
	TextDrawSetProportional(authUI_logo, 1);
	TextDrawSetSelectable(authUI_logo, 0);

	authUI_excl_mark = TextDrawCreate(69.000000, 199.000000, "!");
	TextDrawFont(authUI_excl_mark, 0);
	TextDrawLetterSize(authUI_excl_mark, 0.737500, 3.849997);
	TextDrawTextSize(authUI_excl_mark, 0.000000, 0.000000);
	TextDrawSetOutline(authUI_excl_mark, 1);
	TextDrawSetShadow(authUI_excl_mark, 0);
	TextDrawAlignment(authUI_excl_mark, 2);
	TextDrawColor(authUI_excl_mark, -1);
	TextDrawBackgroundColor(authUI_excl_mark, 255);
	TextDrawBoxColor(authUI_excl_mark, 16777215);
	TextDrawUseBox(authUI_excl_mark, 0);
	TextDrawSetProportional(authUI_excl_mark, 1);
	TextDrawSetSelectable(authUI_excl_mark, 0);

	authUI_info_button = TextDrawCreate(89.000000, 259.000000, "informacija");
	TextDrawFont(authUI_info_button, 2);
	TextDrawLetterSize(authUI_info_button, 0.179167, 1.150014);
	TextDrawTextSize(authUI_info_button, 15, 64.000000);
	TextDrawSetOutline(authUI_info_button, 0);
	TextDrawSetShadow(authUI_info_button, 0);
	TextDrawAlignment(authUI_info_button, 2);
	TextDrawColor(authUI_info_button, -1);
	TextDrawBackgroundColor(authUI_info_button, 1296911871);
	TextDrawBoxColor(authUI_info_button, 577803263);
	TextDrawUseBox(authUI_info_button, 1);
	TextDrawSetProportional(authUI_info_button, 1);
	TextDrawSetSelectable(authUI_info_button, 1);

	authUI_quit_button = TextDrawCreate(144.000000, 259.000000, "iseiti");
	TextDrawFont(authUI_quit_button, 2);
	TextDrawLetterSize(authUI_quit_button, 0.179167, 1.150014);
	TextDrawTextSize(authUI_quit_button, 15, 29.000000);
	TextDrawSetOutline(authUI_quit_button, 0);
	TextDrawSetShadow(authUI_quit_button, 0);
	TextDrawAlignment(authUI_quit_button, 2);
	TextDrawColor(authUI_quit_button, -1);
	TextDrawBackgroundColor(authUI_quit_button, 1296911871);
	TextDrawBoxColor(authUI_quit_button, -2071889153);
	TextDrawUseBox(authUI_quit_button, 1);
	TextDrawSetProportional(authUI_quit_button, 1);
	TextDrawSetSelectable(authUI_quit_button, 1);

	authUI_register_button = TextDrawCreate(108.000000, 242.000000, "registruotis");
	TextDrawFont(authUI_register_button, 2);
	TextDrawLetterSize(authUI_register_button, 0.179167, 1.100013);
	TextDrawTextSize(authUI_register_button, 15, 102.000000);
	TextDrawSetOutline(authUI_register_button, 0);
	TextDrawSetShadow(authUI_register_button, 0);
	TextDrawAlignment(authUI_register_button, 2);
	TextDrawColor(authUI_register_button, -1);
	TextDrawBackgroundColor(authUI_register_button, 1296911871);
	TextDrawBoxColor(authUI_register_button, 565265151);
	TextDrawUseBox(authUI_register_button, 1);
	TextDrawSetProportional(authUI_register_button, 1);
	TextDrawSetSelectable(authUI_register_button, 1);

	authUI_login_button = TextDrawCreate(108.000000, 242.000000, "prisijungti");
	TextDrawFont(authUI_login_button, 2);
	TextDrawLetterSize(authUI_login_button, 0.179167, 1.100013);
	TextDrawTextSize(authUI_login_button, 15, 102.000000);
	TextDrawSetOutline(authUI_login_button, 0);
	TextDrawSetShadow(authUI_login_button, 0);
	TextDrawAlignment(authUI_login_button, 2);
	TextDrawColor(authUI_login_button, -1);
	TextDrawBackgroundColor(authUI_login_button, 1296911871);
	TextDrawBoxColor(authUI_login_button, 565265151);
	TextDrawUseBox(authUI_login_button, 1);
	TextDrawSetProportional(authUI_login_button, 1);
	TextDrawSetSelectable(authUI_login_button, 1);
}