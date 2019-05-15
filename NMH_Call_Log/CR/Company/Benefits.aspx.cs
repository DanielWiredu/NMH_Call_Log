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
    public partial class Benefits : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BenefitGrid.Rebind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string query = "insert into Benefits(Benefit, BenefitGroupId) values(@Benefit, @BenefitGroupId)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        connection.Open();
                        command.Parameters.Add("@Benefit", SqlDbType.VarChar).Value = txtBenefit.Text;
                        command.Parameters.Add("@BenefitGroupId", SqlDbType.Int).Value = dlBenefitGroup.SelectedValue;
                        rows = command.ExecuteNonQuery();
                        if (rows > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            BenefitGrid.Rebind();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string query = "update Benefits set Benefit=@Benefit, BenefitGroupId=@BenefitGroupId where ID = @ID";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        connection.Open();
                        command.Parameters.Add("@Benefit", SqlDbType.VarChar).Value = txtBenefit1.Text;
                        command.Parameters.Add("@BenefitGroupId", SqlDbType.Int).Value = dlBenefitGroup1.SelectedValue;
                        command.Parameters.Add("@ID", SqlDbType.Int).Value = ViewState["BenefitId"].ToString();
                        rows = command.ExecuteNonQuery();
                        if (rows > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
                            BenefitGrid.Rebind();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeeditModal();", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void BenefitGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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

        protected void BenefitGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["BenefitId"] = item["ID"].Text;
                dlBenefitGroup1.SelectedValue = item["BenefitGroupId"].Text;
                txtBenefit1.Text = item["Benefit"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "editModal();", true);
                e.Canceled = true;
            }
        }
    }
}