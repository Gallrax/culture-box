package com.test;

import com.alibaba.fastjson.JSON;
import org.junit.Test;

import java.io.File;
import java.util.HashMap;

/**
 * @Author: 冯冠凯
 * @Description:
 * @Date: Created on 2017/10/12
 * @Version: 1.0
 */
public class TestOther {

    @Test
    public void test01() {
        File file = new File("D:\\Program Files (x86)\\JetBrains\\ChaoXProjects\\culture-box\\src\\main\\webapp\\datas\\logo");
        System.out.println(file.exists());
        String path = file.getPath();
        String absolutePath = file.getAbsolutePath();
        System.out.println(path);
        System.out.println(absolutePath);
    }

    @Test
    public void test02() {
        String json = "{\"categoryId\":11}";
        HashMap<String, String> map = JSON.parseObject(json, HashMap.class);
        for (String o : map.keySet()) {
            System.out.println("key : " + o + " value : " + map.get(o));
        }
    }
}
