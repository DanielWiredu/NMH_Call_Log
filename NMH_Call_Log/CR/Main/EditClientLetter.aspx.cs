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
    public partial class EditClientLetter : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["Id"] = Request.QueryString["Id"].ToString();
                string query = "select * from tblClientLetters where Id = @Id";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@Id", SqlDbType.Int).Value = ViewState["Id"].ToString();
                        try
                        {
                            connection.Open();
                            SqlDataReader reader = command.ExecuteReader();
                            if (reader.Read())
                            {
                                dlCROfficer.SelectedValue = reader["CROfficerId"].ToString();
                                dlLetterType.SelectedText = reader["LType"].ToString();
                                dlMode.SelectedText = reader["LMode"].ToString();
                                dpPeriod.SelectedDate = Convert.ToDateTime(reader["LPeriod"]);
                                txtTopic.Text = reader["Topic"].ToString();
                                dpDate.SelectedDate = Convert.ToDateTime(reader["DueDate"]);
                            }
                            reader.Close();
                        }
                        catch (Exception ex)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
                        }
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string lMode = dlMode.SelectedText;
            if (dlLetterType.SelectedText == "BDU Bulletin" || dlLetterType.SelectedText == "Newsletter")
                lMode = "Email";

            string query = "update tblClientLetters set CROfficerId=@CROfficerId,LType=@LType,LMode=@LMode,LMonth=@LMonth,LYear=@LYear,LPeriod=@LPeriod,Topic=@Topic,DueDate=@DueDate where Id = @Id";
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
                    command.Parameters.Add("@Id", SqlDbType.Int).Value = ViewState["Id"].ToString();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows != 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully','Success');", true);
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