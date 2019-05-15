using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NMH_Call_Log
{
    public partial class CRHome : System.Web.UI.MasterPage
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //lblUser.InnerText = Context.User.Identity.Name;
                spUser.InnerText = Context.User.Identity.Name;

                getNotifications();
                if (expComps != 0)
                {
                    spExpCompanies.InnerText = expComps.ToString();
                    spExpCompanies.Visible = true;
                    lkExpCompanies.InnerText = expComps + " Companies due for renewal";
                }
                else
                {
                    spExpCompanies.Visible = false;
                    lkExpCompanies.InnerText = "0 Companies due for renewal";
                }
            }
        }

        int expComps;
        protected void getNotifications()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spGetCRM_Notifications", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@expCompanies", SqlDbType.Int).Direction = ParameterDirection.Output;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        expComps = Convert.ToInt32(command.Parameters["@expCompanies"].Value);
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        expComps = 0;
                    }
                }
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Context.User.Identity.Name != spUser.InnerText)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "", "toastr.error('Error occured while changing password. Please login again and retry', 'Error');", true);
                return;
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spChangeUserPassword", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@userID", SqlDbType.Int).Value = Convert.ToInt32(Session["userID"].ToString());
                    command.Parameters.Add("@newPassword", SqlDbType.VarChar).Value = txtPassword.Text.Trim();
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retval = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retval == 0)
                        {
                            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "", "toastr.success('Password Changed Successfully', 'Success');", true);
                            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "pop", "closepassmodal();", true);
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
    }
}