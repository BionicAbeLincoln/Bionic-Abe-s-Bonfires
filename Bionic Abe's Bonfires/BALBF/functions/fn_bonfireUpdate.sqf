/*
	fn_bonfireUpdate
	by Bionic Abe Lincoln
	v 2017.2.11.1

	Removes the actions of all lit bonfires and replaces it with a refreshed list for the client it was called on.

	Args: none
 */

 try
 {
	if (!isDedicated) then
	{

		private _unsortedBonfires = +(missionNamespace getVariable "BALBF_LitBonfires");

		//_unsortedBonfires remoteExec ["diag_log", 2];

		private _litBonfires = [];

		// prepare the update
		// Create a list of bonfires ordered alphabetically by name.
		if (count _unsortedBonfires > 0) then
		{
			private _bonfireNames = [];

			{ _bonfireNames pushBack (_x getVariable "BALBF_Name"); } foreach _unsortedBonfires;

			_bonfireNames sort true;

			{
				private _name = _x;
				_litBonfires pushBack ((_unsortedBonfires select {_name == (_x getVariable "BALBF_Name")}) select 0);
			} foreach _bonfireNames;
		};

		// Get a selection of all living players on this player's side, excluding this player,
		private _warpPlayers = allPlayers - [player];

		private _st = "<t color='" + BALBF_ACTION_COLOR + "'>";
		private _sta = "<t color='" + BALBF_ACTION_ARSENAL_COLOR + "'>";
		private _et = "</t>";

		// execute update
		{
			private _bf = _x;
			// We also apply actions to the gun stuck in the fire to make a bigger target and remove the need to stare at the floor.
			private _g = nearestObject [_bf, "Weapon_srifle_LRR_F"];

			// Make sure the fire is lit
			_bf inflame true;

			// Make sure the marker has the correct color and name displayed
			private _marker = _bf getVariable "BALBF_MarkerName";
			_marker setMarkerColor BALBF_CFG_BonfireMapColorLit;
			_marker setMarkerText ((_bf getVariable "BALBF_Name") + " bonfire");

			// Make sure the marker is in the correct visible state per settings
			if (BALBF_CFG_DisplayBonfiresOnMap > 0) then
			{
				_marker setMarkerAlpha 1;
			};

			// remove existing actions
			removeAllActions _bf;
			removeAllActions _g;

			// add arsenal options
			if (BALBF_CFG_EnableVirtualArsenal) then
			{
				0 = _bf addAction [_sta + "Open Virtual Arsenal" + _et, {["Open", true] call BIS_fnc_arsenal;}, nil, 100, true, true, "", "true", 5];
				0 = _g addAction [_sta + "Open Virtual Arsenal" + _et, {["Open", true] call BIS_fnc_arsenal;}, nil, 100, true, true, "", "true", 5];
			};

			_priorityCounter = 98;

			// add player warps
			if ((BALBF_CFG_AllowTeleportingToPlayers) && (count _warpPlayers) > 0) then
			{
				{
					_bf addAction [format [_st + "Warp to %1" + _et, name _x], {
						_unit = _this select 1;
						_dest = _this select 3;
						[_unit, _dest, 2.5] call BALBF_fnc_bonfireTeleport;
					}, _x, _priorityCounter, false, true, "", "true", 5];

					_g addAction [format [_st + "Warp to %1" + _et, name _x], {
						_unit = _this select 1;
						_dest = _this select 3;
						[_unit, _dest, 2.5] call BALBF_fnc_bonfireTeleport;
					}, _x, _priorityCounter, false, true, "", "true", 5];

					_priorityCounter = _priorityCounter - 1;
				} foreach _warpPlayers;
			};

			// add bonfire warps
			if ((BALBF_CFG_AllowTeleportingToBonfires) && (count _litBonfires ) > 1) then
			{
				_warpBonfires = +_litBonfires;
				_warpBonfires deleteAt (_warpBonfires find _bf);

				{
					_bf addAction [format [_st + "Warp to %1" + _et, _x getVariable "BALBF_Name"], {
						_unit = _this select 1;
						_dest = _this select 3;
						[_unit, _dest, 3] call BALBF_fnc_bonfireTeleport;
					}, _x, _priorityCounter, false, true, "", "true", 5];

					_g addAction [format [_st + "Warp to %1" + _et, _x getVariable "BALBF_Name"], {
						_unit = _this select 1;
						_dest = _this select 3;
						[_unit, _dest, 3] call BALBF_fnc_bonfireTeleport;
					}, _x, _priorityCounter, false, true, "", "true", 5];

					_priorityCounter = _priorityCounter - 1;
				} foreach _warpBonfires;
			};

		} foreach _litBonfires;
	};

	true
 }
 catch
 {
	_exception call BIS_fnc_error;
	false
 };