/// @desc Set Up UI
/*
	ctrlUI.Create
	-------------------------------------------------------------------------
	Script:			ctrlUI.Create
	Version:		v1.00
	Created:		15/11/2024 by Alun Jones
	Description:	Create the UI
	-------------------------------------------------------------------------
	History:
	 - Created 15/11/2024 by Alun Jones
	
	To Do:
*/

// Icon Frames
ICONFRAMES = [
	sprFrameDefault,
	sprFrameLJW,
	sprFrameTLNM,
	sprFrameLMSH2,
	sprFrameLTI,
	sprFrameLDCSV,
];

// Create Global Environment
ENVIRONMENT = new GlobalEnvironment();
ENVIRONMENT.add(new ViewerPanel());
ENVIRONMENT.add(new IconPanel());
ENVIRONMENT.addModal(new StartupModal());
ENVIRONMENT.openModal("Welcome");

// Initialize TSH
TSH = noone;
PRIMARY_SURFACE = noone;
SECONDARY_SURFACE = noone;