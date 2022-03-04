//	edited by [TF]def 2015 09 20 (0.4.1)
/**/
//Only display vehicles for that players side, if true Opfor can only spawn Opfor vehicles and so on.
VVS_SideOnly = true;

//Only set to true if you are making pre-made vehicle lists with VVS_x (i.e VVS_Car)
VVS_Premade_List = false;

/*
									Pre-set VVS Vehicles
		This is similar to VAS's functionality, using these variables will only make those vehicles available.
		Leave them the way they are if you want to auto-fetch the entire vehicle config and list every vehicle.

		Example:
		VVS_Car = ["C_Offroad_01_F","C_Quadbike_01_F"];
		VVS_Air = ["B_Heli_Light_01_armed_F"];
*/

VVS_Car = [
"3AS_Barc",
"3AS_Saber_m1",
"3AS_Saber_m1G",
"3AS_Saber_m1Recon",
"3AS_Saber_AA",
"3AS_RTT",
"3AS_ATTE_Base",
"RD501_warden_tank_field"
];

VVS_Air = [
"3AS_LAAT_Mk1",
"3AS_LAAT_Mk1Lights",
"3AS_LAATC",
"3AS_V19_Base"
];

VVS_Car_Mercenary = [

	];

VVS_Air_Mercenary = [

	];



VVS_RF = [
	"rhsgref_BRDM2_ATGM_msv",
	"rhs_t90a_tv",
	"rhs_gaz66_zu23_msv",
	"rhs_kamaz5350_msv",
	"rhs_kamaz5350_flatbed_cover_msv",
	"RHS_Ural_Fuel_MSV_01",
	"RHS_Ural_Ammo_MSV_01",
	"RHS_Ural_Repair_MSV_01",
	"rhs_tigr_m_msv",
	"rhs_tigr_sts_msv",
	"rhs_btr80_msv",
	"rhs_btr80a_msv",
	"rhs_bmp2_msv",
	"rhsgref_BRDM2_HQ_msv",
	"rhsgref_BRDM2_msv",
	"rhs_gaz66_ammo_msv",
	"RHS_UAZ_MSV_01"
	];
VVS_RF_Air = [
	"B_Heli_Light_01_armed_F",
	"RHS_Mi8mt_Cargo_vvs"
	];
	
VVS_NATO = [
	"rhsusf_m113_usarmy_medical",
	"rhsusf_M977A4_REPAIR_usarmy_wd",
	"rhsusf_M978A4_usarmy_wd",
	"rhsusf_mrzr4_d",
	"rhsusf_stryker_m1132_m2_wd",
	"RHS_M2A3_wd",
	"RHS_M6_wd",
	"rhsusf_m1a1fep_wd",
	"rhsusf_m1025_w_mk19",
	"rhsusf_m966_w",
	"rhsusf_m1025_w_m2",
	"rhsusf_m1151_m2_v2_usarmy_wd",
	"rhsusf_m1025_w",
	"rhsusf_m1240a1_m2_usarmy_wd",
	"rhsusf_m1240a1_mk19_uik_usarmy_wd",
	"rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy",
	"rhsusf_M1083A1P2_B_WD_fmtv_usarmy",
	"LOP_CHR_Civ_Landrover",
	"rhsusf_M1085A1P2_B_WD_Medical_fmtv_usarmy"
	];
VVS_NATO_Air = [
	"B_Heli_Light_01_armed_F",
	"RHS_UH60M2"
	];



VVS_Ship = [];
VVS_Armored = [];
VVS_Autonomous = [];
VVS_Support = [];

VVS_Civ_Land = [

];

/*
									Vehicle restriction
		Again, similar to VAS's functionality. If you want to restrict a specific vehicle you can do it or
		you can restrict an entire vehicle set by using its base class.

		Example:
		VVS_Car = ["Quadbike_01_base_F"]; //Completely removes all quadbikes for all sides
		VVS_Air = ["B_Heli_Light_01_armed_F"]; //Removes the Pawnee
*/
VVS_R_Car = [
	"RD501_Warhammer_Republic",
	"Barc_91",
	"RD501_warden_tank_field",
	"RD501_bantha_501st_MkI",
	"rd501_sw_barc",
	"OPTRE_M812_TT",
	"Shadow_TX130",
	"OPTRE_M813_TT",
	"RD501_Longbow_Republic",
	"RD501_fast_infantry_transport_republic_medic",
	"RD501_light_infantry_transport_Rep_MkII",
	"3as_saber_m1",
	"3as_saber_m1Recon",
	"3as_saber_super",
	"3as_saber_m1G",
	"3as_UTAT",
	"3AS_BarcSideCar",
	"3as_Jug",
	"3as_RTT",
	"3as_AV7",
	"SWLG_tanks_tx130",
	"RD501_saber_republic_super_saber_MkII",
	"B_mako_Edessan_Tur_F",
	"C_mako_m32_FCW_F",
	"C_M080apc1_FCW_F"	,
	"Corp99_Dagor_unarmed",
	"Corp99_DAGOR_AT"
			];
VVS_R_Air = [
	"RD501_LAAT_Mk3",
	"RD501_LAAT_spec_ops",
	"B_BSCI212thWampalead_GAR_LAAT_IMK1_01",
	"RD501_delta_7a_Mk2",
	"O_T_VTOL_02_infantry_dynamicLoadout_F",
	"O_OCISHumanDivision_Local_Militial_Air_Transport_01",
	"RD501_Y_wing_MkII",
	"RD501_ARC_170_MKII",
	"RD501_v_wing_MKII",
	"MEOP_veh_kodiakArm_old",
	"MEOP_veh_turKod_hier",
	"3as_LAAT_Mk1",
	"3as_LAAT_Mk3",
	"3as_LAAT_Mk2",
	"3as_LAAT_Mk2Lights",
	"3AS_Nuclass",
	"3as_arc_170_red",
	"3as_arc_170_razor",
	"3as_arc_170_blue",
	"3as_arc_170_green",
	"3as_arc_170_yellow",
	"3as_arc_170_Orange",
	"3as_Z95_Republic"
];
VVS_R_Ship = [];
VVS_R_Armored = [];
VVS_R_Autonomous = [];
VVS_R_Support = [];
