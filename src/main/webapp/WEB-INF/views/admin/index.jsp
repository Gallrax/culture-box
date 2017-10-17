<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>文化盒子后台管理系统</title>

    <link href="/dwz/themes/default/style.css" rel="stylesheet" type="text/css" media="screen"/>
    <link href="/dwz/themes/css/core.css" rel="stylesheet" type="text/css" media="screen"/>
    <link href="/dwz/themes/css/print.css" rel="stylesheet" type="text/css" media="print"/>
    <link href="/dwz/uploadify/css/uploadify.css" rel="stylesheet" type="text/css" media="screen"/>
    <!--[if IE]>
    <link href="/dwz/themes/css/ieHack.css" rel="stylesheet" type="text/css" media="screen"/>
    <![endif]-->

    <!--[if lt IE 9]>
    <script src="/dwz/js/speedup.js" type="text/javascript"></script>
    <script src="/dwz/js/jquery-1.11.3.min.js" type="text/javascript"></script><![endif]-->
    <!--[if gte IE 9]><!-->
    <script src="/dwz/js/jquery-2.1.4.min.js" type="text/javascript"></script><!--<![endif]-->

    <script src="/dwz/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/dwz/js/jquery.validate.js" type="text/javascript"></script>
    <script src="/dwz/js/jquery.bgiframe.js" type="text/javascript"></script>
    <script src="/dwz/xheditor/xheditor-1.2.2.min.js" type="text/javascript"></script>
    <script src="/dwz/xheditor/xheditor_lang/zh-cn.js" type="text/javascript"></script>
    <script src="/dwz/uploadify/scripts/jquery.uploadify.js" type="text/javascript"></script>

    <!-- svg图表  supports Firefox 3.0+, Safari 3.0+, Chrome 5.0+, Opera 9.5+ and Internet Explorer 6.0+ -->
    <script type="text/javascript" src="/dwz/chart/raphael.js"></script>
    <script type="text/javascript" src="/dwz/chart/g.raphael.js"></script>
    <script type="text/javascript" src="/dwz/chart/g.bar.js"></script>
    <script type="text/javascript" src="/dwz/chart/g.line.js"></script>
    <script type="text/javascript" src="/dwz/chart/g.pie.js"></script>
    <script type="text/javascript" src="/dwz/chart/g.dot.js"></script>

    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=6PYkS1eDz5pMnyfO0jvBNE0F"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/Heatmap/2.0/src/Heatmap_min.js"></script>

    <%--<script src="js/dwz.core.js" type="text/javascript"></script>
    <script src="js/dwz.util.date.js" type="text/javascript"></script>
    <script src="js/dwz.validate.method.js" type="text/javascript"></script>
    <script src="js/dwz.barDrag.js" type="text/javascript"></script>
    <script src="js/dwz.drag.js" type="text/javascript"></script>
    <script src="js/dwz.tree.js" type="text/javascript"></script>
    <script src="js/dwz.accordion.js" type="text/javascript"></script>
    <script src="js/dwz.ui.js" type="text/javascript"></script>
    <script src="js/dwz.theme.js" type="text/javascript"></script>
    <script src="js/dwz.switchEnv.js" type="text/javascript"></script>
    <script src="js/dwz.alertMsg.js" type="text/javascript"></script>
    <script src="js/dwz.contextmenu.js" type="text/javascript"></script>
    <script src="js/dwz.navTab.js" type="text/javascript"></script>
    <script src="js/dwz.tab.js" type="text/javascript"></script>
    <script src="js/dwz.resize.js" type="text/javascript"></script>
    <script src="js/dwz.dialog.js" type="text/javascript"></script>
    <script src="js/dwz.dialogDrag.js" type="text/javascript"></script>
    <script src="js/dwz.sortDrag.js" type="text/javascript"></script>
    <script src="js/dwz.cssTable.js" type="text/javascript"></script>
    <script src="js/dwz.stable.js" type="text/javascript"></script>
    <script src="js/dwz.taskBar.js" type="text/javascript"></script>
    <script src="js/dwz.ajax.js" type="text/javascript"></script>
    <script src="js/dwz.pagination.js" type="text/javascript"></script>
    <script src="js/dwz.database.js" type="text/javascript"></script>
    <script src="js/dwz.datepicker.js" type="text/javascript"></script>
    <script src="js/dwz.effects.js" type="text/javascript"></script>
    <script src="js/dwz.panel.js" type="text/javascript"></script>
    <script src="js/dwz.checkbox.js" type="text/javascript"></script>
    <script src="js/dwz.history.js" type="text/javascript"></script>
    <script src="js/dwz.combox.js" type="text/javascript"></script>
    <script src="js/dwz.file.js" type="text/javascript"></script>
    <script src="js/dwz.print.js" type="text/javascript"></script>--%>

    <!-- 可以用dwz.min.js替换前面全部dwz.*.js (注意：替换时下面dwz.regional.zh.js还需要引入)
    -->
    <script src="/dwz/bin/dwz.min.js" type="text/javascript"></script>
    <script src="/dwz/js/dwz.regional.zh.js" type="text/javascript"></script>
    <script src="/static/js/mine.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function () {
            DWZ.init("/dwz/dwz.frag.xml", {
                loginUrl: "/admin/login.html", loginTitle: "登录",	// 弹出登录对话框
//		loginUrl:"login.html",	// 跳到登录页面
                statusCode: {ok: 200, error: 300, timeout: 301}, //【可选】
                pageInfo: {
                    pageNum: "pageNum",
                    numPerPage: "numPerPage",
                    orderField: "orderField",
                    orderDirection: "orderDirection"
                }, //【可选】
                keys: {statusCode: "statusCode", message: "message"}, //【可选】
                ui: {hideMode: 'display'}, //【可选】hideMode:navTab组件切换的隐藏方式，支持的值有’display’，’offsets’负数偏移位置的值，默认值为’display’
                debug: false,	// 调试模式 【true|false】
                callback: function () {
                    initEnv();
                    $("#themeList").theme({themeBase: "themes"}); // themeBase 相对于index页面的主题base路径
                }
            });
        });
    </script>

