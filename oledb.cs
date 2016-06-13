           private void city(int cityMode)
           {
                   int cityRowNum = cityDt.Rows.Count;
                   int cityColumnNum = cityDt.Columns.Count;
                  for (int i = 0; i < cityRowNum; i++)
                 {
                         if (i % 5 == cityMode)  fileOutOleDb(i);
                 }            
                 this.Close();
           }
         2.4、读取需要导出的城市的用户记录数

          private int  findUserCount(int cityId)

         {

                  读取数据库数据

        }

        2.5、读取相应页的用户数

        private DataTable findUser(int cityId,int int skipNum)

        {

              return DataTable("select * from user where id="+cityId.toString()+" limit "+skipNum.tostring+",1000");

        }

       2.6、导出Excel文件处理

 

        private void fileOutOleDb(int i)
        {
            int city_id = Convert.ToInt32(cityDt.Rows[i][0]);
            string city_ename = cityDt.Rows[i]["ename"].ToString();
            string city_name = cityDt.Rows[i]["ename"].ToString();
            int userCount = findUserCount(city_id);
            int pageCount = userCount / 1000;
            if (pageCount * 1000 < userCount) userCount += 1;
            int beginPageNo = 1;// Convert.ToInt32(textBox3.Text);
            int endPageNo = pageCount;// Convert.ToInt32(textBox4.Text);
            string curDirectory = fileOutFolder + "\\" + city_name;
            if (!Directory.Exists(curDirectory))
            {
                Directory.CreateDirectory(curDirectory);
            }

            for (int j = beginPageNo; j <= endPageNo; j++)
            {
                textBox2.Text = j.ToString();
                try
                {
                    //1、读出数据
                    DataTable tempdt = findUser(Convert.ToInt32(cityDt.Rows[i][0]), j * 1000);
                    //判断文件是否存在，不存在则拷贝一个文件
                    string fileFullName = curDirectory + "\\" + city_name + "_" + j.ToString() + ".xls";
                    if (!File.Exists(fileFullName))
                    {
                        File.Copy("d:\\model.xls", fileFullName);
                    }

                    //2、得到连接对象
                    string strCon = string.Format(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties='Excel 12.0;HDR=YES;IMEX=0'", fileFullName);
                    OleDbConnection myConn = new OleDbConnection(strCon);
                    string strCom = "SELECT * FROM [Sheet1$]";
                    myConn.Open();
                    OleDbDataAdapter myDataAdapter = new OleDbDataAdapter(strCom, myConn);
                    DataSet myDataSet = new DataSet();
                    myDataAdapter.Fill(myDataSet, "[Sheet1$]");
                    myConn.Close();
                    DataTable dt = myDataSet.Tables[0]; //初始化DataTable实例
                    dt.PrimaryKey = new DataColumn[] { dt.Columns["id"] };//创建索引列

                    int rowNum = tempdt.Rows.Count;
                    int colNum = tempdt.Columns.Count;
                    for (int k = 0; k < rowNum; k++)
                    {
                        DataRow myRow = dt.NewRow();
                        for (int m = 0; m < colNum; m++) myRow[m] = tempdt.Rows[k][m];
                        dt.Rows.Add(myRow);
                    }
                    OleDbCommandBuilder odcb = new OleDbCommandBuilder(myDataAdapter);
                    odcb.QuotePrefix = "[";   //用于搞定INSERT INTO 语句的语法错误
                    odcb.QuoteSuffix = "]";

                    myDataAdapter.Update(myDataSet, "[Sheet1$]"); //更新数据集对应的表
                }
                catch
                {
                }
                if (j == pageCount) break;
                //System.Threading.Thread.Sleep(1000);
            }
        }
