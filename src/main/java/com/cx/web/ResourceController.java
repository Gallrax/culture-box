package com.cx.web;


import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cx.entity.Resource;
import com.cx.service.ResourceService;
import com.cx.util.EWUtil;
import com.cx.util.URLUtil;
import com.yd.epub.modules.parse.read.BookInfo;
import com.yd.epub.modules.parse.read.Reader;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.File;
import java.util.List;
import java.util.Map;

/**
 * @Author: 冯冠凯
 * @Description: 资源控制器
 * @Date: Created on 2017/9/12
 * @Version: 1.0
 */
@Controller
@RequestMapping("/resource")
public class ResourceController {

    @Autowired
    private ResourceService resourceService;
    private static Logger logger = Logger.getLogger(ResourceController.class);

    /**
     * @Author: 冯冠凯
     * @Description: 根据转码后的等值进行分页查询
     * @Date: Created on 2017/9/25
     * @Version: 1.0
     */
    @RequestMapping("/getByFields")
    @ResponseBody
    public List<Resource> getByFields(String eq) {
        logger.info(" ---------- resource getByFields ---------- ");
        EntityWrapper<Resource> ew = new EntityWrapper<>();
        Map<String, String> eqMap = URLUtil.decodeAndMap(eq);//将eq进行解码并转为Map
        logger.info(" paramer : eqMap : " + eqMap);
        EWUtil.eqMap(ew, eqMap);
        List<Resource> resources = resourceService.selectList(ew.orderBy("innerId"));
        logger.info(" result : " + resources);
        return resources;
    }

    /**
     * @Author: 冯冠凯
     * @Description: 根据资源id查询资源，并通过epubReader进行编译
     * @Date: Created on 2017/9/25
     * @Version: 1.0
     */
    @RequestMapping("/epubRead")
    @ResponseBody
    public String epubRead(Integer id) {
        Resource resource = resourceService.selectById(id);
        String route = resource.getRoute();
        File file = new File(route);
        BookInfo book = new Reader().read(new File(file.getAbsolutePath()), 20, 600, 800,1);
        return JSON.toJSONString(book);
    }

}
