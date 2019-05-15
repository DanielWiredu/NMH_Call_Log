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
    public partial class MonthlyUsage_Mobimed : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            usageGrid.Rebind();
        }

        protected void usageGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["Id"] = item["Id"].Text;
                dpPeriod1.SelectedDate = Convert.ToDateTime(item["UsagePeriod"].Text);
                txtWhatsappOrders1.Text = item["WhatsappOrders"].Text;
                txtMobileAppOrders1.Text = item["MobileAppOrders"].Text;
                txtSuppliedOrders1.Text = item["SuppliedOrders"].Text;
                txtDownloads1.Text = item["Downloads"].Text;
                txtNonSupplyReasons1.Text = item["NonSupplyReasons"].Text;
                txtRemarks1.Text = item["Remarks"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "editModal();", true);
                e.Canceled = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string query = "insert into tblMonthlyUsage_Mobimed(UsageMonth,UsageYear,UsagePeriod,WhatsappOrders,MobileAppOrders,SuppliedOrders,Downloads,NonSupplyReasons,Remarks,CreatedBy) values(@UsageMonth,@UsageYear,@UsagePeriod,@WhatsappOrders,@MobileAppOrders,@SuppliedOrders,@Downloads,@NonSupplyReasons,@Remarks,@CreatedBy)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@UsageMonth", SqlDbType.Int).Value = dpPeriod.SelectedDate.Value.Month;
                    command.Parameters.Add("@UsageYear", SqlDbType.Int).Value = dpPeriod.SelectedDate.Value.Year;
                    command.Parameters.Add("@UsagePeriod", SqlDbType.VarChar).Value = dpPeriod.SelectedDate.Value.ToString("MMMM yyyy");
                    command.Parameters.Add("@WhatsappOrders", SqlDbType.Int).Value = txtWhatsappOrders.Text;
                    command.Parameters.Add("@MobileAppOrders", SqlDbType.Int).Value = txtMobileAppOrders.Text;
                    command.Parameters.Add("@SuppliedOrders", SqlDbType.Int).Value = txtSuppliedOrders.Text;
                    command.Parameters.Add("@Downloads", SqlDbType.Int).Value = txtDownloads.Text;
                    command.Parameters.Add("@NonSupplyReasons", SqlDbType.VarChar).Value = txtNonSupplyReasons.Text;
                    command.Parameters.Add("@Remarks", SqlDbType.VarChar).Value = txtRemarks.Text;
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
            string query = "update tblMonthlyUsage_Mobimed set UsageMonth=@UsageMonth,UsageYear=@UsageYear,UsagePeriod=@UsagePeriod,WhatsappOrders=@WhatsappOrders,MobileAppOrders=@MobileAppOrders,SuppliedOrders=@SuppliedOrders,Downloads=@Downloads,NonSupplyReasons=@NonSupplyReasons,Remarks=@Remarks where Id = @Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@UsageMonth", SqlDbType.Int).Value = dpPeriod1.SelectedDate.Value.Month;
                    command.Parameters.Add("@UsageYear", SqlDbType.Int).Value = dpPeriod1.SelectedDate.Value.Year;
                    command.Parameters.Add("@UsagePeriod", SqlDbType.VarChar).Value = dpPeriod1.SelectedDate.Value.ToString("MMMM yyyy");
                    command.Parameters.Add("@WhatsappOrders", SqlDbType.Int).Value = txtWhatsappOrders1.Text;
                    command.Parameters.Add("@MobileAppOrders", SqlDbType.Int).Value = txtMobileAppOrders1.Text;
                    command.Parameters.Add("@SuppliedOrders", SqlDbType.Int).Value = txtSuppliedOrders1.Text;
                    command.Parameters.Add("@Downloads", SqlDbType.Int).Value = txtDownloads1.Text;
                    command.Parameters.Add("@NonSupplyReasons", SqlDbType.VarChar).Value = txtNonSupplyReasons1.Text;
                    command.Parameters.Add("@Remarks", SqlDbType.VarChar).Value = txtRemarks1.Text;
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

        protected void usageGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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