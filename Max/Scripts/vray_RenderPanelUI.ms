/*
VrayRender UI for 3ds Max
Author: Huey Yeng
URL: https://taukeke.com
Last updated: 31 October 2017
*/

renderSceneDialog.close()

vrayRdrSetPath = "vray_RenderSettings.ms"
fileIn vrayRdrSetPath

-- Set Initial Variables Here
rdrName = classof renderers.current as string
titlePrefix = "VrayRender UI "
titleVer = ( "v" + "0.01" )
titleFloater = ( titlePrefix + titleVer ) as string

global PCR = panel_CheckRenderer
global PIQ = panel_IQ
global PSY = panel_System
global PAB = panel_About

---------------------------------------------------------------
---------------------------------------------------------------

-- FUNCTION Retrieve Current Renderer Name
fn rdrCheck item =
(
	rdrName = classof renderers.current as string
	item.text = rdrName
	--item.text = vrayShortName()
)

-- FUNCTION Disabled Image Quality and System Rollouts
fn disableRO item = 
(
   roCtrl = item.controls
   for each in roCtrl do each.enabled = false
)

fn disableCheck =
(
	if (vrayShortName() == "V_Ray_Adv") then
	(
		print "Vray is already the active renderer!"
	)
	else
	(
		print "Disabling Vray rollouts..."
		disableRO PIQ
		disableRO PSY
	)	
)

---------------------------------------------------------------
---------------------------------------------------------------

-- Create Main Window

try( closeRolloutFloater mainFloater ) catch()
mainFloater = newRolloutFloater titleFloater 240 505

-- Create Rollouts for Main Window

rollout PCR "Current Renderer"
(
	label textCheckRenderer rdrName
	button setVrayAdv_BTN "Set VrayAdv"\
	tooltip:"Set V-Ray Renderer"\	
	across:3
	
	on setVrayAdv_BTN pressed do
	(
        vraySetAdv()
		rdrCheck textCheckRenderer
		global vr = renderers.current
		vrayShowAll() --vrayGI_OFF() vrayMoBlurOff()
		resetRdrSetup()
		for each in PIQ.controls do each.enabled = true
		for each in PSY.controls do each.enabled = true
    )
	
	button setVrayRT_BTN "Set VrayRT"\
	tooltip:"Set V-Ray RT Renderer"\	
	offset: [10,0]
	
	on setVrayRT_BTN pressed do
	(
        vraySetRT()
		disableCheck()
		rdrCheck textCheckRenderer
		global vr = renderers.current
		resetRdrSetup()
    )

	button rdrRefresh_BTN "Refresh"\
	tooltip:"Refresh and Check Active Renderer Name"\
	offset: [10,0]
	
	on rdrRefresh_BTN pressed do
	(
		disableCheck()
		rdrCheck textCheckRenderer
    )

	label textOutliner "Outliner for 3ds Max"
	button toggleOL_BTN "Toggle Outliner"\
	tooltip:"Open/Close Outliner Window"
	
	on toggleOL_BTN pressed do
	(
	try ( macros.run "Outliner" "toggleOutliner" )\
	catch ( messageBox "Outliner Macros is not installed!" )
	)
)

