_param = _this select 3;

switch (_param) do {
case("212"):
{
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

//основное
player forceAddUniform "212th_Clone_Phase1_Armor_212th";
player addVest "SWLB_clone_basic_armor";
player addBackpack "SWLB_clone_backpack";
player addHeadgear "212th_Phase_1_Helmet_212th";

//всякое
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "SWLB_comlink";
player linkItem "ItemGPS";
player linkItem "212th_JLTS_Clone_Helmet_NVG_Chip";

//оружие
player addWeapon "SWLB_clone_commander_binocular";
player addWeapon "212th_arifle_DC15A_F";
player addWeapon "212th_DC17";

//патрончики
//Не забывайте добавлять в initPlayerLocal.sqf (Может когда-то сделаю покрасивее :) )
player addMagazine "212th_35Rnd_DC15A_mag";
player addMagazine "212th_35Rnd_DC17_mag";

//хрень для лечения
for "_i" from 1 to 2 do {player addItemToBackpack "ACE_epinephrine";}; //Адреналин
for "_i" from 1 to 3 do {player addItemToBackpack "ACE_morphine";}; //Морфин
for "_i" from 1 to 4 do {player addItemToBackpack "ACE_tourniquet";}; //Жгуты
for "_i" from 1 to 2 do {player addItemToBackpack "ACE_splint";}; //Шины
for "_i" from 1 to 10 do {player addItemToBackpack "ACE_elasticBandage";}; //Давящая повязка
for "_i" from 1 to 5 do {player addItemToBackpack "ACE_packingBandage";}; //Тампонирующая
for "_i" from 1 to 2 do {player addItemToBackpack "kat_larynx";}; // KingLT

//По хорошему это надо сделать всё в функцию... Но это позже. Сейчас как-то лень :)
//Всё равно так же будет работать.

};
};