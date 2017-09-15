package com.cx.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cx.entity.Series;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
  * InnoDB free: 34816 kB; (`categoryId`) REFER `culture-box/cx_category`(`id`) Mapper 接口
 * </p>
 *
 * @author Gallrax
 * @since 2017-09-12
 */
public interface SeriesDao extends BaseMapper<Series> {

    List<Series> selectByParentCategoryId(@Param("pcid") Integer id, @Param("index") Integer index, @Param("size") Integer size);

}