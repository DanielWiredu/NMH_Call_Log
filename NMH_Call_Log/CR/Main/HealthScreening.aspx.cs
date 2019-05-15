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
    public partial class HealthScreening : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

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


        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            screeningGrid.Rebind();
        }

        protected void screeningGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["Id"] = item["Id"].Text;
                lblCompany.InnerText = item["Company"].Text;
                dpDate1.SelectedDate = Convert.ToDateTime(item["ScreenDate"].Text);
                dlScreenType1.SelectedText = item["ScreenType"].Text;
                txtHealthFacility1.Text = item["HealthFacility"].Text;
                txtResourcePerson1.Text = item["ResourcePerson"].Text;
                dlResults1.SelectedText = item["ScreenResults"].Text;
                dlStatistics1.SelectedText = item["ScreenStats"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "editModal();", true);
                e.Canceled = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(dlCompany.SelectedValue))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Select a Company','Error');", true);
                return;
            }
            string query = "insert into tblHealthScreening(CompanyId,ScreenDate,ScreenType,HealthFacility,ResourcePerson,ScreenResults,ScreenStats,CreatedBy) values(@CompanyId,@ScreenDate,@ScreenType,@HealthFacility,@ResourcePerson,@ScreenResults,@ScreenStats,@CreatedBy)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@CompanyId", SqlDbType.Int).Value = dlCompany.SelectedValue;
                    command.Parameters.Add("@ScreenDate", SqlDbType.DateTime).Value = dpDate.SelectedDate;
                    command.Parameters.Add("@ScreenType", SqlDbType.VarChar).Value = dlScreenType.SelectedText;
                    command.Parameters.Add("@HealthFacility", SqlDbType.VarChar).Value = txtHealthFacility.Text;
                    command.Parameters.Add("@ResourcePerson", SqlDbType.VarChar).Value = txtResourcePerson.Text;
                    command.Parameters.Add("@ScreenResults", SqlDbType.VarChar).Value = dlResults.SelectedText;
                    command.Parameters.Add("@ScreenStats", SqlDbType.VarChar).Value = dlStatistics.SelectedText;
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
            string query = "update tblHealthScreening set ScreenDate=@ScreenDate,ScreenType=@ScreenType,HealthFacility=@HealthFacility,ResourcePerson=@ResourcePerson,ScreenResults=@ScreenResults,ScreenStats=@ScreenStats where Id = @Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@ScreenDate", SqlDbType.DateTime).Value = dpDate1.SelectedDate;
                    command.Parameters.Add("@ScreenType", SqlDbType.VarChar).Value = dlScreenType1.SelectedText;
                    command.Parameters.Add("@HealthFacility", SqlDbType.VarChar).Value = txtHealthFacility1.Text;
                    command.Parameters.Add("@ResourcePerson", SqlDbType.VarChar).Value = txtResourcePerson1.Text;
                    command.Parameters.Add("@ScreenResults", SqlDbType.VarChar).Value = dlResults1.SelectedText;
                    command.Parameters.Add("@ScreenStats", SqlDbType.VarChar).Value = dlStatistics1.SelectedText;
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

        protected void screeningGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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