</head>

<body>
<div id="layout">
    <div id="header">
        <div class="headerNav">
            <a class="logo" href="http://j-ui.com">标志</a>
            <ul class="nav">
                <li><a href="login.html">退出</a></li>
            </ul>
        </div>
        <!-- navMenu -->
    </div>

    <div id="leftside">
        <div id="sidebar">
            <div class="toggleCollapse"><h2>主菜单</h2>
                <div>收缩</div>
            </div>

            <div class="accordion" fillSpace="sidebar">
                <div class="accordionHeader">
                    <h2><span>Folder</span>功能</h2>
                </div>
                <div class="accordionContent">
                    <ul class="tree treeFolder">
                        <li><a href="javascript:void(0);" target="navTab">推荐管理</a>
                            <ul>
                                <li><a href="/admin/resourceManage.html?categoryId=1" target="navTab" external="true" rel="temp_1">好书推荐</a></li>
                                <li><a href="/admin/resourceManage.html?categoryId=2" target="navTab" external="true" rel="temp_2">精品课程</a></li>
                                <li><a href="/admin/resourceManage.html?categoryId=3" target="navTab" external="true" rel="temp_3">有声读物</a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0);">图片管理</a>
                            <ul>
                                <li><a href="/admin/carouselManage.html" target="navTab" external="true" rel="boxId_2-1">轮播图管理</a></li>
                                <li><a href="/admin/logoManage.html" target="navTab" external="true" rel="boxId_2-2">LOGO管理</a></li>
                            </ul>
                        </li>

                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div id="container">
        <div id="navTab" class="tabsPage">
            <div class="tabsPageHeader">
                <div class="tabsPageHeaderContent"><!-- 显示左右控制时添加 class="tabsPageHeaderMargin" -->
                    <ul class="navTab-tab">
                        <li tabid="main" class="main"><a href="javascript:;"><span><span class="home_icon">主页</span></span></a></li>
                    </ul>
                </div>
                <div class="tabsLeft">left</div><!-- 禁用只需要添加一个样式 class="tabsLeft tabsLeftDisabled" -->
                <div class="tabsRight">right</div><!-- 禁用只需要添加一个样式 class="tabsRight tabsRightDisabled" -->
                <div class="tabsMore">more</div>
            </div>
            <ul class="tabsMoreList">
                <li><a href="javascript:;">主页</a></li>
            </ul>
            <div class="navTab-panel tabsPageContent layoutBox">
                <div class="page unitBox">
                    <div class="accountInfo">
                        <p><span>文化盒子后台管理系统</span></p>
                    </div>
                    <div class="pageFormContent" layoutH="80" style="margin-right:230px">
                    </div>

                </div>

            </div>
        </div>
    </div>

</div>
</body>
</html>
<script>
    var categoryId;

    function changeCategory(id) {
        categoryId = id;
    }
</script>