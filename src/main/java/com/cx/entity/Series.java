package com.cx.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.io.Serializable;
import java.util.Date;

/**
 * 系列(资源总称)
 * @author Gallrax
 * @since 2017-09-12
 */
@TableName("cx_series")
public class Series extends Model<Series> {

    private static final long serialVersionUID = 1L;

	@TableId(value="id", type= IdType.AUTO)
	private Integer id;
	//系列名
	private String name;
	//系列资源格式
	private String type;
	//系列状态
	private Integer status;
	//系列作者
	private String author;
	//系列作者单位
	private String authorCompany;
	//系列页数
	private Integer page;
	//系列出版社
	private String press;
	//系列发布时间(为防止提供的Excel导入异常,此处设置类型为String)
	private String pubishDate;
	//isbn
	private String isbn;
	//系列关键字
	private String keyword;
	//系列封面路径
	private String image;
	//系列下总资源数
	@JSONField(serialzeFeatures = SerializerFeature.WriteNullNumberAsZero)
	private Integer count;
	//系列是否推荐
	private Integer isRecommend;
	//系列是否精品
	private Integer isFine;
	//系列创建时间
	private Date insertTime;
	//系列分类id
	private Integer categoryId;


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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getAuthorCompany() {
		return authorCompany;
	}

	public void setAuthorCompany(String authorCompany) {
		this.authorCompany = authorCompany;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public String getPress() {
		return press;
	}

	public void setPress(String press) {
		this.press = press;
	}

	public String getPubishDate() {
		return pubishDate;
	}

	public void setPubishDate(String pubishDate) {
		this.pubishDate = pubishDate;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Integer getIsRecommend() {
		return isRecommend;
	}

	public void setIsRecommend(Integer isRecommend) {
		this.isRecommend = isRecommend;
	}

	public Integer getIsFine() {
		return isFine;
	}

	public void setIsFine(Integer isFine) {
		this.isFine = isFine;
	}

	public Date getInsertTime() {
		return insertTime;
	}

	public void setInsertTime(Date insertTime) {
		this.insertTime = insertTime;
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

	@Override
	public String toString() {
		return "Series{" +
			", id=" + id +
			", name=" + name +
			", type=" + type +
			", status=" + status +
			", author=" + author +
			", authorCompany=" + authorCompany +
			", page=" + page +
			", press=" + press +
			", pubishDate=" + pubishDate +
			", isbn=" + isbn +
			", keyword=" + keyword +
			", image=" + image +
			", count=" + count +
			", isRecommend=" + isRecommend +
			", isFine=" + isFine +
			", insertTime=" + insertTime +
			", categoryId=" + categoryId +
			"}";
	}
}
