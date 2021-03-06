package com.starlighting.lvpaiweb;

/**
 * @功能说明：
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-08
 */
import com.starlighting.lvpaiweb.bean.UserGeneralInfo;
import com.starlighting.lvpaiweb.bean.UserTypeEnum;
import com.starlighting.lvpaiweb.service.manager.UserService;
import org.nutz.dao.Dao;
import org.nutz.dao.impl.FileSqlManager;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.util.Daos;
import org.nutz.ioc.Ioc;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.NutConfig;
import org.nutz.mvc.Setup;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import java.util.List;

public class MainSetup implements Setup {
    private static final Log log = Logs.get();
    public void init(NutConfig conf) {
        Ioc ioc = conf.getIoc();
        Dao dao = ioc.get(Dao.class);
        Daos.createTablesInPackage(dao, "com.starlighting.lvpaiweb", false);


        // 初始化默认根用户
        if (dao.count(UserGeneralInfo.class) == 0) {
//            UserService us = ioc.get(UserService.class);
//            us.add("p1", "123456", UserTypeEnum.PHOTOGRAPHER);
//            us.add("c1", "123456",UserTypeEnum.CUSTOMER);
//            us.add("a1", "123456",UserTypeEnum.ADMIN);
            FileSqlManager fm = new FileSqlManager("init_system_mysql.sql");
            List<Sql> sqlList = fm.createCombo(fm.keys());
            dao.execute(sqlList.toArray(new Sql[sqlList.size()]));
        }

        // 测试发送邮件
//        try {
//            HtmlEmail email = ioc.get(HtmlEmail.class);
//            email.setSubject("测试NutzBook");
//            email.setMsg("This is a test mail ... :-)" + System.currentTimeMillis());
//            email.addTo("vt400@qq.com");//请务必改成您自己的邮箱啊!!!
//            email.send();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }

//        JedisPool jedisPool = ioc.get(JedisPool.class);
//        try (Jedis jedis = jedisPool.getResource()) { // Java7的语法
//            String re = jedis.set("_nutzbook_test_key", "http://nutzbook.wendal.net");
//            log.debug("redis say : " + re);
//            re = jedis.get("_nutzbook_test_key");
//            log.debug("redis say : " + re);
//        } finally {}
    }

    public void destroy(NutConfig conf) {
    }

}