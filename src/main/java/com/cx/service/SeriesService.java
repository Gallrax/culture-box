package com.cx.service;

import com.cx.entity.Series;
import com.baomidou.mybatisplus.service.IService;

import java.util.List;

/**
 * <p>
 * InnoDB free: 34816 kB; (`categoryId`) REFER `culture-box/cx_category`(`id`) 服务类
 * </p>
 *
 * @author Gallrax
 * @since 2017-09-12
 */
public interface SeriesService extends IService<Series> {

    List<Series> selectByParentCategoryId(Integer id, Integer index, Integer size);

}
