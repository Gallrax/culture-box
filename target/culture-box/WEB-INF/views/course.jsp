<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no"/>
	<!--禁止缓存-->
	<meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<!--设定网页的到期时间-->
	<meta http-equiv="expires" content="0"/>
	<title></title>
	<link rel="stylesheet" href="static/css/reset.css"/>
	<link rel="stylesheet" href="static/css/mui.min.css">
	<link rel="stylesheet" href="static/css/reader.css"/>
</head>
<body>
<header class="mui-bar mui-bar-nav">
	<div class="backBox">
		<a href="javascript:void(0);" onclick="window.history.back();"><img src="static/image/arrow-blue-left.png"/><span>返回</span></a>
		<p class="title">公开课</p>
		<img src="static/image/home.png" onclick="location.href = '/'"/>
	</div>
	<div class="searchBox">
		<input id="search_value" type="text" placeholder="请输入书名或作者"/>
		<img src="static/image/search.png" onclick="search()"/>
	</div>
</header>
<div class="mui-content">
	<div id="slider" class="mui-slider mui-fullscreen">
		<div id="sliderSegmentedControl"
			 class="mui-scroll-wrapper mui-slider-indicator mui-segmented-control mui-segmented-control-inverted">
			<div id="reader_categary" class="mui-scroll">
				<%--<a class="mui-control-item mui-active" href="#item1mobile">科幻文学</a>
                <a class="mui-control-item" href="#item2mobile">儿童故事</a>
                <a class="mui-control-item" href="#item3mobile">英语听力</a>
                <a class="mui-control-item" href="#item4mobile">有声小说</a>
                <a class="mui-control-item" href="#item5mobile">风云人物</a>
                <a class="mui-control-item" href="#item6mobile">更多</a>--%>
			</div>
		</div>
		<div id="outter_div" class="mui-slider-group">
			<%--<div id="item1mobile" class="mui-slider-item mui-control-content mui-active">
                <div id="scroll1" class="mui-scroll-wrapper">
                    <div class="mui-scroll">
                        <ul class="mui-table-view">
                            <a>
                                <img class="readerPic" src="img/pic.png"/>
                                <p class="title word">了不起的火箭</p>
                                <p class="total word">共一集</p>
                            </a>
                        </ul>
                    </div>
                </div>
            </div>
            <div id="item2mobile" class="mui-slider-item mui-control-content">
                <div class="mui-scroll-wrapper">
                    <div class="mui-scroll">
                        <ul class="mui-table-view">
                            <a>
                                <img class="readerPic" src="img/pic.png"/>
                                <p class="title word">打鱼人和他的灵魂</p>
                                <p class="total word">共一集</p>
                            </a>
                        </ul>
                    </div>
                </div>
            </div>
            <div id="item3mobile" class="mui-slider-item mui-control-content">
                <div class="mui-scroll-wrapper">
                    <div class="mui-scroll">
                        <ul class="mui-table-view">
                            <a>
                                <img class="readerPic" src="img/pic.png"/>
                                <p class="title word">自私的巨人</p>
                                <p class="total word">共一集</p>
                            </a>
                        </ul>
                    </div>
                </div>
            </div>--%>
		</div>
	</div>
</div>
</body>
</html>
<script src="static/js/jquery.min.js"></script>
<script src="static/js/mine.js"></script>
<script src="static/js/mui.min.js"></script>
<script src="static/js/mui.pullToRefresh.js"></script>
<script src="static/js/mui.pullToRefresh.material.js"></script>

<script>

    var pid = 2;
    var map = new Object();//用于储存每个分类下查询当前页

    $(function () {
        getCategory();
        $("#category_0").click();
    });

    //获取分类
    function getCategory() {
        var url = "/category/getByPid/" + pid;
        var result = jsGet(url, null);
        var obj = $.parseJSON(result);
        var tempStr = "";
        if (obj.length >= 1) {
            tempStr += "<a id=\"category_0\" title=\"" + obj[0].id + "\" class=\"mui-control-item mui-active\" href=\"#item" + 1 + "mobile\">" + obj[0].name + "</a>";
            writeDiv(1, obj[0].id, true);
            map[0] = 1;//初始化
        }
        for (var i = 1; i < obj.length; i++) {
            tempStr += "<a id=\"category_" + i + "\" title=\"" + obj[i].id + "\" class=\"mui-control-item\" href=\"#item" + (i + 1) + "mobile\">" + obj[i].name + "</a>";
            writeDiv((i + 1), obj[i].id, false);
            map[i] = 1;//初始化
        }
        $("#reader_categary").append(tempStr);
    }

    //根据分类在分类下的div中写数据
    function writeDiv(index, categoryId, isOne) {
        var tempStr = isOne ? "<div id=\"item" + index + "mobile\" class=\"mui-slider-item mui-control-content mui-active\"> " : "<div id=\"item" + index + "mobile\" class=\"mui-slider-item mui-control-content\"> ";
        tempStr += "<div id=\"scroll" + index + "\" class=\"mui-scroll-wrapper\"> " +
            "<div class=\"mui-scroll\"> " +
            "<ul id=\"ul_" + index + "\" class=\"mui-table-view\"> " +
            "</ul> " +
            "</div> " +
            "</div> " +
            "</div>";
        $("#outter_div").append(tempStr);
        writeData(index, 1, categoryId);
    }

    //写数据实现
    function writeData(index, page, categoryId) {
        var obj = getData(page, categoryId);
        var tempStr = "";
        for (var i in obj) {
            tempStr += "<a> " +
                "<img class=\"readerPic\" src=\""+ obj[i].image +"\" onclick=\"location.href = '/coursevideo.html?sid="+ obj[i].id +"'\"/> " +
                "<p class=\"title word\">"+ obj[i].name +"</p> " +
                "<p class=\"author word\">"+ obj[i].authorCompany +"</p> " +
                "</a> ";
        }
        console.log(" index : " + index + " tempStr : " + tempStr);
        $("#ul_" + index).append(tempStr);
    }

    //获取数据并转换
    function getData(page, categoryId) {
        var temp = new Object();
        temp.categoryId = categoryId;
        var eq = ifyAndEnc(temp);
        var result = jsGet("/series/getByFields", "eq="+ eq +"&page=" + page);
        var obj = $.parseJSON($.parseJSON(result));
        return obj;
    }

    //搜索跳转
	function search() {
        var value = $("#search_value").val();
        var search = encodeURI(encodeURI(value));
        if(!isEmpty(value)) location.href = "/search.html?pid=" + pid + "&search=" + search;
    }

    //方便下方mui获取(在下方script中无法获取)
    function getCategoryId(index) {
        var categoryId = $("#category_" + index).attr("title");
        return categoryId;
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
                var length = ul.querySelectorAll('a').length;
                var fragment = document.createDocumentFragment();
                var current_page = map[index] + 1;
                var obj = getData(current_page, getCategoryId(index));
                if (obj.length != 0) map[index] = current_page + 1;
                for (var i = 0; i < obj.length; i++) {
                    li = document.createElement('a');
                    li.innerHTML = "<img class=\"readerPic\" src=\"" + obj[i].image + "\" /><p class=\"title word\">" + obj[i].name + "</p><p class=\"author word\">共" + obj[i].count + "集</p>";
                    fragment.appendChild(li);
                }
                return fragment;
            };
        });
    })(mui);
</script>
