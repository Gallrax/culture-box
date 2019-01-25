package com.cx.web;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cx.entity.Resource;
import com.cx.service.ResourceService;
import com.cx.util.EWUtil;
import com.cx.util.URLUtil;
import com.yd.epub.modules.parse.read.BookInfo;
import com.yd.epub.modules.parse.read.Reader;
import nl.siegmann.epublib.util.StringUtil;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.swing.text.html.parser.Entity;
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
        EWUtil.eqMap(ew, eqMap, false);
        List<Resource> resources = resourceService.selectList(ew.orderBy("innerId"));
        //增加调接口获取播放地址
        setUrlAndVideoUrlByObjectid(resources);
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
    public String epubRead(Integer id,
                           @RequestParam Integer width,
                           @RequestParam Integer height,
                           @RequestParam(required = false, defaultValue = "60") Integer fontSize,
                           @RequestParam(required = true, defaultValue = "1") Integer clientType,
                           HttpServletRequest request) {
        logger.info(" ---------- resource epubRead ---------- ");
        logger.info(" paramer : id : " + id + " width : " + width + " height : " + height + " clientType : " + clientType);
        Resource resource = resourceService.selectById(id);
        boolean judge = request.getRealPath("/").endsWith("/");
        String route = judge ? resource.getRoute().replaceFirst("/", "") : resource.getRoute();//windows获取路径尾部会加个斜杠，linux则不加斜杠
        logger.info(" tempPath : " + request.getRealPath("/"));
        String path = request.getRealPath("/") + route;
        logger.info(" path : " + path);
//        File file = new File(route.replaceFirst("/", ""));//需要将第一个/去掉，以防到根目录寻找资源
        BookInfo book = new Reader().read(new File(path), fontSize, width, height, clientType);
        return JSON.toJSONString(book);
    }

    public void setUrlAndVideoUrlByObjectid(List<Resource> resources) {
        for (Resource resource : resources) {
            if (!StringUtil.isEmpty(resource.getObjectid())) {
                setUrlAndVideoUrlByObjectid(resource);
            }
        }
    }

    public void setUrlAndVideoUrlByObjectid(Resource resource) {
        if (resource == null || resource.getObjectid().isEmpty()) return;
        try (CloseableHttpClient httpClient = HttpClientBuilder.create().build()) {
            HttpGet httpGet = new HttpGet("http://jpkc.yunya2.chaoxing.com/editor/cdn/status/" + resource.getObjectid());
            String result = EntityUtils.toString(httpClient.execute(httpGet).getEntity(), "UTF-8");
            logger.info(" result : " + result);
            JSONObject jsonObject = JSONObject.parseObject(result);
            if (jsonObject.get("status") != null && jsonObject.get("status").equals("success")) {
                resource.setRoute(jsonObject.get("http").toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
