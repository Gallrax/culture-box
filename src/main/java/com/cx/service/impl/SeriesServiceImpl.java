package com.cx.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cx.dao.SeriesDao;
import com.cx.entity.Series;
import com.cx.service.SeriesService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * InnoDB free: 34816 kB; (`categoryId`) REFER `culture-box/cx_category`(`id`) 服务实现类
 * </p>
 *
 * @author Gallrax
 * @since 2017-09-12
 */
@Service
public class SeriesServiceImpl extends ServiceImpl<SeriesDao, Series> implements SeriesService {

    @Override
    public List<Series> selectByParentCategoryId(Integer id, Integer index, Integer size) {
        List<Series> series = baseMapper.selectByParentCategoryId(id, index, size);
        return series;
    }
}
