 long totalRows = dt.Rows.Count;

            // 1.b 向上取整得到共需要多少个sheet页存放数据
            int sheetsCount = int.Parse(Convert.ToString(Math.Ceiling((decimal)totalRows / (decimal)EXCEL_MAX_LINE)));

            // 1.d 定义workSheet,
            Worksheet workSheet;
            string workSheetName = "Sheet";
            bool IsDataWriteTemplate = false;

            //2.循环写入数据
            for (int i = 0; i < sheetsCount; i++)
            {
                // (1)模板+第一页
                if (iSheetStart > 0 && i == 0)
                {
                    workSheet = workBook.Worksheets[iSheetStart - 1];
                    // 获取当前的Sheet名称
                    workSheetName = workSheet.Name;

                    // 写入模板
                    IsDataWriteTemplate = true;

                }
                // (2)模板 + 第N页(N>1)
                else if (iSheetStart > 0 && i > 0)
                {
                    workBook.Worksheets.Add(workSheetName + i.ToString());

                    workSheet = workBook.Worksheets[workSheetName + i.ToString()];
                    workSheet.AutoFitColumns();
                    // 拷贝第一行数据(即为行标题)
                    workSheet.Cells.CopyRow(workBook.Worksheets[iSheetStart - 1].Cells, 0, 0);

                    // 写入模板
                    IsDataWriteTemplate = true;

                }
                // (3) 非模板 
                else
                {
                    try
                    {
                        //workBook.Worksheets.Clear();
                        if (workBook.Worksheets[workSheetName + (i + 1).ToString()] == null)
                        {
                            workBook.Worksheets.Add(workSheetName + (i + 1).ToString());
                        }
                    }
                    catch
                    {

                    }
                    workSheet = workBook.Worksheets[workSheetName + (i + 1).ToString()];
                    workSheet.AutoFitColumns();
                    // 写入模板 
                    IsDataWriteTemplate = false;
                }

                // 2.b 列索引,行索引,总列数,总行数
                int colIndex = 0;
                int RowIndex = 0;

                int colCount = dt.Columns.Count;
                int RowCount;

                // 2.c 如果dt的总行数比Excel最后一页最后一笔数据的行号要小
                if (dt.Rows.Count < (i + 1) * EXCEL_MAX_LINE)
                {
                    RowCount = dt.Rows.Count;
                }
                else
                {
                    RowCount = (i + 1) * EXCEL_MAX_LINE;
                }

                // 2.d 相关数据
                // 创建数据缓存
                object[,] objData;

                // 列
                int j;

                // 需要写入EXCEL的其实行
                int iStartRow;

                // (1) 写入模板
                if (IsDataWriteTemplate)
                {
                    // 模板中最大的行是 2000行
                    if (RowCount <= 2000)
                    {
                        objData = new object[2000, colCount];
                    }
                    else
                    {
                        objData = new object[RowCount, colCount];
                    }
                    // objData 存储数据 从0 开始
                    j = 0;
                    // 写入EXCEL,从第二行开始
                    iStartRow = 1;
                }
                // (2) 写入EXCEL 非模板
                else
                {

                    objData = new object[RowCount + 1, colCount];
                    // 写入列数据
                    foreach (DataColumn dc in dt.Columns)
                    {
                        objData[RowIndex, colIndex++] = dc.ColumnName;
                    }
                    // objData 存在列标题,则存储数据 从1 开始
                    j = 1;
                    // 写入EXCEL ,从第一行开始写入
                    iStartRow = 0;
                }

                // 获取数据
                for (RowIndex = i * EXCEL_MAX_LINE; RowIndex < RowCount; RowIndex++, j++)
                {
                    for (colIndex = 0; colIndex < colCount; colIndex++)
                    {
                        objData[j, colIndex] = "'" + dt.Rows[RowIndex][colIndex].ToString();
                    }
                }

                // 3.写入EXCEL   

                workSheet.Cells.ImportTwoDimensionArray(objData, iStartRow, 0, true);
                // 修改记录 01 开始
                // 4,非模板数据的设置列字段的显示格式
                if (IsDataWriteTemplate == false)
                {
                    for (int k = 0; k < dt.Columns.Count; k++)
                    {
                        //字段名称字体样式
                        Cell cell = workSheet.Cells[0, k];
                        Style style = new Style();
                        // 字体黑体
                        style.Font.IsBold = true;
                        style.Font.Size = 10;
                        // 背景色设置的颜色
                        ThemeColor thecolor = new ThemeColor(ThemeColorType.Accent3, 5.00);
                        //style.ForegroundThemeColor = thecolor;
                        //style.BackgroundThemeColor = thecolor;
                        style.ForegroundColor = System.Drawing.Color.Orange;
                        style.Pattern = BackgroundType.Solid;
                        // 居中垂直对齐
                        style.VerticalAlignment = TextAlignmentType.Right;
                        // 边框设置
                        style.Borders.DiagonalStyle = CellBorderType.None;
                        style.Borders.SetColor(System.Drawing.Color.Black);

                        cell.SetStyle(style);
                        workSheet.AutoFitColumn(k);// 列宽自动调整

                    }

                }
                // 修改记录 01 结束

            }// end of  for (int i = 0; i < sheetsCount; i++)
            return workBook;
