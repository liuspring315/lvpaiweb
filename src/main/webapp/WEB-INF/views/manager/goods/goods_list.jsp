<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/manager/meta.jsp" %>

    <script src="${resourceUrl}/js/pager.js"></script>
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
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">拍摄服务列表</h3>
                            <div class="box-tools">
                                <div class="input-group">
                                    <form action="#" id="goods_query_form">
                                        <input type="text" name="table_search" class="form-control input-sm pull-right" style="width: 150px;" placeholder="搜索">
                                        <div class="input-group-btn">
                                            <button class="btn btn-sm btn-default"><i class="fa fa-search"></i></button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div><!-- /.box-header -->
                        <div class="box-body table-responsive no-padding">

                            <table class="table table-hover">

                                <tr>
                                    <th>#</th>
                                    <th>摄影师</th>
                                    <th>服务名称</th>
                                    <th>提供项目</th>
                                    <th>拍摄类型</th>
                                    <th>拍摄地</th>
                                    <th>片数</th>
                                    <th>价格</th>
                                    <th>预付款</th>
                                    <th>状态</th>
                                    <th>操作</th>
                                </tr>
                                <tbody id="goods_list">
                                </tbody>
                            </table>
                        </div><!-- /.box-body -->
                        <div id="div_pager"></div>
                    </div><!-- /.box -->
                </div>
            </div>
        </section><!-- /.content -->

    </div>
    <!-- /.content-wrapper -->
    <jsp:include flush="true" page="/WEB-INF/views/include/manager/footer.jsp"/>

</div>
<!-- ./wrapper -->
<form action="${ctx}/manager/goods/view" id="goods_view_form" method="post">
    <input type="hidden" name="id" id="goodsid" value=""/>
</form>
</body>
<script type="text/javascript">
    $(document).ready(function() {
        loadGoods(1,20);
    });//end ready
    function loadGoods(pageNumber,pageSize){
        var postdata = $("#goods_query_form").serializeArray ();
        if(pageNumber){
            postdata.push({name: 'pageNumber', value: pageNumber});
            postdata.push({name: 'pageSize', value: pageSize});
        }
        $.ajax({
            url : ctx + "/manager/goods/query",
            data : postdata,
            dataType : "json",
            type : "POST",
            success : function(re) {
                if (!re.ok) {
                    alert(re.msg);
                    return;
                }
                data = re.data;
                //console.log(data);
                var list_html = "";
                //console.log(data.list);
                for (var i=0;i<data.list.length;i++) {
                    var goods = data.list[i];
                    var tmp = "\n<tr>"
                            + "<td>"+goods.id+"</td>"
                            + "<td>"+goods.id+"</td>"
                            + "<td><a onclick='javascript:updateGoods("+goods.id+")' href='#'>"+goods.goodsName+"</a></td>"
                            + "<td>";
                    for (var j=0;j<goods.dicProjects.length;j++) {
                        var project = goods.dicProjects[i];
                        if(project)
                        tmp =  tmp + "<span class=\""+project.projectIco+"\"></span>";
                    }

                    tmp =  tmp + "</td>";
                    tmp =  tmp + "<td>";
                    switch(goods.photoType){
                        case 1:tmp = tmp + "婚纱摄影";break;
                        case 2:tmp = tmp + "旅行跟拍";break;
                        case 3:tmp = tmp + "上门拍";break;
                        default :tmp = tmp +  "";
                    }
                    tmp =  tmp + "</td><td>"+goods.dicPlace.placeName+"</td>"
                            + "<td>"+goods.originalNum+"</td>"
                            + "<td>￥"+goods.totalPrice+"</td>"
                            + "<td>￥"+goods.advancePayment+"</td><td>";
                    switch(goods.orderStat){
                        case 0:tmp = tmp + "已提交待审核";break;
                        case 1:tmp = tmp + "已审核通过";break;
                        case 2:tmp = tmp + "审核不通过";break;
                        default :tmp = tmp +  "";
                    }
                    tmp =  tmp +  "</td><td>";
                    if(goods.orderStat != 2){
                        tmp =  tmp +  "<button class=\"btn btn-primary btn-xs\" type='button' onclick='javascript:updateGoods("
                                +goods.id+")'><span class=\"fa fa-edit\"></span><strong>&nbsp;&nbsp;查看<strong></button>&nbsp;&nbsp;"
                                + "<button class=\"btn btn-primary btn-xs\" type='button' onclick='javascript:updateGoods("
                                +goods.id+")'><span class=\"fa fa-trash-o\"></span><strong>&nbsp;&nbsp;删除<strong></button>";
                    }

                    tmp =  tmp +  "</td>"
                            + "</tr>";
                    list_html += tmp;
                }
                $("#goods_list").html(list_html);
                $("#div_pager").html(PagerTag.showPagerTag("loadGoods","",data.pager));
                //console.log(window._user_roles);
            }
        });
    }
    function updateGoods(id){
        $("#goodsid").val(id);
        $("#goods_view_form").submit();
    }
</script>
</html>