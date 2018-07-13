/*
	fn_bonfireSystemPreInit
	by Bionic Abe Lincoln
	v 2017.2.11.1

	Args: none
 */

/*---------------------------------------------------------------------------
	Config Variables:  Edit for mission customization
---------------------------------------------------------------------------*/

// ** Teleporting **
// When false, players cannot teleport from a bonfire to any other bonfire.
BALBF_CFG_AllowTeleportingToBonfires = true;
// When false, players cannot teleport from a bonfire to any other player.
BALBF_CFG_AllowTeleportingToPlayers = true;

// **Teleporting per side**
BALBF_CFG_AllowTeleportingToBonfiresBlufor = true;
BALBF_CFG_AllowTeleportingToBonfiresOpfor = true;
BALBF_CFG_AllowTeleportingToBonfiresIndfor = true;
BALBF_CFG_AllowTeleportingToBonfiresCiv = true;

// ** Equipment **
// When false, the virtual arsenal cannot be accessed from any bonfire.
BALBF_CFG_EnableVirtualArsenal = true;

// ** Feedback **
// When false, players will never hear the global sound notifying them that a bonfire has been lit.
BALBF_CFG_BroadcastSoundOnLight = true;
// When false, players will never receive the global radio message notifying them that a bonfire has been lit.
BALBF_CFG_BroadcastMessageOnLight = true;

// ** Map **
// Determines how bonfires are displayed on the map.
// 0 = Bonfires never show up on the map.
// 1 = Only lit bonfires show up on the map.
// 2 = Both lit and unlit bonfires show up on the map.
BALBF_CFG_DisplayBonfiresOnMap = 2;
// Sets the icon used on the map for bonfires using values from Arma 3's CfgMarkers.  (Default is "mil_start")
BALBF_CFG_BonfireMapSymbol = "mil_start";
// Sets the color of unlit bonfires on the map using values from Arma 3's CfgMarkerColors.  (Default is "ColorBlack")
BALBF_CFG_BonfireMapColorDark = "ColorBlack";
// It's recommended to use a faction color here, such as "colorBLUFOR", "colorOPFOR", or "colorIndependent"
BALBF_CFG_BonfireMapColorLit = "colorBLUFOR";

// (None of the above variables are really designed to be changed mid-game.)

/*---------------------------------------------------------------------------
	Constants
---------------------------------------------------------------------------*/
BALBF_MISSION_ROOT = str missionConfigFile select [0, count str missionConfigFile - 15];

BALBF_ACTION_COLOR = "#ff6600";
BALBF_ACTION_COLOR_DISABLED = "#993300";

BALBF_ACTION_ARSENAL_COLOR = "#ff3300";

if (isDedicated || isServer) then
{
	missionNamespace setVariable ["BALBF_AllBonfires", [], true];
	missionNamespace setVariable ["BALBF_LitBonfires", [], true];
	missionNamespace setVariable ["BALBF_CanWarpToSquadmates", true, true];
	// BALBF_AllBonfires = [];
	// BALBF_LitBonfires = [];
	// BALBF_CanWarpToSquadmates = true;
	// publicVariable "BALBF_AllBonfires";
	// publicVariable "BALBF_LitBonfires";
	// publicVariable "BALBF_CanWarpToSquadmates";
}

