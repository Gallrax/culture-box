package com.cx.web;


import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.cx.constant.Size;
import com.cx.entity.Series;
import com.cx.service.SeriesService;
import com.cx.util.EWUtil;
import com.cx.util.StringUtil;
import com.cx.util.URLUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

/**
 * @Author: 冯冠凯
 * @Description: 系列控制器
 * @Date: Created on 2017/9/12
 * @Version: 1.0
 */
@Controller
@RequestMapping("/series")
public class SeriesController {

    @Autowired
    private SeriesService seriesService;
    private static Logger logger = Logger.getLogger(SeriesController.class);

    /**
     * @Author: 冯冠凯 
     * @Description: 根据转码后的等值、模糊进行分页查询
     * @Date: Created on 2017/9/25
     * @Version: 1.0
     */
    @RequestMapping("/getByFields")
    @ResponseBody
    public String getByFields(String eq, String like, Integer page) {
        logger.info(" ---------- series getByFields ---------- ");
        EntityWrapper<Series> ew = new EntityWrapper<>();
        EWUtil.eqMap(ew, URLUtil.decodeAndMap(eq), false);
        EWUtil.likeMap(ew, URLUtil.decodeAndMap(like), true);
        Page<Series> pager = seriesService.selectPage(new Page<Series>(page == null ? 1 : page, Size.BIG_SIZE), ew.orderBy("insertTime", true));
        logger.info(" result pager : " + pager);
        if (StringUtil.judgeNotEmpty(like)) return JSON.toJSONString(pager);//如果like不为空则顺带返回查询结果总数
        return JSON.toJSONString(pager.getRecords());//如果like为空则说明不需要结果总数，只需返回数据即可
    }

    @RequestMapping("/getCountByField")
    @ResponseBody
    public Integer getCountByField(String eq, String like) {
        logger.info(" ---------- series getCountByField ---------- ");
        EntityWrapper<Series> ew = new EntityWrapper<>();
        EWUtil.eqMap(ew, URLUtil.decodeAndMap(eq), false);
        EWUtil.likeMap(ew, URLUtil.decodeAndMap(like), true);
        int count = seriesService.selectCount(ew);
//        Page<Series> pager = seriesService.selectPage(new Page<Series>(page == null ? 1 : page, Size.BIG_SIZE), ew.orderBy("insertTime", true));
        logger.info(" result count : " + count);
        return count;
    }

    /**
     * @Author: 冯冠凯
     * @Description: 根据分类父id进行查询
     * @Date: Created on 2017/9/25
     * @Version: 1.0
     */
    @RequestMapping("/getByPCid/{pcid}")
    @ResponseBody
    public List<Series> getByPCid(@PathVariable Integer pcid) {
        logger.info(" ---------- series getByPCid ---------- ");
//        List<Series> series = seriesService.selectByParentCategoryId(pcid, 0, Size.SMALL_SIZE);
        List<Series> series = seriesService.selectPage(
                new Page<Series>(1, 10),
                new EntityWrapper<Series>().eq("categoryPId", pcid).eq("isRecommend", 1).orderBy("updateTime", false))
                .getRecords();
        logger.info(" result series : " + series);
        return series;
    }

    @RequestMapping("/recommend/{id}")
    @ResponseBody
    public String recommend(@PathVariable Long id) {
        logger.info(" ---------- series recommend ---------- ");
        Series series = seriesService.selectById(id);
        series.setIsRecommend(1);
        series.setUpdateTime(new Date());
        try {
            seriesService.updateById(series);
        } catch (Exception e) {
            logger.info(" series recommend 发生异常 : "+ e.getMessage());
            e.printStackTrace();
            return "false";
        }
        return "success";
    }
}
