package com.cx.web;

import com.cx.service.SeriesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

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

    /**
     * @Author: 冯冠凯
     * @Description: 静态页面跳转
     * @Date: Created on 2017/9/25
     * @Version: 1.0
     */
    @RequestMapping(value = {"/*.html", "/", "/**/*.html"})
    public String index(HttpServletRequest request) {
        String uri = request.getRequestURI();
        if("/".equals(uri)) return "index";
        return uri.substring(1, uri.length() - 5);
    }

}
