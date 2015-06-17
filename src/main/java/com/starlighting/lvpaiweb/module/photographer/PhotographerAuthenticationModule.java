package com.starlighting.lvpaiweb.module.photographer;

import com.starlighting.lvpaiweb.bean.AuthenticationStatEnum;
import com.starlighting.lvpaiweb.bean.PhotographerExtra;
import com.starlighting.lvpaiweb.bean.UserGeneralInfo;
import com.starlighting.lvpaiweb.module.BaseModule;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.nutz.aop.interceptor.ioc.TransAop;
import org.nutz.dao.DaoException;
import org.nutz.img.Images;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.annotation.*;
import org.nutz.mvc.impl.AdaptorErrorContext;
import org.nutz.mvc.upload.TempFile;
import org.nutz.mvc.upload.UploadAdaptor;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;

/**
 * @功能说明：摄影师申请认证
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-11
 */
@At("/photographer/authenticate")
@IocBean
@Ok("void")//避免误写导致敏感信息泄露到服务器外
public class PhotographerAuthenticationModule extends BaseModule {

    private static final Log log = Logs.get();

    @Inject("java:$config.get('img.small.w')")
    private int imgSmallWidth;
    @Inject("java:$config.get('img.small.h')")
    private int imgSmallHeight;



    @At
    @Ok("jsp:views.photographer.photographer_authenticate_view")
    public Object view(@Attr("me")UserGeneralInfo me) {
        PhotographerExtra photographerExtra = dao.fetch(PhotographerExtra.class, me.getId());
        if(photographerExtra == null){
            return 0;//未完善个人信息不允许申请认证
        }
        return 1;
    }



    @RequiresUser
    @AdaptBy(type=UploadAdaptor.class, args={"${app.root}/WEB-INF/tmp/user_avatar", "8192", "utf-8", "20000000", "102400000"})
    @POST
    @Ok(">>:/photographer/authenticate/view")
    @At("/avatar")
    @Aop(TransAop.READ_COMMITTED)
    public void uploadAvatar(@Param("file")TempFile[] tf,
                             @Attr("me")UserGeneralInfo me,@Param("certificateType") int certificateType,@Param("certificateNum") String certificateNum,
                             AdaptorErrorContext err) {
        String msg = null;
        if (err != null && err.getAdaptorErr() != null) {
            msg = "文件大小不符合规定";
        } else if (tf == null) {
            msg = "空文件";
        } else {
            PhotographerExtra photographerExtra = dao.fetch(PhotographerExtra.class, me.getId());
            try {
                BufferedImage image = Images.read(tf[0].getFile());
                image = Images.zoomScale(image, imgSmallWidth, imgSmallHeight, Color.WHITE);
                ByteArrayOutputStream out = new ByteArrayOutputStream();
                Images.writeJpeg(image, out, 0.8f);
                photographerExtra.setIdcardBack(out.toByteArray());

                image = Images.read(tf[1].getFile());
                image = Images.zoomScale(image, imgSmallWidth, imgSmallHeight, Color.WHITE);
                out = new ByteArrayOutputStream();
                Images.writeJpeg(image, out, 0.8f);
                photographerExtra.setIdcardFront(out.toByteArray());

                photographerExtra.setCertificateType(certificateType);
                photographerExtra.setCertificateNum(certificateNum);

                UserGeneralInfo userGeneralInfo = dao.fetch(UserGeneralInfo.class, me.getId());
                userGeneralInfo.setAuthenticationStat(AuthenticationStatEnum.WAIT_APPROVE.getCode());
                dao.update(photographerExtra, "^idcardBack|idcardFront|certificateNum|certificateType$");
                dao.update(userGeneralInfo, "^authenticationStat$");
            } catch(DaoException e) {
                log.error("System Error", e);
                msg = "系统错误";
            } catch (Throwable e) {
                log.error("System Error", e);
                msg = "图片格式错误";
            }
        }

        me.setAuthenticationStat(AuthenticationStatEnum.WAIT_APPROVE.getCode());
        dao.fetchLinks(me,"photographerExtra");

        if (msg != null)
            Mvcs.getHttpSession().setAttribute("upload-error-msg", msg);
    }
}
