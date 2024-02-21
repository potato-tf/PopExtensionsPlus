local scripts = [
    "popextensions/constants.nut" //must be included first
    "popextensions/util.nut" //must be included second

    "popextensions/hooks.nut" //must be included before popextensions
    "popextensions/popextensions.nut" //must be included here, other files may depend on this one

    "popextensions/robotvoicelines.nut" //must be included before missionattributes.nut
    "popextensions/missionattributes.nut"
    
    "popextensions/botbehavior.nut" //must be included before tags.nut
    "popextensions/tags.nut"

    "popextensions/globalfixes.nut"
    "popextensions/spawntemplates.nut"
    "popextensions/reverse.nut"
]

foreach (script in scripts) try IncludeScript(script) catch(e);