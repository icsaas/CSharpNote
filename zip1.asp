<%
'main文件夹中包含cmd.exe rar.exe例如:要压缩的文件(*.mdb)
'压缩后的存放目录为main/data.rar
on error resume next
unzip_path = Server.mappath("main")&"/"
Set WshShell = server.CreateObject("Wscript.Shell")
IsSuccess = WshShell.Run("winrar a "&unzip_path&"data"&unzip_path&"*.mdb",1,False)
'WinRAR <命令> -<开关1> -<开关N> <压缩文件> <文件...><@列表文件...>
'<解压路径/>
'命令:A -添加到压缩文件中
if IsSuccess = 0 Then 
Response.write "命令执行成功！"
else 
Response.Write "命令执行失败！权限不够或者改程序无法运行"
end if
if err.number <> 0 then 
Response.Write "<p>错误号码："&Err.number
Response.Write "<p>原因:"&Err.description
Response.Write "<p>错误来源:"&Err.Source
Response.Write
endif
%>
