package com.cx.web;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cx.entity.Category;
import com.cx.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * InnoDB free: 34816 kB; (`pid`) REFER `culture-box/cx_category`(`id`) 前端控制器
 * </p>
 *
 * @author Gallrax
 * @since 2017-09-12
 */
@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @RequestMapping("/getByPid/{pid}")
    @ResponseBody
    public List<Category> getByLv(@PathVariable Integer pid) {
        List<Category> categories = categoryService.selectList(new EntityWrapper<Category>().eq("pid", pid));
        return categories;
    }

    @RequestMapping("/getByFields")
    @ResponseBody
    public List<Category> getByFields(Map<String, Object> map) {
        List<Category> categories = categoryService.selectByMap(map);
        return categories;
    }

}