rollout PIQ "Image Quality" rolledUp: true
(
	button vrAdaptive_BTN "Use Adaptive Sampler"\
	tooltip: "Apply general purpose Adaptive values\nfor both animation and still images."\
	align: #center --offset: [30, 0]

	on vrAdaptive_BTN pressed do
	(
		vrayAdaptive()
		resetRdrSetup()
    )
	
	label vrMoBlur_LBL "Motion Blur"\
		align: #left\
		offset: [15, 0]
	radiobuttons vrMoBlur_RDO Labels:#("On", "Off")\
		default: 2\
		align: #right\
		offset: [-10, -19]
    on vrMoBlur_RDO changed state do
	(         
		 case vrMoBlur_RDO.state of
		 (
			 1:(vrayMoBlurOn(); print "Motion Blur On")
			 2:(vrayMoBlurOff(); print "Motion Blur Off")
		 )
    )
	
	label vrGI_LBL "Global Illumination"\
		align: #left\
		offset: [15, 0]
	radiobuttons vrGI_RDO labels:#("On", "Off")\
		default: 2\
		align: #right\
		offset: [-10, -19]
    on vrGI_RDO changed state do
	(
		 case vrGI_RDO.state of
		 (
			 1:(vrayGI_ON(); print "Global Illumination On")
			 2:(vrayGI_OFF(); print "Global Illumination Off")
		 )
    ) 		
	
	label lineBreakIQ_1 ""
	
	label headerToggleLS "Toggle Global Lights/Shadows" --align:#left offset: [15, 0]
	
	label vrLights_LBL "Lights"\
		align: #left\
		offset: [15, 0]
	radiobuttons vrLights_RDO labels:#("Enable", "Disable")\
		default: 1\
		align: #right\
		offset: [-10, -19]
    on vrLights_RDO changed state do
	(
		 case vrLights_RDO.state of
		 (
			 1:(vrayLights_ON(); print "Global Lights On")
			 2:(vrayLights_OFF(); print "Global Lights Off")
		 )
    ) 		
	
	label vrShadows_LBL "Shadows"\
		align: #left\
		offset: [15, 0]
	radiobuttons vrShadows_RDO  labels:#("Enable", "Disable")\
		default: 1\
		align: #right\
		offset: [-10, -19]
    on vrShadows_RDO changed state do
	(
		 case vrShadows_RDO.state of
		 (
			 1:(vrayShadows_ON(); print "Global Shadows On")
			 2:(vrayShadows_OFF(); print "Global Shadows Off")
		 )
    ) 		
	
	label lineBreakIQ_2 ""	

	/*
	checkbox chk_A "Checkbox A" checked:true
    on chk_A changed state do
	(
        print ("the state of the checkbox is:" + state as string)
    ) 	
	
	spinner spn_A "Spinner A" range:[0,10,1] type:#integer
    on spn_a changed val do
	(
        print ("the value is:" + val as string)
    ) 
	
	dropdownlist ddl_A "Presets" items:#("Draft","Default","Final")
    on ddl_A selected sel do
	(
        print ("The selection number was:" + sel as string)
        print ("The selected text was:" + ddl_A.selected)
    ) 
	

	listbox lbx_A "Listbox A" items:#("item1","item2","item3")
    on lbx_A selected sel do
	(
        print ("The selection number was:" + sel as string)
        print ("The selection number was:" + lbx_A.selection as string)
        print ("The selected text was:" + lbx_A.selected)
    )

	
	edittext edt_A "Edit Text A" text:"this is not a fish"
	on edt_A changed text do
	(
         print ("edt_A text is:" + text) 
    )
    on edt_A entered text do
	(
        print ("edt_A text entered was:" + text)
    )
	*/	
)

rollout PSY "Vray System Settings" rolledUp: true
(	
	button vrSystem_BTN "Use Recommended Settings" 
	button vrLinear_BTN "Set Linear Multiply Color Space"
	
	on vrSystem_BTN pressed do
	(
		vraySystem()
		resetRdrSetup()
    )
	on vrLinear_BTN pressed do
	(
		vrayLinearSpace()
		resetRdrSetup()
    )	
)

rollout PAB "About" rolledUp: false
(
	label textAuthor "Written by Huey Yeng"
	label textYear "Copyright \xa9 2016-2018"
	hyperlink textWeb "https://taukeke.com/" address: "https://taukeke.com/" hoverColor:( color 255 255 255 ) visitedColor:( color 250 210 255 ) align:#center
	--label textWarning "Use at your own risk!"
)

addrollout PCR mainFloater
addrollout PIQ mainFloater
addrollout PSY mainFloater
addrollout PAB mainFloater


---------------------------------------------------------------
---------------------------------------------------------------

if (vrayShortName() != "V_Ray_Adv") do
(
	disableRO PIQ
	disableRO PSY
)

renderSceneDialog.open()