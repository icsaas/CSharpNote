Function downloadFile(strFile) 
strFilename = server.MapPath(strFile) 
Response.Buffer = True 
Response.Clear 
Set s = Server.CreateObject("ADODB.Stream") 
s.Open 
s.Type = 1 
on error resume next 
Set fso = Server.CreateObject("Scripting.FileSystemObject") 
if not fso.FileExists(strFilename) then 
Response.Write("<h1>Error:</h1> 文件不存在<p>") 
Response.End 
end if 
Set f = fso.GetFile(strFilename) 
intFilelength = f.size 
s.LoadFromFile(strFilename) 
if err then 
Response.Write("<h1>Error: </h1>" & err.Description & "<p>") 
Response.End 
end if 
Response.AddHeader "Content-Disposition", "attachment; filename=" &f.name
Response.AddHeader "Content-Length", intFilelength
Response.CharSet = "UTF-8" 
Response.ContentType = "application/octet-stream" 
Response.BinaryWrite s.Read 
Response.Flush 
s.Close 
Set s = Nothing 
End Function 