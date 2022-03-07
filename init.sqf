0 fadeRadio 0;
enableRadio false;
enableSentences false;
enableSaving [false, false];
CHVD_maxView = 3000; // Set maximum view distance (default: 12000)
CHVD_maxObj = 2600; // Set maximimum object view distance (default: 12000)

[] execVM "external\Vcom\VcomInit.sqf";

if (hasInterface) then { 
    [] spawn { 
        waitUntil {alive player}; 
        player setVariable ["loadout",getUnitLoadout player,false]; 
        player addEventHandler ["Respawn", { 
            player setUnitLoadout (player getVariable "loadout"); 
        }]; 
    }; 
};
