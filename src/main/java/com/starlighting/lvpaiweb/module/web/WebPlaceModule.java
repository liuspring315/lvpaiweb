package com.starlighting.lvpaiweb.module.web;

import com.starlighting.lvpaiweb.bean.*;
import com.starlighting.lvpaiweb.module.BaseModule;
import org.nutz.dao.Cnd;
import org.nutz.dao.Condition;
import org.nutz.dao.FieldFilter;
import org.nutz.dao.QueryResult;
import org.nutz.dao.pager.Pager;
import org.nutz.dao.util.Daos;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @功能说明：地点展示
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-14
 */
@IocBean // 声明为Ioc容器中的一个Bean
@At("/web/place")
public class WebPlaceModule extends BaseModule {

    /**
     * 显示地点首页
     * @param pager
     * @return
     */
    @GET
    @At
    @Ok("jsp:views.web.place_all")
    public Object place_all(@Param("..")Pager pager) {
        Condition cnd = Cnd.wrap("ispub = 1 ");
        QueryResult qr = new QueryResult();
        qr.setList(Daos.ext(dao, FieldFilter.create(DicPlace.class, "^id|placeName|about$")).query(DicPlace.class, cnd, pager));
        qr.setPager(pager);
        return qr;
    }

    @GET
    @At
    @Ok("jsp:views.web.place_all")
    public Object place1(@Param("..")Pager pager) {
        Condition cnd = Cnd.wrap("ispub = 1 and placeType = 1");
        QueryResult qr = new QueryResult();
        qr.setList(Daos.ext(dao, FieldFilter.create(DicPlace.class, "^id|placeName|about$")).query(DicPlace.class, cnd, pager));
        qr.setPager(pager);
        return qr;
    }

    @GET
    @At
    @Ok("jsp:views.web.place_all")
    public Object place2(@Param("..")Pager pager) {
        Condition cnd = Cnd.wrap("ispub = 1 and placeType = 2");
        QueryResult qr = new QueryResult();
        qr.setList(Daos.ext(dao, FieldFilter.create(DicPlace.class, "^id|placeName|about$")).query(DicPlace.class, cnd, pager));
        qr.setPager(pager);
        return qr;
    }

    /**
     * 地点详情页
     * @param id
     * @return
     */
    @POST
    @At
    @Ok("jsp:views.web.place_view")
    public Object view(@Param("id") int id,@Param("..")Pager pager) {
        DicPlace dicPlace = Daos.ext(dao, FieldFilter.create(DicPlace.class, "^id|placeName|about$")).fetch(DicPlace.class,id);
        dao.fetchLinks(dicPlace,"dicPlacePicsList");
        Map<String,Object> obj = new HashMap<String,Object>();
        obj.put("dicPlace",dicPlace);

        Condition cnd = Cnd.where("userType", "=", UserTypeEnum.PHOTOGRAPHER.getCode())
                .and("registerCheckState", "=", RegisterCheckStateEnum.APPROVE_YES.getCode())
//                .and("authenticationStat", "=", AuthenticationStatEnum.APPROVE_YES.getCode())
                .and("location","=",dicPlace.getId())
                .desc("id");
        pager.setPageSize(4);
        List<UserGeneralInfo> userGeneralInfoList = dao.query(UserGeneralInfo.class, cnd, pager);
        dao.fetchLinks(userGeneralInfoList,"dicPlace");
        dao.fetchLinks(userGeneralInfoList,"photographerExtra");

        obj.put("photographerExtra",userGeneralInfoList);

        return obj;
    }

    /////////////////////////展示图片的方法////start////////////////////////////

    @Ok("raw:jpg")
    @At("/avatar_small")
    @GET
    public Object getAvatarSmall(@Param("id") int id, HttpServletRequest req) throws SQLException {
        DicPlace profile = Daos.ext(dao, FieldFilter.create(DicPlace.class, "^avatarSmall$")).fetch(DicPlace.class,id);
        if (profile == null || profile.getAvatarSmall() == null) {
            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
        }
        return profile.getAvatarSmall();
    }
    @Ok("raw:jpg")
    @At("/avatar_medium")
    @GET
    public Object getAvatarMedium(@Param("id") int id, HttpServletRequest req) throws SQLException {
        DicPlace profile = Daos.ext(dao, FieldFilter.create(DicPlace.class, "^avatarMedium$")).fetch(DicPlace.class,id);
        if (profile == null || profile.getAvatarMedium() == null) {
            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
        }
        return profile.getAvatarMedium();
    }
    @Ok("raw:jpg")
    @At("/avatar_big")
    @GET
    public Object getAvatarBig(@Param("id") int id, HttpServletRequest req) throws SQLException {
        DicPlace profile = Daos.ext(dao, FieldFilter.create(DicPlace.class, "^avatarBig$")).fetch(DicPlace.class,id);
        if (profile == null || profile.getAvatarBig() == null) {
            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
        }
        return profile.getAvatarBig();
    }


    ////////////////////
    @Ok("raw:jpg")
    @At("/pic_small")
    @GET
    public Object getpicSmall(@Param("id") int id, HttpServletRequest req) throws SQLException {
        DicPlacePics profile = Daos.ext(dao, FieldFilter.create(DicPlacePics.class, "^svatarSmall$")).fetch(DicPlacePics.class,id);
        if (profile == null || profile.getAvatarSmall() == null) {
            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
        }
        return profile.getAvatarSmall();
    }
    @Ok("raw:jpg")
    @At("/pic_medium")
    @GET
    public Object getpicMedium(@Param("id") int id, HttpServletRequest req) throws SQLException {
        DicPlacePics profile = Daos.ext(dao, FieldFilter.create(DicPlacePics.class, "^avatarMedium$")).fetch(DicPlacePics.class,id);
        if (profile == null || profile.getAvatarMedium() == null) {
            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
        }
        return profile.getAvatarMedium();
    }
    @Ok("raw:jpg")
    @At("/pic_big")
    @GET
    public Object getpicBig(@Param("id") int id, HttpServletRequest req) throws SQLException {
        DicPlacePics profile = Daos.ext(dao, FieldFilter.create(DicPlacePics.class, "^avatarBig$")).fetch(DicPlacePics.class,id);
        if (profile == null || profile.getAvatarBig() == null) {
            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
        }
        return profile.getAvatarBig();
    }

    /////////////////////////展示图片的方法////end////////////////////////////


}
