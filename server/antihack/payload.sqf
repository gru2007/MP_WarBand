// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: payload.sqf
//	@file Author: AgentRev, Tonic, AWA (OpenDayZ.net)
//	@file Created: 01/06/2013 21:31

// This file can be moved to "A3Wasteland_settings\antihack" in order to be loaded externally from the server, which removes the need for it to be in the mission PBO

if (isServer || !hasInterface) exitWith {};

params ["_flagChecksum", "_rscParams"];
private ["_cheatFlag", "_cfgPatches", "_escCheck", "_patchClass", "_patchName", "_ctrlCfg", "_memAnomaly", "_currentRecoil", "_loopCount"];

waitUntil {!isNull player};

// diag_log "ANTI-HACK starting...";



for "_i" from 0 to (count _cfgPatches - 1) do
{

};

if (isNil "_cheatFlag" && _escCheck) then
{

};

if (isNil "_cheatFlag") then
{

};

// diag_log "ANTI-HACK: Starting loop!";