<%@LANGUAGE="JAVASCRIPT" CODEPAGE="936"%>
<!--#include file="DB.asp"-->
<!--#include file="Page.asp"-->
<table>
<%
var p=new String(Request.QueryString("p"));
 
var list=new DB.List();
list.Query({table:'ttable',fields:'[id],[title],[idnum]',sort:'id asc'});
 
 
var data=list.Get(p);
 
for(var i=0;i<data.length;i++)
{
%>
<tr>
<td><%=data[i]["id"]%></td>
<td><%=data[i]["title"]%></td>
<td><%=data[i]["idnum"]%></td>
</tr>
<%
}
var page=new Page(list.Page.AP,list.Page.PC,11,'?p=');
%>
<tr>
<td colspan="3">
<%=page.getPrev()%>
<%=page.getCode()%>
<%=page.getNext()%>
共 <%=list.Page.RC%> 条
共 <%=list.Page.PC%> 页
</td>
</tr>
</table>