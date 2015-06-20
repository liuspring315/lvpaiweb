<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="/WEB-INF/views/include/meta.jsp" %>
    <script src="${resourceUrl}/js/pager.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/views/include/menu.jsp" %>
<!-- 路径导航 -->
<div class="container">
    <ol class="breadcrumb">
        <li><a href="${ctx}/">首页</a></li>
        <li><a href="${ctx}/web/photographer/photographer_all">摄影师</a></li>
        <li class="active">摄影服务介绍</li>
    </ol>
</div>

<!-- 主体内容 -->
<div class="container">
    <!-- 本页面唯一row，内分两列，摄影师左边栏和服务详情 -->
    <div class="row">
        <!-- 摄影师左边栏 -->
        <div class="col-md-2">
            <div class="row">
                <!-- 头像 -->
                <div class="col-md-12">
                    <img alt="140x140" src="${ctx}/web/avatar?id=${obj.userGeneralInfo.id}" class="img-rounded" />
                </div>

                <!-- 摄影师信息 -->
                <div class="col-md-12 text-center">
                    <h2>
                        ${obj.userGeneralInfo.lastName}&nbsp;&nbsp;&nbsp;&nbsp;
                    </h2>
                    <p>
                        ${obj.userGeneralInfo.dicPlace.placeName}
                    </p>
                    <p>
                        <c:if test="${obj.userGeneralInfo.gender==0}">男</c:if>  <c:if test="${obj.userGeneralInfo.gender==1}">女</c:if>
                    </p>
                    <p>
                        V${obj.photographerExtra.authentication} 认证
                    </p>
                    <p>
                        ${obj.photographerExtra.orderNum} 次成功服务
                    </p>
                </div>
                <div class="col-md-12 text-center">
                    <button type="button" class="btn btn-info">收藏摄影师</button>
                </div>
            </div>
        </div>

        <!-- 服务详情 -->
        <div class="col-md-10">
            <!-- 摄影服务 -->
            <div class="row">
                <div class="col-md-12">
                    <h2 class="text-center">
                        ${obj.goodsInfo.goodsName}
                    </h2>
                    <!-- 拍摄地及类型 -->
                    <div class="row">
                        <p>
                        <div class="col-md-2 lvpaizhe-tab">
                            <lable>拍摄地</lable>
                        </div>
                        <div class="col-md-4">
                            <lable>${obj.goodsInfo.dicPlace.placeName}</lable>
                        </div>
                        <div class="col-md-2 lvpaizhe-tab">
                            <lable>拍摄类型</lable>
                        </div>
                        <div class="col-md-4">
                            <lable>
                                <c:if test="${obj.goodsInfo.photoType==1}">婚纱摄影</c:if>
                                <c:if test="${obj.goodsInfo.photoType==2}">旅行跟拍</c:if>
                                <c:if test="${obj.goodsInfo.photoType==3}">上门拍</c:if>
                            </lable>
                        </div>
                        </p>
                    </div>

                    <!-- 价格 -->
                    <div class="row">
                        <p>
                        <div class="col-md-2 lvpaizhe-tab">
                            <lable>总价格</lable>
                        </div>
                        <div class="col-md-4">
                            <lable>${obj.goodsInfo.totalPrice}元</lable>
                        </div>
                        <div class="col-md-2 lvpaizhe-tab">
                            <lable>预付款</lable>
                        </div>
                        <div class="col-md-4">
                            <lable>${obj.goodsInfo.advancePayment}元</lable>
                        </div>
                        </p>
                    </div>

                    <!-- 片数 -->
                    <div class="row">
                        <p>
                        <div class="col-md-2 lvpaizhe-tab">
                            <lable>原片数量</lable>
                        </div>
                        <div class="col-md-4">
                            <lable>100张</lable>
                        </div>
                        <div class="col-md-2 lvpaizhe-tab">
                            <lable>精修数量</lable>
                        </div>
                        <div class="col-md-4">
                            <lable>50张</lable>
                        </div>
                        </p>
                    </div>

                    <!-- 服务项目 -->
                    <div class="row">
                        <p>
                        <div class="col-md-2 lvpaizhe-tab">
                            <label>提供服务</label>
                        </div>
                        <div class="col-md-10">
                            <label class="lvpaizhe-servers">
                                <span class="fa fa-fw fa-truck"></span>当地用车
                            </label>

                            <label class="lvpaizhe-servers">
                                <span class="fa fa-fw fa-female"></span>服装
                            </label>

                            <label class="lvpaizhe-servers">
                                <span class="glyphicon glyphicon-facetime-video"></span>&nbsp;视频
                            </label>

                            <label class="lvpaizhe-servers">
                                <span class="glyphicon glyphicon-scissors"></span>&nbsp;化妆造型
                            </label>

                            <label class="lvpaizhe-servers">
                                <span class="glyphicon glyphicon-bed"></span>&nbsp;酒店
                            </label>
                        </div>
                        </p>
                    </div>

                    <!-- 联系客服及预订（上） -->
                    <div class="row">
                        <div id="context" class="col-md-6 col-md-offset-1 lp-contact-server">
                            <div class="row">
                                <div class="col-md-3 text-center">
                                    <lable><strong>联系客服</strong></lable>
                                </div>
                                <div class="col-md-3">
                                    <lable><img alt="16×16" src="img/envelope.gif"/>站内留言</lable>
                                </div>
                                <div class="col-md-3">
                                    <lable><img alt="16×16" src="img/wechat.png"/>微信联系</lable>
                                </div>
                                <div class="col-md-3">
                                    <lable><img alt="16×16" src="img/qq.png"/>QQ联系</lable>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2 text-center lvpaizhe-booking-btn">
                            <a href="#" class="btn btn-primary" role="button" data-toggle="modal" data-target="#bs-booking">马上预订</a>
                        </div>
                    </div>

                    <!-- 自定义服务内容展示 -->
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <img src="img/aaa.jpg">
                        </div>
                    </div>

                    <!-- 分享功能 -->
                    <div class="row">
                        <div class="col-md-11 col-md-offset-1">
                            <!-- JiaThis Button BEGIN -->
                            <div id="share" class="jiathis_style">
                                <span class="jiathis_txt">分享到：</span>
                                <a class="jiathis_button_tools_1"></a>
                                <a class="jiathis_button_tools_2"></a>
                                <a class="jiathis_button_tools_3"></a>
                                <a class="jiathis_button_tools_4"></a>
                                <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank">更多</a>
                            </div>
                            <!-- JiaThis Button END -->
                        </div>
                    </div>

                    <!-- 联系客服及预订（下） -->
                    <div class="row">
                        <div id="context" class="col-md-6 col-md-offset-1 lp-contact-server">
                            <div class="row">
                                <div class="col-md-3 text-center">
                                    <lable><strong>联系客服</strong></lable>
                                </div>
                                <div class="col-md-3">
                                    <lable><img alt="16×16" src="img/envelope.gif"/>站内留言</lable>
                                </div>
                                <div class="col-md-3">
                                    <lable><img alt="16×16" src="img/wechat.png"/>微信联系</lable>
                                </div>
                                <div class="col-md-3">
                                    <lable><img alt="16×16" src="img/qq.png"/>QQ联系</lable>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2 text-center lvpaizhe-booking-btn">
                            <button type="button" class="btn btn-primary">马上预订</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include flush="true" page="/WEB-INF/views/include/footer.jsp"/>
