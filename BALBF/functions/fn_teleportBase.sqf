/*
	fn_teleportBase
	by Bionic Abe Lincoln
	v 2017.2.11.1

	Move an object from one position to another.  No special effects.

	Args: [_subject, _destination, (_offset)]
	_subject: 		object 						- the object to be moved.
	_destination: 	object, string, position 	- the target destination.  teleport to an object,
												  to a marker with the string name, or to a position.
	_offset (optional):	number					- distance from the _destination object in meters.  Default value is 3 for humans,
												  8 for anything else.
 */

private["_subject", "_destination", "_pos", "_dir", "_offset"];

_subject = 		param [0, objNull, [objNull]];
_destination = 	param [1, objNull, [objNull, "", []], [3]];
_offset = 		param [2, -1, [0]];

try
{
	if ((isNil {_subject}) || (isNull _subject)) throw ["InvalidArgument _subject"];
	if (isNil {_destination}) throw ["InvalidArgument _destination"];

	_pos = 0;
	_dir = 0;

	switch (typeName _destination) do
	{
		case "ARRAY":
		{
			_pos = _destination;
			_dir = getDir _subject;
		};

		case "GROUP":
		{
			_pos = getPosATL (leader _destination);

			// If the destination is a person, put the _subject behind them to prevent people getting shot.
			if ((leader _destination) isKindOf "Man") then
			{
				_dir = getDir leader _destination;
				if (_offset == -1) then { _offset = 3 };
			}
			else
			{
				_dir = random 359;
				if (_offset == -1) then { _offset = 8 };
			};

			if (!(_pos isEqualTo [0,0,0])) then
			{
				_pos set [0, (_pos select 0) - _offset * sin(_dir)];
				_pos set [1, (_pos select 1) - _offset * cos(_dir)];
			};
		};

		case "OBJECT":
		{
			_pos = getPosATL _destination;

			// If the destination is a person, put the _subject behind them to prevent people getting shot.
			if (_destination isKindOf "Man") then
			{
				_dir = getDir _destination;
				if (_offset == -1) then { _offset = 3 };
			}
			else
			{
				_dir = random 359;
				if (_offset == -1) then { _offset = 8 };
			};

			if (!(_pos isEqualTo [0,0,0])) then
			{
				_pos set [0, (_pos select 0) - _offset * sin(_dir)];
				_pos set [1, (_pos select 1) - _offset * cos(_dir)];
			};
		};

		case "STRING":
		{
			_pos = getMarkerPos _destination;
			_dir = markerDir _destination;
		};
	};

	if (_pos isEqualTo [0,0,0]) then
	{
		hint "Something's wrong with that destination.";
	}
	else
	{
		_subject setVehiclePosition [_pos, [], 0, "CAN_COLLIDE"];
		_subject setDir _dir;
	};

	true
}
catch
{
	_exception call BIS_fnc_error;
	false
};