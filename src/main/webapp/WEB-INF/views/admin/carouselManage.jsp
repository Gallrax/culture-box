<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/12
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>
    <h1>当前轮播图个数 : ${_carouselSize}</h1>
    <h1>设置轮播图个数 :
        <select id="carousel_size">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
        </select>
        <input type="button" value="提交" onclick="changeSize()"/>
    </h1>
    <br>
</div>
<table border="1" width="98%" style="text-align: center">
    <thead>
    <tr>
        <th>序号</th>
        <th>轮播图</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody id="series_list">

    </tbody>
</table>
<div>
    <h1>推送轮播图 : </h1>
    <form id="carouselForm"  enctype="multipart/form-data">
        <input id="tempFile" type="file" name="file" onchange="imgPreview(this)"/>
        <input type="button" value="提交" onclick="sub()"/>
    </form>
    <img id="tempImg"/>
</div>
</body>
</html>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/mine.js"></script>
<script>

    var size = ${_carouselSize};

    $(function () {
        getCarousel();
    });

    //获取轮播图
    function getCarousel() {
        var url = "/carousel/getByPage";
        var result = jsGet(url, null);
        var obj = $.parseJSON(result);
        var tempStr = "";
        for (var i in obj) {
//            tempStr += "<div class=\"swiper-slide\"><img src=\"" + obj[i].image + "\" height=100% width=100%/></div>";
            tempStr += "<tr><td>" + (parseInt(i) + 1) + "</td><td><img src=\"" + obj[i].image + "\" width=\"300px\"></td><td><input type=\"button\" value=\"删除\" onclick=\"deleteCarousel(" + obj[i].id + ")\"/></td></tr>"
        }
        $("#series_list").append(tempStr);
    }

    //更改轮播图数量
    function changeSize() {
        var size = $("#carousel_size").val();
        $.ajax({
            url: "/carousel/changeSize",
            type: "get",
            data: "size=" + size,
            success: function (data) {
                var result = $.parseJSON(data);
                if (result == "success") {
                    location.reload();
                } else {
                    alert("操作异常");
                }
            }
        })
    }

    //删除某轮播图
    function deleteCarousel(id) {
        $.get("/carousel/delete/" + id, function (data) {
            if($.parseJSON(data) == "success") {
                alert("删除成功");
                location.reload();
            }else {
                alert("操作异常");
            }
        })
    }

    //上传图片预览
    function imgPreview(fileDom) {
        //判断是否支持FileReader
        if (window.FileReader) {
            var reader = new FileReader();
        } else {
            alert("您的设备不支持图片预览功能，如需该功能请升级您的设备！");
        }

        //获取文件
        var file = fileDom.files[0];
        var imageType = /^image\//;
        //是否是图片
        if (!imageType.test(file.type)) {
            alert($("#tempFile").val(null));
            alert("请选择图片！");
            return;
        }
        //读取完成
        reader.onload = function (e) {
            //获取图片dom
            var img = document.getElementById("tempImg");
            //图片路径设置为读取的图片
            img.src = e.target.result;
        };
        reader.readAsDataURL(file);
    }

    //提交
    function sub() {
        var judge = $("#tempFile").val() == null || $("#tempFile").val() == "";
        if(judge) {
            alert("请添加图片");
            return false;
        }else {
            var formData = new FormData($("#carouselForm")[0]);
            $.ajax({
                url : "/carousel/add",
                type : "post",
                data : formData,
                contentType: false,
                processData: false,
                success : function(data) {
                    location.reload();
                }
            })
        }
    }

</script>

