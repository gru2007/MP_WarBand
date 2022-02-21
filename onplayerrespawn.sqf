if (!hasInterface) exitWith { };
removeAllActions player;

if(GameLanguage=="Russian") then {
private _text = "";
switch (playerSide) do {
    case west: {_text = "<t color='#d40000' size='3'>Вы очнулись в медицинском блоке!</t><br/><t color='#ffffff' size='1'>Вы не помните, что с Вами случилось!</t>"};
		case resistance: {_text = "<t color='#d40000' size='3'>Вы очнулись в лагере!</t><br/><t color='#ffffff' size='1'>Вы не помните, что с Вами случилось!</t>"};
		case civilian: {_text = "<t color='#d40000' size='3'>Вы очнулись в незнакомом месте!</t><br/><t color='#ffffff' size='1'>Вы не помните, что с Вами случилось!</t>"};
		case east: {_text = "<t color='#d40000' size='3'>Вы очнулись в медицинском блоке!</t><br/><t color='#ffffff' size='1'>Вы не помните, что с Вами случилось!</t>"};
};
titleText [_text, "PLAIN", 0.2, true, true];}
else{
private _text = "";
switch (playerSide) do {
    case west: {_text = "<t color='#d40000' size='3'>You woke up in the medical unit!</t><br/><t color='#ffffff' size='1'>You don't remember what happened to you!</t>"};
		case resistance: {_text = "<t color='#d40000' size='3'>You woke up in the camp!</t><br/><t color='#ffffff' size='1'>You don't remember what happened to you!</t>"};
		case civilian: {_text = "<t color='#d40000' size='3'>You woke up in an unfamiliar place!</t><br/><t color='#ffffff' size='1'>You don't remember what happened to you!</t>"};
		case east: {_text = "<t color='#d40000' size='3'>You woke up in the medical unit!</t><br/><t color='#ffffff' size='1'>You don't remember what happened to you!</t>"};
};
titleText [_text, "PLAIN", 0.2, true, true];};

[] spawn {
	"dynamicBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [15];
	"dynamicBlur" ppEffectCommit 0;
	"dynamicBlur" ppEffectAdjust [0.0];
	"dynamicBlur" ppEffectCommit 5;
};

[player, {
private _curators = call ZONT_fnc_retrieveCurators;
if not ((getPlayerUID _this) in _curators) exitWith { };
_this call ZONT_fnc_giveZeus;
}] remoteExec ["bis_fnc_call", 2];

{ [_x select 0, player, _x select 1, true] spawn ZONT_fnc_addSkillAction } foreach MPC_skills_actions;
