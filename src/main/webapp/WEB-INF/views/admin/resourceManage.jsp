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
    <div class="pageContent">
        <div class="panelBar">
            <ul class="toolBar">
                <li><input type="checkbox" class="checkboxCtrl" group="ids"/>全选</li>
            </ul>
        </div>
    </div>

    <table class="list" width="98%">
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

    <div class="panelBar">
        <div class="pages">
            共<span id="series_count"></span>条
        </div>
        <!--分页组件-->
        <div class="pagination" targetType="navTab" totalCount="${pager.totalCount}" numPerPage="${pager.everyPage}"
             pageNumShown="10" currentPage="${pager.currentPage}"></div>
    </div>

</div>
</div>
</body>
</html>
<script>

    var categoryId;

    $(function () {
        init();
    });

    function init() {
        seriesId = getUrlParamer("categoryId");
        getData(1);
    }
    
    function getData(page) {
        var result = jsGet("/series/getByFields", "categoryId=" + categoryId +"&page="+ page);

    }
</script>
