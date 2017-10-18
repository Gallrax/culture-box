<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/18
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>
    <table border="1" style="width:98%; height: 80%; text-align: center">
        <thead>
        <tr>
            <th>名称</th>
            <th>一级分类</th>
            <th>二级分类</th>
            <th>点击量</th>
        </tr>
        </thead>
        <tbody id="clicks_list">

        </tbody>
    </table>
</div>
<div id="page_div" style="display: none;">
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

    var type;
    var url;
    var pageUrl;
    var eq;
    var totalCount;

    $(function () {
        init();
    });

    function init() {
        type = getUrlParamer("type");
        if (type == 1) {
            eq = encodeURI(encodeURI("{\"lv\":1}"));
            url = "/category/getByFields";
            pageUrl = "/category/getCountByField";
        } else if (type == 2) {
            eq = encodeURI(encodeURI("{\"lv\":2}"));
            url = "/category/getByFields";
            pageUrl = "/category/getCountByField";
        } else {
            $("#page_div").show();
            eq = "";
            url = "/series/getByFields";
            pageUrl = "/series/getCountByField";
        }
        writeData(1);
        writePage();
    }

    function writeData(index) {
        $("#clicks_list").empty();
        var data = getData(index);
        var field;
        var tempStr = "";
        for (var i = 0 in data) {
            if (type == 1) {
                field = "eq=" + encodeURI(encodeURI("{\"outterId\":" + data[i].id + ", \"type\":1}"));
            } else if (type == 2) {
                field = "eq=" + encodeURI(encodeURI("{\"innerId\":" + data[i].id + ", \"type\":1}"));
            } else {
                field = "eq=" + encodeURI(encodeURI("{\"innerId\":" + data[i].id + ", \"type\":2}"));
            }
            var tempResult = jsGet("/click/getByFields", field);
            var tempCount = $.parseJSON(tempResult);
            tempStr += "<tr><td>" + data[i].name + "</td><td>" + tempCount + "</td></tr>";
        }
        $("#clicks_list").append(tempStr);
    }

    function getData(index) {
        var tempField = type == 3 ? "eq=" + eq + "&page=" + index : "eq=" + eq;
        var result = jsGet(url, tempField);
        console.log(result);
        return type == 3 ? $.parseJSON($.parseJSON(result)) : $.parseJSON(result);
    }

    //写总数
    function writePage() {
        totalCount = getCount();
        console.log(" totalCount : " + totalCount);
        var page = totalCount % 12 == 0 ? totalCount / 12 : totalCount / 12 + 1;
        var tempStr;
        for (var i = 1; i <= page; i++) {
            tempStr += "<option value=\"" + i + "\">" + i + "</option>";
        }
        $("#tempPage").append(tempStr);
    }

    function getCount() {
        var result = jsGet(pageUrl, "eq=" + eq);
        return $.parseJSON(result);
    }
</script>
