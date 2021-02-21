/*
This file was generated by Nickk's TextDraw editor script
Nickk888 is the author of the NTD script
*/

//Variables
new Text:body;
new Text:logo;
new Text:exit_button;
new Text:login_button;
new Text:exclamation_decoration;
new Text:info_button;
new PlayerText:motto[MAX_PLAYERS];

//Textdraws
body = TextDrawCreate(108.000000, 0.000000, "_");
TextDrawFont(body, 0);
TextDrawLetterSize(body, 0.000000, 50.000000);
TextDrawTextSize(body, 183.500000, 133.500000);
TextDrawSetOutline(body, 1);
TextDrawSetShadow(body, 0);
TextDrawAlignment(body, 2);
TextDrawColor(body, -1);
TextDrawBackgroundColor(body, 255);
TextDrawBoxColor(body, 215);
TextDrawUseBox(body, 1);
TextDrawSetProportional(body, 1);
TextDrawSetSelectable(body, 0);

logo = TextDrawCreate(48.000000, 153.000000, "SanAndreas.lt");
TextDrawFont(logo, 0);
TextDrawLetterSize(logo, 0.679166, 2.699999);
TextDrawTextSize(logo, 168.000000, 0.000000);
TextDrawSetOutline(logo, 1);
TextDrawSetShadow(logo, 0);
TextDrawAlignment(logo, 1);
TextDrawColor(logo, -1);
TextDrawBackgroundColor(logo, 255);
TextDrawBoxColor(logo, -741092353);
TextDrawUseBox(logo, 0);
TextDrawSetProportional(logo, 1);
TextDrawSetSelectable(logo, 0);

exit_button = TextDrawCreate(144.000000, 259.000000, "iseiti");
TextDrawFont(exit_button, 2);
TextDrawLetterSize(exit_button, 0.179167, 1.150014);
TextDrawTextSize(exit_button, 0.000000, 29.000000);
TextDrawSetOutline(exit_button, 0);
TextDrawSetShadow(exit_button, 0);
TextDrawAlignment(exit_button, 2);
TextDrawColor(exit_button, -1);
TextDrawBackgroundColor(exit_button, 1296911871);
TextDrawBoxColor(exit_button, -2071889153);
TextDrawUseBox(exit_button, 1);
TextDrawSetProportional(exit_button, 1);
TextDrawSetSelectable(exit_button, 1);

login_button = TextDrawCreate(108.000000, 242.000000, "registruotis");
TextDrawFont(login_button, 2);
TextDrawLetterSize(login_button, 0.179167, 1.100013);
TextDrawTextSize(login_button, 179.500000, 102.000000);
TextDrawSetOutline(login_button, 0);
TextDrawSetShadow(login_button, 0);
TextDrawAlignment(login_button, 2);
TextDrawColor(login_button, -1);
TextDrawBackgroundColor(login_button, 1296911871);
TextDrawBoxColor(login_button, 565265151);
TextDrawUseBox(login_button, 1);
TextDrawSetProportional(login_button, 1);
TextDrawSetSelectable(login_button, 1);

exclamation_decoration = TextDrawCreate(69.000000, 199.000000, "!");
TextDrawFont(exclamation_decoration, 0);
TextDrawLetterSize(exclamation_decoration, 0.737500, 3.849997);
TextDrawTextSize(exclamation_decoration, 0.000000, 0.000000);
TextDrawSetOutline(exclamation_decoration, 0);
TextDrawSetShadow(exclamation_decoration, 0);
TextDrawAlignment(exclamation_decoration, 2);
TextDrawColor(exclamation_decoration, -1);
TextDrawBackgroundColor(exclamation_decoration, 255);
TextDrawBoxColor(exclamation_decoration, 16777215);
TextDrawUseBox(exclamation_decoration, 0);
TextDrawSetProportional(exclamation_decoration, 1);
TextDrawSetSelectable(exclamation_decoration, 0);

info_button = TextDrawCreate(89.000000, 259.000000, "INFORMACIJA");
TextDrawFont(info_button, 2);
TextDrawLetterSize(info_button, 0.179167, 1.150014);
TextDrawTextSize(info_button, 178.000000, 64.000000);
TextDrawSetOutline(info_button, 0);
TextDrawSetShadow(info_button, 0);
TextDrawAlignment(info_button, 2);
TextDrawColor(info_button, -1);
TextDrawBackgroundColor(info_button, 1296911871);
TextDrawBoxColor(info_button, 577803263);
TextDrawUseBox(info_button, 1);
TextDrawSetProportional(info_button, 1);
TextDrawSetSelectable(info_button, 1);


//Player Textdraws
motto[playerid] = CreatePlayerTextDraw(playerid, 62.000000, 180.000000, "serveris perzengiantis limitus~n~~n~~n~         zaidejas slapyvardziu~n~         ~r~vardas pavarde~s~ nera~n~         registruotas!");
PlayerTextDrawFont(playerid, motto[playerid], 2);
PlayerTextDrawLetterSize(playerid, motto[playerid], 0.125000, 0.949998);
PlayerTextDrawTextSize(playerid, motto[playerid], 152.000000, 0.000000);
PlayerTextDrawSetOutline(playerid, motto[playerid], 1);
PlayerTextDrawSetShadow(playerid, motto[playerid], 0);
PlayerTextDrawAlignment(playerid, motto[playerid], 1);
PlayerTextDrawColor(playerid, motto[playerid], -1);
PlayerTextDrawBackgroundColor(playerid, motto[playerid], 255);
PlayerTextDrawBoxColor(playerid, motto[playerid], 255);
PlayerTextDrawUseBox(playerid, motto[playerid], 0);
PlayerTextDrawSetProportional(playerid, motto[playerid], 1);
PlayerTextDrawSetSelectable(playerid, motto[playerid], 0);


/*Player Progress Bars
Requires "progress2" include by Southclaws
Download: https://github.com/Southclaws/progress2/releases */
