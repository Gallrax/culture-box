package com.test;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cx.constant.Size;
import com.cx.entity.Category;
import com.cx.service.CategoryService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: 冯冠凯
 * @Description:
 * @Date: Created on 2017/9/12
 * @Version: 1.0
 */
public class TestCategory {

    ApplicationContext context;
    CategoryService categoryService;

    @Before
    public void before() {
        context = new ClassPathXmlApplicationContext("spring/spring.xml");
        categoryService = context.getBean(CategoryService.class);
    }

    @Test
    public void test01() {
        Category category = categoryService.selectById(1);
        System.out.println(category);
    }

    @Test
    public void test02() {
        int count = categoryService.selectCount(null);
        System.out.println(count);
    }

    @Test
    public void test03() {
        System.out.println(Size.SMALL_SIZE);
        HashMap map = JSON.parseObject(null, HashMap.class);
        System.out.println(map);
    }

    @Test
    public void test04() {
        Map<String, Object> map = new HashMap<String, Object>() {{
            //put("lv", "2");//数字和String都可
        }};
        List<Category> categories = categoryService.selectByMap(map);
        System.out.println(categories);
    }

    @Test
    public void test05() {
        List<Category> categories = categoryService.selectList(new EntityWrapper<Category>());
        for (Category category : categories) {
            Integer pid = category.getPid();
            System.out.println(" old category : " + category);
            if (pid == null) {
                continue;
            } else if (pid == 2) {
                category.setPid(1);
                categoryService.updateById(category);
            } else if (pid == 1) {
                category.setPid(2);
                categoryService.updateById(category);
            }
            System.out.println(" new category : " + category);
        }
    }

}
