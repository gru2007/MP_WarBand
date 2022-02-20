params ["_player", "_didJIP"];
private _curators = call ZONT_fnc_retrieveCurators;
if not ((getPlayerUID _player) in _curators) exitWith { };
_player call ZONT_fnc_giveZeus;
_name = name _player;
_uid = getPlayerUID _player;
[MPS_BDL_pres, "updName", [_name, _uid]] call ZONT_fnc_bd_customRequest;