/*
Create Render Filename/Directory Output
Author: Huey Yeng
URL: https://taukeke.com
Last updated: 21 April 2018
*/

renderSceneDialog.close() -- Necessary to ensure filename are applied properly
global render_folder = "DEBUG"

-- Functions goes here --
fn createOutputDir pathOutputDir filename = 
(
	warning_text = render_folder + " directory already exists!"
	
	if (doesFileExist pathOutputDir) then
	(
		messageBox warning_text
	)
	else
	(
 		makeDir pathOutputDir
 		messagebox (pathOutputDir + " was successfully created.")
 		rendOutputFilename = pathOutputDir + filename
	)
)
-- Functions ends here--


-- Since "\"" is an escape character, use "\\" for directory separator
-- TODO: Use @ character aka Verbatim String for file path strings?

drive = "P:\\"  -- Drive letter or volume path to projects
project = "DQ"  -- Project Name or equivalent
output_dir =  "Output"  -- The output directory (set to where your render output goes)
output_path = drive + "\\" + project + "\\\\" + output_dir + "\\\\"  -- The final render path

filepath = maxFilePath
filename = maxFileName

-- Debugging purpose
-- filename = "s002c002A_BG_v001.max"
-- filename = "s002c002A_BG_Utility_Render_v001.max"
-- filename = "s002c002A_FX_Firaga_Beauty_Render_v001.max"

token_a = "\\"
token_b = "_ ."

a = filterString filepath token_a splitEmptyTokens:false
b = filterString filename token_b splitEmptyTokens:true

render_path = output_path + a[4] + "\\\\" + a[5] + "\\\\"

if (b.count == 5) then
	render_folder = b[1] + "_" + b[2] + "_" + b[3] + "_" + b[4]
else if (b.count == 6) then
	render_folder = b[1] + "_" + b[2] + "_" + b[3] + "_" + b[5]
else if (b.count == 7) then
	render_folder = b[1] + "_" + b[2] + "_" + b[3] + "_" + b[4] + "_" + b[6]

r_filename = render_folder + "." + ".exr"
r_filepath = render_path + render_folder + "\\\\"

popup_text = ("This will be your output name:" + "\n" + render_filename)

if (queryBox popup_text == true) then
	createOutputDir r_filepath r_filename
else
	messageBox "Process aborted by user!"
