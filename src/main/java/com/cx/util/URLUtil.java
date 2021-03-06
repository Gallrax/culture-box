package com.cx.util;

import com.alibaba.fastjson.JSON;
import org.apache.log4j.Logger;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

/**
 * @Author: 冯冠凯
 * @Description: 对URL操作工具类
 * @Date: Created on 2017/9/14
 * @Version: 1.0
 */
public class URLUtil {

    private static Logger logger = Logger.getLogger(URLUtil.class);

    /**
     * @Author: 冯冠凯 
     * @Description: 普通解码
     * @Date: Created on 2017/9/25
     * @Version: 1.0
     */
    public static String decode(String str) {
        logger.info(" URLUtil decode : " + str);
        if(str == null || str.isEmpty()) return null;
        String result = null;
        try {
            result = URLDecoder.decode(str, "UTF-8");
            logger.info(" decode result : " + str);
        } catch (UnsupportedEncodingException e) {
            logger.info(" URLUtil decode exception message : " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    /**
     * @Author: 冯冠凯 
     * @Description: 普通编码
     * @Date: Created on 2017/9/25
     * @Version: 1.0
     */
    public static String encode(String str) {
        logger.info(" URLUtil decode : " + str);
        if(str == null || str.isEmpty()) return null;
        String result = null;
        try {
            result = URLEncoder.encode(str, "UTF-8");
            logger.info(" decode result : " + str);
        } catch (UnsupportedEncodingException e) {
            logger.info(" URLUtil decode exception message : " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    /**
     * @Author: 冯冠凯 
     * @Description: 解码并将返回值转换为map
     * @Date: Created on 2017/9/25
     * @Version: 1.0
     */
    public static Map<String, String> decodeAndMap(String str) {
        logger.info(" URLUtil decode : " + str);
        String result = decode(str);
        logger.info(" decode result : " + str);
        HashMap<String, String> map = JSON.parseObject(result, HashMap.class);
        logger.info(" result : " + map);
        return map == null ? new HashMap<String, String>() : map;
    }
}
