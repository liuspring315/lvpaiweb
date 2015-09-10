<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/manager/meta.jsp" %>
    <%--<link rel="stylesheet" type="text/css" href="${resourceUrl}/manager/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css" />--%>
    <%--<script src="${resourceUrl}/manager/plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js" type="text/javascript"></script>--%>
    <%--<script src="${resourceUrl}/manager/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.js" type="text/javascript"></script>--%>
    <%--<script src="${resourceUrl}/manager/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.zh-CN.js" type="text/javascript"></script>--%>
    <script src="${resourceUrl}/manager/plugins/jQuery/jquery.validate.js" type="text/javascript"></script>
    <script src="${resourceUrl}/manager/plugins/jQuery/jquery.metadata.js" type="text/javascript"></script>


</head>
<body class="skin-blue">
<div class="wrapper">

    <%@ include file="/WEB-INF/views/include/manager/menu.jsp" %>
    <!-- Right side column. Contains the navbar and content of the page -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                摄影师拍摄服务</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li class="active">摄影师拍摄服务</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <!-- Small boxes (Stat box) -->
            <div class="row">
                <div class="col-xs-12 box box-primary lvpaizhe-a-info-padding">
                        <!-- 标题 -->
                        <div class="form-group">
                            <label for="goodsName" class="col-sm-2 control-label">标题</label>
                            <div class="col-sm-4">
                                <input type="text" maxlength="30" value="${obj.goodsInfo.goodsName}"
                                       class="form-control {validate:{required:true,trimstr:true,stringCheck:true,messages:{required:'请输入标题'}}}"
                                       id="goodsName" name="goodsName">
                            </div>
                        </div>
                        <!-- 拍摄地 -->
                        <div class="form-group">
                            <label for="place" class="col-sm-2 control-label">拍摄地</label>
                            <div class="col-sm-4">
                                <input type="text" value="${obj.goodsInfo.dicPlace.placeName}"
                                       class="form-control {validate:{required:true,trimstr:true,stringCheck:true,messages:{required:'请选择拍摄地'}}}"
                                       readonly id="placeName">
                                <input type="hidden" name="place" id="place"  value="${obj.goodsInfo.place}">
                            </div>
                        </div>
                        <!-- 拍摄类型 -->
                        <!-- 问题：minimal属性未生效 -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">拍摄类型</label>
                            <div class="col-sm-4">
                                <input type="radio" class="minimal" name="photoType"  value="1" <c:if test="${obj.goodsInfo.photoType == 1}">checked</c:if> >
                                婚纱摄影
                                </label>
                                <label>
                                    <input type="radio" class="minimal" name="photoType"  value="2" <c:if test="${obj.goodsInfo.photoType == 2}">checked</c:if> >
                                    旅行跟拍
                                </label>
                                <label>
                                    <input type="radio" class="minima" name="photoType"  value="3" <c:if test="${obj.goodsInfo.photoType == 3}">checked</c:if> >
                                    上门拍
                                </label>
                            </div>
                        </div>
                        <!-- 提供项目 -->
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">提供项目</label>
                            <div class="col-sm-4" id="div_project">
                                <c:if test="${not empty obj.projectList}">
                                    <c:forEach var="project" items="${obj.projectList}" varStatus="status">
                                        <label>
                                            <input type="checkbox" class="minimal" name="dicProjectsId"
                                                   id="projectChk${project.id}" value="${project.id}">
                                            <span class="${project.projectIco}"></span> ${project.projectName}
                                        </label>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                        <!-- 总价格 -->
                        <div class="form-group">
                            <label for="totalPrice" class="col-sm-2 control-label">总价格</label>
                            <div class="col-sm-2">
                                <input type="text" class="form-control {validate:{required:true,number:true,messages:{required:'请输入总价格'}}}"
                                       maxlength="6" value="${obj.goodsInfo.totalPrice}"
                                       id="totalPrice" name="totalPrice">
                            </div>
                            <div class="col-sm-2">
                                <span class="help-block">元</span>
                            </div>
                        </div>
                        <!-- 预付款 -->
                        <div class="form-group">
                            <label for="advancePayment" class="col-sm-2 control-label">预付款</label>
                            <div class="col-sm-2">
                                <input type="text" class="form-control {validate:{required:true,number:true,messages:{required:'请输入预付款'}}}"
                                       maxlength="6" value="${obj.goodsInfo.advancePayment}"
                                       id="advancePayment" name="advancePayment">
                            </div>
                            <div class="col-sm-2">
                                <span class="help-block">元</span>
                            </div>
                        </div>
                        <!-- 原片数量 -->
                        <div class="form-group">
                            <label for="originalNum" class="col-sm-2 control-label">原片数量</label>
                            <div class="col-sm-2">
                                <input type="text" class="form-control {validate:{required:true,number:true,messages:{required:'请输入原片数量'}}}"
                                       maxlength="6" value="${obj.goodsInfo.originalNum}"
                                       id="originalNum" name="originalNum">
                            </div>
                            <div class="col-sm-5">
                                <span class="help-block">张</span>
                            </div>
                        </div>
                        <!-- 精修数量 -->
                        <div class="form-group">
                            <label for="processingNum" class="col-sm-2 control-label">精修数量</label>
                            <div class="col-sm-2">
                                <input type="text" class="form-control {validate:{required:true,number:true,messages:{required:'请输入精修数量'}}}"
                                       maxlength="6" value="${obj.goodsInfo.processingNum}"
                                       id="processingNum" name="processingNum">
                            </div>
                            <div class="col-sm-5">
                                <span class="help-block">张</span>
                            </div>
                        </div>
                        <!-- 详细介绍 -->
                        <div class="form-group">
                            <label for="goodsDesc" class="col-sm-2 control-label">详细介绍</label>
                            <div class="col-sm-8">
                                <%--<textarea id="goodsDesc" name="goodsDesc" class="form-control"--%>
                                          <%--placeholder="Enter text ..."--%>
                                          <%--style="width: 100%; height: 500px; font-size: 14px; line-height: 18px;">--%>
                                          <%--${obj.goodsInfo.goodsDesc}--%>
                                <%--</textarea>--%>
                                    <!-- 配置文件 -->
                                    <script type="text/javascript" src="${resourceUrl}/manager/plugins/ueditor/ueditor.config.js"></script>
                                    <!-- 编辑器源码文件 -->
                                    <script type="text/javascript" src="${resourceUrl}/manager/plugins/ueditor/ueditor.all.js"></script>
                                    <!-- 语言包文件(建议手动加载语言包，避免在ie下，因为加载语言失败导致编辑器加载失败) -->
                                    <script type="text/javascript" src="${resourceUrl}/manager/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
                                    <!-- 加载编辑器的容器 -->
                                    <script id="goodsDesc" name="goodsDesc" type="text/plain">
                                        ${obj.goodsInfo.goodsDesc}
                                    </script>
                                    <!-- 实例化编辑器 -->
                                    <script type="text/javascript">
                                        var editor = UE.getEditor('goodsDesc',{initialFrameHeight:500});
                                    </script>
                            </div>
                        </div>


                        <div class="box-footer">
                            <button type="button" id="goodsApproceYSubmitBtn" class="btn btn-primary">审核通过</button>
                            <button type="button" id="goodsApproveNSubmitBtn" class="btn btn-primary">审核不通过</button>
                        </div>

                    <!-- 样片上传 -->
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">样片上传</label>
                        <div class="col-sm-10">
                            <c:if test="${not empty obj.goodsInfo.goodsPics}">
                                <c:forEach var="pic" items="${obj.goodsInfo.goodsPics}" varStatus="status">
                                    <img src="${ctx}/manager/goods/pic_avatar_small?id=${pic.id}">
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                    <!-- /.box -->
                </div>
            </div>
        </section><!-- /.content -->

    </div>
    <!-- /.content-wrapper -->
    <jsp:include flush="true" page="/WEB-INF/views/include/manager/footer.jsp"/>

</div>
<form action="${ctx}/manager/goods/approve" id="goods_view_form" method="post">
    <input type="hidden" name="id" id="goodsid" value="${obj.goodsInfo.id}"/>
    <input type="hidden" name="orderStat" id="orderStat" value="2"/>
</form>
</body>
<script type="text/javascript">
    $(document).ready(function() {
        $("#goodsApproceYSubmitBtn").click(function(){
            $("#orderStat").val(1);
            $("#goods_view_form").submit();
        });
        $("#goodsApproveNSubmitBtn").click(function(){
            $("#orderStat").val(2);
            $("#goods_view_form").submit();
        });
        <c:if test="${not empty obj.goodsInfo.dicProjects}">
        <c:forEach var="project" items="${obj.goodsInfo.dicProjects}" varStatus="status">
        $("#projectChk${project.id}").prop("checked",true);
        </c:forEach>
        </c:if>
        $('#goodsDesc').wysihtml5({locale: "zh-CN"});
    });//end ready

</script>
</html>