#include <sourcemod>
#pragma semicolon 1
#pragma newdecls required

char logpath[PLATFORM_MAX_PATH];

public Plugin myinfo =
{
    name = "IP logger",
    author = "Dave",
    description = "Logs IP's through .log file",
    version = "1.0",
    url = "https://daveskz.com/"
};

public void OnPluginStart()
{
    /*char path[PLATFORM_MAX_PATH];
    BuildPath(Path_SM, path, sizeof(path), "logs/clientlogger/");
    CreateDirectory(path, 711);*/
    BuildPath(Path_SM, logpath, sizeof(logpath), "/logs/clientlogger/clientlogs.txt");
}

public void OnClientPostAdminCheck(int client)
{
    if(!IsFakeClient(client))
        LogClient(client);
}

public void LogClient(int client)
{
    char clientIp[32], clientId[32];

    GetClientAuthId(client, AuthId_Steam2, clientId, sizeof(clientId));
    GetClientIP(client, clientIp, sizeof(clientIp), true);

    LogToFile(logpath, "%N (%s) connected through %s", client, clientId, clientIp);
}