<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="/WEB-INF/views/include/meta.jsp" %>
    <script type="text/javascript">
        $(function () {
            // 登陆
            $("#login_button").click(function () {
                // 提交数据
                $.ajax({
                    url: ctx + "/login",
                    type: "POST",
                    data: $('#loginForm').serialize(),
                    error: function (request) {
                        alert(request.responseText);
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data && data.ok) {
                            alert("登陆成功");
                            window.location = ctx + "/index";
                        } else {
                            var emsg = data.msg;
                            alert(emsg);
                        }
                    }
                });
            });

            // 登出
//            $("#logout_button").click(function () {
//                window.location.href = base + "/user/logout"
//            });



        });

    </script>
</head>

<body>
<%@ include file="/WEB-INF/views/include/menu.jsp" %>
<!-- 路径导航 -->
<div class="container">
    <ol class="breadcrumb">
        <li><a href="index.html">首页</a></li>
        <li class="active">会员登录</li>
    </ol>
</div>
<div class="container marketing">
    <div class="row">
        <div class="col-lg-12 text-center">
            <h2>欢迎您回到旅拍者</h2>
        </div>
    </div>
    <hr>
    <div class="row">
        <div class="col-lg-6 col-md-offset-3 text-center">
            <form action="#" method="post" id="loginForm">
                <jsp:include page="/WEB-INF/views/include/message.jsp"/>
                <div class="form-group has-feedback">
                    <input type="text" value="a1" name="username" id="username" class="form-control" placeholder="用户名">
                    <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <input type="password" value="123456" name="password" id="password" class="form-control" placeholder="密码">
                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                </div>
                <div class="row">
                    <div class="col-xs-8">
                        <div class="checkbox icheck">
                            <label class="">
                                <input type="checkbox" id="rememberMe"> 记住我
                            </label>
                        </div>
                    </div><!-- /.col -->
                    <div class="col-xs-4">
                        <button type="button" id="login_button" class="btn btn-primary btn-block btn-flat">登录</button>
                    </div><!-- /.col -->
                </div>
            </form>
            <div class="modal-footer">
                <div class="col-xs-6 text-left">
                    <a href="#">忘记密码？</a>
                </div>
                <div class="col-xs-6 text-right">
                    <a href="${ctx}/user/register" class="text-center">注册新用户</a>
                </div>
            </div>
        </div>
    </div>
    <div class="row lvpaizhe-margin-bottom">
        <div class="col-sm-12 text-center">
            您想作为<b>摄影师</b>或服务提供者加入我们？请移步<a href="${ctx}/server/register">加盟入驻</a>
        </div>
    </div>
    <!-- Three columns of text below the carousel -->
</div>
<jsp:include flush="true" page="/WEB-INF/views/include/footer.jsp"/>

</body>
</html>