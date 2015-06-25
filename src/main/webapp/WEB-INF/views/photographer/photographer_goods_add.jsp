<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
        <%@ include file="/WEB-INF/views/include/manager/meta.jsp" %>
    <%--<link rel="stylesheet" type="text/css" href="lib/css/bootstrap.min.css" /> <!-- Please use the newest Version of Bootstrap 3.0.X -->--%>
    <link rel="stylesheet" type="text/css" href="${resourceUrl}/manager/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css" />
    <script src="${resourceUrl}/manager/plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js" type="text/javascript"></script>
    <%--<script src="lib/js/jquery-1.7.2.min.js" type="text/javascript"></script>--%>
    <%--<script src="lib/js/bootstrap.min.js" type="text/javascript"></script>--%>
    <script src="${resourceUrl}/manager/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.js" type="text/javascript"></script>

        <%--<link rel="stylesheet" type="text/css" href="${resourceUrl}/manager/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css" />--%>
        <%--<script src="${resourceUrl}/manager/plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js" type="text/javascript"></script>--%>
        <%--<script src="${resourceUrl}/manager/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.js" type="text/javascript"></script>--%>
        <script src="${resourceUrl}/manager/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.zh-CN.js" type="text/javascript"></script>
    <script src="${resourceUrl}/manager/plugins/jQuery/jquery.validate.js" type="text/javascript"></script>
    <script src="${resourceUrl}/manager/plugins/jQuery/jquery.metadata.js" type="text/javascript"></script>

    <script type="text/javascript">
        <c:if test="${obj.can==0}">
        alert("未申请认证不允许提交拍摄服务");
        window.location.href = "${ctx}/photographer/authenticate/view";
        </c:if>
    </script>
</head>
<body class="skin-blue">
<div class="wrapper">

    <%@ include file="/WEB-INF/views/include/manager/menu.jsp" %>
    <!-- Right side column. Contains the navbar and content of the page -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                摄影师拍摄服务列表</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li class="active">摄影师拍摄服务列表</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <!-- Small boxes (Stat box) -->
            <div class="row">
                <div class="col-xs-12 box box-primary">
                    <div class="box-header">
                        第一步：填写服务基本信息
                    </div>
                    <!-- form start -->
                    <form class="form-horizontal" method="post" id="goods_form">
                        <c:if test="${not empty obj}">
                            <input type="hidden" name="id" value="${obj.goodsInfo.id}"/>
                        </c:if>
                        <c:if test="${empty obj}">
                            <input type="hidden" name="id" value="0"/>
                        </c:if>
                        <!-- 标题 -->
                        <div class="form-group">
                            <label for="goodsName" class="col-sm-2 control-label">标题</label>
                            <div class="col-sm-4">
                                <input type="text" maxlength="30" value="${obj.goodsInfo.goodsName}"
                                       class="form-control {validate:{required:true,trimstr:true,stringCheck:true,messages:{required:'请输入标题'}}}"
                                       id="goodsName" name="goodsName">
                            </div>
                            <div class="col-sm-6">
                                <span class="help-block">限制30汉字或60字符</span>
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
                            <div class="col-sm-6">
                                    <span class="help-block">
                                    <button type="button" id="placeSelectBtn" class="btn btn-primary">选择</button>
                                    </span>
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
                            <div class="col-sm-6">
                                <span class="help-block">
                                    <button type="button" class="btn btn-primary">全选</button>
                                </span>
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
                            <div class="col-sm-8 adv-textarea">
                                <textarea id="goodsDesc" htmlEdit="1" name="goodsDesc" class="form-control" rows="4">${obj.goodsInfo.goodsDesc}</textarea>
                            </div>
                        </div>
                        <div class="box-footer">
                            <button type="button" id="goodsSubmitBtn" class="btn btn-primary">保存</button>
                        </div>
                    </form>
                </div>
                <div class="col-xs-12 box box-primary">
                    <div class="box-header">
                        第二步：上传样片
                    </div>
                    <form class="form-horizontal" action="${ctx}/photographer/goods/avatararr" id="avatararr_form" method="post"
                          enctype="multipart/form-data">
                        <div class="form-group">
                            <div class="col-md-6 ">
                                <input type="hidden" name="id" value="${obj.goodsInfo.id}"/>
                                <input type="file" name="file">
                                <input type="file" name="file">
                                <input type="file" name="file">
                                <input type="file" name="file">
                            </div>
                        </div>
                        <div class="box-footer">
                            <button type="submit"  id="avatararrBtn" class="btn btn-primary">保存</button>
                        </div>
                    </form>
                    <!-- 样片上传 -->
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">样片上传</label>
                        <div class="col-sm-10">
                            <c:if test="${not empty obj.goodsInfo.goodsPics}">
                                <c:forEach var="pic" items="${obj.goodsInfo.goodsPics}" varStatus="status">
                                    <img src="${ctx}/photographer/goods/pic_avatar_small?id=${pic.id}">
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
<!-- ./wrapper -->
<div class="modal fade" id="placeSelectModal" tabindex="-1" role="dialog" aria-labelledby="photographerModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">选择地点</h4>
            </div>
            <div class="modal-body" id="confirmModalMess">
                <iframe src="${ctx}/manager/dicplace/listpop" frameborder="0"></iframe>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>

            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    $(document).ready(function() {
        $.metadata.setType("class");
        $("#goods_form").validate({
            ignore:".ignore",
            meta: "validate",
            focusInvalid: false,
            invalidHandler: function(form, validator) {
                validateShowMess(validator);
            },
            submitHandler: function(form) {
                // 提交数据
                $.ajax({
                    url: ctx + "/photographer/goods/update",
                    type: "POST",
                    data: $('#goods_form').serialize(),
                    error: function (request) {
                        alert(request.responseText);
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data && data==1) {
                            alert("提交订单成功");
                            window.location.href = ctx + "/photographer/goods/list";
                        } else if (data==-1) {
                            alert("该服务已审核通过不能修改");
                        }else {
                            var emsg = data.msg;
                            alert(emsg);
                        }
                    }
                });
            }
        });
        $("#placeSelectBtn").click(function(){
            $("#placeSelectModal").modal('show');
        });
        $("#placeSelectBtn").click(function(){
            $("#placeSelectModal").modal('show');
        });
        $("#goodsSubmitBtn").click(function(){
            $("#goods_form").submit();
        });
        <c:if test="${not empty obj.goodsInfo.dicProjects}">
        <c:forEach var="project" items="${obj.goodsInfo.dicProjects}" varStatus="status">
        $("#projectChk${project.id}").prop("checked",true);
        </c:forEach>
        </c:if>
        $('#goodsDesc').wysihtml5({"stylesheets": ["${resourceUrl}/manager/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5-color.css"],locale: "zh-CN"});
    });//end ready
    function placeCallback(id,placeName){
        $("#placeName").val(placeName);
        $("#place").val(id);
        $("#placeSelectModal").modal('hide');
    }
</script>
</html>