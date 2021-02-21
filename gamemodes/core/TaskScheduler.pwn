#define TASK_MAX_NAME 17

enum taskType {
	TASK_RUN_ONCE,
	TASK_REPEAT
}

enum TaskFunction {
	funcName[TASK_MAX_NAME+1],
	funcFormat[2],
	funcArg
}


static sTimer;
static funcQueue[2][16][TaskFunction];
static oQueueLength, rQueueLength;

forward onServerTick();

stock scheduler_init() {
	sTimer = SetTimerEx("onServerTick", 1000, true, "");
}

stock scheduler_stop() {
	KillTimer(sTimer);
}


stock scheduler_addTaskFunction(taskType:type, const name[TASK_MAX_NAME+1], const format[2], arg) {
	print(name);
	if (type == taskType:TASK_RUN_ONCE) {
		funcQueue[0][oQueueLength][funcName] = name;
		funcQueue[0][oQueueLength][funcFormat] = format;
		funcQueue[0][oQueueLength][funcArg] = arg;
		oQueueLength++;
	} /*else {
		funcQueue[1][rQueueLength][funcName] = funcName;
		funcQueue[1][rQueueLength][format] = format;
		funcQueue[1][rQueueLength][args] = args;
		rQueueLength++;
	}*/
}

public onServerTick() {
	for (new i = 0; i < oQueueLength; i++) {
		CallRemoteFunction(funcQueue[0][i][funcName],
						   funcQueue[0][i][funcFormat],
						   funcQueue[0][i][funcArg]
		);
	}
	oQueueLength = 0;
	/*for (new i = 0; i < rQueueLength; i++) {
		CallRemoteFunction(funcQueue[1][i], "");
	}*/
}