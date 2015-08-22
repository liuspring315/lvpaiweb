package com.starlighting.lvpaiweb.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

import java.io.Serializable;

/**
 * @功能说明：商品图片
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-16
 */
@Table("goods_pic")
public class GoodsPic extends BasePojo implements Serializable {

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
    private Integer gid;

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

    public Integer getGid() {
        return gid;
    }

    public void setGid(Integer gid) {
        this.gid = gid;
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
