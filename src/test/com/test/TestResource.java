package com.test;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cx.entity.Resource;
import com.cx.entity.Series;
import com.cx.service.ResourceService;
import com.cx.service.SeriesService;
import com.yd.epub.modules.parse.read.BookInfo;
import com.yd.epub.modules.parse.read.Reader;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.File;
import java.util.List;

/**
 * @Author: 冯冠凯
 * @Description:
 * @Date: Created on 2017/9/21
 * @Version: 1.0
 */
public class TestResource {

    ApplicationContext context;
    ResourceService resourceService;
    SeriesService seriesService;

    @Before
    public void before() {
        context = new ClassPathXmlApplicationContext("spring/spring.xml");
        resourceService = context.getBean(ResourceService.class);
        seriesService = context.getBean(SeriesService.class);
    }

    @Test
    public void test01() {
        Resource resource = resourceService.selectById(6);
        System.out.println(resource.getRoute());
        BookInfo book = new Reader().read(new File("/temp.epub"), 20, 600, 800, 1);
        System.out.println(book.getContents().get(1).getContent());
    }

    @Test
    public void test02() {
        Resource resource = resourceService.selectById(6);
        File file = new File(resource.getRoute());
        System.out.println(file.getAbsolutePath());
        BookInfo book = new Reader().read(file, 20, 600, 800, 1);
    }

    @Test
    public void test03() {
        List<Resource> resources = resourceService.selectList(new EntityWrapper<Resource>().eq("1", "1"));
        for (Resource resource : resources) {
            String route = resource.getRoute();
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
            resource.setRoute(result);
            resourceService.updateById(resource);
            System.out.println(" new route : " + result);
        }
    }

    @Test
    public void test04() {
        String tempStr = "ABCD";
        String replace = tempStr.replace("BC", "ZZ");
        System.out.println(replace);
    }

    @Test
    public void test05() {
        Resource resource = resourceService.selectById(6);
        System.out.println(resource.getRoute());
        System.out.println(resource.getRoute().replaceFirst("/", ""));
    }

    @Test
    public void test06() {
        List<Series> seriesList = seriesService.selectList(new EntityWrapper<Series>().eq("type", "epub"));
        System.out.println(seriesList.size());
        for (Series series : seriesList) {
            List<Resource> resources = resourceService.selectList(new EntityWrapper<Resource>().eq("seriesId", series.getId()));
            for (Resource resource : resources) {
                String route = resource.getRoute();
                String substring = route.substring(26, route.length());
                String[] split = substring.split("\\.");
                String tempStr = route.substring(0, 26) +
                        split[0].toLowerCase()
                        + "."
                        + split[1];
                System.out.println( " old : "+route);
                System.out.println( " new : "+tempStr);
                resource.setRoute(tempStr);
                resourceService.updateById(resource);
            }
        }
    }

    @Test
    public void test07() {
        String tempStr = "/datas/resources/epub/EPUB/TSas12a.epub";
        String substring1 = tempStr.substring(0, 26);
        String substring2 = tempStr.substring(26, tempStr.length());
        String[] strings = substring2.split("\\.");
        String str = substring1 + strings[0].toLowerCase() + "." + strings[1];
        System.out.println(substring1);
        System.out.println(substring2);
        System.out.println(str);
//        String s = tempStr.toUpperCase();
//        System.out.println(s);
    }
}
