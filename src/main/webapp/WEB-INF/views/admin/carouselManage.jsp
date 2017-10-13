<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/12
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table border="1" width="98%" style="text-align: center">
    <thead>
    <tr>
        <th>序号</th>
        <th>轮播图</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody id="series_list">

    </tbody>
</table>
</body>
</html>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/mine.js"></script>
<script>

    $(function () {
        getCarousel();
    });

    //获取分裂
    function getCarousel() {
        var url = "/carousel/getByPage";
        var result = jsGet(url, null);
        var obj = $.parseJSON(result);
        var tempStr = "";
        for (var i in obj) {
//            tempStr += "<div class=\"swiper-slide\"><img src=\"" + obj[i].image + "\" height=100% width=100%/></div>";
            tempStr += "<tr><td>"+ (parseInt(i) + 1) +"</td><td><img src=\""+ obj[i].image +"\" width=\"300px\"></td><td>暂无</td></tr>"
        }
        $("#series_list").append(tempStr);
    }
</script>

