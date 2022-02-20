//	edited by [TF]def 2015 09 20 (0.4.1)
/**/
//Only display vehicles for that players side, if true Opfor can only spawn Opfor vehicles and so on.
VVS_SideOnly = false;

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
VVS_CIS = [
	"C_Offroad_01_F"
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
