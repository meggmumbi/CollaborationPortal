
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Office.Interop.Excel;
using System.Runtime.InteropServices;
using System.IO;
using System.Configuration;

namespace HRPortal
{
    public partial class StaffUpload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnUpload_Click(object sender, EventArgs e)

        {

            if (FileUpload1.HasFile)

            {

                string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);

                string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);

                string FolderPath = ConfigurationManager.AppSettings["FolderPath"];


                string excelFilePath = Server.MapPath("~/downloads/Files" + "\\" + FileName);
                //Microsoft.Office.Interop.Excel.Application excel = new Microsoft.Office.Interop.Excel.Application();
                //Microsoft.Office.Interop.Excel.Workbook wb = null;
                //object missing = Type.Missing;
                //wb = excel.Workbooks.Open("c:\\test.xls", missing, missing, missing, missing, missing, missing, missing, missing, missing, missing, missing, missing, missing, missing);
                //excel.Visible = true;


                string workbookPath = Server.MapPath("~/downloads/Files" + "\\" + FileName);
                Microsoft.Office.Interop.Excel.Application myExcelApp = new Microsoft.Office.Interop.Excel.Application();
                Microsoft.Office.Interop.Excel.Workbook excelWorkbook = myExcelApp.Workbooks.Open(workbookPath, 0,
                false, 5, "", "", false, Microsoft.Office.Interop.Excel.XlPlatform.xlWindows, "", true, false, 0, true, false, false);
                foreach (Microsoft.Office.Interop.Excel.Worksheet sheet in myExcelApp.Worksheets)
                {
                    sheet.SaveAs(Path.Combine(Path.GetDirectoryName(FileName), sheet.Name), Microsoft.Office.Interop.Excel.XlFileFormat.xlCSV,
                    Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing,
                    Type.Missing, Type.Missing, Type.Missing);
                }
                myExcelApp.Workbooks.Close();
                myExcelApp.Quit();






            }

        }

    }
}