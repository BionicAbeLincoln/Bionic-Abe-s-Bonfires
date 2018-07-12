/*
	fn_bonfireTeleport
	by Bionic Abe Lincoln
	v 2017.2.11.1

	Teleport using special bonfire sounds and effects.

	Args: same as BAL_fnc_teleportBase
 */

0 = _this spawn
{
	_invulnTime = 10;

	_subject = _this select 0;

	// Use _subject to make sure that these teleport effects only apply to somebody who has teleported themselves.
	if (_subject == player) then
	{
		switch (currentWeapon player) do {
			case ("") : {player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";};
			case (binocular player): {player playMove "AinvPercMstpSoptWbinDnon_Putdown_AmovPercMstpSoptWbinDnon";};
			case (handgunWeapon player) : {player playMove "AinvPercMstpSrasWpstDnon_Putdown_AmovPercMstpSrasWpstDnon";};
			case (secondaryWeapon player) : {player playMove "AinvPercMstpSrasWlnrDnon_Putdown_AmovPercMstpSrasWlnrDnon";};
			case (primaryWeapon player) : {player playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";};

		};
		if (isClass (missionConfigFile >> 'CfgSounds' >> 'DSBonfireSit')) then { playSound "DSBonfireSit"; };
		cutText ["", "BLACK OUT", 0.6];
		sleep 0.6;
	};

	_this call BALBF_fnc_teleportBase;
	playSound3D [BALBF_MISSION_ROOT + "sfx\DSAreaTransition.ogg", _this select 0, false, getPosASL (_this select 0), 0.7];

	if (_subject == player) then
	{
		_subject allowDamage false;
		cutText ["", "BLACK IN", 0.4];
		sleep _invulnTime;
		_subject allowDamage true;
	};
};

true