package com.starlighting.lvpaiweb.module;

import com.starlighting.lvpaiweb.bean.Permission;
import com.starlighting.lvpaiweb.bean.UserGeneralInfo;
import com.starlighting.lvpaiweb.bean.UserTypeEnum;
import com.starlighting.lvpaiweb.service.manager.UserService;
import org.nutz.aop.interceptor.ioc.TransAop;
import org.nutz.dao.Cnd;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Strings;
import org.nutz.lang.util.NutMap;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import java.util.ArrayList;
import java.util.List;

/**
 * @功能说明：
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-10
 */
@IocBean // 声明为Ioc容器中的一个Bean
@At("/web")
public class ServerRegisterModule  extends BaseModule{
    @Inject
    protected UserService userService;
    @At("/server/register")
    @Ok("jsp:views.user.server_register")
    public void user_register() {
    }

    @At("/server/photoer/register")
    @Ok("jsp:views.user.photoer_register")
    public void user_photoer_register() {
    }

    @At("/server/photoer/user_register_submit")
    @Aop(TransAop.READ_COMMITTED)
    public Object user_register_submit(@Param("..")UserGeneralInfo user) {

        NutMap re = new NutMap();
        String msg = checkUser(user, true);
        if (msg != null){
            return re.setv("ok", false).setv("msg", msg);
        }
        user.setUserType(UserTypeEnum.PHOTOGRAPHER.getCode());
        user = userService.add(user);

        List<Permission> ps = new ArrayList<Permission>();
        Permission p = dao.fetch(Permission.class, 10);
        ps.add(p);
        Permission p2 = dao.fetch(Permission.class, 14);
        ps.add(p2);
        user.setPermissions(ps);
        dao.insertRelation(user, "permissions");
        return re.setv("ok", true).setv("data", user);
    }

    protected String checkUser(UserGeneralInfo user, boolean create) {
        if (user == null) {
            return "空对象";
        }
        if (create) {
            if (Strings.isBlank(user.getUserName()) || Strings.isBlank(user.getPassword()))
                return "用户名/密码不能为空";
        } else {
            if (Strings.isBlank(user.getPassword()))
                return "密码不能为空";
        }
        String passwd = user.getPassword().trim();
        if (6 > passwd.length() || passwd.length() > 12) {
            return "密码长度错误";
        }
        user.setPassword(passwd);
        if (create) {
            int count = dao.count(UserGeneralInfo.class, Cnd.where("userName", "=", user.getUserName()));
            if (count != 0) {
                return "用户名已经存在";
            }
            count = dao.count(UserGeneralInfo.class, Cnd.where("email", "=", user.getEmail()));
            if (count != 0) {
                return "email已经存在";
            }
            count = dao.count(UserGeneralInfo.class, Cnd.where("mobile", "=", user.getMobile()));
            if (count != 0) {
                return "移动电话已经存在";
            }
        } else {
            if (user.getId() < 1) {
                return "用户Id非法";
            }
        }
        if (user.getUserName() != null)
            user.setUserName(user.getUserName().trim());
        return null;
    }
}
