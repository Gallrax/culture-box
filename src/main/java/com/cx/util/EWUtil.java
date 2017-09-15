package com.cx.util;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.apache.log4j.Logger;

import java.util.Map;

/**
 * @Author: 冯冠凯
 * @Description:
 * @Date: Created on 2017/9/14
 * @Version: 1.0
 */
public class EWUtil {

    private static Logger logger = Logger.getLogger(EWUtil.class);

    public static void eqMap(EntityWrapper ew, Map<String, String> map) {
        logger.info(" EWUtil eqMap param : map - "+ map);
        if(ew == null) throw new RuntimeException(" EWUtil eqMap ew is null !!!");
        for (String s : map.keySet()) {
            ew.eq(s, map.get(s));
        }
    }

    public static void likeMap(EntityWrapper ew, Map<String, String> map) {
        logger.info(" EWUtil likeMap param : map - "+ map);
        if(ew == null) throw new RuntimeException(" EWUtil likeMap ew is null !!!");
        for (String s : map.keySet()) {
            ew.like(s, map.get(s));
        }
    }
}
