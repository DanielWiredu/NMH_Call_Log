using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Configuration;
using System.Data.SqlClient;

namespace NMH_Call_Log.CR.Company
{
    public partial class Company_Plan_Map : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void companyPlanGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            companyPlanGrid.Rebind();
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

        protected void companyPlanGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Benefits")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/CR/Company/Company_Plan_Benefits.aspx?cid=" + item["CompanyId"].Text + "&pid=" + item["PlanId"].Text + "&cname=" + item["Company"].Text);
            }

            else if (e.CommandName == "Delete")
            {
                GridDataItem item = e.Item as GridDataItem;
                int companyId = int.Parse(item["CompanyId"].Text);
                int planId = int.Parse(item["PlanId"].Text);
                string query = "DELETE FROM [Company_X_Plan_Benefits_Limits] WHERE [CompanyId] = @CompanyId AND [PlanID] = @PlanID";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        try
                        {
                            connection.Open();
                            command.Parameters.Add("@CompanyId", SqlDbType.Int).Value = companyId;
                            command.Parameters.Add("@PlanID", SqlDbType.Int).Value = planId;
                            rows = command.ExecuteNonQuery();
                            if (rows > 0)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Plan Deleted Successfully', 'Success');", true);
                                companyPlanGrid.Rebind();
                            }
                        }
                        catch (Exception ex)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        }
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Add_Company_Plan_Benefits", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        command.Parameters.Add("@companyId", SqlDbType.Int).Value = int.Parse(dlCompany.SelectedValue);
                        command.Parameters.Add("@planId", SqlDbType.Int).Value = int.Parse(dlPlan.SelectedValue);
                        command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                        command.ExecuteNonQuery();
                        int retval = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retval == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Plan Saved Successfully', 'Success');", true);
                            companyPlanGrid.Rebind();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                        }
                        else if (retval == 25)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Plan has already been added to company. Please try again', 'Error');", true);
                        }
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