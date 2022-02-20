//Counts AI in groups ID 1 and ID 2 +shows fps
private["_count1","_count2","_count3","_count4"];
if(isNil("diagHint"))then{diagHint = true;}else{
	if(diagHint)then{diagHint = false; hint "";}else{diagHint = true;};
};

while{diagHint}do{ 

_east = ({side _x == east} count allunits)-1;

hint parseText format["<t size='1.25' font='puristaMedium' color='#ff0000'>Дроидов осталось:</t> <t size='1.5' font='puristaMedium' color='#ffffff'>%1</t>",_east];

sleep 5;

};