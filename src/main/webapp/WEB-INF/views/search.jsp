<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="UTF-8">
    <title></title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"
          id="vp"/>
    <link rel="stylesheet" href="static/css/reset.css" type="text/css"/>
    <link rel="stylesheet" href="static/css/select.css" type="text/css"/>
    <style>
        .pullUp {
            height: 40px;
            line-height: 40px;
            font-size: 14px;
            text-align: center;
            color: #b3b3b3;
        }

        .pullUp .pullUpIcon {
            display: inline-block;
            vertical-align: top;
            width: 16px;
            height: 16px;
            margin: 12px 9px 0 0;
            background: url(http://img.learn.16q.cn/home/2/new/refresh.png) no-repeat;
            background-size: contain;
            -webkit-transform: rotate(0deg) translateZ(0);
            -webkit-transition-duration: 0ms;
            -webkit-animation-name: loading;
            -webkit-animation-duration: 2s;
            -webkit-animation-iteration-count: infinite;
            -webkit-animation-timing-function: linear;
        }

        @-webkit-keyframes loading {
            from {
                -webkit-transform: rotate(0deg) translateZ(0);
            }
            to {
                -webkit-transform: rotate(360deg) translateZ(0);
            }
        }
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
    <input id="search_value" type="text" class="fl"/>
    <img src="static/image/search.png" class="fr" onclick="flushSearch()"/>
</div>
<div class="info-wrap">
    相关结果共<span id="result_count"></span>个
</div>
<div id="result_data">
    <%--<div class="list-wrap">
        <img src="static/image/ears.png" class="fl"/>
        <div class="fl list-content">
            <p class="word red">
                <span class="red">故事新编</span>
            </p>
            <p>第一集</p>
        </div>
        <span class="fr list-button">查看</span>
    </div>
    <div class="list-wrap">
        <img src="static/image/ears.png" class="fl"/>
        <div class="fl list-content">
            <p class="word red">
                <span class="red">故事新编</span>
            </p>
            <p>第二集</p>
        </div>
        <span class="fr list-button">查看</span>
    </div>--%>
</div>
<div class="pullUp">已经到底啦~(>_<)~~</div>
</body>
</html>
<script type="text/javascript" src="static/js/jquery.min.js"></script>
<script src="static/js/mine.js"></script>
<script>
    var pid;
    var search;
    var url;
    var index = 1;

    $(function () {
        init();
        getTitle();
        writeData(index);
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
            var tempAuthor = isEmpty(obj[i].author) ? "" : obj[i].author + "著";
            var tempImage = isEmpty(obj[i].image) ? (obj[i].type == "mp3" ? "/static/image/listen.png" : "/static/image/defaultVedio.jpg") : obj[i].image;
            tempStr += "<div class=\"list-wrap\" onclick=\"location.href = '" + url + "?sid=" + obj[i].id + "'\"> " +
                "<img src=\"" + tempImage + "\" class=\"fl\"/> " +
                "<div class=\"fl list-content\"> " +
                "<p class=\"word\"> " + obj[i].name + "</p> " +
                "<p>" + tempAuthor + "</p> " +
                "</div> " +
                "<span class=\"fr list-button\" onclick=\"location.href = '" + url + "?sid=" + obj[i].id + "'\">查看</span> " +
                "</div>";
        }
        $("#result_data").append(tempStr);
        index++;
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
<script>
    $(document).ready(function () {
        $(window).scroll(function () {
            if ($(document).scrollTop() <= 0) {
                //				      alert("滚动条已经到达顶部为0");
            }
            if ($(document).scrollTop() + $(window).height() + 1 >= $(document).height()) {
                writeData(index);
            }
        });
    });
</script>
