<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/manager/meta.jsp" %>
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
                        d.add(place.id,place.pid,place.placeName,"javascript:placeClick("+place.id+",'"+place.placeName+"')");
                    }
                    $("#div_place_tree").html(d.toString());
                }
            });


        });//end ready
        function placeClick(id,placeName){
            parent.placeCallback(id,placeName);
        }
    </script>
</head>
<body class="skin-blue">

    <div  id="div_place_tree">
    </div>
</body>
</html>