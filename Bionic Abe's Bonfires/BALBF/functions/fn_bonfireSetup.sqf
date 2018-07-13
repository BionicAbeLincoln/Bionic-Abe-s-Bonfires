/*
	fn_bonfireSetup
	by Bionic Abe Lincoln
	v 2017.2.11.1

	Put in the init of a bonfire to set it up.
	Remember to give the bonfire a role description for its displayed name.

	Args: [_bf, _name, (_alreadyLit)]
	_bf: object - the bonfire we're setting up.
	_name: string - display name of this bonfire.

	Optional:
	_alreadyLit: bool - true if this bonfire starts lit, false by default.
	_onLight: code - code to be called when the bonfire is lit. (Unimplemented)
 */

private _bf = param [0, objNull, [objNull]];
private _name = param [1, "unnamed", [""]];
private _startsLit = param [2, false, [false]];
private _onLight = param [3, {}, [{}, ""]];

 try
 {
 	private _g = nearestObject[_bf, "Weapon_srifle_LRR_F"];

	if ((isNil {_bf}) || (isNull _bf)) throw ["InvalidArgument _bf"];

	if (isServer) then {
		// record name
		_bf setVariable ["BALBF_Name", _name, true];
	};

	// Create a marker on the bonfire
	private _marker = createMarker ["bf_marker_" + (_name splitString " " joinString ""), _bf];
	_marker setMarkerColor BALBF_CFG_BonfireMapColorDark;
	_marker setMarkerType BALBF_CFG_BonfireMapSymbol;
	_marker setMarkerSize [0.75, 0.75];

	if (BALBF_CFG_DisplayBonfiresOnMap < 2) then  { _marker setMarkerAlpha 0; };

	if (isServer) then {
		_bf setVariable ["BALBF_MarkerName", _marker, true];
		_bf setVariable ["BALBF_Lit", _startsLit, true];
	};

	if (_startsLit) then
	{
		if (isServer) then {
			// use silent lighting function
			[_bf, true] call BALBF_fnc_bonfireLight;
		};
	}
	else
	{
		// add action for lighting
		private _actionID = _bf addAction ["<t color='" + BALBF_ACTION_COLOR + "'>Light bonfire</t>",{ [_this select 0] call BALBF_fnc_bonfireLight; }, nil, 5, true, true, "", "true", 4];
		_g addAction ["<t color='" + BALBF_ACTION_COLOR + "'>Light bonfire</t>",{ [_this select 3] call BALBF_fnc_bonfireLight; }, _bf, 5, true, true, "", "true", 4];
	};

	if (isServer) then {
		private _allBonfires = missionNamespace getVariable "BALBF_AllBonfires";
		_allBonfires pushBackUnique _bf;
		missionNamespace setVariable ["BALBF_AllBonfires", _allBonfires, true];
	};

	true
 }
 catch
 {
	_exception call BIS_fnc_error;
	false
 };