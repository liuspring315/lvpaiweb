package com.starlighting.lvpaiweb.module.manager.dic;

import com.starlighting.lvpaiweb.bean.DicProject;
import com.starlighting.lvpaiweb.module.BaseModule;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.nutz.dao.Cnd;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.util.NutMap;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import java.util.Date;
import java.util.List;

/**
 * @功能说明：提供项目管理
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-15
 */
@At("/manager/dicproject")
@IocBean
public class DicProjectModule extends BaseModule {

    @RequiresPermissions("manager:dicproject:list")
    @At
    @Ok("jsp:views.manager.dicproject.dicproject_list")
    public void list() {
    }

    @RequiresPermissions("manager:dicproject:list")
    @RequiresUser
    @At
    @Ok("json")
    public Object query() {
        List<DicProject> dicProjectList = dao.query(DicProject.class, Cnd.NEW());
        return ajaxOk(dicProjectList);
    }

    @RequiresPermissions("manager:dicproject:add")
    @At
    @Ok("json")
    public Object add(@Param("..") DicProject data) {
        Date now = new Date();
        data.setUpdateTime(now);
        data.setCreateTime(now);
        data.setId(null);
        dao.insert(data);
        return new NutMap().setv("ok", true);

    }

    @RequiresPermissions("manager:dicproject:update")
    @At
    @Ok("json")
    public Object update(@Param("..") DicProject dicProject) {
        DicProject data = dao.fetch(DicProject.class,dicProject.getId());
        Date now = new Date();
        data.setUpdateTime(now);
        data.setProjectIco(dicProject.getProjectIco());
        data.setProjectName(dicProject.getProjectName());
        dao.update(data);
        return new NutMap().setv("ok", true);

    }

}
