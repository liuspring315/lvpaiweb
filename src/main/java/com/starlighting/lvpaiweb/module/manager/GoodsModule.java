package com.starlighting.lvpaiweb.module.manager;

import com.starlighting.lvpaiweb.bean.*;
import com.starlighting.lvpaiweb.module.BaseModule;
import com.starlighting.lvpaiweb.service.ImageService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.nutz.dao.Cnd;
import org.nutz.dao.FieldFilter;
import org.nutz.dao.QueryResult;
import org.nutz.dao.pager.Pager;
import org.nutz.dao.util.Daos;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @功能说明：
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-17
 */
@At("/manager/goods")
@IocBean
@Ok("void")//避免误写导致敏感信息泄露到服务器外
public class GoodsModule extends BaseModule {

    private static final Log log = Logs.get();
    @Inject
    ImageService imageService;
    @Inject("java:$config.get('img.small.w')")
    private int imgSmallWidth;
    @Inject("java:$config.get('img.small.h')")
    private int imgSmallHeight;

    @Inject("java:$config.get('img.medium.w')")
    private int imgMediumWidth;
    @Inject("java:$config.get('img.medium.h')")
    private int imgMediumHeight;

    @Inject("java:$config.get('img.big.w')")
    private int imgBigWidth;
    @Inject("java:$config.get('img.big.h')")
    private int imgBigHeight;

    @At
    @Ok("jsp:views.manager.goods.goods_list")
    public void list(@Attr("me")UserGeneralInfo me) {
    }

    @RequiresPermissions("manager:goods:list")
    @At
    @Ok("json")
    public Object query(@Attr("me")UserGeneralInfo me, @Param("..")Pager pager) {
        QueryResult qr = new QueryResult();
        Cnd cnd = Cnd.NEW();
        List<GoodsInfo> goodsInfos = dao.query(GoodsInfo.class, cnd, pager);
        dao.fetchLinks(goodsInfos,"dicProjects");
        for(GoodsInfo goodsInfo : goodsInfos){
            if(goodsInfo.getPlace() != null){
                goodsInfo.setDicPlace(Daos.ext(dao, FieldFilter.create(DicPlace.class, "^id|placeName$")).fetch(DicPlace.class, goodsInfo.getPlace()));
            }
        }
        qr.setList(goodsInfos);
        pager.setRecordCount(dao.count(GoodsInfo.class, cnd));
        qr.setPager(pager);
        return ajaxOk(qr);
    }

    @RequiresPermissions("manager:goods:view")
    @At
    @Ok("jsp:views.manager.goods.goods_view")
    public Object view(@Attr("me")UserGeneralInfo me,@Param("id") int id) {
        Map<String,Object> map = new HashMap<String,Object>();
        GoodsInfo goodsInfo = dao.fetch(GoodsInfo.class, id);
        dao.fetchLinks(goodsInfo, "dicProjects");
        dao.fetchLinks(goodsInfo, "dicPlace");
        dao.fetchLinks(goodsInfo, "goodsPics");
        map.put("projectList",dao.query(DicProject.class, Cnd.NEW()));
        map.put("goodsInfo",goodsInfo);
        return map;
    }

    @RequiresPermissions("manager:goods:approve")
    @At
    @Ok(">>:/manager/goods/list")
    public void approve(@Attr("me")UserGeneralInfo me,@Param("id") int id,@Param("orderStat") int orderStat) {
        Map<String,Object> map = new HashMap<String,Object>();
        GoodsInfo goodsInfo = dao.fetch(GoodsInfo.class, id);
        if(goodsInfo.getOrderStat() == OrderStatEnum.WAIT_APPROVE.getCode()){
            goodsInfo.setOrderStat(orderStat);
            dao.update(goodsInfo);
        }
    }

    @RequiresUser
    @Ok("raw:jpg")
    @At("/pic_avatar_small")
    @GET
    public Object pic_avatar_small(@Param("id")long picId, HttpServletRequest req) throws SQLException {
//        GoodsPic profile = Daos.ext(dao, FieldFilter.create(GoodsPic.class, "^avatarSmall$")).fetch(GoodsPic.class, picId);
//        if (profile == null || profile.getAvatarSmall() == null) {
//            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
//        }
//        return profile.getAvatarSmall();
        return imageService.getImg("avatarSmall","goods_pic","id",(int)picId);
    }

}
