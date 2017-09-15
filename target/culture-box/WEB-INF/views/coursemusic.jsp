<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="UTF-8">
    <title></title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"
          id="vp"/>
    <link rel="stylesheet" href="static/css/reset.css" type="text/css"/>
    <link rel="stylesheet" href="static/css/course.css" type="text/css"/>
    <link rel="stylesheet" href="static/css/swiper.min.css">
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <style>
        #a1 {
            height: 10rem;
            background: red;
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
<div class="video-wrap" id="a1">
    <audio id="audio_resource" src="" controls="controls"></audio>
</div>
<div class="video-menu">
    <div class="video-button clearfix">
        <span class="fl" onclick="goTo(-1)">上一集</span>
        <span class="fr" onclick="goTo(1)">下一集</span>
    </div>
    <div class="video-title">选集</div>
    <div id="datas_list" class="video-news">
        <%--<span class="fl blue">[第一集]创意营销与创意思维</span><span class="fr">[第二集]网络商业模式的创新</span>
        <span class="fl">[第三集]网上消费者体验创新</span><span class="fr">[第四集]产品定价与销售创新</span>
        <span class="fl">[第五集]交互式营销沟通创新</span><span class="fr">[第六集]个性化营销服务创新</span>--%>
    </div>
</div>
</body>
</html>

<script src="static/js/jquery.min.js"></script>
<script src="static/js/mine.js"></script>
<script>
    var seriesId;
    var innerId;
    var maxId;
    $(function () {
        seriesId = getUrlParamer("sid");
        innerId = getUrlParamer("iid");
        if (innerId == null) innerId = 1;
        innerId = parseInt(innerId);
        getTitle();
        getAutio();
        getList();
    });

    function getTitle() {
        var obj = new Object();
        obj.id = seriesId;
        var result = jsGet("/series/getByFields", "eq=" + ifyAndEnc(obj));
        var obj = $.parseJSON(result);
        $("#series_name").append(obj[0].name);
    }

    function getAutio() {
        var obj = new Object();
        obj.seriesId = seriesId;
        obj.innerId = innerId;
        var result = jsGet("/resource/getByFields", "eq=" + ifyAndEnc(obj));
        var obj = $.parseJSON(result);
        $("#audio_resource").attr("src", obj[0].route);
        console.log("obj[0].route");
    }

    function getList() {
        var obj = new Object();
        obj.seriesId = seriesId;
        var result = jsGet("/resource/getByFields", "eq=" + ifyAndEnc(obj));
        var obj = $.parseJSON(result);
        maxId = obj.length;
        var str = "";
        for (var i in obj) {
            var tempLR = i % 2 ? "fr" : "fl";
            var temp = (parseInt(i) + 1) == innerId ? tempLR + " blue" : tempLR;
            str += "<span class=\"" + temp + "\" onclick=\"location.href = '/coursemusic.html?sid=" + seriesId + "&iid=" + obj[i].innerId + "'\">" +
                "[第" + obj[i].innerId + "集]" + obj[i].name + "" +
                "</span>";
        }
        $("#datas_list").append(str);
    }

    //判断是上一集或下一集
    function goTo(judge) {
        if (judge == -1) {
            var tempId = innerId <= 1 ? 1 : innerId - 1;
            location.href = "/coursemusic.html?sid=" + seriesId + "&iid=" + tempId;
        } else if (judge == 1) {
            var tempId = (innerId + 1) >= maxId ? maxId : (innerId + 1);
            location.href = "/coursemusic.html?sid=" + seriesId + "&iid=" + tempId;
        }
    }

</script>