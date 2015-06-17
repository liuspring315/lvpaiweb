package com.starlighting.lvpaiweb.module.web;

import com.restfb.types.User;
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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @功能说明：摄影师展示
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-14
 */
@IocBean // 声明为Ioc容器中的一个Bean
@At("/web/photographer")
public class PhotographerModule extends BaseModule {

    /**
     * 显示地点首页
     * @param pager
     * @return
     */
    @GET
    @At
    @Ok("jsp:views.web.photographer_all")
    public Object photographer_all(@Param("..")Pager pager) {
        Condition cnd = Cnd.where("userType", "=", UserTypeEnum.PHOTOGRAPHER.getCode())
                .and("registerCheckState", "=", RegisterCheckStateEnum.APPROVE_YES.getCode())
                .and("authenticationStat", "=", AuthenticationStatEnum.APPROVE_YES.getCode())
                .desc("id");
        QueryResult qr = new QueryResult();
        List<UserGeneralInfo> userGeneralInfoList = dao.query(UserGeneralInfo.class, cnd, pager);
        dao.fetchLinks(userGeneralInfoList, "dicPlace");
        dao.fetchLinks(userGeneralInfoList, "photographerExtra");
        return qr;
    }

    /**
     * 地点详情页
     * @param id
     * @return
     */
    @POST
    @At
    @Ok("jsp:views.web.photographer_view")
    public Object view(@Param("id") int id) {
        UserGeneralInfo userGeneralInfo = Daos.ext(dao, FieldFilter.create(UserGeneralInfo.class, "^id|lastName|location")).fetch(UserGeneralInfo.class,id);
        dao.fetchLinks(userGeneralInfo,"dicPlace");
        dao.fetchLinks(userGeneralInfo,"photographerExtra");
        return userGeneralInfo;
    }

    @At
    @Ok("json")
    public Object goodsquery(@Param("pid") int pid, @Param("..")Pager pager) {
        QueryResult qr = new QueryResult();
        Cnd cnd = Cnd.NEW().where("serviceProviderId","=",pid).and("orderStat","=",OrderStatEnum.APPROVE_YES.getCode());
        List<GoodsInfo> goodsInfos = dao.query(GoodsInfo.class, cnd, pager);
        dao.fetchLinks(goodsInfos,"dicProjects");
        dao.fetchLinks(goodsInfos,"dicPlace");
        qr.setList(goodsInfos);
        pager.setRecordCount(dao.count(GoodsInfo.class, cnd));
        qr.setPager(pager);
        return ajaxOk(qr);
    }

    @At("/allPhotographerList")
    @Ok("json")
    public Object queryPhotographerList(@Param("..")Pager pager) {
        Condition cnd = Cnd.where("userType", "=", UserTypeEnum.PHOTOGRAPHER.getCode())
                .and("registerCheckState", "=", RegisterCheckStateEnum.APPROVE_YES.getCode())
                .and("authenticationStat", "=", AuthenticationStatEnum.APPROVE_YES.getCode())
                .desc("id");
        QueryResult qr = new QueryResult();
        qr.setList(dao.query(UserGeneralInfo.class, cnd, pager));
        qr.setPager(pager);
        dao.fetchLinks(qr.getList(),"dicPlace");
        dao.fetchLinks(qr.getList(),"photographerExtra");
        pager.setRecordCount(dao.count(UserGeneralInfo.class, cnd));
        return qr;
    }


}
