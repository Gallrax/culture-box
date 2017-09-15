package com.cx.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cx.dao.ResourceDao;
import com.cx.entity.Resource;
import com.cx.service.ResourceService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * InnoDB free: 34816 kB; (`seriesId`) REFER `culture-box/cx_series`(`id`) 服务实现类
 * </p>
 *
 * @author Gallrax
 * @since 2017-09-12
 */
@Service
public class ResourceServiceImpl extends ServiceImpl<ResourceDao, Resource> implements ResourceService {
	
}
