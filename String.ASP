String.prototype.htmlEntity = function () {
    html = this
        .replace(/\&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#39;");
    return html;
}
 
//实体 转换为 html
String.prototype.entityHtml = function () {
    entity = this
        .replace(/\&amp;/g, "&")
        .replace(/\&lt;/g, "<")
        .replace(/\&gt;/g, ">")
        .replace(/\&quot;/g, '"')
        .replace(/\&#39;/g, "'");
    return entity;
}
 
String.prototype.Trim=function(){
    return this.replace(/(^\s*)|(\s*$)/g, ""); 
}
 
String.prototype.toSafeSQL=function(){
    return this.replace(/'/g,"''")
}
 
String.prototype.Left=function(num){
    if(this.length<=num){
        return this;
    }else{
        return this.substr(0,num-1);
    }   
}