package com.cx.entity;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.io.Serializable;
import java.util.Date;

/**
 * @Author: 冯冠凯 
 * @Description: 资源
 * @Date: Created on 2017/9/25
 * @Version: 1.0
 */
@TableName("cx_resource")
public class Resource extends Model<Resource> {

    private static final long serialVersionUID = 1L;

	@TableId(value="id", type= IdType.AUTO)
	private Integer id;
	//资源名称(系列下的名称 例:第一集)
	private String name;
	//资源简介
	private String introduce;
	//资源状态
	private Integer status;
	//资源路径
	private String route;
	//创建时间
	private Date insertTime;
	//系列内id(系列的该资源的序号)
	private Integer innerId;
	//系列id
	private Long seriesId;


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

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getRoute() {
		return route;
	}

	public void setRoute(String route) {
		this.route = route;
	}

	public Date getInsertTime() {
		return insertTime;
	}

	public void setInsertTime(Date insertTime) {
		this.insertTime = insertTime;
	}

	public Integer getInnerId() {
		return innerId;
	}

	public void setInnerId(Integer innerId) {
		this.innerId = innerId;
	}

	public Long getSeriesId() {
		return seriesId;
	}

	public void setSeriesId(Long seriesId) {
		this.seriesId = seriesId;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

	@Override
	public String toString() {
		return "Resource{" +
			", id=" + id +
			", name=" + name +
			", introduce=" + introduce +
			", status=" + status +
			", route=" + route +
			", insertTime=" + insertTime +
			", innerId=" + innerId +
			", seriesId=" + seriesId +
			"}";
	}
}
