local root = getroottable()

function Include(path)
{
    IncludeScript("popextensions/" + path, root)
}

Include("constants.nut");
Include("util.nut");
Include("hooks.nut");
Include("popextensions.nut");
Include("robotvoicelines.nut");
Include("missionattributes.nut");
Include("botbehavior.nut");
Include("tags.nut");
Include("globalfixes.nut");
Include("spawntemplate.nut");
Include("reverse.nut");