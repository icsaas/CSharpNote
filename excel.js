//导出到excel
function AutomateExcel(tableid){
var elTable = document.getElementById(tableid); //要导出的table id。
var oRangeRef = document.body.createTextRange(); 
oRangeRef.moveToElementText(elTable); 
oRangeRef.execCommand("Copy");
var appExcel = new ActiveXObject("Excel.Application");
appExcel.Workbooks.Add().Worksheets.Item(1).Paste(); 
appExcel.Visible = true; 
appExcel = null;
}
//导出到word
//指定页面区域内容导入Word
function AllAreaWord(tableid)
{
var elTable = document.getElementById(tableid); 
var sel = document.body.createTextRange();
sel.moveToElementText(elTable);
sel.execCommand("Copy");
var oWD = new ActiveXObject("Word.Application");
var oDC = oWD.Documents.Add("",0,1);
var orange =oDC.Range(0,1);
//sel.select();
orange.Paste();
oWD.Application.Visible = true;
oWD = null;
}

<input name="word" type="button" value="导出到word" onclick="AllAreaWord('tableid');" /> 
<input name="excel" type="button" value="导出到excel" onclick="AutomateExcel('tableid');"/>