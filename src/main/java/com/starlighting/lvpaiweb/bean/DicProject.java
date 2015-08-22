package com.starlighting.lvpaiweb.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

import java.io.Serializable;

/**
 * @功能说明：提供项目
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-11
 */
@Table("dic_project")
public class DicProject  extends BasePojo implements Serializable {

    /**
     * 主键
     */
    @Id
    @Column("id")
    private Integer id;

    @Column
    private String projectName;
    @Column
    private String projectIco;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }
    public String getProjectIco() {
        return projectIco;
    }

    public void setProjectIco(String projectIco) {
        this.projectIco = projectIco;
    }
}
