#include <a_samp>
#include "core/TaskScheduler.pwn"
#include "core/Macros.pwn"
#include "core/GlobalConstants.pwn"
#include "core/SQLConnection.pwn"
#include "core/ui/StaticUI.pwn"
#include "core/ui/ClickableUIController.pwn"
#include "core/player/PlayerConnectionController.pwn"
//#include <Pawn.CMD>

enum LogType {
    LOG_INFO,
    LOG_WARNING,
    LOG_ERROR
}


stock log(LogType:type, const text[]) {
    switch(type) {
        case LOG_INFO: {
            printf("[INFO]: %s", text);
            return;
        } case LOG_WARNING: {
            printf("[ISPEJIMAS]: %s", text);
            return;
        } case LOG_ERROR: {
            printf("[KLAIDA]: %s", text);
        }
    }
}

main() {
    print("\n\n\n\
           ..-===============+++================-..\
           \n\
           \n           "SERVER_NAME" ["SERVER_VERSION"]\
           \n         Modifikacija by Dovias\
           \n\n\
           `^-===============+++================-^`\
           \n\n\n");
}

public OnGameModeInit()
{
    log(LogType:LOG_INFO, "Pradedama uzkrauti modifikacija...");
    log(LogType:LOG_INFO, "Bandoma prisijungti prie SQL duomenu bazes. Prasome palaukti...");
    if (!sql_connect()) {
        log(LogType:LOG_ERROR, "Nepavyko prisijungti prie SQL duomenu bazes! Patikrinkite ar failas dbsettings.ini yra teisingas!");
        for ( ;; ) {}
    }
    log(LogType:LOG_INFO, "Sekmingai prisijungta prie SQL duomenu bazes. Perziurima ar SQL duomenu baze yra paruosta modifikacijos naudojimui...");
    if (!sql_init()) {
        log(LogType:LOG_ERROR, "Nepavyko paruosti SQL duomenu bazes! Patikrinkite ar duomenu baze turi visus reikalingus vartotojo leidimus!");
        for ( ;; ) {}
    }
    log(LogType:LOG_INFO, "SQL duomenu baze yra sekmingai paruosta modifikacijos naudojimui. Tesiamas modifikacijos paruosimas darbui...");
    SetGameModeText(SERVER_NAME" "SERVER_VERSION);
    staticUI_init();
    scheduler_init();
    return 1;
}


public OnGameModeExit()
{
    log(LogType:LOG_INFO, SERVER_NAME" "SERVER_VERSION" modifikacija buvo sekmingai isjungta!");
    return 1;
}

OnPlayerText(playerid, text[])