scriptName "fn_quickFunctions:";
/*
	Author: Daniel Stone <ninjakow@gmail.com>
	v 2017.4.15.1

	Description:
	Declares several quick functions that are used in BALBF.

	Parameter(s):
	none

	Returns:
	none
*/
#define SELF _fnc_fn_quickFunctions


/*
	Takes a side argument and returns the appropriate marker color from CfgMarkerColors.

	Parameter(s):
	_side:

	Returns:
	String of a color from CfgMarkerColors.
*/
BALBF_SideToMarkerColor = {
	private _side = param [0, sideUnknown, [sideUnknown]];

	private _result = "Default";

	// the game has multiple aliases for the same colors, like ColorWEST = ColorBLUFOR.
	// We could strictly match sides to their aliases, but for now I'm going to be going with
	// the more modern alias.
	switch (_side) do
	{
		case blufor:
		case west:
		{
			_result = "ColorBLUFOR";
		};

		case opfor:
		case east:
		{
			_result = "ColorOPFOR";
		};

		case independent:
		case resistance:
		{
			_result = "ColorIndependent";
		};

		case civilian:
		{
			_result = "ColorCivilian";
		};

		default
		{
			_result = "Default";
		};
	};

	_result
};