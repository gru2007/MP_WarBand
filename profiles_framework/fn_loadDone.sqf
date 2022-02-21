params ["_equip", "_pos"];

if (not isNil "_equip") then {
  if (typeName [] == typeName _equip and {count _equip > 0}) then { player setUnitLoadout _equip };
};

if (not isNil "_pos") then {
  if (typeName [] == typeName _pos and {count _pos == 3}) then {
    if(GameLanguage=="Russian") then {
    private _tp = ["Телепортироваться на последнее сохранённое место?", "Warband Milsim", "Да", "Нет"]}
    else {
    private _tp = ["Teleport to last saved place?", "Warband Milsim", "Yes", "No"]
    };  
        call BIS_fnc_guiMessage;
    if (_tp) then { player setPosATL _pos };
  };
};

MPC_canSave = true
