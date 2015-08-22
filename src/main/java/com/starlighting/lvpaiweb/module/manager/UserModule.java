package com.starlighting.lvpaiweb.module.manager;

import com.starlighting.lvpaiweb.bean.*;
import com.starlighting.lvpaiweb.module.BaseModule;
import com.starlighting.lvpaiweb.service.manager.UserService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.nutz.aop.interceptor.ioc.TransAop;
import org.nutz.dao.Cnd;
import org.nutz.dao.FieldFilter;
import org.nutz.dao.QueryResult;
import org.nutz.dao.pager.Pager;
import org.nutz.dao.util.Daos;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Strings;
import org.nutz.lang.util.NutMap;
import org.nutz.mvc.annotation.*;

import java.util.List;

/**
 * @功能说明：
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-09
 */
@IocBean // 声明为Ioc容器中的一个Bean
@At("/manager/user") // 整个模块的路径前缀
@Ok("json:{locked:'password|salt',ignoreNull:true}") // 忽略password和salt属性,忽略空属性的json输出
@Fail("http:500") // 抛出异常的话,就走500页面
public class UserModule extends BaseModule {

    @Inject
    protected UserService userService;

    @At
    public int count() { // 统计用户数的方法,算是个测试点
        return dao.count(UserGeneralInfo.class);
    }

    @RequiresPermissions("manager:user:list")
    @At
    @Ok("jsp:views.manager.user.user_list")
    public void list() {
    }



//    @RequiresPermissions("user:add")
//    @At
//    public Object add(@Param("..")UserGeneralInfo user) { // 两个点号是按对象属性一一设置
//        NutMap re = new NutMap();
//        String msg = checkUser(user, true);
//        if (msg != null){
//            return re.setv("ok", false).setv("msg", msg);
//        }
//        user = userService.add(user);
//        return re.setv("ok", true).setv("data", user);
//    }

    @RequiresPermissions("manager:user:update")
    @At
    public Object update(@Param("password")String password, @Param("id")int userId) {
        if (Strings.isBlank(password) || password.length() < 6)
            return new NutMap().setv("ok", false).setv("msg", "密码不符合要求");
        userService.updatePassword(userId, password);
        return new NutMap().setv("ok", true);
    }

    @RequiresPermissions("manager:user:delete")
    @At
    @Aop(TransAop.READ_COMMITTED)
    public Object delete(@Param("id")int id, @Attr("me")UserGeneralInfo me) {
        if (me.getId() == id) {
            return new NutMap().setv("ok", false).setv("msg", "不能删除当前用户!!");
        }
        dao.delete(UserGeneralInfo.class, id); // 再严谨一些的话,需要判断是否为>0
        dao.delete(PhotographerExtra.class, id);
//        dao.delete(AgencyExtra.class, id);
        dao.delete(CustomerExtra.class, id);
        return new NutMap().setv("ok", true);
    }
//
    @RequiresPermissions("manager:user:query")
    @At
    public Object query(@Param("userName")String userName, @Param("..")Pager pager) {
        Cnd cnd = Strings.isBlank(userName)? null : Cnd.where("userName", "like", "%"+userName+"%");
        QueryResult qr = new QueryResult();
        List<UserGeneralInfo> userGeneralInfoList = Daos.ext(dao, FieldFilter.locked(UserGeneralInfo.class, "headThumb"))
                .query(UserGeneralInfo.class, cnd, pager);
        qr.setList(userGeneralInfoList);
        pager.setRecordCount(dao.count(UserGeneralInfo.class, cnd));
        qr.setPager(pager);
        return qr; //默认分页是第1页,每页20条
    }

    @RequiresPermissions("manager:user:update")
    @At("/checkstate/?/?")
    @Aop(TransAop.READ_COMMITTED)
    public Object pass(int rc,int personId) {
        if(userService.updateRegisterCheckState(personId, rc)){
            return new NutMap().setv("ok", true);
        }else{
            return new NutMap().setv("ok", false).setv("msg","此用户不能自行该操作");
        }
    }

    @At
    @Ok("json")
    public Object view(@Param("id")long id) {
        UserGeneralInfo userGeneralInfo = dao.fetch(UserGeneralInfo.class,id);
        dao.fetchLinks(userGeneralInfo, "dicPlace");

        if(userGeneralInfo.getUserType() == UserTypeEnum.PHOTOGRAPHER.getCode()){
            dao.fetchLinks(userGeneralInfo, "photographerExtra");
        }else if(userGeneralInfo.getUserType() == UserTypeEnum.CUSTOMER.getCode()){
            dao.fetchLinks(userGeneralInfo, "customerExtra");
        }
        return ajaxOk(userGeneralInfo);
    }

    @At
    @Ok("json")
    public Object authenticationUpdate(@Param("id")long id) {
        UserGeneralInfo userGeneralInfo = dao.fetch(UserGeneralInfo.class,id);

        if(userGeneralInfo.getUserType() == UserTypeEnum.PHOTOGRAPHER.getCode()){
            dao.fetchLinks(userGeneralInfo, "photographerExtra");
            if(userGeneralInfo.getAuthenticationStat() == AuthenticationStatEnum.WAIT_APPROVE.getCode()){
                PhotographerExtra photographerExtra = userGeneralInfo.getPhotographerExtra();
                if(photographerExtra.getAuthentication() < 3){
                    photographerExtra.setAuthentication(photographerExtra.getAuthentication()+1);
                    dao.update(photographerExtra);
                    userGeneralInfo.setAuthenticationStat(AuthenticationStatEnum.APPROVE_YES.getCode());
                    dao.update(userGeneralInfo);
                }
            }
        }else if(userGeneralInfo.getUserType() == UserTypeEnum.CUSTOMER.getCode()){
            dao.fetchLinks(userGeneralInfo, "customerExtra");
        }
        return new NutMap().setv("ok", true);
    }




}
