$(window).resize(function(){
$('#tt').datagrid('resize', {
width:function(){return document.body.clientWidth;},
height:function(){return document.body.clientHeight;},
});
});
