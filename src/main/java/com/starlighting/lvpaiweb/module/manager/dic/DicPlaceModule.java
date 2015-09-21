package com.starlighting.lvpaiweb.module.manager.dic;

import com.starlighting.lvpaiweb.bean.*;
import com.starlighting.lvpaiweb.module.BaseModule;
import com.starlighting.lvpaiweb.service.ImageService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.nutz.dao.Cnd;
import org.nutz.dao.Condition;
import org.nutz.dao.DaoException;
import org.nutz.dao.FieldFilter;
import org.nutz.dao.util.Daos;
import org.nutz.img.Images;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.util.NutMap;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.Scope;
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
import java.util.List;

/**
 * @功能说明：地点维护
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-12
 */
@At("/manager/dicplace")
@IocBean
@Ok("void")//避免误写导致敏感信息泄露到服务器外
public class DicPlaceModule extends BaseModule {
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




    @RequiresPermissions("manager:dicplace:list")
    @At
    @Ok("jsp:views.manager.dicplace.dicplace_list")
    public void list() {
    }
    @RequiresUser
    @At
    @Ok("jsp:views.manager.dicplace.dicplace_pop")
    public void listpop() {
    }


    @RequiresUser
     @At
     @Ok("json")
     public Object query() {
        List<DicPlace> dicPlaceList = Daos.ext(dao,
                FieldFilter.locked(DicPlace.class, "avatar"))
                .query(DicPlace.class,Cnd.NEW());
        return ajaxOk(dicPlaceList);
    }

    @RequiresPermissions("manager:dicplace:list")
     @At
     @Ok("json")
     public Object get(@Param("id")long id) {
        DicPlace dicPlace = dao.fetch(DicPlace.class,id);
        return ajaxOk(dicPlace);
    }

    @RequiresPermissions("manager:dicplace:list")
    @At
    @Ok("json")
    public Object getPlacePic(@Param("id")long id) {
        Condition cnd = Cnd.where("did", "=", id)
                .desc("id");
        return ajaxOk(dao.query(DicPlacePics.class, cnd));
    }

    @RequiresPermissions("manager:dicplace:update")
     @At
     @Ok("json")
     public Object update(@Param("..") DicPlace dicPlace) {
        DicPlace data = dao.fetch(DicPlace.class,dicPlace.getId());
        Date now = new Date();
        data.setUpdateTime(now);
        data.setAbout(dicPlace.getAbout());
        data.setIspub(dicPlace.getIspub());
        data.setOy(dicPlace.getOy());
        data.setPlaceName(dicPlace.getPlaceName());
        data.setPlaceType(dicPlace.getPlaceType());
        data.setPid(dicPlace.getPid());
        data.setDetails(dicPlace.getDetails());
        dao.update(data);
        return new NutMap().setv("ok", true);

    }

    @RequiresPermissions("manager:dicplace:add")
    @At
    @Ok("json")
    public Object add(@Param("..") DicPlace data) {
        Date now = new Date();
        data.setUpdateTime(now);
        data.setCreateTime(now);
        data.setPid(data.getId());
        data.setId(null);
        dao.insert(data);
        return new NutMap().setv("ok", true);

    }
    @RequiresPermissions("manager:dicplace:delete")
    @At
    @Ok("json")
    public Object delete(@Param("..") DicPlace data) {
        dao.delete(DicPlace.class,data.getId());
        return new NutMap().setv("ok", true);

    }


