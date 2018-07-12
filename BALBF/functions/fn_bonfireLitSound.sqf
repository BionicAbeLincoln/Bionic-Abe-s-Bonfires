/*
	fn_bonfireLitSound
	by Bionic Abe Lincoln
	v 2017.2.11.1

	An experiment to see if remote playSound can be used to play different sounds for different people.

	Args: none
 */

try
{
	/*switch (BAL_myBonfireSounds) do
	{
		case 1: {
			if (isClass (missionConfigFile >> 'CfgSounds' >> 'DSBonfireLit')) then { playSound "DSBonfireLit"; };
		};
		case 2: {
			if (isClass (missionConfigFile >> 'CfgSounds' >> 'MGS5MissionQualify')) then { playSound "MGS5MissionQualify"; };
		};
		default: {
			if (isClass (missionConfigFile >> 'CfgSounds' >> 'DSBonfireLit')) then { playSound "DSBonfireLit"; };
		}
	};*/

	if (isClass (missionConfigFile >> 'CfgSounds' >> 'DSBonfireLit')) then { playSound "DSBonfireLit"; };
}
catch
{
	_exception call BIS_fnc_error;
	false
};