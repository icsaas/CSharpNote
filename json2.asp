<!--#include file="Mo.Lib.Json.asp"-->
<%
Dim My,Com2,Com3,Com4,Com5,Str
Set My = MoLibJson.new()
'My.datatype="array"  '默认是object，返回的字符串用{}键值对，如果设置为array，则返回数组
My.dateformat = "yyyy-MM-dd HH:mm:ss"
My.put "name","anlige"
My.put "age",27
My.put "birthday",#1986-9-2 21:45:23#
My.put "boy",true

'put总是为当前节点增加子元素，如果第二个参数留空，则返回子元素的json对象，否则返回一个object对象-有两个属性：key、value（基本无用处）
Set lessons = My.put("lessons") 
lessons.put "chinese",87
lessons.put "english",65
lessons.put "math",99

'puttarray方法添加一个类型为array的子节点
Set teachers = My.put("teachers")
teachers.datatype="array"
teachers.dateformat="yyyy-MM-dd"
Set teacher = teachers.put()	'因为teachers是一个array对象，所以这里的put可以省略键值
teacher.put "name","chinese"
teacher.put "age",31
teacher.put "birthday",#1973-9-2 21:03:23#
teacher.put "students",array("anlige","lilith","malier"),"vbarray"	'等价于teacher.putvbarray "students",array("anlige","lilith","malier")
teacher.put "classes","三年1班,四年2班","arraylist"
Set teacher = teachers.put()
teacher.put "name","english"
teacher.put "age",37
teacher.put "birthday",#1963-9-12 21:03:23#
teacher.put "students",array("anlige","join","lucy"),"vbarray"
teacher.put "classes","三年2班,四年1班","arraylist"

'支持dictionary对象直接附加，意义不大，因为在这里My.put("information")就可以返回一个json对象，用json对象的put方法可以直接替换dictionary的add方法
'也就是说，下面的三行完全可以替代后面用dictionary的那4行
'Set Com4 = My.put("information")
'Com4.put "from","China"
'Com4.put "address","杭州"

Set Com5 = Server.CreateObject("scripting.dictionary")
Com5.add "from","China"
Com5.add "address","杭州"
Set Com4 = My.put("information",Com5,"dictionary")

'这里再为子元素information增加一个子元素，注意Com4是上面的返回值
Set Com2 = Com4.put("other")
Com2.put "mother","marry"
Com2.put "father","join"
Response.Write My.toString()
%>