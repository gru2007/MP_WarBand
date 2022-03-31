this setVariable ["Users", [["password","admin"]]];
this setVariable ["AFS", ["/home/admin",[["test",["t","e","s","t"," ","t","e","x","t"],"admin",[7,4,0]]],"PUBLIC",[7,7,7]]];
this setVariable ["CurUser", "PUBLIC"];this setVariable ["ComputerName", "Baikal Secure Machine"];
this setVariable ["ComputerState", "COMMANDLINE"];
this setVariable ["CommandLine", []];
this setVariable ["Computercolor", "#33CC33"];
this setVariable ["STEED", []];
this setVariable ["devMode", false];this addAction["Использовать ПК","external\computer\armaTerminal.sqf", []];