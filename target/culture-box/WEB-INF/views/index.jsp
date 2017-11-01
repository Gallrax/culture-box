<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>

<head>
    <meta charset="UTF-8">
    <title></title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"
          id="vp"/>
    <link rel="stylesheet" href="/static/css/reset.css" type="text/css"/>
    <link rel="stylesheet" href="/static/css/index.css" type="text/css"/>
    <link rel="stylesheet" href="/static/css/swiper.min.css">
    <style type="text/css">
        .content-wrap {
            width: 100%;
            height: 14rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #dcdcdc;
        }
        .content-section center {
            font-size: 1rem;
            color: #000000;
            width: 80%;
            text-align: center;
            margin: 0 auto;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
    </style>
</head>

<body>
<img src="/datas/logo/${_logo}" class="head"/>
<div class="banner-wrap">
    <div class="swiper-container swiper-container3">
        <div class="swiper-wrapper" id="carousel_image">
            <%--<div class="swiper-slide"><img src="static/image/banner1.png" height="100%" width="100%"/></div>
            <div class="swiper-slide"><img src="static/image/banner1.png" height="100%" width="100%"/></div>--%>
        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination"></div>
    </div>
</div>
<div class="nov-wrap">
    <div class="nov fl">
        <img src="static/image/nov1.png" onclick="location.href='/books.html'"/>
        <center>书城</center>
    </div>
    <div class="nov fl">
        <img src="static/image/nov2.png" onclick="location.href='/course.html'"/>
        <center>公开课</center>
    </div>
    <div class="nov fl">
        <img src="static/image/nov3.png" onclick="location.href='/reader.html'"/>
        <center>有声读物</center>
    </div>
</div>
<div class="content-wrap clearfix">
    <div class="content-title">
        <span class="fl">好书推荐</span>
        <img class="fr" src="/static/image/jiantou.png"/>
        <div class="fr" onclick="location.href='/books.html'">更多</div>
    </div>
    <div class="content fl">
        <div class="swiper-container swiper-container2">
            <div id="data_1" class="swiper-wrapper">
                <%--<div class="swiper-slide content-section">
                    <img src="/static/image/book1.png"/>
                    <center>人类群星闪耀时</center>
                </div>
                <div class="swiper-slide content-section">
                    <img src="/static/image/book2.png"/>
                    <center>经济史的趣味</center>
                </div>
                <div class="swiper-slide content-section">
                    <img src="/static/image/book3.png"/>
                    <center>论语解读</center>
                </div>--%>
            </div>
        </div>
    </div>
</div>
<div class="content-wrap clearfix course">
    <div class="content-title">
        <span class="fl">精品课程</span>
        <img class="fr" src="/static/image/jiantou.png"/>
        <div class="fr" onclick="location.href='/course.html'">更多</div>
    </div>
    <div class="content fl">
        <div class="swiper-container swiper-container3">
            <div id="data_2" class="swiper-wrapper">
                <%--<div class="swiper-slide content-section">
                    <img src="/static/image/course1.png"/>
                    <center>可汗学院公开课</center>
                </div>
                <div class="swiper-slide content-section">
                    <img src="/static/image/course2.png"/>
                    <center>学好网路创意营销</center>
                </div>
                <div class="swiper-slide content-section">
                    <img src="/static/image/course3.png"/>
                    <center>博弈论</center>
                </div>--%>
            </div>
        </div>
    </div>
</div>
<div class="content-wrap clearfix listen">
    <div class="content-title">
        <span class="fl">有声推荐</span>
        <img class="fr" src="/static/image/jiantou.png"/>
        <div class="fr" onclick="location.href='/reader.html'">更多</div>
    </div>
    <div class="content fl" style="padding-bottom: 1rem;">
        <div class="swiper-container swiper-container4">
            <div id="data_3" class="swiper-wrapper">
                <%--<div class="swiper-slide content-section">
                    <img src="/static/image/listen.png"/>
                    <center>了不起的火箭</center>
                </div>
                <div class="swiper-slide content-section">
                    <img src="/static/image/listen.png"/>
                    <center>夜莺与蔷薇</center>
                </div>
                <div class="swiper-slide content-section">
                    <img src="/static/image/listen.png"/>
                    <center>少年国王</center>
                </div>--%>
            </div>
        </div>
    </div>
</div>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/mine.js"></script>
<script>
    $(function () {
        getCarousel();
        writeSeries("data_1", 1);
        writeSeries("data_2", 2);
        writeSeries("data_3", 3);
        endInit();
    });

    //获取分类
    function getCarousel() {
        var url = "/carousel/getByPage";
        var result = jsGet(url, null);
        var obj = $.parseJSON(result);
        var tempStr = "";
        for (var i in obj) {
            tempStr += "<div class=\"swiper-slide\"><img src=\"" + obj[i].image + "\" height=100% width=100%/></div>";
        }
        $("#carousel_image").append(tempStr);
    }

    //根据分类写系列
    function writeSeries(domId, pcid) {
        var obj = getSeries(pcid);
        console.log(obj.length);
        var url;
        if(pcid == 1) {
            url = "/bookinfo.html";
        }else if(pcid == 2) {
            url = "/coursevideo.html";
        }else if(pcid == 3) {
            url = "/coursemusic.html";
        }
        var tempStr = "";
        for (var i in obj) {
            tempStr += "<div class=\"swiper-slide content-section\" onclick=\"location.href = '"+ url +"?sid="+ obj[i].id +"'\"><img src=\"" + autoReplaceImage(obj[i].image, "/static/image/listen.png") + "\"/><center>" + obj[i].name + "</center></div>";
        }
        $("#" + domId).append(tempStr);
    }

    //获取系列
    function getSeries(pcid) {
        var result = jsGet("/series/getByPCid/" + pcid, null);
        var obj = $.parseJSON(result);
        return obj;
    }

    function endInit() {
        var swiper = new Swiper('.swiper-container1', {
            pagination: '.swiper-pagination',
            paginationClickable: true,
            autoplay:2000,
            observer: true,//修改swiper自己或子元素时，自动初始化swiper
            observeParents: true//修改swiper的父元素时，自动初始化swiper
        });

        var swiper = new Swiper('.swiper-container2', {
            slidesPerView: 3,
            spaceBetween: 10,
            observer: true,//修改swiper自己或子元素时，自动初始化swiper
            observeParents: true//修改swiper的父元素时，自动初始化swiper
        });
        var swiper = new Swiper('.swiper-container3', {
            slidesPerView: 3,
            spaceBetween: 10,
            observer: true,//修改swiper自己或子元素时，自动初始化swiper
            observeParents: true//修改swiper的父元素时，自动初始化swiper
        });
        var swiper = new Swiper('.swiper-container4', {
            slidesPerView: 3,
            spaceBetween: 10,
            observer: true,//修改swiper自己或子元素时，自动初始化swiper
            observeParents: true//修改swiper的父元素时，自动初始化swiper
        });
    }

</script>

<script src="/static/js/swiper.min.js"></script>
<script>


</script>
</body>
</html>