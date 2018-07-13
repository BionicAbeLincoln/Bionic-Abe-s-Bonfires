/*
	fn_bonfireLitMessage
	by Bionic Abe Lincoln
	v 2017.2.11.1

	Displays a message about a bonfire being lit on the client's radio chat.

	Args: [_bf, (_player)]
	_bf: object - the bonfire we're lighting.

	Optional:
	_player: object - the player who lit the bonfire.
 */

private _bf = param [0, objNull, [objNull]];
private _player = param [1, objNull, [objNull]];

try
{
	if (isNil {_bf}) throw ["InvalidArgument _bf"];

	private _message = "";

	if (!isNull _player) then
	{
		_message = format ["%1 has lit the %2 bonfire.", name _player, _bf getVariable "BALBF_Name"];
	} else {
		_message = format ["The %1 bonfire is now lit.", _bf getVariable "BALBF_Name"];
	};

	systemChat _message;
}
catch
{
	_exception call BIS_fnc_error;
	false
};