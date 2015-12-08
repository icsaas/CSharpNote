<%
Dim a,b,Main,Shell,Running,RunCode,Cmd,comm,fso
Main = "d:\chengcheng\rar\"  '上传后winrar.exe和cmd.exe的路径
d = Server.mappath("rar")&"\"  '解压rar文件后的存放路径
b = Server.mappath("rar\homepage.rar") '要解压的rar文件，把其中homepage.rar修改为需要解压缩的文件
Set Shell = Server.CreateObject("WScript.Shell")
Running = "d\chengcheng\rar\cmd.exe /c "&Main&"Winara.exe x -t -o+ -p- " '设置运行解压缩的命令
Cmd = Run&b&""&a
Runcode = Shell.Run(Cmd,1,True)
%>
