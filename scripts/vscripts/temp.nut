    // =========================================================

    case "WaveNum":
        SetPropInt(resource, "m_nMannVsMachineWaveCount", value);
    break;

    // =========================================================

    case "MaxWaveNum":
        SetPropInt(resource, "m_nMannVsMachineMaxWaveCount", value);
    break;

    // =========================================================

    case "MultiSapper":
        function MissionAttributes::MultiSapperThink()
        {
            for (local sapper; sapper = FindByClassname("obj_attachment_sapper");)
                SetPropBool(sapper, "m_bDisposableBuilding", true);
        }
        MissionAttributes.ThinkTable.MultiSapperThink <- MissionAttributes.MultiSapperThink;
    break;
    
    // =========================================================