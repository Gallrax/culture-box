<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="UTF-8">
    <title></title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"
          id="vp"/>
    <link rel="stylesheet" href="static/css/reset.css" type="text/css"/>
    <link rel="stylesheet" href="static/css/select.css" type="text/css"/>
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <style>

    </style>
</head>
<body>
<div class="title">
    <img src="static/image/jiantou2.png" class="title-img1" onclick="window.history.back();"/>
    <span onclick="window.history.back();">返回</span>
    <div id="series_name" class="word"></div>
    <img src="static/image/home.png" class="title-img2" onclick="location.href = '/'"/>
</div>
<div class="ipt-wrap">
    <input id="search_value" type="text" class="fl" value="故事新编"/>
    <img src="static/image/search.png" class="fr" onclick="flushSearch()"/>
</div>
<div class="info-wrap">
    相关结果共<span id="result_count"></span>个
</div>
<div id="result_data">
    <%--<div class="list-wrap">
        <img src="static/image/list1.png" class="fl"/>
        <div class="fl list-content">
            <p class="word">
                <span class="red">故事新编</span>
                ：插图本
            </p>
            <p>鲁迅著</p>
        </div>
        <span class="fr list-button">查看</span>
    </div>
    <div class="list-wrap">
        <img src="static/image/list1.png" class="fl"/>
        <div class="fl list-content">
            <p class="word">
                呐喊.彷徨
                <span class="red">故事新编</span>
            </p>
            <p>鲁迅著</p>
        </div>
        <span class="fr list-button">查看</span>
    </div>--%>
</div>
<%--<div class="pullUp">已经到底啦~(>_<)~~</div>--%>
</body>
</html>

<script src="static/js/jquery.min.js"></script>
<script src="static/js/mine.js"></script>
<script>
    var pid;
    var search;
    var url;

    $(function () {
        init();
        getTitle();
        writeData(1);
    });

    //初始化
    function init() {
        pid = getUrlParamer("pid");
        var tempSearch = getUrlParamer("search");
        search = decodeURI(decodeURI(tempSearch));
        $("#search_value").val(search);
        console.log(" pid : " + pid + " search : " + search);
        if (pid == 1) {
            url = "/bookinfo.html";
        } else if (pid == 2) {
            url = "/coursevideo.html";
        } else if (pid == 3) {
            url = "/coursemusic.html";
        }
    }

    //获取标题
    function getTitle() {
        var obj = new Object();
        obj.id = pid;
        var result = jsGet("/category/getByFields", "eq=" + ifyAndEnc(obj));
        var obj = $.parseJSON(result);
        $("#series_name").append(obj[0].name);
    }

    //写数据
    function writeData(page) {
        var result = getData(page, pid);
        var obj = result.records;
        $("#result_count").html(result.total);
        var tempStr = "";
        for (var i in obj) {
            tempStr += "<div class=\"list-wrap\"> " +
                "<img src=\"" + obj[i].image + "\" class=\"fl\"/> " +
                "<div class=\"fl list-content\"> " +
                "<p class=\"word\"> " + obj[i].name + " <span class=\"red\">故事新编</span> </p> " +
                "<p>" + obj[i].author + "著</p> " +
                "</div> " +
                "<span class=\"fr list-button\" onclick=\"location.href = '" + url + "?sid=" + obj[i].id + "'\">查看</span> " +
                "</div>";
        }
        $("#result_data").append(tempStr);
    }

    //获取数据并转换
    function getData(page, pid) {
        var eqObj = new Object();
        eqObj.categoryPId = pid;
        var eq = ifyAndEnc(eqObj);
        var likeObj = new Object();
        likeObj.name = jsLike(search);
        likeObj.author = jsLike(search);
        var like = ifyAndEnc(likeObj);
        var result = jsGet("/series/getByFields", "eq=" + eq + "&like=" + like + "&page=" + page);
        var obj = $.parseJSON($.parseJSON(result));
        return obj;
    }

    //搜索跳转
    function flushSearch() {
        var value = $("#search_value").val();
        var search = encodeURI(encodeURI(value));
        if (!isEmpty(value)) location.href = "/search.html?pid=" + pid + "&search=" + search;
    }

</script>