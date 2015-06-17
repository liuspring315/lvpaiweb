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
	 * 标题
	 */
	@Column("goods_name")
	private String goodsName;

	/**
	 * 拍摄地
	 */
	@Column("place")
	private Integer place;


	/**
	 * 拍摄类型
	 */
	@Column("photo_type")
	private String photoType;


	/**
	 * 总价格
	 */
	@Column("total_price")
	private Long totalPrice;

	/**
	 * 预付款
	 */
	@Column("advance_payment")
	private Long advancePayment;
	/**
	 * 原片数量
	 */
	@Column("original_num")
	private Integer originalNum;

	/**
	 * 精修数量
	 */
	@Column("processing_num")
	private Integer processingNum;


	/**
	 * 提供项目
	 */
	@ManyMany(from="g_id", relation="goods_project", target=DicProject.class, to="project_id")
	protected List<DicProject> dicProjects;


	/**
	 * 产品介绍
	 */
	@Column("goods_desc")
    @ColDefine(type = ColType.TEXT)
	private String goodsDesc;
	/**
	 *  起始日期
	 */
	@Column("photo_begin_date")
	private java.util.Date photoBeginDate;
	/**
	 * 结束日期
	 */
	@Column("photo_end_date")
	private java.util.Date photoEndDate;

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

	@One(target=DicPlace.class, field="place", key="id")
	protected DicPlace dicPlace;

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

	public Integer getPlace() {
		return place;
	}

	public void setPlace(Integer place) {
		this.place = place;
	}

	public String getPhotoType() {
		return photoType;
	}

	public void setPhotoType(String photoType) {
		this.photoType = photoType;
	}

	public Long getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Long totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Long getAdvancePayment() {
		return advancePayment;
	}

	public void setAdvancePayment(Long advancePayment) {
		this.advancePayment = advancePayment;
	}

	public Integer getOriginalNum() {
		return originalNum;
	}

	public void setOriginalNum(Integer originalNum) {
		this.originalNum = originalNum;
	}

	public Integer getProcessingNum() {
		return processingNum;
	}

	public void setProcessingNum(Integer processingNum) {
		this.processingNum = processingNum;
	}

	public List<DicProject> getDicProjects() {
		return dicProjects;
	}

	public void setDicProjects(List<DicProject> dicProjects) {
		this.dicProjects = dicProjects;
	}

	public String getGoodsDesc() {
		return goodsDesc;
	}

	public void setGoodsDesc(String goodsDesc) {
		this.goodsDesc = goodsDesc;
	}

	public Date getPhotoBeginDate() {
		return photoBeginDate;
	}

	public void setPhotoBeginDate(Date photoBeginDate) {
		this.photoBeginDate = photoBeginDate;
	}

	public Date getPhotoEndDate() {
		return photoEndDate;
	}

	public void setPhotoEndDate(Date photoEndDate) {
		this.photoEndDate = photoEndDate;
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

	public DicPlace getDicPlace() {
		return dicPlace;
	}

	public void setDicPlace(DicPlace dicPlace) {
		this.dicPlace = dicPlace;
	}
}