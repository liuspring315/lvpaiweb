package com.starlighting.lvpaiweb.module.web;

import com.starlighting.lvpaiweb.bean.DicPlace;
import com.starlighting.lvpaiweb.module.BaseModule;
import org.nutz.dao.FieldFilter;
import org.nutz.dao.util.Daos;
import org.nutz.img.Images;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.GET;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.sql.SQLException;

/**
 * @功能说明：
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-25
 */
@IocBean // 声明为Ioc容器中的一个Bean
@At("/web")
public class ImagesReadModule extends BaseModule {
    @Inject("java:$config.get('img.path')")
    private String imgPath;


    @Ok("raw:jpg")
    @At("/images/?")
    @GET
    public Object getAvatarSmall(String path) throws SQLException {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        Images.writeJpeg(Images.read(imgPath+path + ".jpg"), out,1.0f);
        return out.toByteArray();
    }
}
