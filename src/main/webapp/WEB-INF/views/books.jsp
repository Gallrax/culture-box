<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no" />
		<!--禁止缓存-->
		<meta http-equiv="pragma" content="no-cache"/>
		<meta http-equiv="cache-control" content="no-cache" />
		<!--设定网页的到期时间--> 
		<meta http-equiv="expires" content="0"/>
	    <title></title>
	    <link rel="stylesheet" href="static/css/reset.css" />
		<link rel="stylesheet" href="static/css/mui.min.css">
		<link rel="stylesheet" href="static/css/books.css" />
	</head>
	<body>
		<header class="mui-bar mui-bar-nav">
			<div class="backBox">
				<a onclick="window.history.back();"><img src="static/image/arrow-blue-left.png"/><span>返回</span></a>
				<p class="title">书城</p>
				<img src="static/image/home.png" onclick="location.href = '/'"/>
			</div>
			<div class="searchBox">
				<input type="text" placeholder="请输入名称或讲师" />
				<img src="static/image/search.png" />
			</div>
		</header>
		
		<div class="mui-content">
			<div id="slider" class="mui-slider mui-fullscreen">
				<div id="sliderSegmentedControl" class="mui-scroll-wrapper mui-slider-indicator mui-segmented-control mui-segmented-control-inverted">
					<div class="mui-scroll">
						<a class="mui-control-item mui-active" href="#item1mobile">艺术</a>
						<a class="mui-control-item" href="#item2mobile">经济</a>
						<a class="mui-control-item" href="#item3mobile">历史</a>
						<a class="mui-control-item" href="#item4mobile">心理</a>
						<a class="mui-control-item" href="#item5mobile">文学</a>
						<a class="mui-control-item" href="#item6mobile">社会</a>
					</div>
				</div>
				<div class="mui-slider-group">
					<div id="item1mobile" class="mui-slider-item mui-control-content mui-active">
						<div id="scroll1" class="mui-scroll-wrapper">
							<div class="mui-scroll">
								<ul class="mui-table-view">
									
									<li class="book-list-wrap">
										<img class="fl book-list-img" src="static/image/pic02.png"/>
										<div class="fl book-list-content">
											<p class="word">故事新编：插图本</p>
											<p class="word">鲁迅著</p>
										</div>
										<span class="fr">阅读</span>
									</li>
									<li class="book-list-wrap">
										<img class="fl book-list-img" src="static/image/pic02.png"/>
										<div class="fl book-list-content">
											<p class="word">故事新编：插图本</p>
											<p class="word">鲁迅著</p>
										</div>
										<span class="fr">阅读</span>
									</li>
									<li class="book-list-wrap">
										<img class="fl book-list-img" src="static/image/pic02.png"/>
										<div class="fl book-list-content">
											<p class="word">故事新编：插图本</p>
											<p class="word">鲁迅著</p>
										</div>
										<span class="fr">阅读</span>
									</li>
									
								</ul>
							</div>
						</div>
					</div>
					<div id="item2mobile" class="mui-slider-item mui-control-content">
						<div class="mui-scroll-wrapper">
							<div class="mui-scroll">
								<ul class="mui-table-view">
									
								</ul>
							</div>
						</div>
					</div>
					<div id="item3mobile" class="mui-slider-item mui-control-content">
						<div class="mui-scroll-wrapper">
							<div class="mui-scroll">
								<ul class="mui-table-view">
									
								</ul>
							</div>
						</div>
					</div>
					<div id="item4mobile" class="mui-slider-item mui-control-content">
						<div class="mui-scroll-wrapper">
							<div class="mui-scroll">
								<ul class="mui-table-view">
									
								</ul>
							</div>
						</div>
					</div>
					<div id="item5mobile" class="mui-slider-item mui-control-content">
						<div class="mui-scroll-wrapper">
							<div class="mui-scroll">
								<ul class="mui-table-view">
									
								</ul>
							</div>
						</div>
					</div>
					<div id="item6mobile" class="mui-slider-item mui-control-content">
						<div class="mui-scroll-wrapper">
							<div class="mui-scroll">
								<ul class="mui-table-view">
									
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script src="static/js/mui.min.js"></script>
		<script src="static/js/mui.pullToRefresh.js"></script>
		<script src="static/js/mui.pullToRefresh.material.js"></script>
		<script>
			mui.init();
			(function($) {
				//阻尼系数
//				var deceleration = mui.os.ios?0.003:0.0009;
				$('.mui-scroll-wrapper').scroll({
					bounce: false,
					indicators: true, //是否显示滚动条
//					deceleration:deceleration
				});
				$.ready(function() {
					//循环初始化所有下拉刷新，上拉加载。
					$.each(document.querySelectorAll('.mui-slider-group .mui-scroll'), function(index, pullRefreshEl) {
						$(pullRefreshEl).pullToRefresh({
							down: {
								callback: function() {
									var self = this;
									setTimeout(function() {
										var ul = self.element.querySelector('.mui-table-view');
										ul.insertBefore(createFragment(ul, index, 6, true), ul.firstChild);
										self.endPullDownToRefresh();
									}, 1000);
								}
							},
							up: {
								callback: function() {
									var self = this;
									setTimeout(function() {
										var ul = self.element.querySelector('.mui-table-view');
										ul.appendChild(createFragment(ul, index, 6));
										self.endPullUpToRefresh();
									}, 1000);
								}
							}
						});
					});
					var createFragment = function(ul, index, count, reverse) {
//						var length = ul.querySelectorAll('a').length;
//						var fragment = document.createDocumentFragment();
//						var li;
//						var liHtml='';
//						for (var i = 0; i < count; i++) {
//							li = document.createElement('a');
//							li.innerHTML='<img class="fl book-list-img" src="img/pic02.png"/><div class="fl book-list-content"><p class="word">故事新编：插图本</p><p class="word">鲁迅著</p></div><span class="fr">阅读</span>'
//							fragment.appendChild(li);
//						}
//						return fragment;
						alert(1)
					};
				});
			})(mui);
		</script>
	</body>

</html>
