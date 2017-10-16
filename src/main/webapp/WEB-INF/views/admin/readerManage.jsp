<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/16
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="pageContent">
    <table class="table" width="100%" layoutH="138">
        <thead>
        <tr>
            <th>系列名称</th>
            <th>系列资源格式</th>
            <th>系列作者</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="series_list">
        <tr rel="1">
            <td>天津农信社</td>
            <td>A120113196309052434</td>
            <td>天津市华建装饰工程有限公司</td>
            <td>联社营业部</td>
            <td>29385739203816293</td>
            <td>5级</td>
            <td>政府机构</td>
            <td>2009-05-21</td>
            <td>
                <a class="button" onclick="alert('-')"><span>推荐</span></a>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<div>
    跳转至 :
    <select id="tempPage" onchange="writeData(this.value)">

    </select>
    页
</div>
<script>

    var categoryId = 3;
    var totalCount;

    $(function () {
        init();
    });

    function init() {
        writeData(1);
        writePage();
    }

    //写系列
    function writeData(page) {
        $("#series_list").empty();
        var data = getData(page);
        var tempStr = "";
        for (var i in data) {
            tempStr += "<tr><td>" + data[i].name + "</td><td>" + data[i].type + "</td><td>" + data[i].author + "</td><td><a class=\"button\"  onclick=\"recommend(" + data[i].id + ")\"><span>推荐</span></a></td></tr>";
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
        for (var i = 1; i <= page; i ++) {
            tempStr += "<option value=\""+ i +"\">" + i + "</option>";
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
        });
    }
</script>
