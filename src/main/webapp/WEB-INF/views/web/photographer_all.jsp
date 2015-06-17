<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="/WEB-INF/views/include/meta.jsp" %>
</head>

<body>
<form action="${ctx}/web/photographer/view" id="photographer_view_form" method="post">
    <input type="hidden" name="id" id="photographerid" value=""/>
</form>
<%@ include file="/WEB-INF/views/include/menu.jsp" %>
<!-- 路径导航 -->
<div class="container">
    <ol class="breadcrumb">
        <li><a href="${ctx}/">首页</a></li>
        <li class="active">摄影师</li>
    </ol>
</div>
<!-- 幻灯片 -->
<div class="container lvpaizhe-background-color homepage-carousel-margin-top">
    <div class="carousel slide" id="carousel-example-generic" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox">
            <div class="item active">
                <img src="${resourceUrl}/img/photographerpic.jpg" alt="...">
                <div class="carousel-caption">
                    <h2>Pierre</h2>
                    <p>法国著名摄影师，被《美国摄影》杂志评为全球著名摄影师</p>
                </div>
            </div>
            <div class="item">
                <img src="${resourceUrl}/img/photographerpic.jpg" alt="...">
                <div class="carousel-caption">
                    <h2>Pierre</h2>
                    <p>法国著名摄影师，被《美国摄影》杂志评为全球著名摄影师</p>
                </div>
            </div>
            <div class="item">
                <img src="${resourceUrl}/img/photographerpic.jpg" alt="...">
                <div class="carousel-caption">
                    <h2>Pierre</h2>
                    <p>法国著名摄影师，被《美国摄影》杂志评为全球著名摄影师</p>
                </div>
            </div>
        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</div>

<!-- 搜索 -->
<div class="container lvpaizhe-background-color lvpaizhe-padding-bottom">
    <div class="row">
        <div class="col-md-4 col-xs-12">
            <form class="form-inline">
                <div class="form-group">
                    <label for="searchPhotographer">筛选摄影师</label>
                    <div class="form-group dropdown ">
                        <button class="btn btn-default dropdown-toggle" type="button" id="searchPhotographer" data-toggle="dropdown" aria-expanded="true">
                            性别
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="searchPhotographer">
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="#">男</a></li>
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="#">女</a></li>
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="#">不限</a></li>
                        </ul>
                    </div>
                    <div class="form-group dropdown ">
                        <button class="btn btn-default dropdown-toggle" type="button" id="searchPhotographer" data-toggle="dropdown" aria-expanded="true">
                            所在地
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="searchPhotographer">
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="#">国内</a></li>
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="#">国外</a></li>
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="#">不限</a></li>
                        </ul>
                    </div>
                    <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- 主体内容 -->
<!-- 摄影师 -->
<div class="container">
    <!-- 摄影师一览 row 包含四个摄影师col-->
    <div id="div_photographer_list"  class="row lvpaizhe-background-color"></div>
    <!-- 分页 -->
    <div class="row" id="div_pager"></div>
</div>
<jsp:include flush="true" page="/WEB-INF/views/include/footer.jsp"/>
<script type="text/javascript">
    function showphotographer(id){
        $("#photographerid").val(id);
        $("#photographer_view_form").submit();
    }
    $(function () {
        $.ajax({
            url : ctx + "/web/photographer/allPhotographerList",
            dataType : "json",
            success : function(data) {
                console.log(data);
                var photographer_list_html = "";
                console.log(data.list);
                for (var i=0;i<data.list.length;i++) {
                    var user = data.list[i];
                    console.log(user);
                    var tmp = "";
                    tmp = tmp + "<div class=\"col-lg-3 col-sm-6\">";
                    tmp = tmp + "<div class=\"lvpaizhe-photographer-index-box\">";
                    <!-- 头像及简介 -->
                    tmp = tmp + "<div class=\"row\">";
                    tmp = tmp + "<div class=\"col-sm-4 lvpaizhe-photographer-avatar\">";
                    tmp = tmp + "<img class=\"img-circle\" src=\"${ctx}/web/avatar?id="+user.id+"\" alt=\"...\" width=\"80\" height=\"80\">";
                    tmp = tmp + "</div>";
                    tmp = tmp + "<div class=\"col-sm-8\">";
                    tmp = tmp + "<table class=\"lvpaizhe-photographer-table\">";
                    tmp = tmp + "<tr>";
                    tmp = tmp + "<td>"+user.lastName+"</td>";
                    tmp = tmp + "<td>"+(user.dicPlace==null?"":user.dicPlace.placeName)+"</td>";
                    tmp = tmp + "</tr>";
                    tmp = tmp + "<tr>";
                    tmp = tmp + "<td colspan=\"2\">V"+(user.photographerExtra==null?"":user.photographerExtra.authentication)+" 认证</td>";
                    tmp = tmp + "</tr>";
                    tmp = tmp + "<tr>";
                    tmp = tmp + "<td colspan=\"2\">"+(user.photographerExtra==null?"":user.photographerExtra.orderNum)+" 次成功服务拍摄</td>";
                    tmp = tmp + "</tr>";
                    tmp = tmp + "</table>";
                    tmp = tmp + "</div>";
                    tmp = tmp + "</div>";
                    <!-- 代表作 -->
                    tmp = tmp + "<div class=\"row\">";
                    tmp = tmp + "<div class=\"col-sm-12 lvpaizhe-photographer-pic\">";
                    tmp = tmp + "<a href=\"#\" onclick=\"javascript:showphotographer("+user.id+")\"><img src=\"${ctx}/web/photographer/avatar_small?id="+user.id+"\" width=\"242\" height=\"175\"></a>";
                    tmp = tmp + "</div>";
                    tmp = tmp + "</div>";
                    tmp = tmp + "</div>";
                    tmp = tmp + "</div>";
                    photographer_list_html += tmp;
                }
                $("#div_photographer_list").html(photographer_list_html);
            }
        });
    });
</script>
</body>
</html>