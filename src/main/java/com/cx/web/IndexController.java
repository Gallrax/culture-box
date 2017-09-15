package com.cx.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @Author: 冯冠凯
 * @Description:
 * @Date: Created on 2017/9/12
 * @Version: 1.0
 */
@Controller
@RequestMapping("/")
public class IndexController {

    @RequestMapping(value = {"/*.html", "/"})
    public String index(HttpServletRequest request) {
        String uri = request.getRequestURI();
        if("/".equals(uri)) return "index";
        return uri.substring(1, uri.length() - 5);
    }
}
