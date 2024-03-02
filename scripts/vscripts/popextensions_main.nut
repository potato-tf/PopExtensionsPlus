local root = getroottable()

function Include(path)
{
	try IncludeScript(format("popextensions/%s", path), root) catch(e) printl(e)
}

Include("constants.nut") //constants must include first
Include("itemdef_constants.nut") //constants must include first
Include("util.nut") //must include second

Include("hooks.nut") //must include before popextensions
Include("popextensions.nut")

Include("robotvoicelines.nut") //must include before missionattributes
Include("missionattributes.nut")

Include("botbehavior.nut") //must include before tags
Include("tags.nut")

Include("globalfixes.nut")
Include("spawntemplate.nut")
Include("tutorialtools.nut")
