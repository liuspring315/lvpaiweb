<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/manager/meta.jsp" %>
    <script src="${resourceUrl}/manager/plugins/jQuery/jquery.validate.js" type="text/javascript"></script>
    <script src="${resourceUrl}/manager/plugins/jQuery/jquery.metadata.js" type="text/javascript"></script>
    <script src="${resourceUrl}/manager/plugins/dtree/dtree.js" type="text/javascript"></script>
    <link href="${resourceUrl}/manager/plugins/dtree/dtree.css" rel="stylesheet">
    <script type="text/javascript">
        var d ;
        $(document).ready(function() {
            $.ajax({
                url: ctx + "/manager/dicplace/query",
                type: "POST",
                error: function (request) {
                    alert(request.responseText);
                },
                dataType: "json",
                success : function(re) {
                    if (!re.ok) {
                        alert(re.msg);
                        return;
                    }
                    d = new dTree('d');
                    d.add(0,-1,'地点管理');

                    var data = re.data;
                    for (var i=0;i<data.length;i++) {
                        var place = data[i];
                        d.add(place.id,place.pid,place.placeName,'javascript:placeClick('+place.id+')');
                    }
                    $("#div_place_tree").html(d.toString());
                }
            });

            $("#updateBtn").click(function(){
                if($("#placeId").val()==""){
                    alert("请先选择地点");
                    return;
                }
                if(confirm("确认修改此地点？")) {
                    $.ajax({
                        url: ctx + "/manager/dicplace/update",
                        data:$("#photographer_info_form").serializeArray(),
                        type: "POST",
                        error: function (request) {
                            alert(request.responseText);
                        },
                        dataType: "json",
                        success: function (re) {
                            if (!re.ok) {
                                alert(re.msg);
                                return;
                            }
                            alert("修改成功");
                        }
                    });
                }
            });

            $("#delBtn").click(function(){
                if($("#placeId").val()==""){
                    alert("请先选择地点");
                    return;
                }
                if(confirm("确认删除此地点？")) {
                    $.ajax({
                        url: ctx + "/manager/dicplace/delete",
                        data:$("#photographer_info_form").serializeArray(),
                        type: "POST",
                        error: function (request) {
                            alert(request.responseText);
                        },
                        dataType: "json",
                        success: function (re) {
                            if (!re.ok) {
                                alert(re.msg);
                                return;
                            }
                            alert("修改成功");
                        }
                    });
                }
            });

            $("#addBtn").click(function(){
                if($("#placeId").val()==""){
                    alert("请先选择地点");
                    return;
                }
                if(confirm("此操作将在当前选中的地点下添加一个地点，确认新增此地点？")) {
                    $.ajax({
                        url: ctx + "/manager/dicplace/add",
                        data:$("#photographer_info_form").serializeArray(),
                        type: "POST",
                        error: function (request) {
                            alert(request.responseText);
                        },
                        dataType: "json",
                        success: function (re) {
                            if (!re.ok) {
                                alert(re.msg);
                                return;
                            }
                            alert("新增成功");
                            window.location.reload();
                        }
                    });
                }
            });

            $("#avatarBtn").click(function(){
                if($("#avatarPlaceId").val()==""){
                    alert("请先选择地点");
                    return;
                }
                $("#avatar_form").submit();
            });

            $("#avatararrBtn").click(function(){
                if($("#avatararrPlaceId").val()==""){
                    alert("请先选择地点");
                    return;
                }
                $("#avatararr_form").submit();
            });

        });//end ready
        function placeClick(id){
            $.ajax({
                url: ctx + "/manager/dicplace/get",
                data : {id:id},
                type: "POST",
                error: function (request) {
                    alert(request.responseText);
                },
                dataType: "json",
                success : function(re) {
                    if (!re.ok) {
                        alert(re.msg);
                        return;
                    }
                    var place = re.data;
                    $("#placeId").val(place.id);
                    $("#avatarPlaceId").val(place.id);
                    $("#avatararrPlaceId").val(place.id);
                    $("#pid").val(place.pid);
                    $("#placeName").val(place.placeName);
                    $("#placeType").val(place.placeType);
                    $("#about").val(place.about);
                    $("#ispub").val(place.ispub);
                    $("#oy").val(place.oy);
                    editor.reset();
                    editor.setContent('');
                    editor.setContent(place.details);
                    $("#img_avatar").prop("src",ctx + "/manager/dicplace/avatar_small?id="+place.id);

                    $.ajax({
                        url: ctx + "/manager/dicplace/getPlacePic",
                        data : {id:place.id},
                        type: "POST",
                        error: function (request) {
                            alert(request.responseText);
                        },
                        dataType: "json",
                        success : function(re) {
                            if (!re.ok) {
                                alert(re.msg);
                                return;
                            }
                            var list = re.data;
                            var img_html = "";
                            for(var i  = 0;i < list.length;i++){
                                var pic = list[i];
                                img_html = img_html + "<img src=\""+ctx + "/manager/dicplace/pic_avatar_small?id="+pic.id+"\">";
                            }
                            $("#div_dicplacepic").html(img_html);
                        }
                    });
                }
            });
        }
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
                地点管理
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li class="active">地点管理</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <!-- Small boxes (Stat box) -->

                        <div class="row">
                            <div class="col-xs-2" id="div_place_tree">
                            </div>
                            <div class="col-xs-10">
                                <form class="form-horizontal box box-primary" id="photographer_info_form"  role="form">
                                    <div class="box-header">
                                        第一步：添加地点
                                    </div>
                                    <div class="form-group">
                                        <label for="placeName" class="col-sm-2 control-label">地点名称</label>
                                        <div class="col-sm-4">
                                            <input type="hidden" name="id" id="placeId" value=""/>
                                            <input type="text" class="form-control {validate:{required:true,trimstr:true,stringCheck:true,messages:{required:'请输入真实姓名'}}}"
                                                   maxlength="25"
                                                   id="placeName" name="placeName" value="" >
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="pid" class="col-sm-2 control-label">上级id</label>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control" maxlength="11"
                                                   id="pid" name="pid"  >
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="placeType" class="col-sm-2 control-label">地点类型</label>
                                        <div class="col-sm-4">
                                            <select name="placeType" id="placeType">
                                                <option value=""></option>
                                                <option value="1">境外</option>
                                                <option value="2">境内</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="about" class="col-sm-2 control-label">关于这里</label>
                                        <div class="col-sm-8">
                                              <textarea class="form-control" maxlength="250"
                                                        name="about" id="about" rows="4" placeholder="字数限制：***"></textarea>
                                        </div>
                                    </div>
                                    <!-- 详细介绍 -->
                                    <div class="form-group">
                                        <label for="details" class="col-sm-2 control-label">详细介绍</label>
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
                                            <script id="details" name="details" type="text/plain">

                                            </script>
                                            <!-- 实例化编辑器 -->
                                            <script type="text/javascript">
                                                var editor = UE.getEditor('details',{initialFrameHeight:500});
                                            </script>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="ispub" class="col-sm-2 control-label">是否发布</label>
                                        <div class="col-sm-4">
                                            <select name="ispub" id="ispub">
                                                <option value=""></option>
                                                <option value="1">是</option>
                                                <option value="0">否</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="oy" class="col-sm-2 control-label">排序</label>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control" id="oy" name="oy">
                                        </div>
                                    </div>

                                    <div class="box-footer">
                                        <button type="button" id="updateBtn" class="btn btn-primary">修改</button>
                                        <button type="button" id="addBtn" class="btn btn-primary">添加</button>
                                        <button type="button" id="delBtn" class="btn btn-primary">删除</button>
                                    </div>
                                </form>
                                <form class="form-horizontal box box-primary" action="${ctx}/manager/dicplace/avatar" id="avatar_form" method="post" enctype="multipart/form-data">
                                    <div class="box-header">
                                        第二步：上传封面图片
                                    </div>
                                    <div class="form-group">
                                        <label for="oy" class="col-sm-2 control-label">封面图片</label>
                                        <div class="col-sm-4">
                                            <img alt="封面图片" id="img_avatar" src="">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="oy" class="col-sm-2 control-label">上传封面图片</label>
                                        <div class="col-sm-4">
                                            <input type="hidden" name="id" id="avatarPlaceId"  value=""/>
                                            <input type="file" name="file">
                                        </div>
                                    </div>
                                    <div class="box-footer">
                                        <button type="button"  id="avatarBtn" class="btn btn-primary">保存</button>
                                    </div>
                                </form>
                                <form class="form-horizontal box box-primary" action="${ctx}/manager/dicplace/avatararr" id="avatararr_form" method="post"
                                      enctype="multipart/form-data">
                                    <div class="box-header">
                                        第三步：上传地点页面四个小图
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-4" id="div_dicplacepic">
                                        </div>
                                        <label for="oy" class="col-sm-2 control-label">地点照片文件</label>
                                        <div class="col-sm-4">
                                            <input type="hidden" name="id" id="avatararrPlaceId"  value=""/>
                                            <input type="file" name="file">
                                            <input type="file" name="file">
                                            <input type="file" name="file">
                                            <input type="file" name="file">
                                        </div>
                                    </div>

                                    <div class="box-footer">
                                        <button type="button"  id="avatararrBtn" class="btn btn-primary">保存</button>
                                    </div>

                                </form>
                            </div>
                        </div>

        </section>
    </div>
    </section><!-- /.content -->
</div><!-- /.content-wrapper -->
<jsp:include flush="true" page="/WEB-INF/views/include/manager/footer.jsp"/>

</div><!-- ./wrapper -->
</body>
</html>