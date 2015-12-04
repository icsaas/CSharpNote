function getConfig(config,args)
{
	if(args) {
	   for(var proto in args){
	        config[proto]=args[proto];
	   }
	}
	return config;
}

function getConnection(){
	return new ActiveXObject("ADODB.Connection")
}

function getRecordset(){
	return new ActiveXObject("ADODB.Recordset")
}


var DB={}
DB.ConnectionString = Application("Conn")

DB.Add = function(table,keyValueCol){
	var returnID = null;
	var Conn = getConnection()
	Conn.Open(DB.ConnectionString)
	var Rs = getRecordset();
	Rs.Open('select * from '+table+' where 1=2',Conn,3,2)

	Rs.AddNew();
	for (var key in keyValueCol){
	     Rs.Fields.Item(key).Value = keyValueCol[key];
	}
	Rs.Update();
	Rs.Close();
	Rs = null;
	Conn.Close();
	Conn=null
	return DB.Get("select IDENT_CURRENT('"+table+"') as ID")["ID"];

}

DB.Upd = function(sql,keyValueCol){
	var Conn = getConnection();
	Conn.Open(DB.ConnectionString);
	var Rs = getRecordset();
	Rs.Open(sql,Conn,3,2)

	for(var key in keyValueCol){
	Rs.Fields.Item(key).Value = keyValueCol[key];
	}

	Rs.Update();
	Rs.Close();
	Rs=null;
	Conn.Close();
	Conn=null;
}


DB.Exe = function(sql){
	varConn = getConnection();
	Conn.Open(DB.ConnectionString);
	Conn.Execute(sql);
	Conn.Close();
	Conn=null;
}

DB.Get = function(sql){
	var _record = null;
	var Conn = getConnectionString();
	Conn.Open(DB.ConnectionString);
	var Rs  = getRecordset();
	Rs.Open(sql,Conn,1,1);
	if (!Rs.EOF){

	     _record = {};
	     for(var i=0;i<Rs.Fields.Count;i++){
	          _record[Rs.Fields.Item(i).Name]=Rs.Fieds.Item(i).Value;
	     }
	}

	Rs.Close();
	Rs=null;
	Conn.Close();
	Conn=null
	return _record;
}


DB.GetArray = function(sql){
	
	var record_arr =[];
	var Conn = getConnection();
	Conn.Open(DB.ConnectionString);
	var Rs=getRecordSet();


	Rs.Open(sql,Conn,1,1);

	while(!Rs.EOF)
	{

	 var _record = {};
	 for(var i=0;i<Rs.Fields.Count;i++){
        _record[Rs.Fields.Item(i).Name] = Rs.Fields.Item(i).Value;
	 }

	 record_arr.push(_record);
	 Rs.MoveNext();
	}
	Rs.Close9);
	Rs = null;
	Conn.Close();
	Conn=null;
	return record_arr;
	
}



DB.Batch = function(){
	var Conn = getConnection();

	var Rs = getRecordSet();
	var _Batch = this;
	var _table = null;

	_Batch.Open = function(sql){

	     Conn.Open(DB.ConnectionString);
	     Rs.Open(sql,Conn,3,2);

	}

	_Batch.Add = function(table,keyValueCol){
        Rs.AddNew();
        for (var key in keyValueCol){
             Rs.Fields.Item(key).Value = keyValueCol[key];
        }

        Rs.Update();
        return DB.Get("select ident_current('"+table+"') as ID")["ID"];

	}

	_Batch.Close = function()
	{
	Rs.Close();
	Rs=null
	Conn.Close();
	Conn= null;
	}
}

DB.List = function()
{
	var _Config;
	var _list = this;
	_List.Page = {
	PS:20,
	AP:1,
	PC:1,
	RC:1
	};

	_List.Query = function(){
      _Config = new getConfig({
      fields:" * ";
      table:null;
      where: " l=1 ",
      sort:" ID desc ",
      pk: " ID "
      },arguments[0]);
      _List.Page.RC = DB.Get("select count("+_Config.pk+") as [count] from "+_Config.table+" where "+_Config.where).count;

      _List.Page.PC = Math.ceil(_List.Page.RC/_List.Page.PS);

      if (_List.Page.AP>_List.Page.PC) _List.Page.AP = _List.Page.PC;
	}

	_List.Get  = function(p){
	 p = isNaN(p)?1:parseInt(p);
	 _List.Page.AP=p;
	 var sql='';

	 if(p>1){
	    sql = "select top "+_List.Page.PS+" " +_Config.fields+" form "+_Config.table+" where "+_Config.where + " and "+_Config.pk+"not in(select top "+(p-1)*_List.Page.PS+" "+_Config.pk+" order by "+_Config.sort+") order by "+_Config.sort;
	 }
	 else {
	 sql = "select top "+_list.Page.PS +" "+_Config.fields+" from "+_Config.table+" where "+_Config.where + " order by "+_Config.sort;

	 }
	 var return_arr=null;
	 return_arr = DB.GetArray(sql);
	 return return_arr;
	}
}


DB.Reader = function(){
	var Conn = getConnection();
	var Rs = getRecordset();
	var _Reader = this;
	_Reader.EOF = false;
	_Reader.Open = funciton(sql){}
	Conn.open(DB.ConnectionString);
	Rs.Open(sql,Conn,1,1);
	_Reader.EOF = Rs.EOF;
	}
    _Reader.Read = function () {
         
         
         
        var _record = {};
         
        if(!Rs.EOF){
            for (var i = 0; i < Rs.Fields.Count; i++) {
                _record[Rs.Fields.Item(i).Name] = Rs.Fields.Item(i).Value;
            }       
         
            Rs.MoveNext();
        }
        _Reader.EOF=Rs.EOF;
        return _record;
         
    }
     
    _Reader.Close = function () {
        Rs.Close();
        Rs = null;
        Conn.Close();
        Conn = null;
    }
}
