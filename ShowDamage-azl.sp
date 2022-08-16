#include <sourcemod>
#include <sdktools>
#include <cstrike>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo =
{
	name = "ShowDamage-AZL",
	author = "AZzeL",
	description = "",
	version = "1.0",
	url = "http://fireon.ro"
};

Event g_hEvent;

public void OnPluginStart()
{
	HookEvent("player_hurt", Event_PlayerHurt);
}

public void OnMapStart()
{
	g_hEvent = CreateEvent("show_survival_respawn_status", true);
}

public Action Event_PlayerHurt(Handle event, const char[] name, bool dontBroadcast)
{	
    	if (!GameRules_GetProp("m_bWarmupPeriod") == 1)
    	{   
		int iAttacker = GetClientOfUserId(GetEventInt(event, "attacker"));
		int iVictim   = GetClientOfUserId(GetEventInt(event, "userid"));
	
		if(iVictim == iAttacker || iAttacker < 1 || iAttacker > MaxClients || !IsClientInGame(iAttacker) || IsFakeClient(iAttacker))
			return;

		int iHp       = GetEventInt(event, "dmg_health");
		int iArmor    = GetEventInt(event, "dmg_armor");
		int iHitgroup = GetEventInt(event, "hitgroup");

		switch(iHitgroup)
		{
			case 0:
			{
	       	 		AlertText(g_hEvent, iAttacker, 2, "-<font color='#FF0000'>%i</font> HP | -<font color='#008FFF'>%i</font> Armor", iHp, iArmor);
			}
			case 1:
			{
	       			AlertText(g_hEvent, iAttacker, 2, "In <font color='#FF8B00'>Head</font>. -<font color='#FF0000'>%i</font> HP | -<font color='#008FFF'>%i</font> Armor", iHp, iArmor);
			}
			case 2:
			{
	       	 		AlertText(g_hEvent, iAttacker, 2, "In <font color='#36FF00'>Chest</font>. -<font color='#FF0000'>%i</font> HP | -<font color='#008FFF'>%i</font> Armor", iHp, iArmor);
			}
			case 3:
			{
	       		 	AlertText(g_hEvent, iAttacker, 2, "In <font color='#36FF00'>Stomach</font>. -<font color='#FF0000'>%i</font> HP | -<font color='#008FFF'>%i</font> Armor", iHp, iArmor);
			}
			case 4:
			{
	       	 		AlertText(g_hEvent, iAttacker, 2, "In <font color='#36FF00'>Left arm</font>. -<font color='#FF0000'>%i</font> HP | -<font color='#008FFF'>%i</font> Armor", iHp, iArmor);
			}
			case 5:
			{
	       		 	AlertText(g_hEvent, iAttacker, 2, "In <font color='#36FF00'>Right arm</font>. -<font color='#FF0000'>%i</font> HP | -<font color='#008FFF'>%i</font> Armor", iHp, iArmor);
			}
			case 6:
			{
	       	 		AlertText(g_hEvent, iAttacker, 2, "In <font color='#36FF00'>Left leg</font>. -<font color='#FF0000'>%i</font> HP | -<font color='#008FFF'>%i</font> Armor", iHp, iArmor);
			}
			case 7:
			{
	       	 		AlertText(g_hEvent, iAttacker, 2, "In <font color='#36FF00'>Right leg</font>. -<font color='#FF0000'>%i</font> HP | -<font color='#008FFF'>%i</font> Armor", iHp, iArmor);
			}
		}
	}
}

void AlertText(Event event, int client, int duration, const char[] msg, any ...)
{
    	static char buff[512];
   	VFormat(buff, sizeof(buff), msg, 5);
   	event.SetString("loc_token", buff);
   	event.SetInt("duration", duration);
    	event.SetInt("userid", -1);
    	event.FireToClient(client);
}
