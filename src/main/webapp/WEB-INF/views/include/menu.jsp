<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!-- NAVBAR================================================== -->
<nav class="navbar navbar-lvpaizhe navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <span  class="visible-lg-block visible-xs-block"><a class="navbar-brand" href="${ctx}/">旅拍者</a></span>
        </div>

        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="${ctx}/">首页</a></li>
                <li><a href="${ctx}/web/photographer/photographer_all">摄影师</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">旅拍在路上<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="${ctx}/web/place/place2">境内</a></li>
                        <li><a href="${ctx}/web/place/place1">境外</a></li>
                    </ul>
                </li>
                <li><a href="wedding_pic.html">旅拍婚纱</a></li>
                <li><a href="about.html">关于旅拍者</a></li>
                <li><a href="${ctx}/web/server/register">加盟入驻</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                    <c:if test="${empty me}">
                        <li><a href="${ctx}/login">登陆</a></li>
                        <li><a href="${ctx}/web/register">注册</a></li>
                    </c:if>
                        <c:if test="${not empty me}">
                        <li><a href="${ctx}/">欢迎，${me.userName}</a></li>

                        </c:if>
            </ul>
        </div>
    </div>
</nav>
