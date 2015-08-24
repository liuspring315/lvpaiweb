package com.starlighting.lvpaiweb.module.web;

import com.starlighting.lvpaiweb.bean.DicPlace;
import com.starlighting.lvpaiweb.bean.GoodsInfo;
import com.starlighting.lvpaiweb.bean.PhotographerExtra;
import com.starlighting.lvpaiweb.bean.UserGeneralInfo;
import com.starlighting.lvpaiweb.module.BaseModule;
import org.nutz.dao.FieldFilter;
import org.nutz.dao.pager.Pager;
import org.nutz.dao.util.Daos;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.POST;
import org.nutz.mvc.annotation.Param;

import java.util.HashMap;
import java.util.Map;

/**
 * @功能说明：
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-20
 */
@IocBean // 声明为Ioc容器中的一个Bean
@At("/web/goods")
public class WebGoodsModule extends BaseModule {

    /**
     * 地点详情页
     * @param id
     * @return
     */
    @At
    @Ok("jsp:views.web.goods_view")
    public Object view(@Param("id") int id) {
        GoodsInfo goodsInfo =dao.fetch(GoodsInfo.class, id);
        dao.fetchLinks(goodsInfo,"dicProjects");

        UserGeneralInfo userGeneralInfo = dao.fetch(UserGeneralInfo.class,goodsInfo.getServiceProviderId());
        if(userGeneralInfo.getLocation() != null){
            userGeneralInfo.setDicPlace(Daos.ext(dao, FieldFilter.create(DicPlace.class, "^id|placeName$")).fetch(DicPlace.class, userGeneralInfo.getLocation()));
        }
        userGeneralInfo.setPhotographerExtra(Daos.ext(dao, FieldFilter.create(PhotographerExtra.class, "^authentication|orderNum$")).fetch(PhotographerExtra.class, userGeneralInfo.getId()));

        Map<String,Object> obj = new HashMap<String,Object>();
        obj.put("goodsInfo",goodsInfo);
        obj.put("userGeneralInfo",userGeneralInfo);

        return obj;
    }
}
