<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/manager/meta.jsp" %>
    <script src="${resourceUrl}/manager/plugins/jQuery/jquery.validate.js" type="text/javascript"></script>
    <script src="${resourceUrl}/manager/plugins/jQuery/jquery.metadata.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $.metadata.setType("class");
            $("#photographer_info_form").validate({
                ignore:".ignore",
                meta: "validate",
                focusInvalid: false,
                invalidHandler: function(form, validator) {
                    validateShowMess(validator);
                },
                submitHandler: function(form) {
                    // 提交数据
                    $.ajax({
                        url: ctx + "/photographer/info/update",
                        type: "POST",
                        data: $('#photographer_info_form').serialize(),
                        error: function (request) {
                            alert(request.responseText);
                        },
                        dataType: "json",
                        success: function (data) {
                            if (data && data.ok) {
                                alert("修改个人信息成功");
                                window.location.reload();
                            } else {
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
        });//end ready

        function placeCallback(id,placeName){
            $("#inputLocation").val(placeName);
            $("#location").val(id);
            $("#placeSelectModal").modal('hide');
        }
        <%
 	if (session.getAttribute("upload-error-msg") != null) {
 		String msg = session.getAttribute("upload-error-msg")
 				.toString();
 		out.print("alert('"+msg+"');");
 		session.removeAttribute("upload-error-msg");
 	}
 %>
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
                我的个人信息
                <small>请保持个人信息及时更新</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li class="active">我的个人信息</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <!-- Small boxes (Stat box) -->
            <div class="row">
                <div class="col-xs-12">
                    <div class="box box-primary lvpaizhe-a-info-padding">
                        <div class="row">
                            <div class="col-xs-6">
                                <!-- form start -->
                                <form class="form-horizontal" id="photographer_info_form"  role="form">
                                    <input type="hidden" name="id" id="id" value="${me.id}">
                                    <div class="form-group">
                                        <label for="inputRealname" class="col-sm-2 control-label">真实姓名</label>
                                        <div class="col-sm-4">
                                            <input type="text"
                                                   class="form-control {validate:{required:true,trimstr:true,stringCheck:true,messages:{required:'请输入真实姓名'}}}"
                                                   maxlength="25"
                                                   id="lastName" name="lastName" value="${me.lastName}" >
                                        </div>
                                        <div class="col-sm-6">
                                            <span  class="help-block">请填写真实姓名，与有效证件保持一致</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputSex" class="col-sm-2 control-label">性别</label>
                                        <div class="col-sm-1 radio">
                                            <label>
                                                <input type="radio" name="gender" id="gender0" value="0" <c:if test="${me.gender == 0}">checked="true"</c:if>>
                                                男
                                            </label>
                                        </div>
                                        <div class="col-sm-1 radio">
                                            <label>
                                                <input type="radio" name="gender" id="gender1" value="1" <c:if test="${me.gender == 1}">checked="true"</c:if>>
                                                女
                                            </label>
                                        </div>
                                        <div class="col-sm-4 col-md-offset-2">
                                            <span  class="help-block">请选择性别</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail" class="col-sm-2 control-label">电子邮箱</label>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control {validate:{required:true,trimstr:true,email:true,messages:{required:'请输入邮箱'}}}"
                                                   maxlength="25" id="email" name="email" value="${me.email}">
                                        </div>
                                        <div class="col-sm-6">
                                            <span  class="help-block">请填写您的常用邮箱</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputMobile" class="col-sm-2 control-label">手机</label>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control" maxlength="11" id="mobile"
                                                   name="mobile" value="${me.mobile}" placeholder="000 0000 0000">
                                        </div>
                                        <div class="col-sm-6">
                                            <span  class="help-block">为保证您及时接收到重要信息，请正确填写手机号码</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputDate" class="col-sm-2 control-label">出生日期</label>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control" maxlength="10" id="birthday"
                                                   name="birthday" value="<fmt:formatDate value="${me.birthday}" pattern="yyyy-MM-dd"/>"
                                                   >
                                        </div>
                                        <div class="col-sm-6">
                                            <span  class="help-block">非必填</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputLocation" class="col-sm-2 control-label">所在地</label>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control" readonly id="inputLocation" value="${me.dicPlace.placeName}">
                                            <input type="hidden" name="location" id="location">
                                            <button type="button" id="placeSelectBtn" class="btn btn-primary">选择</button>
                                        </div>
                                        <div class="col-sm-6">
                                            <span  class="help-block">所在地信息与摄影地关联  <span class="label label-danger">重要</span></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputMobile" class="col-sm-2 control-label">个人简介</label>
                                        <div class="col-sm-8">
                                            <textarea class="form-control" maxlength="250"
                                                      name="introduction" id="introduction" rows="4" placeholder="字数限制：***">${me.photographerExtra.introduction}</textarea>
                                        </div>
                                        <div class="col-sm-6 col-md-offset-2">
                                            <span  class="help-block">请填写自我简述，将被客户查看</span>
                                        </div>
                                    </div>
                                    <div class="box-footer">
                                        <button type="submit" class="btn btn-primary">保存</button>
                                    </div>
                                    </form>
                            </div>
                            <div class="col-xs-4">
                                <form class="form-inline" role="form" id="img_user_form" action="${ctx}/photographer/info/avatarHeadThumb" method="post"
                                      enctype="multipart/form-data">
                                    <div>
                                        <img id="img_user" src="${ctx}/manager/avatar">
                                    </div>
                                    <div class="box-body">
                                        <div class="form-group">
                                            <input type="file" name="file">
                                            <button type="submit" id="avatararrBtn" class="btn btn-primary">更新头像</button>
                                        </div>
                                    </div><!-- /.box-body -->


                                </form>
                                <form class="form-inline" role="form"  action="${ctx}/photographer/info/update_avatar" method="post"
                                      enctype="multipart/form-data">
                                    <div>
                                        <img   src="${ctx}/photographer/info/avatar">
                                    </div>
                                    <div class="box-body">
                                        <div class="form-group">
                                            <input type="file" name="file">
                                            <button type="submit"  class="btn btn-primary">更新摄影师招牌图片</button>
                                        </div>
                                    </div><!-- /.box-body -->


                                </form>
                            </div>
                        </div>
                    </div>
                </div><!-- /.box -->
            </div>
            </section>
    </div>
    </section><!-- /.content -->
</div><!-- /.content-wrapper -->
<jsp:include flush="true" page="/WEB-INF/views/include/manager/footer.jsp"/>

</div><!-- ./wrapper -->
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
</html>