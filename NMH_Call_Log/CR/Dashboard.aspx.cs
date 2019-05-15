using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace NMH_Call_Log.CR
{
    public partial class Dashboard : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadDashboard();
                checkDueTasks();
            }
        }
        protected void loadDashboard()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("Get_ComplaintLog_Dash", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@totalComplaints", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@referred", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@unresolved", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@resolved", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        lblTotalComplaints.InnerText = command.Parameters["@totalComplaints"].Value.ToString();
                        lblReferred.InnerText = command.Parameters["@referred"].Value.ToString();
                        lblUnResolved.InnerText = command.Parameters["@unresolved"].Value.ToString();
                        lblResolved.InnerText = command.Parameters["@resolved"].Value.ToString();
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
        protected void checkDueTasks()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spCheckCRSchedule", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@notify", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retval = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        bool notify = Convert.ToBoolean(command.Parameters["@notify"].Value);
                        if (notify)
                        {
                            ntTodo.Show();
                        }
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