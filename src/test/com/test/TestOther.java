package com.test;

import org.junit.Test;

import java.io.File;

/**
 * @Author: 冯冠凯
 * @Description:
 * @Date: Created on 2017/10/12
 * @Version: 1.0
 */
public class TestOther {

    @Test
    public void test01() {
        File file = new File("datas/logo");
        String path = file.getPath();
        String absolutePath = file.getAbsolutePath();
        System.out.println(path);
        System.out.println(absolutePath);
    }
}
