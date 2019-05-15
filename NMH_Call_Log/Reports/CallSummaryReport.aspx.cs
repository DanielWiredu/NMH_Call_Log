using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NMH_Call_Log.Reports
{
    public partial class CallSummaryReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            Session["rptCallType"] = dlCallType.SelectedText;
            //Session["sdate"] = dpStartDate.SelectedDate.Value.ToString("dd-MMM-yyyy");
            //Session["edate"] = dpStartDate.SelectedDate.Value.ToString("dd-MMM-yyyy");
            Session["sdate"] = dpStartDate.SelectedDate.Value.ToString();
            Session["edate"] = dpEndDate.SelectedDate.Value.ToShortDateString() + " 11:59:59 PM";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/CallSummary.aspx');", true);
        }
    }
}