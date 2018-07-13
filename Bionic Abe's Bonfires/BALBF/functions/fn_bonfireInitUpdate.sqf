/*
	fn_bonfireInitUpdate
	by Bionic Abe Lincoln
	v 2017.2.11.1

	When called from a client, sends the call to the server.
	When called from the server, updates all lit bonfires on all clients to show a refreshed menu.

	Args: none
 */

try
{
	if (isServer || isDedicated) then
	{
		// execute the update everywhere but a dedicated host.
		remoteExec ["BALBF_fnc_bonfireUpdate", [0, -2] select isDedicated];
	} else {
		// pass the signal for an update to the server.
		remoteExec ["BALBF_fnc_bonfireInitUpdate", 2];
	};
}
catch
{
	_exception call BIS_fnc_error;
	false
};