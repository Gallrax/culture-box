package com.test;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
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

    @Test
    public void test04() {
        List<Series> list = seriesService.selectList(new EntityWrapper<Series>().eq("1", "1"));
        for (Series series : list) {
            series.getImage();
            String route = series.getImage();
            String tempRoute = "";
            System.out.println(" old route : " + route);
            if (route.contains("文化盒子视频数据")) {
                String replace = route.replace("文化盒子视频数据", "mp4");
                if (route.contains("报告厅视频")) {
                    tempRoute = replace.replace("报告厅视频", "bgtsp");
                } else if (route.contains("超星课堂视频")) {
                    tempRoute = replace.replace("超星课堂视频", "cxktsp");
                } else if (route.contains("少儿视频")) {
                    tempRoute = replace.replace("少儿视频", "sesp");
                } else if (route.contains("微视频")) {
                    tempRoute = replace.replace("微视频", "wsp");
                } else {
                    tempRoute = replace;
                }
            } else if (route.contains("文化盒子图书数据")) {
                tempRoute = route.replace("文化盒子图书数据", "epub");
            } else if (route.contains("文化盒子音频整理")) {
                String replace = route.replace("文化盒子音频整理", "mp3");
                tempRoute = replace.replace("文化盒子\\", "");
            } else {
                System.out.println(" ---------- !!! ----------");
            }
            String result = tempRoute.replace("H:\\", "\\datas\\resources\\").replace("\\", "/");
            /*series.setImage(result);
            seriesService.updateById(series);*/
//            System.out.println(" new route : " + result);
        }
    }
}
