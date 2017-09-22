package com.test;

import com.cx.entity.Resource;
import com.cx.service.ResourceService;
import com.yd.epub.modules.parse.read.BookInfo;
import com.yd.epub.modules.parse.read.Reader;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.File;

/**
 * @Author: 冯冠凯
 * @Description:
 * @Date: Created on 2017/9/21
 * @Version: 1.0
 */
public class TestResource {

    ApplicationContext context;
    ResourceService resourceService;

    @Before
    public void before() {
        context = new ClassPathXmlApplicationContext("spring/spring.xml");
        resourceService = context.getBean(ResourceService.class);
    }

    @Test
    public void test01() {
        Resource resource = resourceService.selectById(6);
        System.out.println(resource.getRoute());
        BookInfo book = new Reader().read(new File("/temp.epub"), 20, 600, 800,1);
        System.out.println(book.getContents().get(1).getContent());
    }

    @Test
    public void test02() {
        Resource resource = resourceService.selectById(6);
        File file = new File(resource.getRoute());
        System.out.println(file.getAbsolutePath());
        BookInfo book = new Reader().read(file, 20, 600, 800,1);
    }
}
