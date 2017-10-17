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
        logger.info(" param : innerId : " + innerId + " outterId : "+ outterId);
        Click click = clickService.selectOne(new EntityWrapper<Click>().eq("innerId", innerId));
        if (click != null) {
            Integer tempClick = click.getClick();
            click.setClick(++tempClick);
            clickService.updateById(click);
        } else if (click == null) {
            click = new Click();
            Integer type = outterId == null || outterId.isEmpty() ? 2 : 1;//防止outterId为""
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
        EntityWrapper<Click> ew = new EntityWrapper<>();
        EWUtil.eqMap(ew, URLUtil.decodeAndMap(eq), false);
        Integer count = clickService.selectCount(ew);
        return count;
    }

}
