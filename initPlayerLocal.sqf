waitUntil {vehicle player == player};

[] spawn ZONT_fnc_loadProfile;
[] spawn ZONT_fnc_autoSaveInit;

[] spawn ZONT_fnc_initSkills;

[] spawn ZONT_fnc_initTeleportTerminals;

[] execVM "chatCommands.sqf";
[] execVM "legacy\intro\introtext.sqf";

/******                            Language                             ******/
GameLanguage = language;


/******                            Money                                ******/
if (isNil "ODKB_Money") then	// has the variable already been set and broadcast?
{	
[{
  private _mmoney = [MPS_BDL_pres, "getMoneyODKB", []] call ZONT_fnc_bd_customRequest;
  [_mmoney]
},{
  params ["_mmoney"];
  ODKB_Money = (_mmoney select 0) select 0;
}, []] call ZONT_fnc_remoteExecCallback; // if not, set it on the local machine
};
if (isNil "NATO_Money") then
{
[{
  private _mmoney = [MPS_BDL_pres, "getMoneyNATO", []] call ZONT_fnc_bd_customRequest;
  [_mmoney]
},{
  params ["_mmoney"];
  NATO_Money = (_mmoney select 0) select 0;
}, []] call ZONT_fnc_remoteExecCallback; 
};

/******                            Vehile Lists                             ******/
Hveh = [ //1000$
	"rhs_tigr_m_msv",
	"rhs_tigr_sts_msv"
];

/******                            Ranks                             ******/
_nameplayer = name player;
if ((_nameplayer find "МТР" !=-1) || (_nameplayer find "СМТР" !=-1)) then 
{
	player setRank "CORPORAL"
} 
else 
{
	if ((_nameplayer find "Старшина" !=-1) || (_nameplayer find "Сержант" !=-1)) then 
	{
		player setRank "SERGEANT"
	} 
	else 
	{
		if ((_nameplayer find "Прапор" !=-1)) then 
		{
			player setRank "LIEUTENANT"
		} 
		else 
		{
			if ((_nameplayer find "ЛНТ" !=-1)) then 
			{
				player setRank "CAPTAIN"
			} 
			else 
			{
				if ((_nameplayer find "КПТ" !=-1) || (_nameplayer find "МЙР" !=-1)) then 
        {
            player setRank "MAJOR"
        }
        else 
				{
            if ((_nameplayer find "ППЛК" !=-1) || (_nameplayer find "ПЛК" !=-1)) then 
            {
              player setRank "COLONEL"
            }
        }
			}
		}
	}
};

/******                            Zeus list                             ******/
MCH_ZEUS_LIST = [{
  if (isnull (finddisplay 312)) exitWith {};
  mpc_cc_name = format ["%1 (%2)", name player, getPlayerUID player];
  if (isNil 'mpv_current_curators') then {mpv_current_curators = []};

  if (!(mpc_cc_name in mpv_current_curators)) then {
      mpv_current_curators pushBack mpc_cc_name;
      publicVariable 'mpv_current_curators';
      (finddisplay 312) displayAddEventHandler ["Unload", {
          mpv_current_curators deleteAt (mpv_current_curators find mpc_cc_name);
          publicVariable 'mpv_current_curators';
          hintSilent "";
      }];
  };
  private _str = "<t color='#00FF00'>Active GMs:</t>";
  { _str = format ["%1<br/>%2", _str, _x]; } forEach mpv_current_curators;
  hintSilent parseText _str;
}, 1] call CBA_fnc_addPerFrameHandler;
