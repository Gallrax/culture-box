<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/10
  Time: 14:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>当前logo :</h1>
<img src="/datas/logo/${_logo}"/><br/>
<h1>替换logo :</h1>
<form id="logoForm"  enctype="multipart/form-data">
    <input id="tempFile" type="file" name="file" onchange="imgPreview(this)"/>
    <input type="button" value="提交" onclick="sub()"/>
</form>
<img id="tempImg"/>
</body>
</html>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/mine.js"></script>
<script>

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
            var formData = new FormData($("#logoForm")[0]);
            $.ajax({
                url : "/changeLogo",
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
