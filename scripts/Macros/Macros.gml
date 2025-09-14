/*
	Macros
	-------------------------------------------------------------------------
	Script:			Macros
	Version:		v1.00
	Created:		15/11/2024 by Alun Jones
	Description:	Globally Used Macros
	-------------------------------------------------------------------------
	History:
	 - Created 15/11/2024 by Alun Jones
	
	To Do:
*/

// Global Version
#macro VERSION 0.011

// Run From IDE
#macro RUN_FROM_IDE parameter_count() == 3 && string_count("GMS2TEMP", parameter_string(2))

// Debug Output
#macro DBGOUT show_debug_message
#macro DBGMSG ($"{_GMFILE_}.{_GMFUNCTION_} line:{_GMLINE_}    -")

// File System
#macro TEMP_DIRECTORY		global.__tempDirectory__
#macro CONFIG_DIRECTORY		global.__configDirectory__
#macro WORKING_DIRECTORY	global.__workingDirectory__

// Graphics
#macro WINDOW_SIZE			global.__windowSize__
#macro CURSOR_POSITION		global.__cursorPosition__

// Global Vars
#macro SETTINGS				global.__settings__
#macro CONFIG				global.__config__
#macro ADDONS				global.__addons__
#macro ABOUT				global.__about__
#macro VERSIONS				global.__versions__
#macro VERSION_TAG			global.__versionTag__

// Environment
#macro FONT					global.__font__
#macro ENVIRONMENT			global.__environment__
#macro ICONFRAMES			global.__iconFrames__
#macro TSH					global.__tshFile__
#macro TSH_NAME				global.__tshName__
#macro PRIMARY_SURFACE		global.__primarySurface__
#macro SECONDARY_SURFACE	global.__secondarySurface__