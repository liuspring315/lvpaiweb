package com.starlighting.lvpaiweb.module.photographer;

import com.starlighting.lvpaiweb.bean.*;
import com.starlighting.lvpaiweb.module.BaseModule;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.nutz.aop.interceptor.ioc.TransAop;
import org.nutz.dao.DaoException;
import org.nutz.dao.FieldFilter;
import org.nutz.dao.util.Daos;
import org.nutz.img.Images;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Strings;
import org.nutz.lang.util.NutMap;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.annotation.*;
import org.nutz.mvc.impl.AdaptorErrorContext;
import org.nutz.mvc.upload.TempFile;
import org.nutz.mvc.upload.UploadAdaptor;

import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.sql.SQLException;
import java.util.Date;

/**
 * @功能说明：摄影师个人信息
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-11
 */
@At("/photographer/info")
@IocBean
@Ok("json:{locked:'password|salt',ignoreNull:true}") // 忽略password和salt属性,忽略空属性的json输出
public class PhotographerInfoModule extends BaseModule {


    private static final Log log = Logs.get();

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

    @RequiresPermissions("photographer:info:view")
    @At
    @Ok("jsp:views.photographer.photographer_info_view")
    public void view(@Attr("me")UserGeneralInfo me) {

    }

    @RequiresPermissions("photographer:info:update")
    @At
    @Aop(TransAop.READ_COMMITTED)
    public Object update(@Attr("me")UserGeneralInfo me,
                         @Param("..") UserGeneralInfo userGeneralInfo,
                         @Param("..") PhotographerExtra photographerExtra) {
        if (userGeneralInfo == null || userGeneralInfo.getId() != me.getId())
            return new NutMap().setv("ok", false);
        UserGeneralInfo data = dao.fetch(UserGeneralInfo.class, userGeneralInfo.getId());
        if (data == null)
            return new NutMap().setv("ok", false);
        Date now = new Date();

        data.setUpdateTime(now);
        data.setLastName(userGeneralInfo.getLastName());
        data.setGender(userGeneralInfo.getGender());
        data.setEmail(userGeneralInfo.getEmail());
        data.setMobile(userGeneralInfo.getMobile());
        data.setBirthday(userGeneralInfo.getBirthday());
        data.setLocation(userGeneralInfo.getLocation());
        data.setAuthenticationStat(AuthenticationStatEnum.WAIT_APPROVE.getCode());
        dao.update(data);
        PhotographerExtra pdata = dao.fetch(PhotographerExtra.class, userGeneralInfo.getId());
        if (pdata == null) {
            photographerExtra.setUserGeneralInfoId(data.getId());
            photographerExtra.setUpdateTime(now);
            photographerExtra.setCreateTime(now);
            photographerExtra.setAuthentication(0);
            photographerExtra.setOrderNum(0);
            dao.insert(photographerExtra);
        }else{
            pdata.setIntroduction(photographerExtra.getIntroduction());
            pdata.setUpdateTime(now);
            pdata.setCreateTime(now);
            photographerExtra.setAuthentication(0);
            dao.update(pdata);
        }

        me.setUpdateTime(now);
        me.setLastName(userGeneralInfo.getLastName());
        me.setGender(userGeneralInfo.getGender());
        me.setEmail(userGeneralInfo.getEmail());
        me.setMobile(userGeneralInfo.getMobile());
        me.setBirthday(userGeneralInfo.getBirthday());
        me.setLocation(userGeneralInfo.getLocation());
        me.setAuthenticationStat(AuthenticationStatEnum.WAIT_APPROVE.getCode());
        dao.fetchLinks(me,"dicPlace");
        dao.fetchLinks(me,"photographerExtra");
        return new NutMap().setv("ok", true);
    }

    @RequiresUser
    @AdaptBy(type=UploadAdaptor.class, args={"${app.root}/WEB-INF/tmp/user_avatar", "8192", "utf-8", "20000000", "102400000"})
    @POST
    @Ok(">>:/photographer/info/view")
    @At("/avatarHeadThumb")
    public void uploadHeadThumb(@Param("file")TempFile tf,
                             @Attr("me")UserGeneralInfo me,
                             AdaptorErrorContext err) {
        String msg = null;
        if (err != null && err.getAdaptorErr() != null) {
            msg = "文件大小不符合规定";
        } else if (tf == null) {
            msg = "空文件";
        } else {
            UserGeneralInfo userGeneralInfo = dao.fetch(UserGeneralInfo.class, me.getId());
            try {
                BufferedImage image = Images.read(tf.getFile());
                image = Images.zoomScale(image, imgSmallWidth, imgSmallHeight, Color.WHITE);
                ByteArrayOutputStream out = new ByteArrayOutputStream();
                Images.writeJpeg(image, out, 0.8f);
                userGeneralInfo.setHeadThumb(out.toByteArray());

                dao.update(userGeneralInfo, "^headThumb$");
            } catch(DaoException e) {
                log.error("System Error", e);
                msg = "系统错误";
            } catch (Throwable e) {
                log.error("System Error", e);
                msg = "图片格式错误";
            }
        }

        if (msg != null)
            Mvcs.getHttpSession().setAttribute("upload-error-msg", msg);
    }

