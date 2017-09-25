package com.cx.entity;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.io.Serializable;
import java.util.Date;

/**
 * @Author: 冯冠凯 
 * @Description: 分类
 * @Date: Created on 2017/9/25
 * @Version: 1.0
 */
@TableName("cx_category")
public class Category extends Model<Category> {

    private static final long serialVersionUID = 1L;

	@TableId(value="id", type= IdType.AUTO)
	private Integer id;
	//分类名称
	private String name;
	//分类状态
	private Integer status;
	//分类登记
	private Integer lv;
	//分类图片途径
	private String image;
	//分类父id
	private Integer pid;
	//创建时间
	private Date insertTime;


	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getLv() {
		return lv;
	}

	public void setLv(Integer lv) {
		this.lv = lv;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public Date getInsertTime() {
		return insertTime;
	}

	public void setInsertTime(Date insertTime) {
		this.insertTime = insertTime;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

	@Override
	public String toString() {
		return "Category{" +
			", id=" + id +
			", name=" + name +
			", status=" + status +
			", lv=" + lv +
			", pid=" + pid +
			", insertTime=" + insertTime +
			"}";
	}
}
