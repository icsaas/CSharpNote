<%
'main文件夹中包含cmd.exe rar.exe 要解压缩的文件（*.rar)
'解压缩后的存放目录为main
on error resume next
 unzip_path = Server.mappath("main")&"/"
 Set WshShell = server.CreateObject("Wscript.Shell")
 IsSuccess = WshShell.run("winrar x -r -o+ "&unzip_apth&"*.rar"&unzip_path&"",1,False)
 '命令x- 从压缩文件中全路径解压文件
 '开关 R-连同子文件夹
 '开关:O+-覆盖已经存在的文件
 '开关:O-不覆盖已经存在的文件
 if IsSuccess =0 Then
 Response.Write("命令执行成功！")
 else
 Response.Write("命令执行失败，权限不够或者改程序无法运行")
 end if
 if err.number<> 0 then
 Response.Write("<p>错误号码："&Err.number)
 Response.Write("<p>原因:"&Err.description)
 Response.Write("<p>错误来源："&Err.Source)
 Response.Write
 end if