/*
Vray Render Settings
Author: Huey Yeng
URL: https://taukeke.com
Last updated: 02 November 2017
*/

global vr=renderers.current

-- Close and Reopen Render Setup Dialog because "Max UI Refresh Limitations" unlike Maya
global resetRdrSetup
fn resetRdrSetup = 
(
	renderSceneDialog.update()
)

-- Exposed Hidden Settings (no idea why Chaos Group doesn't make it the default...)
global vrayShowAll
fn vrayShowAll =
(
	vr.options_ui_view = 2 -- Expert View
	vr.colormapping_ui_view = 2 -- Expert View
	vr.dmc_ui_view = 1 -- Advanced View
	vr.gi_ui_view = 2 -- Expert View
	vr.lightcache_ui_view = 2
	vr.caustics_ui_view = 1
	vr.system_ui_view = 2
)

-- Functions
global vrayShortName
fn vrayShortName =
(
	str = classof renderers.current as string
	substring str 1 (str.count-8)
)


global vraySetAdv
fn vraySetAdv =
(
	--renderers.current = V_Ray_Adv_3_20_03()
	renderers.current = Vray()
)

global vraySetRT
fn vraySetRT =
(
	--renderers.current = V_Ray_RT_3_20_03()
	renderers.current = VrayRT()
)

global vrayLinearSpace
fn vrayLinearSpace =
(
	vr.colormapping_ui_view = 2 -- Expert View
	vr.colorMapping_type = 0 -- Linear Mapping
)

global vrayAdaptive
fn vrayAdaptive =
(
	vr.imageSampler_type = 1 -- Adaptive
	vr.filter_on = on
	vr.filter_kernel = Cook_Variable() -- For filter name with space/dash, use underscore instead
	vr.filter_size = 2.0
	vr.twoLevel_baseSubdivs = 1
	vr.twoLevel_fineSubdivs = 8
	vr.twoLevel_useDMCSamplerThresh = on
	vr.dmc_ui_view = 1
	vr.dmc_earlyTermination_amount = 0.9
	vr.dmc_earlyTermination_minSamples = 8
	vr.dmc_earlyTermination_threshold = 0.01 -- Default value. Draft: 0.1 or higher // Final: 0.003 to 0.01
)

global vrayMoBlurOn
fn vrayMoBlurOn =
(
	vr.moblur_on = on
	vr.moblur_duration = 0.5
	vr.moblur_intervalCenter = 0
	vr.moblur_geomSamples = 4
)

global vrayMoBlurOff
fn vrayMoBlurOff =
(
	vr.moblur_on = off
)

global vraySystem
fn vraySystem =
(
	vr.system_ui_view = 2
	vr.system_region_x = 24
	vr.system_region_y = 24
	vr.system_region_allow_dynamic_buckets = 1
	vr.system_lowThreadPriority = on
	vr.system_embree_on = on
	vr.system_embree_moblur = on
	vr.options_ui_view = 2
)

global vrayGI_ON
fn vrayGI_ON =
(
	vr.gi_on = true
	vr.gi_primary_type = 2
	vr.gi_secondary_type = 3
	vr.dmcgi_subdivs = 8
	vr.lightcache_subdivs = 1500
	vr.lightcache_multipleViews = on
	vr.lightcache_scale = 1
)

global vrayGI_OFF
fn vrayGI_OFF =
(
	vr.gi_on = false
)

global vrayRflRfc_ON
fn vrayRflRfc_ON =
(
	vr.options_reflectionRefraction = on
)

global vrayRflRfc_OFF
fn vrayRflRfc_OFF =
(
	vr.options_reflectionRefraction = false
)

global vrayGlossy_OFF
fn vrayGlossy_OFF =
(
	vr.options_glossyEffects = false
)

global vrayGlossy_ON
fn vrayGlossy_ON =
(
	vr.options_glossyEffects = on
)

global vrayMaps_OFF
fn vrayMaps_OFF =
(
	vr.options_maps = OFF
)

global vrayMaps_ON
fn vrayMaps_ON =
(
	vr.options_maps = on
)

global vrayLights_ON
fn vrayLights_ON =
(
	vr.options_lights = true
)

global vrayLights_OFF
fn vrayLights_OFF =
(
	vr.options_lights = false
)

global vrayShadows_ON
fn vrayShadows_ON =
(
	vr.options_shadows = true
)

global vrayShadows_OFF
fn vrayShadows_OFF =
(
	vr.options_shadows = false
)