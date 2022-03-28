if(GameLanguage=="Russian") then {
TAG_fnc_Article ={
[
[
["title","Самолёт C-192 упал на жилой дом"],
["meta",["Екатирина Святославская",[2015,3,15,11,38],"CET"]],
["textbold","Кому нужна эта война?"],
["image",["\a3\missions_f_orange\data\img\orange_overview_ca.paa",""]],
["box",["\a3\ui_f_curator\data\cfgdiaryimages\altis\kalochori_ca.paa","СРОЧНО! Видео с БПЛА НАТО! СМОТРЕТЬ ВСЕМ!"]],
["text","Сегодня в 11 часов утра доставлялось снабжение бойцам НАТО в котле. Но Российское ПВО сбило грузовой самолёт на подлёте, из-за чего он упал в жилой дом, разрушив его. Кол-во жертв пока что неизвестно, мы всё ещё продолжаем слежить за ситуацией."],
["textlocked",["Продолжение...","Оформите подписку"]],
["author",["\a3\Missions_F_Orange\Data\Img\avatar_journalist_ca.paa","Журналист Екатирина"]]
]
] call BIS_fnc_showAANArticle;
};

player createDiaryRecord ["diary", ["Новости", "
<execute expression='[] call TAG_fnc_Article'>Самолёт</execute>
"]];
} else {
TAG_fnc_Article ={
[
[
["title","The C-192 plane crashed into a residential building"],
["meta",["Ekaterina Svyatoslavskaya",[2015,3,15,11,38],"CET"]],
["textbold","Who needs this war?"],
["image",["\a3\missions_f_orange\data\img\orange_overview_ca.paa",""]],
["box",["\a3\ui_f_curator\data\cfgdiaryimages\altis\kalochori_ca.paa","URGENT! Video from a NATO UAV! EVERYONE WATCH!"]],
["text","Supplies were delivered to NATO fighters in the boiler at 11 a.m. today. But the Russian air defense shot down a cargo plane on approach, which caused it to fall into a residential building, destroying it. The number of victims is still unknown, we are still monitoring the situation."],
["textlocked",["Continuation...","Subscribe to see more"]],
["author",["\a3\Missions_F_Orange\Data\Img\avatar_journalist_ca.paa","Journalist Ekaterina"]]
]
] call BIS_fnc_showAANArticle;
};

player createDiaryRecord ["diary", ["News", "
<execute expression='[] call TAG_fnc_Article'>AirPlane</execute>
"]];
};