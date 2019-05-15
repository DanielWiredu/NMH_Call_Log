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
    public partial class ClientInteraction : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            eventGrid.Rebind();
        }

        protected void eventGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["Id"] = item["Id"].Text;
                dpEventDate1.SelectedDate = Convert.ToDateTime(item["EventDate"].Text);
                txtVenue1.Text = item["Venue"].Text;
                txtParticipants1.Text = item["Participants"].Text;
                txtIssues1.Text = item["Issues"].Text;
                txtRecommendations1.Text = item["Recommendations"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "editModal();", true);
                e.Canceled = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string query = "insert into tblClientInteraction(EventDate,Venue,Participants,Issues,Recommendations,CreatedBy) values(@EventDate,@Venue,@Participants,@Issues,@Recommendations,@CreatedBy)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@EventDate", SqlDbType.DateTime).Value = dpEventDate.SelectedDate;
                    command.Parameters.Add("@Venue", SqlDbType.VarChar).Value = txtVenue.Text;
                    command.Parameters.Add("@Participants", SqlDbType.VarChar).Value = txtParticipants.Text;
                    command.Parameters.Add("@Issues", SqlDbType.VarChar).Value = txtIssues.Text;
                    command.Parameters.Add("@Recommendations", SqlDbType.VarChar).Value = txtRecommendations.Text;
                    command.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = User.Identity.Name;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows != 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully','Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "closenewModal();", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string query = "update tblClientInteraction set EventDate=@EventDate,Venue=@Venue,Participants=@Participants,Issues=@Issues,Recommendations=@Recommendations where Id = @Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@EventDate", SqlDbType.DateTime).Value = dpEventDate1.SelectedDate;
                    command.Parameters.Add("@Venue", SqlDbType.VarChar).Value = txtVenue1.Text;
                    command.Parameters.Add("@Participants", SqlDbType.VarChar).Value = txtParticipants1.Text;
                    command.Parameters.Add("@Issues", SqlDbType.VarChar).Value = txtIssues1.Text;
                    command.Parameters.Add("@Recommendations", SqlDbType.VarChar).Value = txtRecommendations1.Text;
                    command.Parameters.Add("@Id", SqlDbType.Int).Value = ViewState["Id"].ToString();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows != 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully','Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "closeeditModal();", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
                    }
                }
            }
        }

        protected void eventGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
            }
        }
    }
}