using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using CrystalDecisions.Shared;

namespace NMH_Call_Log.Reports
{
    public partial class CallSummary : System.Web.UI.Page
    {
        rptCallSummary rpt = new rptCallSummary();
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter;
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CallSummaryReport_Load(object sender, EventArgs e)
        {
            string callType = Session["rptCallType"].ToString();
            string sdate = Session["sdate"].ToString();
            string edate = Session["edate"].ToString();

            ParameterValues parameters = new ParameterValues();
            ParameterDiscreteValue startdate = new ParameterDiscreteValue();
            ParameterDiscreteValue enddate = new ParameterDiscreteValue();

            startdate.Value = sdate;
            enddate.Value = edate;

            adapter = new SqlDataAdapter("select calltype, callreasonid, callreason from vwCallLog where calltype like '%"+ callType + "%' and (calldate between '"+ sdate +"' and '"+ edate +"')", connection);
            if (connection.State == ConnectionState.Closed)
                connection.Open();
            adapter.Fill(ds, "vwCallLog");
            rpt.SetDataSource(ds);

            parameters.Add(startdate);
            rpt.DataDefinition.ParameterFields["startDate"].ApplyCurrentValues(parameters);
            parameters.Add(enddate);
            rpt.DataDefinition.ParameterFields["endDate"].ApplyCurrentValues(parameters);
            parameters.Add(enddate);

            CallSummaryReport.ReportSource = rpt;

            //adapter.Dispose();
            //connection.Close();
        }
    }
}