package com.cx.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cx.dao.CategoryDao;
import com.cx.entity.Category;
import com.cx.service.CategoryService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * InnoDB free: 34816 kB; (`pid`) REFER `culture-box/cx_category`(`id`) 服务实现类
 * </p>
 *
 * @author Gallrax
 * @since 2017-09-12
 */
@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryDao, Category> implements CategoryService {
	
}
