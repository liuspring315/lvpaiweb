<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="/WEB-INF/views/include/meta.jsp" %>
</head>

<body>
<form action="${ctx}/web/place/view" id="place_view_form" method="post">
    <input type="hidden" name="id" id="placeid" value=""/>
</form>
<%@ include file="/WEB-INF/views/include/menu.jsp" %>
<!-- 主体内容 -->
<!-- 旅拍地点列表 -->
<c:forEach items="${obj.list}" var ="place">
<div class="container">
    <div class="row">
        <div class="col-lg-12 text-center lvpaizhe-padding-bottom">
            <h1><a href="lvpaiplace.html">${place.placeName}</a></h1>
        </div>
    </div>
    <div class="row lvpaizhe-background-color">
        <div class="col-lg-7">
            <img class="movieborder" src="${ctx}/rs/dic_place/avatarMedium/${place.id}.jpg" alt="...">
        </div>
        <div class="col-lg-5">
            <div class="row">
                <div class="col-md-12 placedescribe">
                    <h3>关于这里</h3>
                    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${place.about}</p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 text-center">
                    <button type="submit" onclick="javascript:showplace(${place.id})" class="btn btn-primary">查看详情</button>
                </div>
            </div>
        </div>
    </div>
</div>
</c:forEach>
<jsp:include flush="true" page="/WEB-INF/views/include/footer.jsp"/>
<script type="text/javascript">
    function showplace(id){
//        $("#placeid").val(id);
//        $("#place_view_form").submit();
        window.location.href = "${ctx}/web/place/view?id="+id;
    }
</script>
</body>
</html>