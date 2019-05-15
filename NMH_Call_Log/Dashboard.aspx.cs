using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace NMH_Call_Log
{
    public partial class Dashboard : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadDashboard();
            }
        }
        protected void loadDashboard()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("Get_CallLog_Dash", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@totalCalls", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@escalated", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@pending", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@completed", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        lblTotalCalls.InnerText = command.Parameters["@totalCalls"].Value.ToString();
                        lblEscalated.InnerText = command.Parameters["@escalated"].Value.ToString();
                        lblPending.InnerText = command.Parameters["@pending"].Value.ToString();
                        lblCompleted.InnerText = command.Parameters["@completed"].Value.ToString();
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
    }
}