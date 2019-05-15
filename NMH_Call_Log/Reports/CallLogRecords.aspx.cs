using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NMH_Call_Log.Reports
{
    public partial class CallLogRecords : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            callLogGrd.Rebind();
        }

        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            callLogGrd.MasterTableView.ExportToExcel();
        }
    }
}