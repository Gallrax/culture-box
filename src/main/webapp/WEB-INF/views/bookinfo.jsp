<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="UTF-8">
    <title></title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"
          id="vp"/>
    <link rel="stylesheet" href="static/css/reset.css" type="text/css"/>
    <link rel="stylesheet" href="static/css/bookinfo.css" type="text/css"/>
</head>

<body>
<div class="head-wrap ycenter">
    <img src="static/image/jiantou2.png" class="head-img1" onclick="window.history.back();"/>
    <span onclick="window.history.back();">返回</span>
    <img src="static/image/home.png" class="head-img2" onclick="location.href = '/'"/>
</div>
<div class="content-wrap">
    <div class="content-title clearfix ycenter">
        <img id="data_img" src="static/image/bgbook.png" class="content-img1"/>
        <div id="data_div" class="content-section">
            <%--<p>《最强大脑》</p>
            <p>作者：王洪才，张成琳，唐春花著</p>
            <p>出版社：先交通大学出版社</p>
            <img src="static/image/readbtn.png"/>--%>
        </div>
    </div>
    <div class="content">
        <p>内容简介</p>
        <p id="data_text" class="clearfix"></p>
    </div>
</div>
<div class="nov-wrap clearfix">
    <div class="nov-title">
        <span class="fl">好书推荐</span>
        <img class="fr" src="static/image/jiantou.png"/>
        <div class="fr" onclick="location.href = '/books.html'">更多</div>
    </div>
    <div id="books" class="nov fl">
        <%--<div class="nov-section fl">
            <img src="static/image/book1.png" />
            <center>人类群星闪耀时</center>
        </div>
        <div class="nov-section fl">
            <img src="static/image/book2.png" />
            <center>经济史的趣味</center>
        </div>
        <div class="nov-section fl">
            <img src="static/image/book3.png" />
            <center>论语解读</center>
        </div>--%>
    </div>
</div>
</body>
</html>
<script src="static/js/jquery.min.js"></script>
<script src="static/js/mine.js"></script>
<script>
    var seriesId;
    var categoryPId;

    $(function () {
        seriesId = getUrlParamer("sid");
        addClick(seriesId);
        writeData(seriesId);
        writeBooks(categoryPId);//categoryPId 在 writeData已赋值
    });

    //写数据
    function writeData(seriesId) {
        var obj = getData(seriesId);
        categoryPId = obj[0].categoryPId;
        $("#data_img").attr("src", obj[0].image);
        var tempDiv = "<p>" + obj[0].name + "</p>" +
            "<p>作者：" + obj[0].author + "著</p>" +
            "<p>出版社：" + obj[0].press + "</p>" +
            "<img src=\"static/image/readbtn.png\" onclick=\"location.href = '/epubReader.html?id="+ seriesId +"'\"/>";
        $("#data_div").append(tempDiv);
        var tempText = obj[0].introduce;
        $("#data_text").append(tempText);
    }

    //写好书推荐
    function writeBooks(categoryPId) {
        var obj = getBooks(categoryPId);
        var tempStr = "";
        for (var i in obj) {
            tempStr += "<div class=\"nov-section fl\" onclick=\"location.href = '/bookinfo.html?sid="+ obj[i].id +"'\"><img src=\"" + obj[i].image + "\" /><center>" + obj[i].name + "</center> </div>";
        }
        $("#books").append(tempStr);
    }

    //获取数据
    function getData(seriesId) {
        var temp = new Object();
        temp.id = seriesId;
        var result = jsGet("/series/getByFields", "eq=" + ifyAndEnc(temp));
        var obj = $.parseJSON($.parseJSON(result));
        return obj;
    }

    //获取好书推荐
    function getBooks(categoryPId) {
        var temp = new Object();
        temp.categoryPId = categoryPId;
        var result = jsGet("/series/getByFields", "eq=" + ifyAndEnc(temp));
        var obj = $.parseJSON($.parseJSON(result));
        return obj;
    }


</script>