var IE_Ver = UA.match(/MSIE (\d)\.\d/i);
IE_Ver = IE_Ver ? Number(IE_Ver[1]) : 0;

function $TN(HTML_Elements, TagName) {
    return HTML_Elements.getElementsByTagName(TagName);
}
function PagePath_IE(_BOM) {
    var _PP = _BOM.document.URL;
    _PP = _PP.split('/');
    if (_PP.length > 3) _PP.pop();
    _PP.push('');
    return _PP.join('/');
}

try {
    var _DOM = parent.document;
    var _SE = $TN($TN(_DOM, 'head')[0], 'script');

    for (var i = 2, JS_URL; i < _SE.length; i++) {
        JS_URL = _SE[i].src;
        if (IE_Ver < 8)
        JS_URL = PagePath_IE(parent) + JS_URL;
        ImportJS(JS_URL);        //  自定义的 <script /> 元素创建函数
    }
} catch (Err) {}
