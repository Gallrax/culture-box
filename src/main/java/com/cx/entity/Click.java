package com.cx.entity;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.io.Serializable;

/**
 * <p>
 * InnoDB free: 26624 kB
 * </p>
 *
 * @author Gallrax
 * @since 2017-10-17
 */
@TableName("cx_click")
public class Click extends Model<Click> {

    private static final long serialVersionUID = 1L;

	@TableId(value="id", type= IdType.AUTO)
	private Integer id;
	private String innerId;//唯一标识(资源id或二级分类id)
	private String outterId;//绑定id(资源可无绑定，二级分类可绑定一级分类id)
	private Integer type;//1.分类 2.资源
	private Integer click;//点击量


	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getInnerId() {
		return innerId;
	}

	public void setInnerId(String innerId) {
		this.innerId = innerId;
	}

	public String getOutterId() {
		return outterId;
	}

	public void setOutterId(String outterId) {
		this.outterId = outterId;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getClick() {
		return click;
	}

	public void setClick(Integer click) {
		this.click = click;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

	@Override
	public String toString() {
		return "Click{" +
			"id=" + id +
			", innerId=" + innerId +
			", outterId=" + outterId +
			", type=" + type +
			", click=" + click +
			"}";
	}
}
