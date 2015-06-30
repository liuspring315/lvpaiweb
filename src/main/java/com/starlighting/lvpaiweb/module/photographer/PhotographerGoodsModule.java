package com.starlighting.lvpaiweb.module.photographer;

import com.starlighting.lvpaiweb.bean.*;
import com.starlighting.lvpaiweb.module.BaseModule;
import com.starlighting.lvpaiweb.util.Toolkit;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.nutz.aop.interceptor.ioc.TransAop;
import org.nutz.dao.Cnd;
import org.nutz.dao.DaoException;
import org.nutz.dao.FieldFilter;
import org.nutz.dao.QueryResult;
import org.nutz.dao.pager.Pager;
import org.nutz.dao.util.Daos;
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

import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.sql.SQLException;
import java.util.*;
import java.util.List;

/**
 * @功能说明：摄影师拍摄服务
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-11
 */
@At("/photographer/goods")
@IocBean
@Ok("void")//避免误写导致敏感信息泄露到服务器外
public class PhotographerGoodsModule extends BaseModule {
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

    @Inject("java:$config.get('img.path')")
    private String imgPath;

    @At
    @Ok("jsp:views.photographer.photographer_goods_list")
    public Object list(@Attr("me")UserGeneralInfo me) {
//        PhotographerExtra photographerExtra = dao.fetch(PhotographerExtra.class, me.getId());
//        if(photographerExtra == null || photographerExtra.getAuthentication() ==0){
//            return 0;//未申请认证不允许提交拍摄服务
//        }
        return 1;
    }

    @At
    @Ok("json")
    public Object query(@Attr("me")UserGeneralInfo me, @Param("..")Pager pager) {
        QueryResult qr = new QueryResult();
        Cnd cnd = Cnd.NEW().where("serviceProviderId","=",me.getId());
        List<GoodsInfo> goodsInfos = dao.query(GoodsInfo.class, cnd, pager);
        dao.fetchLinks(goodsInfos,"dicProjects");
        dao.fetchLinks(goodsInfos,"dicPlace");
        qr.setList(goodsInfos);
        pager.setRecordCount(dao.count(GoodsInfo.class, cnd));
        qr.setPager(pager);
        return ajaxOk(qr);
    }

    @At
    @Ok("jsp:views.photographer.photographer_goods_add")

    public Object add(@Attr("me")UserGeneralInfo me) {
        Map<String,Object> map = new HashMap<String,Object>();
//        PhotographerExtra photographerExtra = dao.fetch(PhotographerExtra.class, me.getId());
//        if(photographerExtra == null || photographerExtra.getAuthentication() ==0){
//            map.put("can",0);
//            return map;//未申请认证不允许提交拍摄服务
//        }
        map.put("can",1);
        map.put("projectList",dao.query(DicProject.class, Cnd.NEW()));
        return map;
    }

    @At
    @Ok("jsp:views.photographer.photographer_goods_add")
    public Object view(@Attr("me")UserGeneralInfo me,@Param("id") int id) {
        Map<String,Object> map = new HashMap<String,Object>();
//        PhotographerExtra photographerExtra = dao.fetch(PhotographerExtra.class, me.getId());
//        if(photographerExtra == null || photographerExtra.getAuthentication() ==0){
//            map.put("can",0);
//            return map;//未申请认证不允许提交拍摄服务
//        }
        map.put("can",1);
        GoodsInfo goodsInfo = dao.fetch(GoodsInfo.class, id);
        dao.fetchLinks(goodsInfo, "dicProjects");
        dao.fetchLinks(goodsInfo, "dicPlace");
        dao.fetchLinks(goodsInfo, "goodsPics");
        map.put("projectList",dao.query(DicProject.class, Cnd.NEW()));
        map.put("goodsInfo",goodsInfo);
        return map;
    }

    @At
    @Ok("json")
    @Aop(TransAop.READ_COMMITTED)
    public Object update(@Attr("me")UserGeneralInfo me,@Param("..") GoodsInfo goodsInfo,@Param("dicProjectsId") int [] projectId) {
//        PhotographerExtra photographerExtra = dao.fetch(PhotographerExtra.class, me.getId());
//        if(photographerExtra == null || photographerExtra.getAuthentication() ==0){
//            return 0;//未申请认证不允许提交拍摄服务
//        }
        Date now = new Date();
        if(goodsInfo.getId() == null){

            goodsInfo.setCreateTime(now);
            goodsInfo.setUpdateTime(now);
            goodsInfo.setOrderStat(OrderStatEnum.WAIT_APPROVE.getCode());
            goodsInfo.setPhotoBeginDate(now);
            goodsInfo.setPhotoEndDate(Toolkit.convertStringToDate(Toolkit.SHORTDATEFORMATER,"2016-12-31"));
            goodsInfo.setServiceProviderId(me.getId());

            List<DicProject> ps = new ArrayList<DicProject>();
            for(int i = 0 ; i < projectId.length;i++){
                DicProject dicProject = dao.fetch(DicProject.class,projectId[i]);
                if(dicProject != null) {
                    ps.add(dicProject);
                }
            }
            goodsInfo.setDicProjects(ps);
            dao.insert(goodsInfo);
            dao.insertLinks(goodsInfo, "dicProjects");
        }else{
            GoodsInfo data = dao.fetch(GoodsInfo.class,goodsInfo.getId());
            if(data.getOrderStat() == OrderStatEnum.WAIT_APPROVE.getCode()
                    ||data.getOrderStat() == OrderStatEnum.APPROVE_NO.getCode()){
                data.setUpdateTime(now);
                data.setOrderStat(OrderStatEnum.WAIT_APPROVE.getCode());

                data.setGoodsName(goodsInfo.getGoodsName());
                data.setPlace(goodsInfo.getPlace());
                data.setPhotoType(goodsInfo.getPhotoType());
                data.setTotalPrice(goodsInfo.getTotalPrice());
                data.setAdvancePayment(goodsInfo.getAdvancePayment());
                data.setOriginalNum(goodsInfo.getOriginalNum());
                data.setProcessingNum(goodsInfo.getProcessingNum());
                data.setGoodsDesc(goodsInfo.getGoodsDesc());

                List<DicProject> ps = new ArrayList<DicProject>();
                for(int i = 0 ; i < projectId.length;i++){
                    DicProject dicProject = dao.fetch(DicProject.class,projectId[i]);
                    if(dicProject != null) {
                        ps.add(dicProject);
                    }
                }
                dao.fetchLinks(data, "dicProjects");
                if (data.getDicProjects().size() > 0) {
                    dao.clearLinks(data, "dicProjects");
                }
                goodsInfo.setDicProjects(ps);
                dao.update(data);
                dao.insertRelation(goodsInfo, "dicProjects");
            }else{
                return -1;
            }
        }
        return 1;

    }


