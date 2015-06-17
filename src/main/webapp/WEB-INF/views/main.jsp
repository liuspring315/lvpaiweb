<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="/WEB-INF/views/include/meta.jsp" %>
    <script type="text/javascript">
        function showplace(id){
            $("#placeid").val(id);
            $("#place_view_form").submit();
        }
    </script>
    <script type="text/javascript">
        function showphotographer(id){
            $("#photographerid").val(id);
            $("#photographer_view_form").submit();
        }
    </script>
</head>

<body>
<%@ include file="/WEB-INF/views/include/menu.jsp" %>
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
                <img src="${resourceUrl}/img/pai.jpeg" alt="...">
                <div class="carousel-caption">
                    <h2>泰国-清迈-pai县</h2>
                    <p>Love in Thai, Pai in love</p>
                </div>
            </div>
            <div class="item">
                <img src="${resourceUrl}/img/puji2.jpeg" alt="...">
                <div class="carousel-caption">
                    <h2>泰国-普吉</h2>
                    <p>普吉，爱，你听到了吗？</p>
                </div>
            </div>
            <div class="item">
                <img src="${resourceUrl}/img/yinni.jpeg" alt="...">
                <div class="carousel-caption">
                    <h2>印尼</h2>
                    <p>这么美那么近 重新发现印尼</p>
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

<!-- 主体内容 -->
<!-- 摄影师 -->
<div id="photographer" class="container">
    <div class="row">
        <div class="col-lg-12 text-center lvpaizhe-padding-bottom">
            <h1>遍布世界各地的优秀摄影师</h1>
            <a href="${ctx}/web/photographer/photographer_all">更多摄影师 &gt;</a>
        </div>
    </div>
    <div id="div_photographer_list" class="row lvpaizhe-background-color">
    </div>
</div>
<!-- 旅拍在路上 -->
<div class="container">
    <div class="row">
        <div class="col-lg-12 text-center lvpaizhe-padding-bottom">
            <h1>旅拍在路上</h1>
            <a href="${ctx}/web/place/place_all">更多 &gt;</a>
        </div>
    </div>
    <div class="row lvpaizhe-background-color">
        <div class="col-lg-12">
            <h3>境外</h3>
        </div>
    </div>
    <div  id="div_dicPlace_list1" class="row lvpaizhe-background-color">
    </div>
    <div class="row lvpaizhe-background-color">
        <div class="col-lg-12">
            <h3>境内</h3>
        </div>
    </div>
    <div id="div_dicPlace_list0" class="row lvpaizhe-background-color">
    </div>
</div>

<!-- 婚纱旅拍 -->
<div class="container">
    <div class="row">
        <div class="col-lg-12 text-center lvpaizhe-padding-bottom">
            <h1>婚纱旅拍</h1>
            <a href="#">更多 &gt;</a>
        </div>
    </div>
    <div class="row lvpaizhe-background-color">
        <div class="col-sm-4  place" >
            <img src="${resourceUrl}/img/taiguohunsha.jpg" alt="..."  width="370" height="250">
            <p class="text-center">泰美丽</p>
        </div>
        <div class="col-sm-4  place" >
            <img src="${resourceUrl}/img/4473131_203121495000_2.jpg" alt="..."  width="370" height="250">
            <p class="text-center">某某地</p>
        </div>
        <div class="col-sm-4  place" >
            <img src="${resourceUrl}/img/4473131_185113911000_2.jpg" alt="..." width="370" height="250" >
            <p class="text-center">古堡风情</p>
        </div>
    </div>
</div>


<jsp:include flush="true" page="/WEB-INF/views/include/footer.jsp"/>
<script type="text/javascript">
    $(function () {
        $.ajax({
            url : ctx + "/web/queryDicPlaceList",
            data : {placeType:0},
            dataType : "json",
            success : function(data) {
                console.log(data);
                var dicPlace_list_html = "";
                for (var i=0;i<data.length;i++) {
                    var place = data[i];
                    console.log(place);
                    var tmp = "";
                    tmp = tmp + "<div class=\"col-sm-4  place\" >";
                    tmp = tmp + "<a href=\"#\" onclick=\"javascript:showplace("+place.id+")\"><img src=\"${ctx}/web/place/avatar_small?id="+place.id+"\" alt=\"...\"  width=\"370\" height=\"250\"></a>";
                    tmp = tmp + "<p class=\"text-center\">"+place.placeName+"</p>";
                    tmp = tmp + "</div>";

                    dicPlace_list_html += tmp;
                }
                $("#div_dicPlace_list0").html(dicPlace_list_html);
            }
        });
        $.ajax({
            url : ctx + "/web/queryDicPlaceList",
            data : {placeType:1},
            dataType : "json",
            success : function(data) {
                console.log(data);
                var dicPlace_list_html = "";
                for (var i=0;i<data.length;i++) {
                    var place = data[i];
                    console.log(place);
                    var tmp = "";
                    tmp = tmp + "<div class=\"col-sm-4  place\" >";
                    tmp = tmp + "<a href=\"#\" onclick=\"javascript:showplace("+place.id+")\"><img src=\"${ctx}/web/place/avatar_small?id="+place.id+"\" alt=\"...\"  width=\"370\" height=\"250\"></a>";
                    tmp = tmp + "<p class=\"text-center\"><a href=\"#\" onclick=\"javascript:showplace("+place.id+")\">"+place.placeName+"</a></p>";
                    tmp = tmp + "</div>";

                    dicPlace_list_html += tmp;
                }
                $("#div_dicPlace_list1").html(dicPlace_list_html);
            }
        });
        $.ajax({
            url : ctx + "/web/queryPhotographerList",
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
<form action="${ctx}/web/place/view" id="place_view_form" method="post">
    <input type="hidden" name="id" id="placeid" value=""/>
</form>
<form action="${ctx}/web/photographer/view" id="photographer_view_form" method="post">
    <input type="hidden" name="id" id="photographerid" value=""/>
</form>
</body>
</html>