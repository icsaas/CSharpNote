<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="json.asp"-->
<!--#include file="inc/Conn.asp" -->
<%
response.ContentType="text/json"
dim j

'多重嵌套的JSON,要使用Dictionary才能实现
set j=new json
j.toResponse=false
set r=server.createobject("scripting.dictionary")
set b=server.createobject("scripting.dictionary")
set c=server.createobject("scripting.dictionary")
c.add "x",5
c.add "y",6
c.add "z",11
b.add "event","Mouse Click"
b.add "data",c
r.add "success",true
r.add "result",b
a=j.toJSON(empty,r,false)
response.write a

'记录集转为Json
set i=new json
i.toresponse=false
set rs=server.CreateObject("adodb.recordset")
sqlstr="select top 5 * from producttype"
rs.open sqlstr,conn,0,1
v=i.toJson("result",rs,false)
rs.close
response.write v
%>

"""$(function (){
     $.ajax({
         url:"json.asp",
         dataType:'json',
         async:true, 
         type:'get',
         success:function(data){
           alert(data.a);
         },
         error:function(XMLHttpRequest, textStatus, errorThrown) {
           alert(errorThrown);
         }});
})"""
<%
username="tom"
sex="男"
age="18"
'response.write "姓名："+username +"<br/>"+"性别："+sex +"<br/>"+"年龄："+age
response.write "{""a"":" & username & ",""b"":" & sex & ",""c"":" & age & "}"
%>


