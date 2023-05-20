package com.anifinders.safebox.helper.dynamo;

import java.util.HashMap;
import java.util.Map;

public class Gsi {
    public static Map<String, GsiMapper> safeBoxGSI= new HashMap<>() {
        {
            put("GSI1", new GsiMapper("GSI_HK_1", "GSI_RK_1", "GSI_HK_1-GSI_RK_1-index"));
            put("GSI2", new GsiMapper("GSI_HK_2", "GSI_RK_2", "GSI_HK_2-GSI_RK_2-index"));
        }
    };
}


