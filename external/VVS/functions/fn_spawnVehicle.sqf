/*
	File: fn_spawnVehicle.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Spawns the selected vehicle, if a vehicle is already on the spawn point
	then it deletes the vehicle from the spawn point.
*/
disableSerialization;
private["_pos","_direction","_className","_displayName","_spCheck","_cfgInfo"];
if(lnbCurSelRow 38101 == -1) exitWith {hint "Не выбрана техника для спавна!"};

_className = lnbData[38101,[(lnbCurSelRow 38101),0]];
_displayName = lnbData[38101,[(lnbCurSelRow 38101),1]];
_pos = getPosATL VVS_SP;
_direction = direction VVS_SP;

//Make sure the marker exists in a way.
if(isNil "_pos") exitWith {hint "Точка спавна вообще есть?";};

_cfgInfo = [_className] call VVS_fnc_cfgInfo;

_positionSpawn = [_pos select 0, _pos select 1, (_pos select 2) + 10000];
_position = [_pos select 0, _pos select 1, (_pos select 2) + 0.5];

//Get price
if (_className in Hveh) then {
	price = 1000;
} else {
	price = 300;
};

//Get player side => Money
if(playerSide==east) then {
	money = ODKB_Money;
} else {
	money = NATO_Money;
};

//Check
if(price > money) exitWith{
	hint localize "STR_WB_nomoney";
	closeDialog 0;
};

//Has player rights?
if(!([2] call ZONT_fnc_checkRole)) exitWith{
	hint localize "STR_WB_norights";
	closeDialog 0;
}

//Take money
if(playerSide==east) then {
	ODKB_Money = ODKB_Money - price;
	publicVariable "ODKB_Money"; 
	[[ODKB_Money], {
	params ["_mmmoney"];
	[MPS_BDL_pres, "updMoneyODKB", [_mmmoney]] call ZONT_fnc_bd_customRequest;
	}] remoteExec ["bis_fnc_call", 2];
} else {
	NATO_Money = NATO_Money - price;
	publicVariable "NATO_Money";
	[[NATO_Money], {
	params ["_mmmoney"];
	[MPS_BDL_pres, "updMoneyNATO", [_mmmoney]] call ZONT_fnc_bd_customRequest;
	}] remoteExec ["bis_fnc_call", 2];
};

//Check to make sure the spawn point doesn't have a vehicle on it, if it does then delete it.
_spCheck = nearestObjects[_pos,["landVehicle","Air","Ship"],12];

if(!isNil "_spCheck") then { 
	{ deleteVehicle _x; sleep 0.2; } forEach _spCheck;	
};

_vehicle = _className createVehicle _positionSpawn;
while {isDamageAllowed _vehicle} do {
    _vehicle allowDamage false;
};
_vehicle setPosATL _position; //Make sure it gets set onto the position.
_vehicle setDir _direction; //Set the vehicles direction the same as the marker.

if((_cfgInfo select 4) == "Autonomous") then
{
	createVehicleCrew _vehicle;
};

if(VVS_Checkbox) then
{
	clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
};

//hint format["Вы заспавнили %1",_displayName];
if(GameLanguage=="Russian") then {[format["%1 купил %2 за %3$",name player,_displayName,price]] remoteExec ["hint"];} 
else {[format["%1 bought %2 for %3$",name player,_displayName,price]] remoteExec ["hint"];};
sleep 3;
_vehicle allowDamage true;
closeDialog 0;
