package com.test;

import com.alibaba.fastjson.JSON;
import com.cx.entity.Series;
import com.cx.service.SeriesService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

/**
 * @Author: 冯冠凯
 * @Description:
 * @Date: Created on 2017/9/14
 * @Version: 1.0
 */
public class TestSeries {

    ApplicationContext context;
    SeriesService seriesService;

    @Before
    public void before() {
        context = new ClassPathXmlApplicationContext("spring/spring.xml");
        seriesService = context.getBean(SeriesService.class);
    }

    @Test
    public void test01() {
        List<Series> series = seriesService.selectList(null);
        System.out.println(series);
    }

    @Test
    public void test02() {
        Series series = seriesService.selectById(1);
        series.setId(null);
        String[] temp = new String[]{"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"};
        for (int i = 0; i < 10; i++) {
            series.setName(temp[i] + i);
            seriesService.insert(series);
        }
    }

    @Test
    public void test03() {
        Series series = seriesService.selectById(1);
        String s = JSON.toJSONString(series);
        System.out.println(s);
    }
}
