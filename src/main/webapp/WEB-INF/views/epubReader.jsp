<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/9/21
  Time: 14:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<style>
    .epub_content .text_none {
        text-indent: 0;
    }
</style>
<body>
<div id="epub_temp">
    <%--<div class="epub_content" style="text-indent: 2em;font-size: 20px;line-height: 1.5;"><p style="margin-left:0px;" class="text_none">在其中，感叹科学技术的发达和不可思议。我也同时做起攻克癌症的<br/>白日梦。谁知道孩子们又有着什么样的梦想呢？</p><p style="margin-left:0px;">我想起我们小时候也有这样快乐的日子，过年了，听老人们讲“<br/>年”的故事，一大早就起床穿新衣放鞭炮；端午节听着屈原的故事吃<br/>粽子；七夕有牛郎织女；中秋有后羿射日嫦娥飞天……除了这些节日<br/>的故事，日常大人们也会给我们讲各种各样的神话故事，正是这些神<br/>话故事让我们在懵懵懂懂中有了梦想，知晓了为人处世的道理。可见<br/>，不管是东方还是西方，童话都是孩子们成长过程中不可或缺的一部<br/>分。</p><p style="margin-left:0px;">组织领导能力的启蒙</p><p style="margin-left:0px;">到了美国，让我大开眼界的又一事情是小孩子的生日派对（bir<br/>thday party)。璐璐入幼儿园不到两个月，便收到一封来自班里<br/>小朋友生日派对的邀请函。那是一张精美的小卡片，通过邮局寄到家<br/>里。小卡片清楚地写有时间和地点。让我感到意外的是：地点是一个<br/>体操馆。</p><p style="margin-left:0px;">询问周围的同事朋友我才敢确认，没错，是体操馆。这里小孩子<br/>的生日派对千奇百怪，不管在什么地方，做什么事情，都不必大惊小<br/>怪。美国人强调的是有特色，有创意。</p></div>--%>
    <%--<div class="epub_content" style="text-indent: 2em;font-size: 20px;line-height: 1.5;"><div style="text-align:center;text-indent: 0em;margin: 10px 0;"><img  width="555" height="755" src="/epubread/cache/image/20406f056e2ce41de30165e075c209f5/images/bok001_1.jpg"/></div><p style="margin-left:0px;"></p></div>--%>
</div>
<div onclick="writeData(page)">
    下一页
</div>
</body>
</html>
<script src="static/js/jquery.min.js"></script>
<script src="static/js/mine.js"></script>
<script>

    var seriesId;
    var page = 1;
    var bookinfo;

    $(function () {
        init();
        writeData(1);
    });

    //初始化
    function init() {
        seriesId = getUrlParamer("id");
        bookinfo = getData();
    }

    //写数据
    function writeData(index) {
        index = index <= 1 ? 1 : index;
        $("#epub_temp").empty();
        var text = bookinfo.contents[index - 1].content;
        page++;
        console.log(text);
        $("#epub_temp").append(text);
    }

    //获取数据
    function getData() {
        var temp = new Object();
        temp.seriesId = seriesId;
        var tempResult = jsGet("/resource/getByFields", "eq=" + ifyAndEnc(temp));
        console.log(tempResult);
        var resources = $.parseJSON(tempResult);//获得该系列下的resource
        var width = document.body.clientWidth;
        var height = document.body.clientHeight;
        console.log("width : " + width + " height : " + height);
        var result = jsGet("/resource/epubRead", "id=" + resources[0].id + "&width=" + Math.floor(width) + "&height=" + Math.floor(height));
        var obj = $.parseJSON($.parseJSON(result));
        return obj;
    }
</script>