<form action="#" id="goods_query_form" method="post">
    <input type="hidden" name="pid" id="pid" value="${obj.id}"/>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        loadGoods(1,20);
    });//end ready
    function loadGoods(pageNumber,pageSize){
        var postdata = $("#goods_query_form").serializeArray ();
        if(pageNumber){
            postdata.push({name: 'pageNumber', value: pageNumber});
            postdata.push({name: 'pageSize', value: pageSize});
        }
        $.ajax({
            url : ctx + "/web/photographer/goodsquery",
            data : postdata,
            dataType : "json",
            type : "POST",
            success : function(re) {
                if (!re.ok) {
                    alert(re.msg);
                    return;
                }
                data = re.data;
                //console.log(data);
                var list_html = "";
                //console.log(data.list);
                for (var i=0;i<data.list.length;i++) {
                    var goods = data.list[i];
                    var tmp = "<div class=\"row\">";
                    tmp = tmp + "<div class=\"col-md-3 pics-padding\">";
                    tmp = tmp + "<img src=\""+ctx + "/web/photographer/goods_avatar_small?id=" + goods.id +"\" width=\"242\" height=\"175\">";
                    tmp = tmp + "</div>";
                    tmp = tmp + "<div class=\"col-md-8\">";
                    tmp = tmp + "<h3>";
                    tmp = tmp + goods.goodsName;
                    tmp = tmp + "</h3>";
                    tmp = tmp + "<div class=\"row goods-desc-lineheight\">";
                    tmp = tmp + "<p>";
                    tmp = tmp + "<div class=\"col-md-4\">";
                    tmp = tmp + "<lable>"+goods.dicPlace.placeName+"</lable>";
                    tmp = tmp + "</div>";
                    tmp = tmp + "<div class=\"col-md-4\">";
                    tmp = tmp + "<lable>";
                    switch(goods.photoType){
                        case 1:tmp = tmp + "婚纱摄影";break;
                        case 2:tmp = tmp + "旅行跟拍";break;
                        case 3:tmp = tmp + "上门拍";break;
                        default :tmp = tmp +  "";
                    }
                    tmp = tmp + "</lable>";
                    tmp = tmp + "</div>";
                    tmp = tmp + "</p>";
                    tmp = tmp + "</div>";
                    tmp = tmp + "<div class=\"row goods-desc-lineheight\">";
                    tmp = tmp + "<p>";
                    for (var j=0;j<goods.dicProjects;j++) {
                        var project = goods.dicProjects[i];
                        tmp = tmp + "<div class=\"col-md-2\">";
                        tmp = tmp + "<label>";
                        tmp = tmp + "<span class=\""+project.projectIco+"\"></span>"+project.projectName;
                        tmp = tmp + "</label>";
                        tmp = tmp + "</div>";
                    }

                    tmp = tmp + "</p>";
                    tmp = tmp + "</div>";
                    tmp = tmp + "<div class=\"row goods-desc-lineheight\">";
                    tmp = tmp + "<p>";
                    tmp = tmp + "<div class=\"col-md-3\">";
                    tmp = tmp + "<lable>总价格："+goods.totalPrice+"元</lable>";
                    tmp = tmp + "</div>";
                    tmp = tmp + "<div class=\"col-md-3\">";
                    tmp = tmp + "<lable>预付款："+goods.advancePayment+"元</lable>";
                    tmp = tmp + "</div>";
                    tmp = tmp + "<div class=\"col-md-2 col-md-offset-3 goods-btn text-right\">";
                    tmp = tmp + "<button class=\"btn btn-info\" type=\"button\">详情</button>";
                    tmp = tmp + "</div>";
                    tmp = tmp + "<div class=\"col-md-1 goods-btn\">";
                    tmp = tmp + "<button class=\"btn btn-primary\" type=\"button\">预定</button>";
                    tmp = tmp + "</div>";
                    tmp = tmp + "</p>";
                    tmp = tmp + "</div>";
                    tmp = tmp + "</div>";
                    tmp = tmp + "</div>";
                    tmp = tmp + "<hr>";
                    list_html += tmp;
                }
                $("#div_goods").html(list_html);
                $("#div_pager").html(PagerTag.showPagerTag("loadGoods","",data.pager));
                //console.log(window._user_roles);
            }
        });
    }

</script>
</body>
</html>