package com.starlighting.lvpaiweb.module.photographer;

import com.starlighting.lvpaiweb.module.BaseModule;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;

/**
 * @功能说明：
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-11
 */
@At("/photographer/works")
@IocBean
@Ok("void")//避免误写导致敏感信息泄露到服务器外
public class PhotographerWorksModule extends BaseModule {
    @At
    @Ok("jsp:views.photographer.photographer_works_list")
    public void list() {
    }
}
