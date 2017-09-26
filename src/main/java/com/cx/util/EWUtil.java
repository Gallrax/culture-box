package com.cx.util;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.apache.log4j.Logger;

import java.util.Map;

/**
 * @Author: 冯冠凯
 * @Description: 将map与EntityWrapper进行封装
 * @Date: Created on 2017/9/14
 * @Version: 1.0
 */
public class EWUtil {

    private static Logger logger = Logger.getLogger(EWUtil.class);

    /**
     * @Author: 冯冠凯
     * @Description: 相等的map封装至EntityWrapper
     * @Date: Created on 2017/9/25
     * @Version: 1.0
     */
    public static void eqMap(EntityWrapper ew, Map<String, String> map, Boolean isOr) {
        logger.info(" EWUtil eqMap param : map - " + map);
        if (ew == null) throw new RuntimeException(" EWUtil eqMap ew is null !!!");
        if(isOr && !map.isEmpty()) {
            ew.andNew();//前置后置括号自动设置，无需关心
        }
        int temp = 0;
        for (String s : map.keySet()) {
            if (isOr && temp > 0) ew.or();
            ew.eq(s, map.get(s));
            temp++;
        }
    }

    /**
     * @Author: 冯冠凯
     * @Description: 模糊的map封装至EntityWrapper
     * @Date: Created on 2017/9/25
     * @Version: 1.0
     */
    public static void likeMap(EntityWrapper ew, Map<String, String> map, Boolean isOr) {
        logger.info(" EWUtil likeMap param : map - " + map);
        if (ew == null) throw new RuntimeException(" EWUtil likeMap ew is null !!!");
        if(isOr && !map.isEmpty()) ew.andNew();//前置后置括号自动设置，无需关心
        int temp = 0;
        for (String s : map.keySet()) {
            if (isOr && temp > 0) ew.or();
            ew.like(s, map.get(s));
            temp++;
        }
    }
}
