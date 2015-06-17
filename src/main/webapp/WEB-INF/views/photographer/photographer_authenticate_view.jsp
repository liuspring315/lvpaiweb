<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/manager/meta.jsp" %>
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
                申请认证
                <small>更高等级的认证会让更多的客户信任，但也意味着更大的责任：）</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li class="active">申请认证</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <!-- Small boxes (Stat box) -->
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">选择认证</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body table-responsive no-padding">
                            <table class="table table-bordered">
                                <tbody>
                                <tr>
                                    <td>
                                        <button class="btn btn-block btn-info btn-lg text-center " id="authentication1Button">初级认证</button>
                                    </td>
                                    <td>
                                        <c:if test="${me.photographerExtra.authentication==0}">
                                            <c:if test="${me.authenticationStat==0}">上传清晰证件照片并填写证件号码，待审核通过后，您将取得初级认证</c:if>
                                            <c:if test="${me.authenticationStat==1}">已申请初级认证，待审核</c:if>
                                            <c:if test="${me.authenticationStat==2}">已申请初级认证，审核通过</c:if>
                                            <c:if test="${me.authenticationStat==3}">已申请初级认证，审核不通过</c:if>
                                        </c:if>
                                        <c:if test="${me.photographerExtra.authentication==1}">
                                            审核通过
                                        </c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <button class="btn btn-block btn-primary btn-lg text-center">中级认证</button>
                                    </td>
                                    <td>暂未开放</td>
                                </tr>
                                <tr>
                                    <td>
                                        <button class="btn btn-block btn-success btn-lg text-center">高级认证</button>
                                    </td>
                                    <td>暂未开放</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
            </div>
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    <jsp:include flush="true" page="/WEB-INF/views/include/manager/footer.jsp"/>

</div>
<!-- ./wrapper -->

<!-- /初级认证申请框 -->
<div class="modal fade" id="authenticate1Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="mySmallModalLabel">申请初级认证</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="${ctx}/photographer/authenticate/avatar" enctype="multipart/form-data"
                      method="post" id="photographerAuthenticationForm">
                    <div class="form-group">
                        <label for="certificateType" class="col-sm-3 control-label">证件类型</label>

                        <div class="radio col-sm-5">
                            <label>
                                <input type="radio" name="certificateType" id="certificateType1" value="1" checked>
                                中国大陆居民身份证
                            </label>
                        </div>
                        <div class="radio col-sm-3">
                            <label>
                                <input type="radio" name="certificateType" id="certificateType2" value="2">
                                护照
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="certificateNum" class="col-sm-3 control-label">证件号码</label>

                        <div class="col-sm-8">
                            <input type="text"
                                   class="form-control {validate:{required:true,trimstr:true,messages:{required:'请输入证件号码'}}}"
                                   name="certificateNum" id="certificateNum">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="idcard_front" class="col-sm-3 control-label">证件照正面</label>

                        <div class="col-sm-8">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <div class="fileinput-preview thumbnail" data-trigger="fileinput"
                                     style="width: 248px; height: 250px;">
                                    <img id="imgIdcardFront" src="${resourceUrl}/manager/img/user2-160x160.jpg"/>
                                </div>
                                <div>
                      <span class="btn btn-default btn-file"><span class="fileinput-new">选择图片</span><span
                              class="fileinput-exists">更改</span>
                        <input type="file" name="file"  class="{validate:{required:true,trimstr:true,messages:{required:'请选择图片'}}}"></span>
                                    <a href="#" class="btn btn-default fileinput-exists" data-dismiss="fileinput">移除</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="idcard_back" class="col-sm-3 control-label">证件照背面</label>

                        <div class="col-sm-8">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <div class="fileinput-preview thumbnail" data-trigger="fileinput"
                                     style="width: 248px; height: 250px;">
                                    <img id="imgIdcardBack" src="${resourceUrl}/manager/img/user2-160x160.jpg"/>
                                </div>
                                <div>
                            <span class="btn btn-default btn-file"><span class="fileinput-new">选择图片</span><span
                                    class="fileinput-exists">更改</span>
                              <input type="file" name="file"></span>
                                    <a href="#" class="btn btn-default fileinput-exists" data-dismiss="fileinput">移除</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <c:if test="${me.photographerExtra.authentication==0}">
                            <button type="button" class="btn btn-primary" id="photographerAuthenticationButton">保存</button>
                        </c:if>

                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

</body>
<script src="${resourceUrl}/manager/plugins/jasny-bootstrap/js/jasny-bootstrap.min.js" type="text/javascript"></script>
<link href="${resourceUrl}/manager/plugins/jasny-bootstrap/css/jasny-bootstrap.min.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript">
    $(document).ready(function() {
        <c:if test="${me.authenticationStat!=2 && obj == 1}">
        $("#authentication1Button").click(function(){
            $('#authenticate1Modal').modal('show');
            $("#certificateNum").val("${me.photographerExtra.certificateNum}");
            $("#certificateType${me.photographerExtra.certificateType}").prop("checked","true");
            $("#imgIdcardFront").prop("src","${ctx}/photographer/info/avatar_idcardFront");
            $("#imgIdcardBack").prop("src","${ctx}/photographer/info/avatar_idcardBack");

            $.metadata.setType("class");
            $("#photographerAuthenticationForm").validate({
                ignore:".ignore",
                meta: "validate",
                focusInvalid: false,
                invalidHandler: function(form, validator) {
                    validateShowMess(validator);
                },
                submitHandler: function(form) {
                    form.submit();
                }
            });
            $("#photographerAuthenticationButton").click(function(){
                $("#photographerAuthenticationForm").submit();
            });
        });
        </c:if>
        <c:if test="${obj == 0}">
        alert("未完善个人信息不允许申请认证");
        </c:if>
    });//end ready
</script>
</html>