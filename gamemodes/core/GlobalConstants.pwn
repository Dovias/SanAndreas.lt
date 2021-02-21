#if !defined isNull
    #define isNull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

/*
 * DO NOT CHANGE THESE, IF YOU DON'T KNOW WHAT YOU'RE DOING!
 * These two values represent length of variables in server's gameplay
 * and its SQL storage. If changed without data migration, that could
 * lead to faulty server's authentication system and other server
 * gameplay problems!
 */
#define MAX_HASH_LENGTH 64
#define MAX_CPLAYER_NAME 20

#define SERVER_NAME "SanAndreas.lt"
#define SERVER_WEBSITE "https://sanandreas.lt"
#define SERVER_VERSION "0.1.00-DEV"

#define MIN_PASSWORD 7
#define MAX_PASSWORD 20

enum serverDialog {
	DIALOG_AUTH,
	DIALOG_AUTH_QUIT,
	DIALOG_AUTH_INFO
}

enum serverWorld {
	WORLD_AUTH,
	WORLD_GAMEPLAY
}