    @RequiresUser
    @Ok("raw:jpg")
    @At("/avatar")
    @GET
    public Object readAvatar( @Attr("me")UserGeneralInfo me, HttpServletRequest req) throws SQLException {
        PhotographerExtra profile = Daos.ext(dao, FieldFilter.create(PhotographerExtra.class, "^avatarSmall$")).fetch(PhotographerExtra.class, me.getId());
        if (profile == null || profile.getAvatarSmall() == null) {
            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
        }
        return profile.getAvatarSmall();
    }


    @RequiresUser
    @AdaptBy(type=UploadAdaptor.class, args={"${app.root}/WEB-INF/tmp/user_avatar", "8192", "utf-8", "20000000", "102400000"})
    @POST
    @Ok(">>:/photographer/info/view")
    @At("/update_avatar")
    public void uploadAvatar(@Param("file")TempFile tf,
                             @Attr("me")UserGeneralInfo me,
                             AdaptorErrorContext err) {
        String msg = null;
        if (err != null && err.getAdaptorErr() != null) {
            msg = "文件大小不符合规定";
        } else if (tf == null) {
            msg = "空文件";
        } else {
            PhotographerExtra photographerExtra = dao.fetch(PhotographerExtra.class, me.getId());
            if(photographerExtra == null){
                msg = "请先保存基本信息，再上传图片";
            }else {
                try {
                    BufferedImage image = Images.read(tf.getFile());
                    image = Images.zoomScale(image, imgSmallWidth, imgSmallHeight, Color.WHITE);
                    ByteArrayOutputStream out = new ByteArrayOutputStream();
                    Images.writeJpeg(image, out, 0.8f);
                    photographerExtra.setAvatarSmall(out.toByteArray());

                    image = Images.read(tf.getFile());
                    image = Images.zoomScale(image, imgMediumWidth, imgMediumHeight, Color.WHITE);
                    out = new ByteArrayOutputStream();
                    Images.writeJpeg(image, out, 0.8f);
                    photographerExtra.setAvatarMedium(out.toByteArray());

                    image = Images.read(tf.getFile());
                    image = Images.zoomScale(image, imgBigHeight, imgBigHeight, Color.WHITE);
                    out = new ByteArrayOutputStream();
                    Images.writeJpeg(image, out, 0.8f);
                    photographerExtra.setAvatarBig(out.toByteArray());

                    dao.update(photographerExtra, "^avatar|avatarMedium|avatarBig$");
                } catch (DaoException e) {
                    log.error("System Error", e);
                    msg = "系统错误";
                } catch (Throwable e) {
                    log.error("System Error", e);
                    msg = "图片格式错误";
                }
            }
        }

        if (msg != null)
            Mvcs.getHttpSession().setAttribute("upload-error-msg", msg);
    }

    @RequiresUser
    @Ok("raw:jpg")
    @At("/avatar_idcardFront")
    @GET
    public Object readAvatarIdcardFront( @Attr("me")UserGeneralInfo me, HttpServletRequest req) throws SQLException {
        PhotographerExtra profile = Daos.ext(dao, FieldFilter.create(PhotographerExtra.class, "^idcardFront$")).fetch(PhotographerExtra.class, me.getId());
        if (profile == null || profile.getIdcardFront() == null) {
            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
        }
        return profile.getIdcardFront();
    }

    @RequiresUser
    @Ok("raw:jpg")
    @At("/avatar_idcardBack")
    @GET
    public Object readAvatarIdcardBack( @Attr("me")UserGeneralInfo me, HttpServletRequest req) throws SQLException {
        PhotographerExtra profile = Daos.ext(dao, FieldFilter.create(PhotographerExtra.class, "^idcardBack$")).fetch(PhotographerExtra.class, me.getId());
        if (profile == null || profile.getIdcardBack() == null) {
            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
        }
        return profile.getIdcardBack();
    }


}
