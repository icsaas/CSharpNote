<%
'建立Excel.Application对象'
set objExcel = CreateObject("Excel.Application")

'打开Excel模板'
objExcel.Workbooks.Open(server.mappath("\test")&"\book1.xlt") '打开Excel模板'
objExcel.Sheets(1).select  '选中工作页'
set sheetActive = objExcel.ActiveWorkbook.ActiveSheet


'Excel 常规添加操作'
sheetActive.range("g4").value = date()  '添加时间'
%>
