package com.starlighting.lvpaiweb.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

import java.io.Serializable;

/**
 * @功能说明：DicPlace 的图片s
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-11
 */
@Table("dic_place_pics")
public class DicPlacePics extends BasePojo implements Serializable {

    /**
     * 主键
     */
    @Id
    @Column("id")
    private Integer id;

    /**
     * DicPlace的主键
     */
    @Column
    private Integer did;

    /**头像的byte数据*/
    @Column
    protected byte[] avatarSmall;

    /**大头像的byte数据*/
    @Column
    protected byte[] avatarBig;

    /**大头像的byte数据*/
    @Column
    protected byte[] avatarMedium;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDid() {
        return did;
    }

    public void setDid(Integer did) {
        this.did = did;
    }

    public byte[] getAvatarSmall() {
        return avatarSmall;
    }

    public void setAvatarSmall(byte[] avatarSmall) {
        this.avatarSmall = avatarSmall;
    }

    public byte[] getAvatarMedium() {
        return avatarMedium;
    }

    public void setAvatarMedium(byte[] avatarMedium) {
        this.avatarMedium = avatarMedium;
    }

    public byte[] getAvatarBig() {
        return avatarBig;
    }

    public void setAvatarBig(byte[] avatarBig) {
        this.avatarBig = avatarBig;
    }
}
