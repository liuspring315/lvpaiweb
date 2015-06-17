package com.starlighting.lvpaiweb.bean;

import org.nutz.dao.entity.annotation.*;


/**
*  摄影机构表
*/

//@Table("agency_extra")
public class AgencyExtra  extends BasePojo{

	/**
	 * 主键
	 */
	@Id
	@Column("user_general_info_id")
	private Integer userGeneralInfoId;
	/**
	 * 认证等级
	 */
	@Column("authentication")
	private Integer authentication;
	/**
	 * 证件类型:1=中国居民身份证 2=护照 3=营业执照
	 */
	@Column("certificate_type")
	private Integer certificateType;
	/**
	 * 证件号码
	 */
	@Column("certificate_num")
	private String certificateNum;
	/**
	 * 证件照正面
	 */
	@Column("idcard_front")
	private String idcardFront;
	/**
	 * 证件照背面
	 */
	@Column("idcard_back")
	private String idcardBack;
	/**
	 * 备注
	 */
	@Column("remark")
	private String remark;
	/**
	 * 保证金
	 */
	@Column("deposit")
	private Long deposit;
	/**
	 * 机构简介
	 */
	@Column("introduction")
	private String introduction;
	/**
	 * 摄影师介绍
	 */
	@Column("photographer_desc")
	private String photographerDesc;
	/**
	 * 造型师介绍
	 */
	@Column("stylist_desc")
	private String stylistDesc;
	/**
	 * 服装介绍
	 */
	@Column("dress_desc")
	private String dressDesc;
	/**
	 * 详细地址
	 */
	@Column("address")
	private String address;


	public Integer getUserGeneralInfoId() {
		return userGeneralInfoId;
	}

	public void setUserGeneralInfoId(Integer userGeneralInfoId) {
		this.userGeneralInfoId = userGeneralInfoId;
	}

	public Integer getAuthentication() {
		return authentication;
	}

	public void setAuthentication(Integer authentication) {
		this.authentication = authentication;
	}

	public Integer getCertificateType() {
		return certificateType;
	}

	public void setCertificateType(Integer certificateType) {
		this.certificateType = certificateType;
	}

	public String getCertificateNum() {
		return certificateNum;
	}

	public void setCertificateNum(String certificateNum) {
		this.certificateNum = certificateNum;
	}

	public String getIdcardFront() {
		return idcardFront;
	}

	public void setIdcardFront(String idcardFront) {
		this.idcardFront = idcardFront;
	}

	public String getIdcardBack() {
		return idcardBack;
	}

	public void setIdcardBack(String idcardBack) {
		this.idcardBack = idcardBack;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Long getDeposit() {
		return deposit;
	}

	public void setDeposit(Long deposit) {
		this.deposit = deposit;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getPhotographerDesc() {
		return photographerDesc;
	}

	public void setPhotographerDesc(String photographerDesc) {
		this.photographerDesc = photographerDesc;
	}

	public String getStylistDesc() {
		return stylistDesc;
	}

	public void setStylistDesc(String stylistDesc) {
		this.stylistDesc = stylistDesc;
	}

	public String getDressDesc() {
		return dressDesc;
	}

	public void setDressDesc(String dressDesc) {
		this.dressDesc = dressDesc;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}


}