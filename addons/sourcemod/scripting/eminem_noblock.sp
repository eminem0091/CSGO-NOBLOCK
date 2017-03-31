#include <sourcemod>
#include <cstrike>

#define PLUGIN_VERSION "0.2"

new noblock;

public Plugin:myinfo =
{
    name = "Noblock",
    author = "EMINEM",
    description = "none",
    version = PLUGIN_VERSION,
    url = ""
}

public OnPluginStart()
{
    CreateConVar("noblock_ct/t_version", PLUGIN_VERSION, "", FCVAR_PLUGIN|FCVAR_NOTIFY|FCVAR_DONTRECORD);
    RegConsoleCmd("sm_noblock", NoBlockCmd, "CT On/Off NoBlock");   
    HookEvent("round_start", EventHook:OnRoundStart, EventHookMode_PostNoCopy);    
    LoadTranslations("noblock_eminem.phrases");
}

public OnRoundStart()
{
	ServerCommand("mp_solid_teammates 1");
	noblock = 0;
}

public Action:NoBlockCmd(client, args)	
{
    if(GetClientTeam(client) == CS_TEAM_T) //T
    {        
            PrintToChat(client, "[\x0BTvůj portál NOBLOCK\x01] %t", "Zakazany prikaz pro T");           
            
            return Plugin_Handled;
    } 
    
	else if(GetClientTeam(client) == CS_TEAM_CT) //CT
    {    
    	if (IsPlayerAlive(client)) 
			{
			
            	switch (noblock)
				{
						case 0:
						{
							noblock = 1;
							PrintToChat(client, "[\x0BTvůj portál NOBLOCK\x01] %t", "NoBlock On");
							ServerCommand("mp_solid_teammates 0");
						
							return Plugin_Handled;					
						}			
						default:
						{
							noblock = 0;
							PrintToChat(client, "[\x0BTvůj portál NOBLOCK\x01] %t", "NoBlock Off");
							ServerCommand("mp_solid_teammates 1");
						
							return Plugin_Handled;
						}
				} 
			}
			else // Grr he is not alive -.-
			{
				PrintToChat(client, "[\x0BTvůj portál NOBLOCK\x01] %t", "jsi mrtvy");
			}
    
          
    }
    
    return Plugin_Handled; 
}