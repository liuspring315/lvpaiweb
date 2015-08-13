package com.starlighting.lvpaiweb.module;

import com.starlighting.lvpaiweb.bean.*;
import com.starlighting.lvpaiweb.service.ImageService;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.nutz.dao.Cnd;
import org.nutz.dao.Condition;
import org.nutz.dao.FieldFilter;
import org.nutz.dao.QueryResult;
import org.nutz.dao.pager.Pager;
import org.nutz.dao.util.Daos;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Strings;
import org.nutz.mvc.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.sql.SQLException;

/**
 * @功能说明：
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-09
 */

@IocBean // 声明为Ioc容器中的一个Bean
public class IndexModule extends BaseModule {
    @Inject
    ImageService imageService;

    @At({"/", "/main"})
    @GET
    @Ok("jsp:views.main")
    public void index() {
    }

    @GET
    @At({"/login", "/user/login"})
    @Ok("jsp:views.user.login")
    public void loginPage() {}

    @At
    @Ok("redirect:/${obj}")
    @RequiresUser
    public String index(@Attr("me") UserGeneralInfo user){
        if(user.getUserType()== UserTypeEnum.CUSTOMER.getCode()) {
            return "main";
        }else if(user.getUserType()== UserTypeEnum.PHOTOGRAPHER.getCode()) {
            return "manager/main";
        }else if(user.getUserType()== UserTypeEnum.ADMIN.getCode()) {
            return "manager/main";
        }else if(user.getUserType()== UserTypeEnum.STYLIST.getCode()) {
            return "manager/main";
        }else if(user.getUserType()== UserTypeEnum.AGENCY.getCode()) {
            return "manager/main";
        }else {
            return "main";
        }

    }

    @At("/web/queryPhotographerList")
    @Ok("json")
    public Object queryPhotographerList(@Param("..")Pager pager) {
        Condition cnd = Cnd.where("userType", "=", UserTypeEnum.PHOTOGRAPHER.getCode())
                .and("registerCheckState", "=", RegisterCheckStateEnum.APPROVE_YES.getCode())
//                .and("authenticationStat", "=", AuthenticationStatEnum.APPROVE_YES.getCode())
                .desc("id");
        QueryResult qr = new QueryResult();
        pager.setPageSize(4);
        qr.setList(dao.query(UserGeneralInfo.class, cnd, pager));
        qr.setPager(pager);
        dao.fetchLinks(qr.getList(),"dicPlace");
        dao.fetchLinks(qr.getList(),"photographerExtra");
        return qr;
    }

    @At("/web/queryDicPlaceList")
    @Ok("json")
    public Object queryDicPlaceList(Integer placeType,@Param("..")Pager pager) {
        Condition cnd = Cnd.wrap("ispub = 1 AND placeType = " + placeType);
        pager.setPageSize(3);
        return Daos.ext(dao, FieldFilter.create(DicPlace.class, "^id|placeName$")).query(DicPlace.class, cnd, pager);
    }



     @Ok("raw:jpg")
     @At("/web/avatar")
     @GET
     public Object readAvatar(@Param("id") int id, HttpServletRequest req) throws SQLException {
//        UserGeneralInfo profile = Daos.ext(dao, FieldFilter.create(UserGeneralInfo.class, "^headThumb$")).fetch(UserGeneralInfo.class,id);
//        if (profile == null || profile.getHeadThumb() == null) {
//            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
//        }
//        return profile.getHeadThumb();
         return imageService.getImg("head_thumb","user_general_info","id",id);
    }

    @Ok("raw:jpg")
    @At("/web/photographer/avatar_small")
    @GET
    public Object readPhotographerAvatar(@Param("id") int id, HttpServletRequest req) throws SQLException {
//        PhotographerExtra profile = Daos.ext(dao, FieldFilter.create(PhotographerExtra.class, "^avatarSmall$")).fetch(PhotographerExtra.class,id);
//        if (profile == null || profile.getAvatarSmall() == null) {
//            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
//        }
//        return profile.getAvatarSmall();
        return imageService.getImg("avatarSmall","photographer_extra","user_general_info_id",id);
    }

}
