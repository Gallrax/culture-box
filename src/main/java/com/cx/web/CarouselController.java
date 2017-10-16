package com.cx.web;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.cx.constant.Size;
import com.cx.entity.Carousel;
import com.cx.service.CarouselService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Date;
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
        List<Carousel> carousels = carouselService.selectPage(new Page<Carousel>(1, Size.CAROUSEL_SIZE),
                new EntityWrapper<Carousel>().in("status", new Integer[]{0, 1}).orderBy("insertTime", false)).getRecords();
        logger.info(" result : " + carousels);
        return carousels;
    }

    /**
     * @Author: 冯冠凯
     * @Description: 更改首页轮播图个数
     * @Date: Created on 2017/10/13
     * @Version: 1.0
     */
    @RequestMapping("/changeSize")
    @ResponseBody
    public String changeCount(Integer size) {
        logger.info(" ---------- /carousel/changeSize ----------");
        logger.info(" 参数 size : " + size);
        if (size == null || size < 1 || size > 4) return "false";
        Size.CAROUSEL_SIZE = size;
        return "success";
    }

    /**
     * @Author: 冯冠凯
     * @Description: 推送轮播图
     * @Date: Created on 2017/10/13
     * @Version: 1.0
     */
    @RequestMapping("/add")
    @ResponseBody
    public String add(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        logger.info(" ---------- /carousel/add ----------");
        String[] tempStr = file.getOriginalFilename().split("\\.");
        String path = request.getServletContext().getRealPath("/datas/carousel/");//获取的路径会去掉最后的/,因此要在name前加/
        String carouselName = "/carousel-" + System.currentTimeMillis() + "." + tempStr[tempStr.length - 1];
        logger.info(" new carouselName : " + carouselName);
        String carouselPath = path + "/" + carouselName;
        logger.info(" carouselPath : " + carouselPath);
        File tempFile = new File(carouselPath);
        try {
            file.transferTo(tempFile);
            Carousel carousel = new Carousel();
            carousel.setImage("/datas/carousel/" + carouselName);
            carousel.setStatus(1);
            carousel.setInsertTime(new Date());
            logger.info(" carousel : " + carousel);
            carouselService.insert(carousel);
        } catch (IOException e) {
            logger.info(" carousel add 发生异常 : " + e.getMessage());
            e.printStackTrace();
            return "false";
        }
        return "success";
    }

    /**
     * @Author: 冯冠凯
     * @Description: 下线轮播图
     * @Date: Created on 2017/10/13
     * @Version: 1.0
     */
    @RequestMapping("/delete/{id}")
    @ResponseBody
    public String delete(@PathVariable Integer id) {
        logger.info(" ---------- /carousel/delete ----------");
        Carousel carousel = carouselService.selectById(id);
        logger.info(" carousel : " + carousel);
        if (carousel == null) return "false";
        carousel.setStatus(-1);
        carouselService.updateById(carousel);
        return "success";
    }

}
