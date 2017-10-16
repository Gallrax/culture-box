package com.cx.web;

import com.cx.constant.Logo;
import com.cx.constant.Size;
import com.cx.service.SeriesService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

/**
 * @Author: 冯冠凯
 * @Description: Index控制器
 * @Date: Created on 2017/9/12
 * @Version: 1.0
 */
@Controller
@RequestMapping("/")
public class IndexController {

    @Autowired
    private SeriesService seriesService;
    private static Logger logger = Logger.getLogger(IndexController.class);

    /**
     * @Author: 冯冠凯
     * @Description: 静态页面跳转
     * @Date: Created on 2017/9/25
     * @Version: 1.0
     */
    @RequestMapping(value = {"/*.html", "/", "/**/*.html"})
    public String index(HttpServletRequest request) {
        String uri = request.getRequestURI();
        request.setAttribute("_logo", Logo.name);
        request.setAttribute("_carouselSize", Size.CAROUSEL_SIZE);
        System.out.println(request.getAttribute("_logo"));
        logger.info(" ---------- uri : " + uri + " ----------");
        if ("/".equals(uri)) return "index";
        return uri.substring(1, uri.length() - 5);
    }

    @RequestMapping("/changeLogo")
    @ResponseBody
    public String changeLogo(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        logger.info(" ---------- changeLogo ----------");
        String[] tempStr = file.getOriginalFilename().split("\\.");
        String path = request.getServletContext().getRealPath("/datas/logo/");//获取的路径会去掉最后的/,因此要在name前加/
        String logoName = "logo-" + System.currentTimeMillis() + "." + tempStr[tempStr.length - 1];
        logger.info(" new logoName : "+ logoName);
        String logoPath = path + "/" + logoName;
        logger.info(" logoPath : "+ logoPath);
        File tempFile = new File(logoPath);
        try {
            file.transferTo(tempFile);
            Logo.name = logoName;
        } catch (IOException e) {
            logger.info(" changeLogo 发生异常 : "+ e.getMessage());
            e.printStackTrace();
            return "false";
        }
        return "success";
    }

}
