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
<!-- 主体内容 -->
<div class="container">
    <!-- 摄影师头像及基本信息 -->
    <div class="row">
        <div class="col-md-2">
            <img alt="140x140" src="${ctx}/web/avatar?id=${obj.id}" class="img-rounded" />
        </div>
        <div class="col-md-10">
            <div class="row">
                <div class="col-md-12 lvpaizhe-one-photographer-desc-margin">
                    <h2>
                        ${obj.lastName}&nbsp;&nbsp;&nbsp;&nbsp;${obj.dicPlace.placeName}
                    </h2>
                    <p>
                        V${obj.photographerExtra.authentication} 高级认证
                    </p>
                    <p>
                        ${obj.photographerExtra.orderNum} 次成功服务
                    </p>
                    <p>
                        ${obj.photographerExtra.introduction}
                    </p>
                </div>
            </div>
        </div>
    </div>
    <!-- 收藏及联系客服 -->
    <div class="row">
        <div class="col-md-2 text-center lvpaizhe-one-photographer-collection-margin">
            <button type="button" class="btn btn-info">收藏摄影师</button>
        </div>
        <div id="context" class="col-md-6 lvpaizhe-one-photographer-context-margin">
            <div class="row">
                <div class="col-md-3 text-center">
                    <lable><strong>联系客服</strong></lable>
                </div>
                <div class="col-md-3">
                    <lable><img alt="16×16" src="${resourceUrl}/img/envelope.gif"/>站内留言</lable>
                </div>
                <div class="col-md-3">
                    <lable><img alt="16×16" src="${resourceUrl}/img/wechat.png"/>微信联系</lable>
                </div>
                <div class="col-md-3">
                    <lable><img alt="16×16" src="${resourceUrl}/img/qq.png"/>QQ联系</lable>
                </div>
            </div>
        </div>
    </div>
    <!-- 分享功能 -->
    <div class="row">
        <div class="col-md-12">
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
    <!-- 服务\作品\评价 -->
    <div class="row">
        <div class="col-md-12">
            <div class="tabbable" id="tabs">
                <ul class="nav nav-tabs">
                    <li class="active">
                        <a data-toggle="tab" href="#goods">摄影服务</a>
                    </li>
                    <li>
                        <a data-toggle="tab" href="#pics">作品展示</a>
                    </li>
                    <li>
                        <a data-toggle="tab" href="#Review">会员评价</a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active tab-border" id="div_goods">
                    </div>
                    <div class="tab-pane tab-border" id="pics">
                        <p>
                            第二部分内容.
                        </p>
                    </div>
                    <div class="tab-pane tab-border" id="Review">
                        <p>
                            第三部分内容.
                        </p>
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
                    tmp = tmp + "<img src=\"img/4473131_183410472000_2.jpg\" width=\"242\" height=\"175\">";
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
                    tmp = tmp + "<lable>预付款："+goods.goodsadvancePayment+"元</lable>";
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