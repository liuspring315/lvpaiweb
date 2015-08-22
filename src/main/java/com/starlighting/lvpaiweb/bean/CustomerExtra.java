package com.starlighting.lvpaiweb.bean;

import org.nutz.dao.entity.annotation.*;

import java.io.Serializable;


/**
*  顾客表
*/

@Table("customer_extra")
public class CustomerExtra  extends BasePojo implements Serializable {

	/**
	 * 会员标识
	 */
	@Id(auto=false)
	@Column("user_general_info_id")
	private Integer userGeneralInfoId;
	/**
	 * 个性签名
	 */
	@Column("signature")
	private String signature;
	/**
	 * 想去的地方
	 */
	@Column("destination")
    @ColDefine(type = ColType.VARCHAR, width = 500)
	private String destination;
	/**
	 * 备注
	 */
	@Column("remark")
	private String remark;

	public Integer getUserGeneralInfoId() {
		return userGeneralInfoId;
	}

	public void setUserGeneralInfoId(Integer userGeneralInfoId) {
		this.userGeneralInfoId = userGeneralInfoId;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}