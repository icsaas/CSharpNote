 long totalRows = dt.Rows.Count;

            // 1.b ����ȡ���õ�����Ҫ���ٸ�sheetҳ�������
            int sheetsCount = int.Parse(Convert.ToString(Math.Ceiling((decimal)totalRows / (decimal)EXCEL_MAX_LINE)));

            // 1.d ����workSheet,
            Worksheet workSheet;
            string workSheetName = "Sheet";
            bool IsDataWriteTemplate = false;

            //2.ѭ��д������
            for (int i = 0; i < sheetsCount; i++)
            {
                // (1)ģ��+��һҳ
                if (iSheetStart > 0 && i == 0)
                {
                    workSheet = workBook.Worksheets[iSheetStart - 1];
                    // ��ȡ��ǰ��Sheet����
                    workSheetName = workSheet.Name;

                    // д��ģ��
                    IsDataWriteTemplate = true;

                }
                // (2)ģ�� + ��Nҳ(N>1)
                else if (iSheetStart > 0 && i > 0)
                {
                    workBook.Worksheets.Add(workSheetName + i.ToString());

                    workSheet = workBook.Worksheets[workSheetName + i.ToString()];
                    workSheet.AutoFitColumns();
                    // ������һ������(��Ϊ�б���)
                    workSheet.Cells.CopyRow(workBook.Worksheets[iSheetStart - 1].Cells, 0, 0);

                    // д��ģ��
                    IsDataWriteTemplate = true;

                }
                // (3) ��ģ�� 
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
                    // д��ģ�� 
                    IsDataWriteTemplate = false;
                }

                // 2.b ������,������,������,������
                int colIndex = 0;
                int RowIndex = 0;

                int colCount = dt.Columns.Count;
                int RowCount;

                // 2.c ���dt����������Excel���һҳ���һ�����ݵ��к�ҪС
                if (dt.Rows.Count < (i + 1) * EXCEL_MAX_LINE)
                {
                    RowCount = dt.Rows.Count;
                }
                else
                {
                    RowCount = (i + 1) * EXCEL_MAX_LINE;
                }

                // 2.d �������
                // �������ݻ���
                object[,] objData;

                // ��
                int j;

                // ��Ҫд��EXCEL����ʵ��
                int iStartRow;

                // (1) д��ģ��
                if (IsDataWriteTemplate)
                {
                    // ģ������������ 2000��
                    if (RowCount <= 2000)
                    {
                        objData = new object[2000, colCount];
                    }
                    else
                    {
                        objData = new object[RowCount, colCount];
                    }
                    // objData �洢���� ��0 ��ʼ
                    j = 0;
                    // д��EXCEL,�ӵڶ��п�ʼ
                    iStartRow = 1;
                }
                // (2) д��EXCEL ��ģ��
                else
                {

                    objData = new object[RowCount + 1, colCount];
                    // д��������
                    foreach (DataColumn dc in dt.Columns)
                    {
                        objData[RowIndex, colIndex++] = dc.ColumnName;
                    }
                    // objData �����б���,��洢���� ��1 ��ʼ
                    j = 1;
                    // д��EXCEL ,�ӵ�һ�п�ʼд��
                    iStartRow = 0;
                }

                // ��ȡ����
                for (RowIndex = i * EXCEL_MAX_LINE; RowIndex < RowCount; RowIndex++, j++)
                {
                    for (colIndex = 0; colIndex < colCount; colIndex++)
                    {
                        objData[j, colIndex] = "'" + dt.Rows[RowIndex][colIndex].ToString();
                    }
                }

                // 3.д��EXCEL   

                workSheet.Cells.ImportTwoDimensionArray(objData, iStartRow, 0, true);
                // �޸ļ�¼ 01 ��ʼ
                // 4,��ģ�����ݵ��������ֶε���ʾ��ʽ
                if (IsDataWriteTemplate == false)
                {
                    for (int k = 0; k < dt.Columns.Count; k++)
                    {
                        //�ֶ�����������ʽ
                        Cell cell = workSheet.Cells[0, k];
                        Style style = new Style();
                        // �������
                        style.Font.IsBold = true;
                        style.Font.Size = 10;
                        // ����ɫ���õ���ɫ
                        ThemeColor thecolor = new ThemeColor(ThemeColorType.Accent3, 5.00);
                        //style.ForegroundThemeColor = thecolor;
                        //style.BackgroundThemeColor = thecolor;
                        style.ForegroundColor = System.Drawing.Color.Orange;
                        style.Pattern = BackgroundType.Solid;
                        // ���д�ֱ����
                        style.VerticalAlignment = TextAlignmentType.Right;
                        // �߿�����
                        style.Borders.DiagonalStyle = CellBorderType.None;
                        style.Borders.SetColor(System.Drawing.Color.Black);

                        cell.SetStyle(style);
                        workSheet.AutoFitColumn(k);// �п��Զ�����

                    }

                }
                // �޸ļ�¼ 01 ����

            }// end of  for (int i = 0; i < sheetsCount; i++)
            return workBook;
