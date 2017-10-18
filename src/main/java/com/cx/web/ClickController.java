package com.cx.web;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cx.entity.Click;
import com.cx.service.ClickService;
import com.cx.util.EWUtil;
import com.cx.util.URLUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * @Author: 冯冠凯
 * @Description:
 * @Date: Created on 2017/10/17
 * @Version: 1.0
 */
@Controller
@RequestMapping("/click")
public class ClickController {

    @Autowired
    private ClickService clickService;
    private static Logger logger = Logger.getLogger(ClickController.class);

    @RequestMapping("/add")
    public void add(@RequestParam(required = true) String innerId, String outterId) {
        logger.info(" ---------- /click/add ---------- ");
        logger.info(" param : innerId : " + innerId + " outterId : " + outterId);
        Integer type = outterId == null || outterId.isEmpty() ? 2 : 1;//防止outterId为""
        Click click = clickService.selectOne(new EntityWrapper<Click>().eq("innerId", innerId).eq("type", type));//防止分类id和资源id重复
        if (click != null) {
            Integer tempClick = click.getClick();
            click.setClick(++tempClick);
            clickService.updateById(click);
        } else if (click == null) {
            click = new Click();
            click.setInnerId(innerId);
            click.setOutterId(outterId);
            click.setType(type);
            click.setClick(1);
            clickService.insert(click);
        }
    }

    @RequestMapping("/getByFields")
    @ResponseBody
    public Integer getByFields(String eq) {
        logger.info(" ---------- /click/getByFields ---------- ");
        EntityWrapper<Click> ew = new EntityWrapper<>();
        Map<String, String> eqMap = URLUtil.decodeAndMap(eq);//将eq进行解码并转为Map
        logger.info(" paramer : eqMap : " + eqMap);
        EWUtil.eqMap(ew, eqMap, false);
        Integer count = 0;
        if (eqMap.containsKey("outterId")) {//当查询的是一级分类是，查询的为分类下所有分类的点击量
            List<Click> clicks = clickService.selectList(ew);
            for (Click click : clicks) {
                count += click.getClick();
            }
        } else {//二级分类或者资源则查单个
            Click click = clickService.selectOne(ew);
            if(click == null) return 0;
            count = click.getClick();
        }
        return count;
    }

}
