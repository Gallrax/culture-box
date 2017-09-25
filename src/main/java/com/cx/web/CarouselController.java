package com.cx.web;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.cx.constant.Size;
import com.cx.entity.Carousel;
import com.cx.service.CarouselService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Author: 冯冠凯
 * @Description: 轮播图控制器
 * @Date: Created on 2017/9/12
 * @Version: 1.0
 */
@Controller
@RequestMapping("/carousel")
public class CarouselController {

    @Autowired
    private CarouselService carouselService;
    private static Logger logger = Logger.getLogger(CarouselController.class);

    /**
     * @Author: 冯冠凯
     * @Description: 根据默认分页大小查询轮播图
     * @Date: Created on 2017/9/25
     * @Version: 1.0
     */
    @RequestMapping("/getByPage")
    @ResponseBody
    public List<Carousel> getByPage() {
        logger.info(" ---------- carousel getByPager ----------");
        List<Carousel> carousels = carouselService.selectPage(new Page<Carousel>(1, Size.SMALL_SIZE),
                new EntityWrapper<Carousel>().orderBy("insertTime", false)).getRecords();
        logger.info(" result : "+ carousels);
        return carousels;
    }

}
