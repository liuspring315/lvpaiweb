<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="/WEB-INF/views/include/meta.jsp" %>
</head>

<body>
<%@ include file="/WEB-INF/views/include/menu.jsp" %>
<link href="${resourceUrl}/css/lp-pay.css" rel="stylesheet">
<!-- 主体内容 -->
<div class="container">
    <div class="row">
        <div class="col-md-12 order_square">
            <div class="row">
                <div class="col-md-6">
                    订单详情：${obj.userGeneralInfo.lastName}－${obj.goodsInfo.goodsName}<span class="price">&nbsp;</span>
                </div>
                <div class="col-md-6 text-right">
                    金额：<span class="price">¥${obj.goodsInfo.totalPrice}</span>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 pay_method">
            网银直接支付：
        </div>
        <div class="col-md-2">
            <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1"> <img src="${resourceUrl}/img/pic_bank_gd.gif" alt="..." class="pay_pic_margin">
        </div>
        <div class="col-md-2">
            <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1"> <img src="${resourceUrl}/img/pic_bank_gf.gif" alt="..." class="pay_pic_margin">
        </div>
        <div class="col-md-2">
            <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1"> <img src="${resourceUrl}/img/pic_bank_gs.gif" alt="..." class="pay_pic_margin">
        </div>
        <div class="col-md-2">
            <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1"> <img src="${resourceUrl}/img/pic_bank_js.gif" alt="..." class="pay_pic_margin">
        </div>
        <div class="col-md-2">
            <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1"> <img src="${resourceUrl}/img/pic_bank_jt.gif" alt="..." class="pay_pic_margin">
        </div>
        <div class="col-md-2">
            <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1"> <img src="${resourceUrl}/img/pic_bank_ms.gif" alt="..." class="pay_pic_margin">
        </div>
        <div class="col-md-2">
            <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1"> <img src="${resourceUrl}/img/pic_bank_ny.gif" alt="..." class="pay_pic_margin">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 pay_method">
            支付宝支付：
        </div>
        <div class="col-md-2">
            <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1"> <img src="${resourceUrl}/img/pay_zhifubao.gif" alt="..." class="pay_pic_margin">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 next">
            <button type="button" class="btn btn-info">下一步</button>
        </div>
    </div>
</div>
<jsp:include flush="true" page="/WEB-INF/views/include/footer.jsp"/>
<script type="text/javascript">
    $(document).ready(function() {

    });//end ready


</script>
</body>
</html>