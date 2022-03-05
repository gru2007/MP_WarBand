/******         Database, Database, just living in the Database...       ******/
MPS_spawn_BDINIT = [] spawn {
  [] call ZONT_fnc_bd_initBasic;
  MPS_BDL_pres =
      ["profiles"] call ZONT_fnc_bd_initCustom;
  MPS_BDL_status =
      ["status"] call ZONT_fnc_bd_initCustom;
};

MPH_COMMITER = [{ [] call ZONT_fnc_commitInfo }, 20] call CBA_fnc_addPerFrameHandler;

/******                         Building system                           ******/
private _fortif_list = [
    ["Land_BagFence_Corner_F",10],
    ["Land_BagFence_Round_F",10],
    ["Land_BagFence_Short_F",10],
    ["Land_BagFence_Long_F",10],
    ["Land_fort_bagfence_long",15],
    ["Land_fort_bagfence_round",15],
    ["Land_fort_bagfence_corner",15],
    ["Land_Plank_01_4m_F",10],
    ["Land_HBarrierTower_F",50],
    ["Land_BagBunker_Large_F",50],
    ["Land_HBarrier_5_F",25],
    ["Land_Cargo_Patrol_V3_F",20],
    ["Land_BagBunker_Small_F",25],
    ["Land_Canal_WallSmall_10m_F",15],
    ["CamoNet_BLUFOR_big_F",15],
    ["Land_Research_house_V1_F",15],
    ["Land_Cargo_Tower_V1_F",50],
    ["Land_BarGate_F",15]
];
[west,       50, _fortif_list] call acex_fortify_fnc_registerObjects;
[east,       50, _fortif_list] call acex_fortify_fnc_registerObjects;
[resistance, 50, _fortif_list] call acex_fortify_fnc_registerObjects;
