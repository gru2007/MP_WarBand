waitUntil {vehicle player == player};

[] spawn ZONT_fnc_loadProfile;
[] spawn ZONT_fnc_autoSaveInit;

[] spawn ZONT_fnc_initSkills;

[] spawn ZONT_fnc_initTeleportTerminals;

[] execVM "chatCommands.sqf";
[] execVM "legacy\intro\introtext.sqf";

/******                            Inf Ammo                             ******/
MagazineWhiteList = [
  "JLTS_DC15A_mag", //DC-15A
  "JLTS_DC15S_mag", //DC-15S
  "JLTS_DC15X_mag", //DC-15X
  "JLTS_Z6_mag", //Z-6
  "3AS_60Rnd_EC50_Mag", //Westar M5
  "212th_15rnd_Energy_dc15XM_mag", //DC-15XM
  "212th_3rnd_Plasma_dc15XM_mag", //DC-15XM
  "JLTS_DC17SA_mag", //DC-17SA
  "3AS_15Rnd_EC30_mag", //DC-15SA Razor
  "3AS_Chaingun_Drum_Mag", //Chaingun
  "3AS_100Rnd_EC40_mag", //DC-17M
  "3AS_5Rnd_EC80_mag", //DC-17M
  "3AS_AntiArmour_mag", //DC-17M
  "212th_35Rnd_DC15A_mag", //DC-15A (Mk. 6) 212
  "212th_35Rnd_DC17_mag" //От 212 мода тож
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
  private _str = "<t color='#00FF00'>Активные зевсы:</t>";
  { _str = format ["%1<br/>%2", _str, _x]; } forEach mpv_current_curators;
  hintSilent parseText _str;
}, 1] call CBA_fnc_addPerFrameHandler;
