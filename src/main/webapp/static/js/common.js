/**
 * POST提交Form
 * @param formAction form的action
 * @param paramNames 参数名数组
 * @param paramValues 参数值数组
 */
function sumbitPostForm(formAction,paramNames,paramValues){
    var html = "<form action=\""+ctx+formAction+"\" method=\"post\" id=\"tempSubmitPostForm\">";
    for(var i = 0,j = paramNames.length;i < j;i++){
        html = html + "<input type=\"hidden\" name=\""+paramNames[i]+"\" value=\""+paramValues[i]+"\"/>";
    }
    html = html + "</form>";
    $("body").after(html);
    $("#tempSubmitPostForm").submit();
}
/**
 * //设置ajax请求全局默认设置
 */
$(document).ready(function() {
    $.ajaxSetup({
        async : true,
        error : function(jqXHR, textStatus, errorThrown){
            var msg = $.parseJSON(jqXHR.responseText).fail_key;
            alert(msg);
        },
        traditional : true,
        type : "POST"
    });
});

/**
 * jsonsend
 * @param {Object} url
 * @param {Object} param
 * @param {Object} callback
 */
function jsonSend( url , param , callback ){
    $.ajax({
        url:url,
        data:param,
        dataType:'json',
        success:callback
    });
}
/* forward a url */
function forward( url ){
	window.location.href = url;
}