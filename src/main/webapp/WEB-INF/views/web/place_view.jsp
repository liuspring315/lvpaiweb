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
<!-- 主体内容 -->
<!-- 旅拍地点列表 -->
<div class="container">
    <div class="row">
        <div class="col-lg-12 text-center lvpaizhe-padding-bottom">
            <h1>${obj.dicPlace.placeName}</h1>
        </div>
    </div>
    <%--<div class="row">--%>
        <%--<div class="col-lg-12 text-center">--%>
            <%--<img class="movieborder" src="${ctx}/rs/dic_place/avatarBig/${obj.dicPlace.id}.jpg" alt="...">--%>
        <%--</div>--%>
    <%--</div>--%>
    <div class="row">
        <div class="col-lg-12">
            <%--<h3>关于这里</h3>--%>
            <%--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${obj.dicPlace.about}</p>--%>
            ${obj.dicPlace.details}
        </div>
    </div>
    <%--<div class="row">--%>
        <%--<div class="col-lg-12">--%>
            <%--<h3>记录这里</h3>--%>
            <%--<c:forEach items="${obj.dicPlace.dicPlacePicsList}" var ="pic">--%>
            <%--<img src="${ctx}/rs/dic_place_pics/avatarBig/${pic.id}.jpg" alt="..." width="1140">--%>
            <%--</c:forEach>--%>
        <%--</div>--%>
    <%--</div>--%>
    <div class="row lvpaizhe-background-color bookingphotographer">
        <div class="col-lg-12 text-center lvpaizhe-padding-bottom">
            <h1>预定推荐摄影师</h1>
            <p>旅拍者可以为您推荐符合您要求的摄影师，同时让您仅需付出相对经济的报酬</p>
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
        <div class="col-md-6 text-center">
            <form class="form-inline">
                <button type="submit" class="btn btn-primary">试试这个</button>
            </form>
        </div>
    </div>
</div>
<div id="photographer" class="container bookingphotographer">
    <div class="row">
        <div class="col-lg-12 text-center lvpaizhe-padding-bottom">
            <h1>预定自选摄影师</h1>
            <p>您也可以根据自己的意愿，选择更具个性的摄影师</p>
        </div>
    </div>
    <div class="row lvpaizhe-background-color">
        <!-- 一个摄影师col 共四个 -->
        <c:forEach items="${obj.photographerExtra}" var ="photographer">
        <div class="col-lg-3 col-sm-6">
            <div class="lvpaizhe-photographer-index-box">
                <!-- 头像及简介 -->
                <div class="row">
                    <div class="col-sm-4 lvpaizhe-photographer-avatar">
                        <img class="img-circle" src="${ctx}/rs/user_general_info/head_thumb/${photographer.id}.jpg" alt="..." width="80" height="80">
                    </div>
                    <div class="col-sm-8">
                        <table class="lvpaizhe-photographer-table">
                            <tr>
                                <td>${photographer.lastName}</td>
                                <td>${photographer.dicPlace.placeName}</td>
                            </tr>
                            <tr>
                                <td colspan="2">V ${photographer.photographerExtra.authentication} 认证</td>
                            </tr>
                            <tr>
                                <td colspan="2">${photographer.photographerExtra.orderNum} 次成功服务拍摄</td>
                            </tr>
                        </table>
                    </div>
                </div>
                <!-- 代表作 -->
                <div class="row">
                    <div class="col-sm-12 lvpaizhe-photographer-pic">
                        <img src="${ctx}/rs/photographer_extra/avatarSmall/${photographer.id}.jpg" width="242" height="175">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 text-center">
                        <button type="submit" onclick="javascript:showphotographer(${photographer.id})" class="btn btn-primary">看看他怎么样</button>
                    </div>
                </div>
            </div>
        </div>
        </c:forEach>
    </div>
</div>
<jsp:include flush="true" page="/WEB-INF/views/include/footer.jsp"/>
<script type="text/javascript">
    function showphotographer(id){
        $("#photographerid").val(id);
        $("#photographer_view_form").submit();
    }
</script>
</body>
</html>