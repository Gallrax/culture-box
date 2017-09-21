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
    <img src="static/image/search.png" class="fr"/>
</div>
<div class="info-wrap">
    相关结果共2个
</div>
<div class="list-wrap">
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
</div>
</body>
</html>

<script src="static/js/jquery.min.js"></script>
<script src="static/js/mine.js"></script>
<script src="static/js/mui.min.js"></script>
<script src="static/js/mui.pullToRefresh.js"></script>
<script src="static/js/mui.pullToRefresh.material.js"></script>
<script>
    var pid;
    var search;

    $(function () {
        pid = getUrlParamer("pid");
        search = getUrlParamer("search");
        console.log(" pid : " + pid + " search : " + search);
        $("#search_value").val(search);
        getTitle();
    });

    function getTitle() {
        var obj = new Object();
        obj.id = pid;
        var result = jsGet("/category/getByFields", "eq=" + ifyAndEnc(obj));
        console.log(" result : " + result);
        var obj = $.parseJSON(result);
        $("#series_name").append(obj[0].name);
    }

    //获取数据并转换
    function getData(page, pid) {
        var obj = new Object();
        obj.categoryPId = pid;
        var eq = ifyAndEnc(obj);
        var result = jsGet("/series/getByFields", "eq="+ eq +"&page=" + page);
        var obj = $.parseJSON($.parseJSON(result));
        return obj;
    }

</script>
<script>
    mui.init();
    (function ($) {
        //阻尼系数
//				var deceleration = mui.os.ios?0.003:0.0009;
        $('.mui-scroll-wrapper').scroll({
            bounce: false,
            indicators: true, //是否显示滚动条
//					deceleration:deceleration
        });
        $.ready(function () {
            //循环初始化所有下拉刷新，上拉加载。
            $.each(document.querySelectorAll('.mui-slider-group .mui-scroll'), function (index, pullRefreshEl) {
                $(pullRefreshEl).pullToRefresh({
                    down: {
                        callback: function () {
                            var self = this;
                            setTimeout(function () {
                                var ul = self.element.querySelector('.mui-table-view');
                                ul.insertBefore(createFragment(ul, index, 6, true), ul.firstChild);
                                self.endPullDownToRefresh();
                            }, 1000);
                        }
                    },
                    up: {
                        callback: function () {
                            var self = this;
                            setTimeout(function () {
                                var ul = self.element.querySelector('.mui-table-view');
                                ul.appendChild(createFragment(ul, index, 6));
                                self.endPullUpToRefresh();
                            }, 1000);
                        }
                    }
                });
            });
            var createFragment = function (ul, index, count, reverse) {
                /*var length = ul.querySelectorAll('a').length;
                 var fragment = document.createDocumentFragment();
                 var current_page = map[index] + 1;
                 var obj = getData(current_page, getCategoryId(index));
                 if (obj.length != 0) map[index] = current_page + 1;
                 for (var i = 0; i < obj.length; i++) {
                 li = document.createElement('a');
                 li.innerHTML = "<img class=\"readerPic\" src=\"" + obj[i].image + "\" /><p class=\"title word\">" + obj[i].name + "</p><p class=\"author word\">共" + obj[i].count + "集</p>";
                 fragment.appendChild(li);
                 }
                 return fragment;*/
            };
        });
    })(mui);
</script>