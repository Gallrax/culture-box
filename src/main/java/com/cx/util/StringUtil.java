package com.cx.util;

/**
 * @Author: 冯冠凯
 * @Description: String工具类
 * @Date: Created on 2017/9/14
 * @Version: 1.0
 */
public class StringUtil {

    public static boolean judgeEmpty(String str) {
        return str == null || str.isEmpty();
    }

    public static boolean judgeNotEmpty(String str) {
        return str != null && !str.isEmpty();
    }
}
