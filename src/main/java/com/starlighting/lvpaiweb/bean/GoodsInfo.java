package com.starlighting.lvpaiweb.bean;

import org.nutz.dao.entity.annotation.*;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @功能说明：提供商品
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-11
 */
@Table("goods_info")
public class GoodsInfo  extends BasePojo implements Serializable {

    /**
     * 主键
     */
    @Id
    @Column("id")
    private Integer id = 0;
    /**
     * 摄影师标识
     */
    @Column("service_provider_id")
    private Integer serviceProviderId;


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
     * 拍摄类型 1婚纱摄影 2旅行跟拍 3上门拍
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
    protected List<DicProject> dicProjects = new ArrayList<DicProject>();


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
     * 商品状态 0 已提交待审核 1 已审核通过 2 审核不通过
     */
    @Column("order_stat")
    private Integer orderStat;
    /**
     * 备注
     */
    @Column("remarks")
    private String remarks;


    @One(target=DicPlace.class, field="place", key="id")
    protected DicPlace dicPlace;



    @Many(target = GoodsPic.class, field = "gid")
    private List<GoodsPic> goodsPics = new ArrayList<GoodsPic>();

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

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public DicPlace getDicPlace() {
        return dicPlace;
    }

    public void setDicPlace(DicPlace dicPlace) {
        this.dicPlace = dicPlace;
    }

    public List<GoodsPic> getGoodsPics() {
        return goodsPics;
    }

    public void setGoodsPics(List<GoodsPic> goodsPics) {
        this.goodsPics = goodsPics;
    }
}
