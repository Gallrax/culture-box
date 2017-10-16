<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/10
  Time: 14:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>
    <table border="1" width="98%" style="text-align: center">
        <thead>
        <tr>
            <th>系列名称</th>
            <th>系列资源格式</th>
            <th>系列作者</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="series_list">

        </tbody>
    </table>
</div>
<div>
    跳转至 :
    <select id="tempPage" onchange="writeData(this.value)">

    </select>
    页
</div>
</body>
</html>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/mine.js"></script>
<script>

    var categoryId;

    $(function () {
        init();
    });

    //初始化
    function init() {
        categoryId = getUrlParamer("categoryId");
        writeData(1);
        writePage();
    }

    //写系列
    function writeData(page) {
        $("#series_list").empty();
        var data = getData(page);
        var tempStr = "";
        for (var i in data) {
            tempStr += "<tr><td>" + data[i].name + "</td><td>" + data[i].type + "</td><td>" + data[i].author + "</td><td><input type=\"button\" value=\"推荐\" onclick=\"recommend(" + data[i].id + ")\"/></td></tr>";
        }
        $("#series_list").append(tempStr);
    }

    //获取系列
    function getData(page) {
        var tempObj = new Object();
        tempObj.categoryPId = categoryId;//index已定义
        var result = jsGet("/series/getByFields", "eq=" + ifyAndEnc(tempObj) + "&page=" + page);
        console.log(result);
        var obj = $.parseJSON($.parseJSON(result));
        return obj;
    }

    //写总数
    function writePage() {
        totalCount = getCount();
        var page = totalCount % 12 == 0 ? totalCount / 12 : totalCount / 12 + 1;
        var tempStr;
        for (var i = 1; i <= page; i++) {
            tempStr += "<option value=\"" + i + "\">" + i + "</option>";
        }
        $("#tempPage").append(tempStr);
    }

    //获取总数
    function getCount() {
        var tempObj = new Object();
        tempObj.categoryPId = categoryId;//index已定义
        var result = jsGet("/series/getCountByField", "eq=" + ifyAndEnc(tempObj));
        console.log(result);
        var obj = $.parseJSON($.parseJSON(result));
        return obj;
    }

    //推荐系列
    function recommend(id) {
        $.ajax({
            url: "/series/recommend/" + id,
            type: "get",
            success: function (data) {
                if ($.parseJSON(data) == "success") {
                    alert(" 推荐成功 ");
                }
            }
        })
    }
</script>
