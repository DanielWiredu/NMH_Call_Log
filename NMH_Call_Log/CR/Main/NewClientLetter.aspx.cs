using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace NMH_Call_Log.CR.Main
{
    public partial class NewClientLetter : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string lMode = dlMode.SelectedText;
            if (dlLetterType.SelectedText == "BDU Bulletin" || dlLetterType.SelectedText == "Newsletter")
                lMode = "Email";

            string query = "insert into tblClientLetters(CROfficerId,LType,LMode,LMonth,LYear,LPeriod,Topic,DueDate,CreatedBy) values(@CROfficerId,@LType,@LMode,@LMonth,@LYear,@LPeriod,@Topic,@DueDate,@CreatedBy)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@CROfficerId", SqlDbType.Int).Value = dlCROfficer.SelectedValue;
                    command.Parameters.Add("@LType", SqlDbType.VarChar).Value = dlLetterType.SelectedText;
                    command.Parameters.Add("@LMode", SqlDbType.VarChar).Value = lMode;
                    command.Parameters.Add("@LMonth", SqlDbType.Int).Value = dpPeriod.SelectedDate.Value.Month;
                    command.Parameters.Add("@LYear", SqlDbType.Int).Value = dpPeriod.SelectedDate.Value.Year;
                    command.Parameters.Add("@LPeriod", SqlDbType.VarChar).Value = dpPeriod.SelectedDate.Value.ToString("MMMM yyyy");
                    command.Parameters.Add("@Topic", SqlDbType.VarChar).Value = txtTopic.Text;
                    command.Parameters.Add("@DueDate", SqlDbType.DateTime).Value = dpDate.SelectedDate;
                    command.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = User.Identity.Name;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows != 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully','Success');", true);
                            btnSave.Enabled = false;
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
                    }
                }
            }
        }
    }
}