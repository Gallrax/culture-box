function jsGet(url, fields) {
    var result;
    $.ajax({
        url: url,
        data: fields,
        type: "get",
        async: false,
        success: function (e) {
            result = e;
        }
    });
    return result;
}

function getUrlParamer(key) {
    var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null)return unescape(r[2]);
    return null;
}

function jsLike(value) {
    return "%" + value + "%";
}

function ifyAndEnc(obj) {
    eq = JSON.stringify(obj);
    var s = encodeURI(encodeURI(eq));
    return s;
}

function autoReplaceImage(src, temp) {
    return src == null || src == "" ? temp : src;
}

function isEmpty(value) {
    return value == null || value == "";
}
