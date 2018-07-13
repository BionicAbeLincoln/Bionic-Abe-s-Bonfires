/*
	fn_bonfireLight
	by Bionic Abe Lincoln
	v 2017.2.11.1

	Light a bonfire and connect it to the system.

	Args: [_bf, (_player), (_silent)]
	_bf: object - the bonfire we're lighting.
	_player (optional): object - the player who lit this bonfire.  Only optional if _silent is true.
	_silent (optional): bool - default value is false.  The bonfire lights without sound or message   Set to true for bonfires that start lit.
 */

private _bf = param [0, objNull, [objNull]];
private _silent = param [1, false, [false]];

try
{
	if ((isNil {_bf}) || (isNull _bf)) throw ["InvalidArgument _bf"];

	// diag_log text format ["Beginning BAL_fn_bonfireLight for %1",  name player];
/*	if (!_silent) then {
		(text format ["Beginning BALBF_fnc_bonfireLight for %1",  name player]) remoteExec ["diag_log", 2];
	};
*/
	private _litBonfires = missionNamespace getVariable ["BALBF_LitBonfires", []];

	// diag_log _litBonfires;
	//if (!_silent) then { _litBonfires remoteExec ["diag_log", 2]; };

	_litBonfires pushBackUnique _bf;

	// diag_log text "has been updated to";
	// diag_log _litBonfires;
	/*if (!_silent) then {
		(text "has been updated to") remoteExec ["diag_log", 2];
		(_litBonfires) remoteExec ["diag_log", 2];
	};*/

	missionNamespace setVariable ["BALBF_LitBonfires", _litBonfires, true];

	(_bf getVariable "BALBF_MarkerName") setMarkerColor BALBF_CFG_BonfireMapColorLit;
	(_bf getVariable "BALBF_MarkerName") setMarkerText ((_bf getVariable "BALBF_Name") + " bonfire");

	if (!_silent) then
	{
		if (!isDedicated) then
		{
			0 = [_bf, player] spawn {
				switch (currentWeapon player) do {
					case ("") : {(_this select 1) playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";};
					case (binocular player): {(_this select 1) playMove "AinvPercMstpSoptWbinDnon_Putdown_AmovPercMstpSoptWbinDnon";};
					case (handgunWeapon player) : {(_this select 1) playMove "AinvPercMstpSrasWpstDnon_Putdown_AmovPercMstpSrasWpstDnon";};
					case (secondaryWeapon player) : {(_this select 1) playMove "AinvPercMstpSrasWlnrDnon_Putdown_AmovPercMstpSrasWlnrDnon";};
					case (primaryWeapon player) : {(_this select 1) playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";};

				};
				sleep 0.5;
				(_this select 0) inflame true;
				playSound3D [BALBF_MISSION_ROOT + "sfx\DSKindle.ogg", _this select 0];
				sleep 0.4;
				if (BALBF_CFG_BroadcastSoundOnLight) then { remoteExec ["BALBF_fnc_bonfireLitSound", [0, -2] select isDedicated]; };
				if (BALBF_CFG_BroadcastMessageOnLight) then { _this remoteExec ["BALBF_fnc_bonfireLitMessage"]; };
			};
		} else {
			if (BALBF_CFG_BroadcastSoundOnLight) then { remoteExec ["BALBF_fnc_bonfireLitSound", [0, -2] select isDedicated]; };
			if (BALBF_CFG_BroadcastMessageOnLight) then { _this remoteExec ["BALBF_fnc_bonfireLitMessage"]; };
		};
	};

	_bf setVariable ["BALBF_Lit", true, true];

	// Remove the light action from the bonfire
	call BALBF_fnc_bonfireInitUpdate;
}
catch
{
	_exception call BIS_fnc_error;
	false
};