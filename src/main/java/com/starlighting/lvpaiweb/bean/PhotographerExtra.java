package com.starlighting.lvpaiweb.bean;

import org.nutz.dao.entity.annotation.*;


/**
* 摄影师
*/

@Table("photographer_extra")
public class PhotographerExtra  extends BasePojo{

	/**
	 * 主键
	 */
	@Id
	@Column("user_general_info_id")
	private Integer userGeneralInfoId;


	/**
	 * 0=未认证
            1=初级认证
            2=中级认证
            3=高级认证
	 */
	@Column("authentication")
	private Integer authentication;

	/**
	 * 服务次数
	 */
	@Column("order_num")
	private Integer orderNum;

	/**
	 * 个人简介
	 */
	@Column("introduction")
    @ColDefine(type = ColType.VARCHAR, width = 500)
	private String introduction;

	/**
	 * 证件类型:1=中国居民身份证 2=护照 3=营业执照
            certificate_type
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
	private byte[] idcardFront;
	/**
	 * 证件照背面
	 */
	@Column("idcard_back")
	private byte[] idcardBack;
	/**
	 * 保证金
	 */
	@Column("deposit")
	private Long deposit;
	/**
	 * 备注
	 */
	@Column("remark")
	private String remark;

    /**头像的byte数据*/
    @Column
    protected byte[] avatarSmall;

    /**大头像的byte数据*/
    @Column
    protected byte[] avatarBig;

    /**大头像的byte数据*/
    @Column
    protected byte[] avatarMedium;



    public Integer getUserGeneralInfoId() {
		return userGeneralInfoId;
	}

	public void setUserGeneralInfoId(Integer userGeneralInfoId) {
		this.userGeneralInfoId = userGeneralInfoId;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
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

    public byte[] getIdcardFront() {
        return idcardFront;
    }

    public void setIdcardFront(byte[] idcardFront) {
        this.idcardFront = idcardFront;
    }

    public byte[] getIdcardBack() {
        return idcardBack;
    }

    public void setIdcardBack(byte[] idcardBack) {
        this.idcardBack = idcardBack;
    }

    public Long getDeposit() {
		return deposit;
	}

	public void setDeposit(Long deposit) {
		this.deposit = deposit;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}

    public byte[] getAvatarSmall() {
        return avatarSmall;
    }

    public void setAvatarSmall(byte[] avatarSmall) {
        this.avatarSmall = avatarSmall;
    }

    public byte[] getAvatarBig() {
        return avatarBig;
    }

    public void setAvatarBig(byte[] avatarBig) {
        this.avatarBig = avatarBig;
    }

    public byte[] getAvatarMedium() {
        return avatarMedium;
    }

    public void setAvatarMedium(byte[] avatarMedium) {
        this.avatarMedium = avatarMedium;
    }
}