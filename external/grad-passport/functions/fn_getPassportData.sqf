#include "script_component.hpp"

params [["_passportOwner",objNull]];



(([_passportOwner] call ace_common_fnc_getName) splitstring " ") params [["_zvanie","--"],["_name","--"],["_surname","--"]];

_nick = _surname + " " + _name;

_firstName = _passportOwner getVariable [QGVAR(firstName), _zvanie];
_lastName = _passportOwner getVariable [QGVAR(lastName), _nick];

private _dateOfBirth = _passportOwner getVariable [QGVAR(dateOfBirth),""];
if (_dateOfBirth == "") then {
    _currentYear = date select 0;
    (numberToDate [round ([_currentYear - 60,_currentYear - 25] call BIS_fnc_randomNum),random 1]) params ["_year","_month","_day"];
    _dateOfBirth = format ["%1%2.%3%4.%5",["","0"] select (_day<10),_day,["","0"] select (_month<10),_month,_year];
    _passportOwner setVariable [QGVAR(dateOfBirth),_dateOfBirth,true];
};

private _placeOfBirth = _passportOwner getVariable [QGVAR(placeOfBirth),""];
if (_placeOfBirth == "") then {
    _placeOfBirth =  switch (side _passportOwner) do {case west: { selectRandom ["New York", "Los Angeles", "Chicago", "Houston", "San Antonio", "San Diego", "Dallas", "San Francisco", "Seattle", "Boston", "Detroit", "Portland", "Las Vegas", "Baltimore", "Albuquerque", "Miami", "Minneapolis", "Orlando", "Birmingham"] };
	case east: { selectRandom ["Москва", "Брянск", "Ногинск", "Мурманск", "Владивосток", "Астрахань", "Ростов на Дону"] };case resistance: { selectRandom ["Кабул", "Кандагар", "Герат", "Мазари-Шариф", "Кундуз", "Джелалабад", "Талукан", "Чарикар", "Лашкаргах", "Шибарган", "Газни"] };
	case civilian: { selectRandom ["город1", "город2"] };default { "Unkown" }};
    _passportOwner setVariable [QGVAR(placeOfBirth),_placeOfBirth,true];
};

private _expires = _passportOwner getVariable [QGVAR(expires),""];
if (_expires == "") then {
    _currentYear = date select 0;
    (numberToDate [round ([_currentYear,_currentYear + 15] call BIS_fnc_randomNum),random 1]) params ["_year","_month","_day"];
    _expires = format ["%1%2.%3%4.%5",["","0"] select (_day<10),_day,["","0"] select (_month<10),_month,_year];
    _passportOwner setVariable [QGVAR(expires),_expires,true];
};

private _serial = _passportOwner getVariable [QGVAR(serial),""];
if (_serial == "") then {
    _serial = [10,[false,true,true,false,false,false,false,true,true,true]] call FUNC(generateSerial);
    _passportOwner setVariable [QGVAR(serial),_serial,true];
};

private _height = _passportOwner getVariable [QGVAR(height),""];
if (_height == "") then {
    _height = format ["%1 cm",round ([175,185] call BIS_fnc_randomNum)];
    _passportOwner setVariable [QGVAR(height),_height,true];
};

private _eyeColor = _passportOwner getVariable [QGVAR(eyeColor),""];
if (_eyeColor == "") then {
    _eyeColor = switch (playerSide) do {case west: { "USA" };case east: { "РФ" };case resistance: { "GUER" };case civilian: { "CIV" };default { "Unkown" }} ;
    _passportOwner setVariable [QGVAR(eyeColor),_eyeColor,true];
};

private _address = _passportOwner getVariable [QGVAR(address),"--"];
private _nationality = _passportOwner getVariable [QGVAR(nationality),"--"];
private _misc1 = _passportOwner getVariable [QGVAR(misc1),"--"];
private _misc2 = _passportOwner getVariable [QGVAR(misc2),"--"];


[_firstName,_lastName,_dateOfBirth,_placeOfBirth,_address,_expires,_serial,_height,_eyeColor,_nationality,_misc1,_misc2]
