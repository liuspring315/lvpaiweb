package com.starlighting.lvpaiweb.module.cstmr;

import com.starlighting.lvpaiweb.bean.GoodsInfo;
import com.starlighting.lvpaiweb.bean.OrderStatEnum;
import com.starlighting.lvpaiweb.bean.PhotoOrder;
import com.starlighting.lvpaiweb.bean.UserGeneralInfo;
import com.starlighting.lvpaiweb.module.BaseModule;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Attr;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @功能说明：客户订单
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-07-12
 */
@At("/cstmr/order")
@IocBean
@Ok("void")//避免误写导致敏感信息泄露到服务器外
public class CstmrOrderModule extends BaseModule {

    @RequiresUser
    @At("/add")
    @Ok("jsp:views.web.cstmr.order_info")
    public Object add(@Param("gid")int gid,@Param("uid")int uid,@Param("fixDate")Date fixDate,
                    @Param("orderRemark")String orderRemark,
                    @Attr("me")UserGeneralInfo me) {
        UserGeneralInfo userGeneralInfo = dao.fetch(UserGeneralInfo.class,uid);
        if(userGeneralInfo == null){

        }
        dao.fetchLinks(userGeneralInfo, "photographerExtra");
        if(userGeneralInfo.getPhotographerExtra() == null){

        }

        GoodsInfo goodsInfo = dao.fetch(GoodsInfo.class, gid);
        if(goodsInfo == null){

        }

        if(goodsInfo.getServiceProviderId() != userGeneralInfo.getId()){

        }

        Date now = new Date();
        PhotoOrder photoOrder = new PhotoOrder();
        photoOrder.setCreateTime(now);
        photoOrder.setUpdateTime(now);

        photoOrder.setOrderStat(OrderStatEnum.APPROVE_YES.getCode());
        photoOrder.setServiceProviderId(uid);
        photoOrder.setCstmrId(me.getId());
        photoOrder.setCstmrRemarks(orderRemark);
        photoOrder.setGoodsName(goodsInfo.getGoodsName());
        photoOrder.setOrderFixDate(fixDate);
        photoOrder.setGoodsId(gid);
        dao.insert(photoOrder);

        Map obj = new HashMap<String,Object>();
        obj.put("goodsInfo",goodsInfo);
        obj.put("userGeneralInfo",userGeneralInfo);
        return obj;


    }
}
