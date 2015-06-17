<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/manager/meta.jsp" %>
</head>
<body class="skin-blue">
<div class="wrapper">

    <%@ include file="/WEB-INF/views/include/manager/menu.jsp" %>
    <!-- Right side column. Contains the navbar and content of the page -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                仪表盘
                <small>综合信息控制台</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li class="active">Dashboard</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <!-- Small boxes (Stat box) -->
            <div class="row">
                <div class="col-xs-2">
                    <div class="form-group">
                        <label>认证等级</label>
                        <span class="label label-danger">未认证</span>
                    </div>
                </div>
                <div class="col-xs-2">
                    <div class="form-group">
                        <label>用户名</label>
                        <span>王君毅</span>
                    </div>
                </div>
                <div class="col-xs-2">
                    <div class="form-group">
                        <label>邮箱</label>
                        <span>lvpaizhe@126.com</span>
                    </div>
                </div>
                <div class="col-xs-2">
                    <div class="form-group">
                        <label>手机号码</label>
                        <span>15801234051</span>
                    </div>
                </div>
                <div class="col-xs-2">
                    <div class="form-group">
                        <label>所在地</label>
                        <span>北京</span>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        首页
                    </div><!-- /.box -->
                </div>
            </div>
        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->
    <jsp:include flush="true" page="/WEB-INF/views/include/manager/footer.jsp"/>

</div><!-- ./wrapper -->
</body>
</html>