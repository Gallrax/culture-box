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
</head>
<style>
    #a1 {
        margin: 0 auto;
        width: 100%;
    }
</style>
<body>
<div class="title">
    <img src="static/image/jiantou2.png" class="title-img1" onclick="window.history.back();"/>
    <span onclick="window.history.back();">返回</span>
    <div id="series_name1" class="word"></div>
    <img src="static/image/home.png" class="title-img2" onclick="location.href = '/'"/>
</div>
<div class="video-wrap" id="a1"><video id="vedio_resource" src="" controls="controls" autoplay="autoplay" style="clear:both;display:block;margin:auto;width: 100%"></video></div>
<div class="video-info">
    <span id="series_name2" class="fl word"></span>
    <span class="fr left">课程及讲师简介<img src="static/image/jiantou.png"/></span>
    <span class="fr down"><img src="static/image/down.png"/></span>
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
<div class="video-content clearfix">
    <%--<div class="teacher-introduce">
        <span class="fl">讲师简介</span>
    </div>
    <p>
        何建民，男，华东师范大学经济系毕业，获经济学学士学位；后获复旦大学博士学位。现为教授，经济学博士，旅游管理专业博士生导师，上海财经大学工商管理博士后流动站旅游管理专业博士后联系导师。上海财经大学旅游管理系主任，获国务院特殊津贴专家，全国优秀教师。长期从事旅游业开发与管理研究，发表多篇学术性论文并获奖，被邀请去各地巡回演讲受到欢迎。
    </p>--%>
    <div class="teacher-introduce">
        <span class="fl">课程介绍</span>
    </div>
    <p id="series_introduce">
        <%--互联网为企业整合营销资源，探索、创造和传递价值，实现消费者价值体验，打开了全新营销思路；为消费者搜索和传递各种资讯，彰显个人需求，实现与企业共同创造价值，提供了全新方法。本课程为您讲述互联网营销的新思路和新方法，带您领略网络创意营销的神奇。--%>
    </p>
</div>
<script type="text/javascript" src="static/js/ckplayer.js" charset="utf-8"></script>
<script type="text/javascript">
    /*var flashvars = {
        p: 0,
        e: 1,
        i: 'http://www.ckplayer.com/static/images/cqdw.jpg'
    };
    var video = ['http://img.ksbbs.com/asset/Mon_1605/0ec8cc80112a2d6.mp4->video/mp4'];
    var support = ['all'];
    CKobject.embedHTML5('a1', 'ckplayer_a1', 300, 230, video, flashvars, support);*/

    $(".left").click(function () {
        $(this).hide();
        $(".down").show();
        $(".video-menu").hide();
        $(".video-content").show();
    })
    $(".down").click(function () {
        $(this).hide();
        $(".left").show();
        $(".video-menu").show();
        $(".video-content").hide();
    })
</script>
</body>
</html>

<script src="static/js/jquery.min.js"></script>
<script src="static/js/mine.js"></script>
<script>
    var seriesId;
    var innerId;
    var maxId;
    $(function () {
        init();
    });

    function init(){
        seriesId = getUrlParamer("sid");
        innerId = getUrlParamer("iid");
        if (innerId == null) innerId = 1;
        innerId = parseInt(innerId);
        addClick(seriesId);
        // getTitle();
        getVedio();//标题在此方法中设置
        getList();

    }

    //获取标题
    function getTitle() {
        var temp = new Object();
        temp.id = seriesId;
        var result = jsGet("/series/getByFields", "eq=" + ifyAndEnc(temp));
        var obj = $.parseJSON($.parseJSON(result));
        $("#series_name1").append(obj[0].name);
        $("#series_name2").append(obj[0].name);
        $("#series_introduce").append(obj[0].introduce);
    }

    //获取播放数据来源
    function getVedio() {
        var temp = new Object();
        temp.seriesId = seriesId;
        temp.innerId = innerId;
        var result = jsGet("/resource/getByFields", "eq=" + ifyAndEnc(temp));
        var obj = $.parseJSON(result);
        $("#vedio_resource").attr("src", obj[0].route);
        $("#series_name1").append(obj[0].name);
        $("#series_name2").append(obj[0].name);
        console.log("obj[0].route");
    }

    //获取该系列下所有资源(集)
    function getList() {
        var temp = new Object();
        temp.seriesId = seriesId;
        var result = jsGet("/resource/getByFields", "eq=" + ifyAndEnc(temp));
        var obj = $.parseJSON(result);
        maxId = obj.length;
        var str = "";
        for (var i in obj) {
            var tempLR = i % 2 ? "fr" : "fl";//暂时去掉此样式
            var temp = (parseInt(i) + 1) == innerId ? tempLR + " blue" : tempLR;
            str += "<span class=\""+ temp +"\" onclick=\"location.href = '/coursevideo.html?sid=" + seriesId + "&iid=" + obj[i].innerId + "'\">" +
                "[第" + obj[i].innerId + "集]" + obj[i].name + "" +
                "</span>";
        }
        $("#datas_list").append(str);
    }

    //判断是上一集或下一集
    function goTo(judge) {
        if (judge == -1) {
            var tempId = innerId <= 1 ? 1 : innerId - 1;
            location.href = "/coursevideo.html?sid=" + seriesId + "&iid=" + tempId;
        } else if (judge == 1) {
            var tempId = (innerId + 1) >= maxId ? maxId : (innerId + 1);
            location.href = "/coursevideo.html?sid=" + seriesId + "&iid=" + tempId;
        }
    }

</script>