    @RequiresUser
    @AdaptBy(type=UploadAdaptor.class, args={"${app.root}/WEB-INF/tmp/user_avatar", "8192", "utf-8", "20000000", "102400000"})
    @POST
    @Ok(">>:/photographer/goods/view?id=${obj}")
    @At("/avatararr")
    public int uploadAvatararr(@Param("file")TempFile[] tf,
                                @Param("id")int gid,
                                AdaptorErrorContext err) {
            String msg = null;
        if (err != null && err.getAdaptorErr() != null) {
            msg = "文件大小不符合规定";
        } else if (tf == null) {
            msg = "空文件";
        } else {
            try {
                for(int i = 0;i < tf.length;i++) {
                    GoodsPic goodsPic = new GoodsPic();
                    Date now = new Date();
                    goodsPic.setCreateTime(now);
                    goodsPic.setUpdateTime(now);
                    goodsPic.setGid(gid);

                    BufferedImage image = Images.read(tf[i].getFile());
                    image = Images.zoomScale(image, imgSmallWidth, imgSmallHeight, Color.WHITE);
                    ByteArrayOutputStream out = new ByteArrayOutputStream();
                    Images.writeJpeg(image, out, 0.8f);
                    goodsPic.setAvatarSmall(out.toByteArray());

                    image = Images.read(tf[i].getFile());
                    image = Images.zoomScale(image, imgMediumWidth, imgMediumHeight, Color.WHITE);
                    out = new ByteArrayOutputStream();
                    Images.writeJpeg(image, out, 0.8f);
                    goodsPic.setAvatarMedium(out.toByteArray());

                    image = Images.read(tf[i].getFile());
                    image = Images.zoomScale(image, imgBigHeight, imgBigHeight, Color.WHITE);
                    out = new ByteArrayOutputStream();
                    Images.writeJpeg(image, out, 0.8f);
                    goodsPic.setAvatarBig(out.toByteArray());

                    dao.insert(goodsPic);
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
        return gid;
    }

    @RequiresUser
    @Ok("raw:jpg")
    @At("/pic_avatar_small")
    @GET
    public Object pic_avatar_small(@Param("id")long picId, HttpServletRequest req) throws SQLException {
        GoodsPic profile = Daos.ext(dao, FieldFilter.create(GoodsPic.class, "^avatarSmall$")).fetch(GoodsPic.class, picId);
        if (profile == null || profile.getAvatarSmall() == null) {
            return new File(req.getSession().getServletContext().getRealPath("/rs/user_avatar/none.jpg"));
        }
        return profile.getAvatarSmall();
    }

    @At
    @Ok("jsp:views.photographer.editor_test")
    public void editor_test(@Attr("me")UserGeneralInfo me) {

    }








    @RequiresUser
    @AdaptBy(type=UploadAdaptor.class, args={"${app.root}/WEB-INF/tmp/user_avatar", "8192", "utf-8", "20000000", "102400000"})
    @POST
    @Ok("json")
    @At("/upload/upload_image")
    public ImageData uploadTempImage(@Attr("me")UserGeneralInfo me,HttpServletRequest request,
                               @Param("image1")TempFile tf,AdaptorErrorContext err) {

        ImageData imageData = new ImageData();
        try {
            BufferedImage image = Images.read(tf.getFile());
            String fileName = me.getId()+"_"+ new Date().getTime();
            Images.writeJpeg(image, new File(imgPath+fileName + ".jpg"), 0.9f);

            imageData.setName(fileName);
            String path = request.getScheme() + "://" + request.getServerName()
                    + ":" + request.getServerPort() + request.getContextPath()
                    + "/";
            imageData.setPath(path+"web/images/"+fileName);

        } catch(DaoException e) {
            log.error("System Error", e);
            imageData.setMsg("系统错误");
        } catch (Throwable e) {
            log.error("System Error", e);
            imageData.setMsg("图片格式错误");
        }


        return imageData;
    }


}
