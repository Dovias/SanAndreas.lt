#include <a_mysql>

#define SQL_FILENAME "dbsettings.ini"

new MySQL:g_sql;

/* 
 * mysql_connect_file() can be used, but this seems
 * to be more efficient, since this doesn't check most of
 * the options. Doesn't allow any configuration entries
 * to be empty, for security purposes.
 */
stock sql_connect() {
    new File:file = fopen(SQL_FILENAME, filemode:io_readwrite);
    if (!file) {
        return 0;
    }
    new buffer[254],
        temp,
        bLength,
        dLength;
    fread(file, buffer, sizeof(buffer), false);
    if (isNull(buffer)) {
        buffer = "[SQLCredentials]\n\
                  hostname=127.0.0.1\n\
                  port=3306\n\
                  database=sqldb\n\
                  username=root\n\
                  password=changeme";
        fwrite(file, buffer);
        fclose(file);
        file = fopen(SQL_FILENAME, filemode:io_read);
    } else if (strcmp(buffer, "[SQLCredentials]", true, 16) != 0) {
        fclose(file);
        return 0;
    }
    new data[5][254] = {
        "hostname=",
        "port=",
        "database=",
        "username=",
        "password="
    };
    for (new i = 0; i < 5; i++) {
        fread(file, buffer, sizeof(buffer), false);
        bLength = strlen(buffer);
        if (bLength > 0 && buffer[bLength-2] == '\r') {
            buffer[bLength-2] = '\0';
            bLength -= 2;
        } else if (bLength > 0 && buffer[bLength-1] == '\n') {
            buffer[bLength-1] = '\0';
            bLength -= 1;
        }
        dLength = strlen(data[i]);
        if (!isNull(buffer) && bLength > dLength && strcmp(buffer, data[i], true, dLength) == 0) {
            temp = bLength-dLength;
            //CELL is 4 bytes in this case, since SA:MP server is 32 bit application.
            memcpy(data[i], buffer[dLength], 0, temp*4, 254);
            data[i][temp] = '\0';
            continue;
        }
        fclose(file);
        return false;
    }
    fclose(file);
    new MySQLOpt:options = mysql_init_options();
    mysql_set_option(options, E_MYSQL_OPTION:MULTI_STATEMENTS, true);
    mysql_set_option(options, E_MYSQL_OPTION:POOL_SIZE, 10);
    mysql_set_option(options, E_MYSQL_OPTION:SERVER_PORT, data[1]);
    g_sql = mysql_connect(data[0], data[3], data[4], data[2]);
    if (g_sql == MYSQL_INVALID_HANDLE || mysql_errno(g_sql) != 0) {
        return false;
    }
    return true;
}

stock sql_init() {
    if (g_sql == MYSQL_INVALID_HANDLE) {
        return false;
    }
    mysql_query(g_sql, "CREATE TABLE IF NOT EXISTS `server_userdata` (`id` INT auto_increment PRIMARY KEY,\
                                                                      `username` VARCHAR("#MAX_CPLAYER_NAME") NOT NULL,\
                                                                      `email` CHAR("#MAX_HASH_LENGTH"),\
                                                                      `password` CHAR("#MAX_HASH_LENGTH") NOT NULL,\
                                                                      `x-loc` FLOAT NOT NULL,\
                                                                      `y-loc` FLOAT NOT NULL,\
                                                                      `z-loc` FLOAT NOT NULL,\
                                                                      `angle` FLOAT NOT NULL);");
    if (mysql_errno(g_sql) != 0) {
        return false;
    }
    return true;
}
