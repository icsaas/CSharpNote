using  System;
using System.Data;
using System.Data.SqlClient;


namespace TransferData
{
	class NewTransferDB
	{
	public DataTable SqlClientTest(){
	     string conStr = "server=WJD-PC\\SQLEXPRESS;database = TrnsferTempDB;uid = sa;pwd=123654";
	     string sql = 'select * from srcTable';

	     DataTable dt = null;

	     SqlConnection con = new SqlConnection();
	     conn.ConnectionString = constr;

	     try
	     {
	         conn.Open();
	         SqlCommand cmd = new SqlCommand(sql,conn);
	         SqlDataReader dr = cmd.ExecuteReader();

	         dt = ConvertDRToDT(dr);
	         dr.Close();
	     }
	     catch (Exception ex)
	     {
	     Console.WriteLine("error: "+ex.ToString());
	     }
	     return dt;
	}

	private DataTable ConvertDRToDT(SqlDataReader dr){
	      DataTable dt = new DataTable();

	      for (int i = 0;i<dr.FieldCount;i++){
	          //
	          DataColumn dc = new DataColumn();
	          dc.DataType = dc.GetFieldType(i);
	          dc.ColumnName = dr.GetName(i);

	          dt.Columns.Add(dc);
	      }

	      while (dr.Read()){
	          DataRow datarow = dt.NewRow();
	          for (int i = 0;i<dr.FieldCount;i++){
	              datarow[i] = dr[i];
	          }
	          dt.Rows.Add(datarow);
	      }
	      return dt;
	}

	}
}