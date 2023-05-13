package com.anifinders.safebox.helper.dynamo;

import java.util.HashMap;
import java.util.Map;

public class CompareOperator {
    private static Map<String, String> operators = new HashMap<>() {
        {
            put("EQUAL", "=");
            put("LESSorEQUAL", "<=");
            put("LESS", "<");
            put("GREATERorEQUAL", ">=");
            put("GREATER", ">");
            put("BETWEEN", "");
            put("BEGINWITH", "");
        }
    };

    public static String operatorEqual(String keyName, String valueName) {
        return keyName + " = " + valueName;
    }

    public static String operatorGreater(String keyName, String valueName) {
        return keyName + " > " + valueName;
    }

    public static String operatorGreaterOrEqual(String keyName, String valueName) {
        return keyName + " >= " + valueName;
    }

    public static String operatorLess(String keyName, String valueName) {
        return keyName + " < " + valueName;
    }

    public static String operatorLessOrEqual(String keyName, String valueName) {
        return keyName + " <= " + valueName;
    }

    public static String operatorBegin (String keyName, String valueName) {
        return "begins_with(" + keyName + ", " + valueName + ")";
    }

    public static String operatorBetween (String keyName, String valueName1, String valueName2) {
        return keyName + " between " + valueName1 + " and " + valueName2 + ")";
    }
}
