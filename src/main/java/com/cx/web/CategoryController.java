package com.cx.web;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cx.entity.Category;
import com.cx.service.CategoryService;
import com.cx.util.EWUtil;
import com.cx.util.URLUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * @Author: 冯冠凯
 * @Description: 分类控制器
 * @Date: Created on 2017/9/12
 * @Version: 1.0
 */
@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;
    private static Logger logger = Logger.getLogger(CategoryController.class);

    /**
     * @Author: 冯冠凯
     * @Description: 根据分类父id查询所以子分类
     * @Date: Created on 2017/9/25
     * @Version: 1.0
     */
    @RequestMapping("/getByPid/{pid}")
    @ResponseBody
    public List<Category> getByLv(@PathVariable Integer pid) {
        List<Category> categories = categoryService.selectList(new EntityWrapper<Category>().eq("pid", pid));
        return categories;
    }

    /**
     * @Author: 冯冠凯
     * @Description: 根据转码后的等值进行查询
     * @Date: Created on 2017/9/25
     * @Version: 1.0
     */
    @RequestMapping("/getByFields")
    @ResponseBody
    public List<Category> getByFields(String eq) {
        logger.info(" ---------- resource getByFields ---------- ");
        EntityWrapper<Category> ew = new EntityWrapper<>();
        Map<String, String> eqMap = URLUtil.decodeAndMap(eq);//将eq进行解码并转为Map
        logger.info(" paramer : eqMap : " + eqMap);
        EWUtil.eqMap(ew, eqMap, false);
        List<Category> categories = categoryService.selectList(ew.orderBy("insertTime", false));
        return categories;
    }

}
