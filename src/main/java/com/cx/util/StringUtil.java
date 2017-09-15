package com.cx.util;

/**
 * @Author: 冯冠凯
 * @Description:
 * @Date: Created on 2017/9/14
 * @Version: 1.0
 */
public class StringUtil {

    public static boolean judgeEmpty(String str) {
        return str == null || str.isEmpty();
    }

    public static boolean jusgeNotEnmty(String str) {
        return str != null && !str.isEmpty();
    }
}
