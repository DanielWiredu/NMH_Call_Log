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
    public partial class EditClientSession : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["Id"] = Request.QueryString["Id"].ToString();
                string query = "select * from tblClientSessions where Id = @Id";
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
                                string companyId = reader["CompanyId"].ToString();
                                query = "SELECT ID, Company FROM Companies WHERE ID ='" + companyId + "'";
                                companySource.SelectCommand = query;
                                dlCompany.DataBind();
                                dlCompany.SelectedValue = companyId;

                                dpDate.SelectedDate = Convert.ToDateTime(reader["SessionDate"]);
                                dlSessionType.SelectedText = reader["SessionType"].ToString();
                                txtIssues.Text = reader["Issues"].ToString();
                                txtTheme.Text = reader["Theme"].ToString();
                                txtParticipants.Text = reader["Participants"].ToString();
                                txtResolutions.Text = reader["Resolutions"].ToString();
                                txtFeedback.Text = reader["Feedback"].ToString();
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
        protected void dlCompany_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["Company"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["ID"].ToString();
        }

        protected void dlCompany_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)dlCompany.Footer.FindControl("companyCount")).Text = Convert.ToString(dlCompany.Items.Count);
        }

        protected void dlCompany_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            String sql = "SELECT top(30) ID, Company FROM [Companies] WHERE Company LIKE '%" + e.Text.ToUpper() + "%'";
            companySource.SelectCommand = sql;
            dlCompany.DataBind();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(dlCompany.SelectedValue))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Select a Company','Error');", true);
                return;
            }
            string query = "update tblClientSessions set CompanyId=@CompanyId,SessionDate=@SessionDate,SessionType=@SessionType,Issues=@Issues,Theme=@Theme,Participants=@Participants,Resolutions=@Resolutions,Feedback=@Feedback where Id = @Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@CompanyId", SqlDbType.Int).Value = dlCompany.SelectedValue;
                    command.Parameters.Add("@SessionDate", SqlDbType.DateTime).Value = dpDate.SelectedDate;
                    command.Parameters.Add("@SessionType", SqlDbType.VarChar).Value = dlSessionType.SelectedText;
                    command.Parameters.Add("@Issues", SqlDbType.VarChar).Value = txtIssues.Text;
                    command.Parameters.Add("@Theme", SqlDbType.VarChar).Value = txtTheme.Text;
                    command.Parameters.Add("@Participants", SqlDbType.Int).Value = txtParticipants.Text;
                    command.Parameters.Add("@Resolutions", SqlDbType.VarChar).Value = txtResolutions.Text;
                    command.Parameters.Add("@Feedback", SqlDbType.VarChar).Value = txtFeedback.Text;
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