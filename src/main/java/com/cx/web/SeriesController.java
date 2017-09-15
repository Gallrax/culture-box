package com.cx.web;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.cx.constant.Size;
import com.cx.entity.Series;
import com.cx.service.SeriesService;
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
 * <p>
 * InnoDB free: 34816 kB; (`categoryId`) REFER `culture-box/cx_category`(`id`) 前端控制器
 * </p>
 *
 * @author Gallrax
 * @since 2017-09-12
 */
@Controller
@RequestMapping("/series")
public class SeriesController {

    @Autowired
    private SeriesService seriesService;
    private static Logger logger = Logger.getLogger(SeriesController.class);

    @RequestMapping("/getByFields")
    @ResponseBody
    public List<Series> getByFields(String eq, String like, Integer page) {
        logger.info(" ---------- series getByFields ---------- ");
        EntityWrapper<Series> ew = new EntityWrapper<>();
        Map<String, String> eqMap = URLUtil.decodeAndMap(eq);//将eq进行解码并转为Map
        Map<String, String> likeMap = URLUtil.decodeAndMap(like);//将eq进行解码并转为Map//将like进行解码并转为Map
        logger.info(" paramer : eqMap : " + eqMap + " likeMap : " + likeMap);
        EWUtil.eqMap(ew, eqMap);
        EWUtil.likeMap(ew, likeMap);
        List<Series> series = seriesService.selectPage(
                new Page<Series>(page == null ? 1 : page, Size.SMALL_SIZE), ew.orderBy("insertTime", true))
                .getRecords();
        logger.info(" result series : " + series);
        return series;
    }

    @RequestMapping("/getByPCid/{pcid}")
    @ResponseBody
    public List<Series> getByPCid(@PathVariable Integer pcid) {
        logger.info(" ---------- series getByPCid ---------- ");
        List<Series> series = seriesService.selectByParentCategoryId(pcid, 0, Size.SMALL_SIZE);
        logger.info(" result series : " + series);
        return series;
    }
}
