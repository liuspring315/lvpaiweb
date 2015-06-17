<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/manager/meta.jsp" %>
    <script src="${resourceUrl}/manager/plugins/jQuery/jquery.validate.js" type="text/javascript"></script>
    <script src="${resourceUrl}/manager/plugins/jQuery/jquery.metadata.js" type="text/javascript"></script>
    <script type="text/javascript">
        var d ;
        $(document).ready(function() {
            $.ajax({
                url: ctx + "/manager/dicproject/query",
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
                    var data = re.data;
                    var tmp = "";
                    for(var i = 0; i < data.length;i++){
                        var project = data[i];
                        tmp = tmp + "<tr>";
                        tmp = tmp + "<td>"+project.id+"</td>";
                        tmp = tmp + "<td>"+project.projectName+"</td>";
                        tmp = tmp + "<td>"+project.projectIco+"</td>";
                        tmp = tmp + "<td><button type=\"button\" class=\"btn btn-primary\" onclick=\"javascript:updateProject("+project.id+",'"+project.projectName+"','"+project.projectIco+"')\">修改</button></td>";
                        tmp = tmp + "</tr>";

                    }

                    $("#dicproject_list").html(tmp);
                }
            });

            $("#updateBtn").click(function(){
                $.ajax({
                    url: ctx + "/manager/dicproject/update",
                    data:$("#dicproject_info_form").serializeArray(),
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
                        window.location.reload();
                    }
                });

            });


            $("#addBtn").click(function(){
                $.ajax({
                    url: ctx + "/manager/dicproject/add",
                    data:$("#dicproject_info_form").serializeArray(),
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
                        $("#projectName").val("");
                        $("#projectIco").val("");
                        window.location.reload();
                    }
                });

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
                提供项目管理
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li class="active">提供项目管理</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
            <div class="col-xs-12">
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover">
                        <tr>
                            <th>#</th>
                            <th>项目名称</th>
                            <th>ICO</th>
                            <th width="200px">操作</th>
                        </tr>
                        <tbody id="dicproject_list"></tbody>
                    </table>
                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div>

            <!-- Small boxes (Stat box) -->
            <div class="row">
                <div class="col-xs-12">
                    <div class="box box-primary lvpaizhe-a-info-padding">
                        <div class="row">
                            <div class="col-xs-6">
                                <form class="form-horizontal" id="dicproject_info_form"  role="form">
                                    <div class="form-group">
                                        <label for="projectName" class="col-sm-2 control-label">项目名称</label>
                                        <div class="col-sm-4">
                                            <input type="hidden" name="id" id="projectId" value=""/>
                                            <input type="text" class="form-control {validate:{required:true,trimstr:true,stringCheck:true,messages:{required:'请输入项目名称'}}}"
                                                   maxlength="25"
                                                   id="projectName" name="projectName" value="" >
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="projectIco" class="col-sm-2 control-label">Ico</label>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control {validate:{required:true,trimstr:true,stringCheck:true,messages:{required:'请输入项目Ico'}}}" maxlength="50"
                                                   id="projectIco" name="projectIco"  >
                                        </div>
                                    </div>

                                    <div class="box-footer">
                                        <button type="button" id="updateBtn" class="btn btn-primary">修改</button>
                                        <button type="button" id="addBtn" class="btn btn-primary">添加</button>
                                    </div>
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
</body>
</html>