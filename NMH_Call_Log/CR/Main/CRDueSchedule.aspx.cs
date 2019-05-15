using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NMH_Call_Log.CR.Main
{
    public partial class CRDueSchedule : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadInfoSessions();
                loadClientLetters();
                loadHealthTalks();
                loadHealthScreening();
            }
        }
        protected void loadInfoSessions()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    DataTable dTable = new DataTable();
                    string selectquery = "select top(10) id,company,sessiondate from vwClientSessions where (datediff(D,getdate(),SessionDate) between 0 and 30) order by id desc";
                    adapter.SelectCommand = new SqlCommand(selectquery, connection);
                    try
                    {
                        connection.Open();
                        adapter.Fill(dTable);
                        lvInfoSessions.DataSource = dTable;
                        lvInfoSessions.DataBind();
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message + "', 'Error');", true);
                    }
                }
            }
        }
        protected void loadClientLetters()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    DataTable dTable = new DataTable();
                    string selectquery = "select top(10) id,lperiod,duedate from vwClientLetters where (datediff(D,getdate(),DueDate) between 0 and 30) order by id desc";
                    adapter.SelectCommand = new SqlCommand(selectquery, connection);
                    try
                    {
                        connection.Open();
                        adapter.Fill(dTable);
                        lvNewsLetters.DataSource = dTable;
                        lvNewsLetters.DataBind();
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message + "', 'Error');", true);
                    }
                }
            }
        }
        protected void loadHealthTalks()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    DataTable dTable = new DataTable();
                    string selectquery = "select top(10) id,company,talkdate from vwHealthTalks where (datediff(D,getdate(),TalkDate) between 0 and 30) order by id desc";
                    adapter.SelectCommand = new SqlCommand(selectquery, connection);
                    try
                    {
                        connection.Open();
                        adapter.Fill(dTable);
                        lvHealthTalks.DataSource = dTable;
                        lvHealthTalks.DataBind();
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message + "', 'Error');", true);
                    }
                }
            }
        }
        protected void loadHealthScreening()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    DataTable dTable = new DataTable();
                    string selectquery = "select top(10) id,company,screendate from vwHealthScreening where (datediff(D,getdate(),ScreenDate) between 0 and 30) order by id desc";
                    adapter.SelectCommand = new SqlCommand(selectquery, connection);
                    try
                    {
                        connection.Open();
                        adapter.Fill(dTable);
                        lvHealthScreening.DataSource = dTable;
                        lvHealthScreening.DataBind();
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message + "', 'Error');", true);
                    }
                }
            }
        }
    }
}