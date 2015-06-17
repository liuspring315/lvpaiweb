package com.starlighting.lvpaiweb.bean;

import org.nutz.dao.entity.annotation.*;

import java.util.List;

/**
 * @功能说明：所在地拍摄地
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-11
 */
@Table("dic_place")
public class DicPlace extends BasePojo{

    /**
     * 主键
     */
    @Id
    @Column("id")
    private Integer id;

    /**
     * 地点名称 例如：北京-海淀
     */
    @Column
    private String placeName;

    /**
     * 上级id ，顶层为2境内，1境外
     */
    @Column
    private Integer pid;

    /**
     * 地点类型，2境内，1境外
     */
    @Column
    private Integer placeType;

    /**
     * 关于这里
     */
    @Column
    @ColDefine(type = ColType.VARCHAR, width = 500)
    private String about;

    /**头像的byte数据*/
    @Column
    protected byte[] avatarSmall;

    /**大头像的byte数据*/
    @Column
    protected byte[] avatarBig;

    /**大头像的byte数据*/
    @Column
    protected byte[] avatarMedium;



    /**
     * 发布，0不上，1上
     */
    @Column
    private Integer ispub;

    /**
     * 排序
     */
    @Column
    private Integer oy;

    @Many(target = DicPlacePics.class, field = "did")
    private List<DicPlacePics> dicPlacePicsList;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPlaceName() {
        return placeName;
    }

    public void setPlaceName(String placeName) {
        this.placeName = placeName;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getPlaceType() {
        return placeType;
    }

    public void setPlaceType(Integer placeType) {
        this.placeType = placeType;
    }

    public String getAbout() {
        return about;
    }

    public void setAbout(String about) {
        this.about = about;
    }


    public List<DicPlacePics> getDicPlacePicsList() {
        return dicPlacePicsList;
    }

    public void setDicPlacePicsList(List<DicPlacePics> dicPlacePicsList) {
        this.dicPlacePicsList = dicPlacePicsList;
    }



    public Integer getIspub() {
        return ispub;
    }

    public void setIspub(Integer ispub) {
        this.ispub = ispub;
    }

    public Integer getOy() {
        return oy;
    }

    public void setOy(Integer oy) {
        this.oy = oy;
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
