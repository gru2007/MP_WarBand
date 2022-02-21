waitUntil {vehicle player == player};

[] spawn ZONT_fnc_loadProfile;
[] spawn ZONT_fnc_autoSaveInit;

[] spawn ZONT_fnc_initSkills;

[] spawn ZONT_fnc_initTeleportTerminals;

[] execVM "chatCommands.sqf";
[] execVM "legacy\intro\introtext.sqf";

/******                            Language                             ******/
GameLanguage = "English";

/******                            Inf Ammo                             ******/
MagazineWhiteList = [

];
player addEventHandler ["Reloaded", { 
  if (((_this select 3) select 0) in MagazineWhiteList) then { 
    (_this select 0) addMagazine ((_this select 3) select 0); 
  }; 
}];

/******                            Ranks                             ******/
_nameplayer = name player;
if ((_nameplayer find "PFC" !=-1) || (_nameplayer find "CS" !=-1) || (_nameplayer find "CPL" !=-1)) then 
{
	player setRank "CORPORAL"
} 
else 
{
	if ((_nameplayer find "SGT" !=-1) || (_nameplayer find "SFC" !=-1) || (_nameplayer find "SSG" !=-1) || (_nameplayer find "SPSG" !=-1) || (_nameplayer find "MSG" !=-1) || (_nameplayer find "SGM" !=-1)) then 
	{
		player setRank "SERGEANT"
	} 
	else 
	{
		if ((_nameplayer find "WO" !=-1) || (_nameplayer find "LT" !=-1) || (_nameplayer find "SLT" !=-1) || (_nameplayer find "SPLT" !=-1)) then 
		{
			player setRank "LIEUTENANT"
		} 
		else 
		{
			if ((_nameplayer find "CPT" !=-1)) then 
			{
				player setRank "CAPTAIN"
			} 
			else 
			{
				if ((_nameplayer find "MAJ" !=-1) || (_nameplayer find "GEN" !=-1)) then 
        {
            player setRank "MAJOR"
        }
        else 
				{
            if ((_nameplayer find "ADM" !=-1) || (_nameplayer find "COL" !=-1) || (_nameplayer find "CC" !=-1) || (_nameplayer find "MC" !=-1)) then 
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
  private _str = "<t color='#00FF00'>Active zeuses:</t>";
  { _str = format ["%1<br/>%2", _str, _x]; } forEach mpv_current_curators;
  hintSilent parseText _str;
}, 1] call CBA_fnc_addPerFrameHandler;
