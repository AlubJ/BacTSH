/*
	BactaTankCharacter
	-------------------------------------------------------------------------
	Script:			BactaTankCharacter
	Version:		v1.00
	Created:		20/11/2024 by Alun Jones
	Description:	BactaTank Character Constructor
	-------------------------------------------------------------------------
	History:
	 - Created 20/11/2024 by Alun Jones
	
	To Do:
*/

enum BTCharacterVarients_TCS
{
	None,
	Padme,
	Anakin,
	Pod,
	Walker4Legs,
	Walker2Legs,
	Criter,
	BattleDroid,
	ObiwanKenobi,
	Fett,
	Wookie,
	Clone,
	HanSolo,
	Stormtooper,
	JediStarfighterEp3,
	HoverDroid,
	Lando,
	Luke,
	MaceWindu,
	Tie,
	NabooStarfighter,
	Leia,
	Rebel,
	RepublicGunship,
	Weirdo,
}
global.__characterVarientsTCS = ["None", "Padme", "Anakin", "Pod", "Walker4Legs", "Walker2Legs", "Criter", "BattleDroid", "ObiwanKenobi", "Fett", "Wookie", "Clone", "HanSolo",
								 "Stormtooper", "JediStarfighterEp3", "HoverDroid", "Lando", "Luke", "MaceWindu", "Tie", "NabooStarfighter", "Leia", "Rebel", "RepublicGunship", "Weirdo"];
#macro BT_CHARACTER_VARIENTS_TCS global.__characterVarientsTCS

function BactaTankCharacter() constructor
{
	// General Attributes
	name_id = 0;
	icon_id = "flom_icon";
	varient = BTCharacterVarients_TCS.None;
}