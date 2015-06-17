<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="/WEB-INF/views/include/meta.jsp" %>
</head>

<body>
<%@ include file="/WEB-INF/views/include/menu.jsp" %>
<!-- 路径导航 -->
<div class="container">
    <ol class="breadcrumb">
        <li><a href="${ctx}/main">首页</a></li>
        <li class="active">加盟入驻</li>
    </ol>
</div>


<div class="container marketing">
    <div class="row">
        <div class="col-lg-12 text-center">
            <img src="${resourceUrl}/img/g3.jpg"  height="420" >
        </div>
    </div>
    <!-- Three columns of text below the carousel -->
    <div class="row">
        <div class="col-lg-12 lvpaizhe-padding-bottom text-center">
            <h3>身份选择
                <small>每个帐号只能选择一种身份。 我一专多能，又能拍照又能化妆，
                    <button type="button" class="btn btn-info" data-toggle="modal" data-target=".bs-example-modal-sm">怎么破？</button>
                </small>
            </h3>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-4">
            <span class="icon-camera-retro icon-4x"></span>
            <h2>摄影师</h2>
            <p>独立个人摄影师。我的时间我做主，我为自己代言。<br>&nbsp;</p>
            <a href="${ctx}/web/server/photoer/register" role="button" class="btn btn-primary btn-lg btn-block">选择摄影师身份注册</a>
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">
            <span class="icon-building icon-4x"></span>
            <h2>摄影机构</h2>
            <p>拥有摄影师、造型师、摄影服装及影棚资源的摄影工作室、影楼等。</p>
            <a href="#" role="button" class="btn btn-primary btn-lg btn-block">选择摄影机构身份注册</a>
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">
            <span class="icon-cut icon-4x"></span>
            <h2>造型师</h2>
            <p>个人造型师及化妆师。<br>&nbsp;</p>
            <a href="#" role="button" class="btn btn-primary btn-lg btn-block">选择造型师身份注册</a>
        </div><!-- /.col-lg-4 -->
    </div><!-- /.row -->
</div>


<!-- /提示框 -->
<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="mySmallModalLabel">温馨提示</h4>
            </div>
            <div class="modal-body">
                亲，那您选择摄影师就好了，您在发布摄影套餐的时候可以选择可提供造型服务就好啦！        </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<jsp:include flush="true" page="/WEB-INF/views/include/footer.jsp"/>

</body>
</html>