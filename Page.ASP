function Page(p, pc, size, prefix, suffix) {
    var args = arguments;
    p = args[0] || 1;
    pc = args[1] || 1;
    size = args[2] || 5;
    prefix = args[3] || '';
    suffix = args[4] || '';
     
    p < 1 ? p = 1 : p;
    p > pc ? p = pc : p;
    size > pc ? size = pc : size;
     
    this.getCode = function (cssNormal, cssSelect) {
        var code = "";
        if (pc <= size) {
            for (var i = 1; i <= pc; i++) {
                if (i == p) {
                    code += ' <span' + (cssSelect ? ' class="' + cssSelect + '"' : '') + '>' + i + '</span> ';
                } else {
                    code += ' <a' + (cssNormal ? ' class="' + cssNormal + '"' : '') + ' href="' + prefix + i + suffix + '">' + i + '</a> ';
                }
            }
        } else {
             
            var minx = (size / 2).toFixed(0);
            var sinx = p - minx + 1;
            sinx = (sinx > 1 ? sinx : 1); //开始
            einx = (pc + 1 > sinx + size ? sinx + size : pc + 1); //结束
             
             
            for (var i = sinx; i < einx; i++) {
                if (i == p) {
                    code += ' <span' + (cssSelect ? ' class="' + cssSelect + '"' : '') + '>' + i + '</span> ';
                } else {
                    code += ' <a' + (cssNormal ? ' class="' + cssNormal + '"' : '') + ' href="' + prefix + i + suffix + '">' + i + '</a> ';
                }
            }
        }
         
        return code;
    }
     
    this.getPrev = function (css) {
        return p > 1 ? '<a' + (css ? ' class="' + css + '"' : '') + ' href="' + prefix + (p - 1) + suffix + '">上一页</a>' : '';
    }
     
    this.getNext = function (css) {
        return p < pc ? '<a' + (css ? ' class="' + css + '"' : '') + ' href="' + prefix + (p + 1) + suffix + '">下一页</a>' : '';
    }
}