    @RequiresUser
    @AdaptBy(type=UploadAdaptor.class, args={"${app.root}/WEB-INF/tmp/user_avatar", "8192", "utf-8", "20000000", "102400000"})
    @POST
    @Ok(">>:/manager/dicplace/list")
    @At("/avatar")
    public void uploadAvatar(@Param("file")TempFile tf,
                             @Param("id")long placeId,
                             AdaptorErrorContext err) {
        String msg = null;
        if (err != null && err.getAdaptorErr() != null) {
            msg = "文件大小不符合规定";
        } else if (tf == null) {
            msg = "空文件";
        } else {
            DicPlace dicPlace = dao.fetch(DicPlace.class, placeId);
            try {
                BufferedImage image = Images.read(tf.getFile());
                image = Images.zoomScale(image, imgSmallWidth, imgSmallHeight, Color.WHITE);
                ByteArrayOutputStream out = new ByteArrayOutputStream();
                Images.writeJpeg(image, out, 1.0f);
                dicPlace.setAvatarSmall(out.toByteArray());

                image = Images.read(tf.getFile());
                image = Images.zoomScale(image, imgMediumWidth, imgMediumHeight, Color.WHITE);
                out = new ByteArrayOutputStream();
                Images.writeJpeg(image, out, 1.0f);
                dicPlace.setAvatarMedium(out.toByteArray());

                image = Images.read(tf.getFile());
                image = Images.zoomScale(image, imgBigWidth, imgBigHeight, Color.WHITE);
                out = new ByteArrayOutputStream();
                Images.writeJpeg(image, out, 1.0f);
                dicPlace.setAvatarBig(out.toByteArray());

                dao.update(dicPlace, "^avatarSmall|avatarMedium|avatarBig$");
                imageService.removeImg("avatarSmall", "dic_place","id", placeId);
                imageService.removeImg("avatarMedium","dic_place","id",placeId);
                imageService.removeImg("avatarBig","dic_place","id",placeId);
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
    @AdaptBy(type=UploadAdaptor.class, args={"${app.root}/WEB-INF/tmp/user_avatar", "8192", "utf-8", "20000000", "102400000"})
    @POST
    @Ok(">>:/manager/dicplace/list")
    @At("/avatararr")
    public void uploadAvatararr(@Param("file")TempFile[] tf,
                             @Param("id")int placeId,
                             AdaptorErrorContext err) {
        String msg = null;
        if (err != null && err.getAdaptorErr() != null) {
            msg = "文件大小不符合规定";
        } else if (tf == null) {
            msg = "空文件";
        } else {
            try {
                for(int i = 0;i < tf.length;i++) {
                    DicPlacePics dicPlacePics = new DicPlacePics();
                    Date now = new Date();
                    dicPlacePics.setCreateTime(now);
                    dicPlacePics.setUpdateTime(now);
                    dicPlacePics.setDid(placeId);

                    BufferedImage image = Images.read(tf[i].getFile());
                    image = Images.zoomScale(image, imgSmallWidth, imgSmallHeight, Color.WHITE);
                    ByteArrayOutputStream out = new ByteArrayOutputStream();
                    Images.writeJpeg(image, out, 1.0f);
                    dicPlacePics.setAvatarSmall(out.toByteArray());

                    image = Images.read(tf[i].getFile());
                    image = Images.zoomScale(image, imgMediumWidth, imgMediumHeight, Color.WHITE);
                    out = new ByteArrayOutputStream();
                    Images.writeJpeg(image, out, 1.0f);
                    dicPlacePics.setAvatarMedium(out.toByteArray());

                    image = Images.read(tf[i].getFile());
                    image = Images.zoomScale(image, imgBigWidth, imgBigHeight, Color.WHITE);
                    out = new ByteArrayOutputStream();
                    Images.writeJpeg(image, out, 1.0f);
                    dicPlacePics.setAvatarBig(out.toByteArray());

                    dao.insert(dicPlacePics);
                    imageService.removeImg("avatarSmall", "dic_place_pics","id", (long)dicPlacePics.getId());
                    imageService.removeImg("avatarMedium", "dic_place_pics","id", (long)dicPlacePics.getId());
                    imageService.removeImg("avatarBig", "dic_place_pics","id", (long)dicPlacePics.getId());
                }
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
    @At("/avatar_small")
    @GET
    public Object readAvatarSmall(@Param("id")int placeId, HttpServletRequest req) throws SQLException {
//        DicPlace profile = Daos.ext(dao, FieldFilter.create(DicPlace.class, "^avatarSmall$")).fetch(DicPlace.class, placeId);
//        if (profile == null || profile.getAvatarSmall() == null) {
//            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
//        }
//        return profile.getAvatarSmall();
        return imageService.getImg("avatarSmall","dic_place","id",placeId);
    }
    @RequiresUser
    @Ok("raw:jpg")
    @At("/avatar_medium")
    @GET
    public Object readAvatarMedium(@Param("id")int placeId, HttpServletRequest req) throws SQLException {
//        DicPlace profile = Daos.ext(dao, FieldFilter.create(DicPlace.class, "^avatarMedium$")).fetch(DicPlace.class, placeId);
//        if (profile == null || profile.getAvatarMedium() == null) {
//            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
//        }
//        return profile.getAvatarMedium();
        return imageService.getImg("avatarMedium","dic_place","id",placeId);
    }
    @RequiresUser
    @Ok("raw:jpg")
    @At("/avatar_big")
    @GET
    public Object readAvatarBig(@Param("id")int placeId, HttpServletRequest req) throws SQLException {
//        DicPlace profile = Daos.ext(dao, FieldFilter.create(DicPlace.class, "^avatarBig$")).fetch(DicPlace.class, placeId);
//        if (profile == null || profile.getAvatarBig() == null) {
//            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
//        }
//        return profile.getAvatarBig();
        return imageService.getImg("avatarBig","dic_place","id",placeId);
    }

    @RequiresUser
    @Ok("raw:jpg")
    @At("/pic_avatar_small")
    @GET
    public Object pic_avatar_small(@Param("id")int picId, HttpServletRequest req) throws SQLException {
//        DicPlacePics profile = Daos.ext(dao, FieldFilter.create(DicPlacePics.class, "^avatarSmall$")).fetch(DicPlacePics.class, picId);
//        if (profile == null || profile.getAvatarSmall() == null) {
//            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
//        }
//        return profile.getAvatarSmall();
        return imageService.getImg("avatarSmall","dic_place_pics","id",picId);
    }

}
