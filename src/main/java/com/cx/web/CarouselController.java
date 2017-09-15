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
 * <p>
 * InnoDB free: 34816 kB 前端控制器
 * </p>
 *
 * @author Gallrax
 * @since 2017-09-13
 */
@Controller
@RequestMapping("/carousel")
public class CarouselController {

    @Autowired
    private CarouselService carouselService;
    private static Logger logger = Logger.getLogger(CarouselController.class);

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
