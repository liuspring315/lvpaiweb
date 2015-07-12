package com.starlighting.lvpaiweb.bean;

import org.nutz.dao.entity.annotation.*;

import java.util.Date;
import java.util.List;


/**
* 摄影师产品订单
*/

@Table("photo_order")
public class PhotoOrder  extends BasePojo{

	/**
	 * 主键
	 */
	@Id
	@Column("id")
	private Integer id;
	/**
	 * 摄影师标识
	 */
	@Column("service_provider_id")
	private Integer serviceProviderId;

	/**
	 *  客户标识
	 */
	@Column("cstmr_id")
	private Integer cstmrId;


    /**
     *  商品ID
     */
    @Column("goods_id")
    private Integer goodsId;

	/**
	 * 标题
	 */
	@Column("goods_name")
	private String goodsName;


	/**
	 * 预约日期
	 */
	@Column("order_fix_date")
	private java.util.Date orderFixDate;

	/**
	 * 订单状态
	 */
	@Column("order_stat")
	private Integer orderStat;
	/**
	 * 客户备注
	 */
	@Column("cstmr_remarks")
	private String cstmrRemarks;


	@One(target=UserGeneralInfo.class, field="serviceProviderId", key="id")
	protected UserGeneralInfo serviceProviderInfo;

	@One(target=UserGeneralInfo.class, field="cstmrId", key="id")
	protected UserGeneralInfo cstmrInfo;



	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getServiceProviderId() {
		return serviceProviderId;
	}

	public void setServiceProviderId(Integer serviceProviderId) {
		this.serviceProviderId = serviceProviderId;
	}

	public Integer getCstmrId() {
		return cstmrId;
	}

	public void setCstmrId(Integer cstmrId) {
		this.cstmrId = cstmrId;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}


    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
    }

    public Date getOrderFixDate() {
        return orderFixDate;
    }

    public void setOrderFixDate(Date orderFixDate) {
        this.orderFixDate = orderFixDate;
    }

    public Integer getOrderStat() {
		return orderStat;
	}

	public void setOrderStat(Integer orderStat) {
		this.orderStat = orderStat;
	}

	public String getCstmrRemarks() {
		return cstmrRemarks;
	}

	public void setCstmrRemarks(String cstmrRemarks) {
		this.cstmrRemarks = cstmrRemarks;
	}

	public UserGeneralInfo getServiceProviderInfo() {
		return serviceProviderInfo;
	}

	public void setServiceProviderInfo(UserGeneralInfo serviceProviderInfo) {
		this.serviceProviderInfo = serviceProviderInfo;
	}

	public UserGeneralInfo getCstmrInfo() {
		return cstmrInfo;
	}

	public void setCstmrInfo(UserGeneralInfo cstmrInfo) {
		this.cstmrInfo = cstmrInfo;
	}

}