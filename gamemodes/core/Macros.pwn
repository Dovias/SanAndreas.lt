forward KickInstantly(playerid);

public KickInstantly(playerid) {
	return Kick(playerid);
}

#define Kick(%0) scheduler_addTaskFunction(taskType:TASK_RUN_ONCE, "KickInstantly", "i", %0)
#define ClosePlayerDialog(%0) ShowPlayerDialog(%0, -1, DIALOG_STYLE_MSGBOX, "-", "-", "-", "")
