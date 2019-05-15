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
    public partial class Plan_Benefit : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfPlanId.Value = Request.QueryString["pid"].ToString();
                //dlPlan.SelectedValue = hfPlanId.Value;
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            planBenefitGrid.Rebind();
        }
        protected void dlBenefit_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["Benefit"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["ID"].ToString();
        }

        protected void dlBenefit_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)dlBenefit.Footer.FindControl("BenefitCount")).Text = Convert.ToString(dlBenefit.Items.Count);
        }

        protected void dlBenefit_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            String sql = "SELECT top(30) ID, Benefit FROM [Benefits] WHERE Benefit LIKE '%" + e.Text.ToUpper() + "%'";
            BenefitSource.SelectCommand = sql;
            dlBenefit.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string query = "insert into Plan_X_BenefitsLimits(PlanID, BenefitID, CoverStatus, CoverLimit, CoverComment) values(@PlanID, @BenefitID, @CoverStatus, @CoverLimit, @CoverComment)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        connection.Open();
                        command.Parameters.Add("@PlanID", SqlDbType.Int).Value = hfPlanId.Value;
                        command.Parameters.Add("@BenefitID", SqlDbType.Int).Value = dlBenefit.SelectedValue;
                        command.Parameters.Add("@CoverStatus", SqlDbType.VarChar).Value = dlCoverStatus.SelectedText;
                        command.Parameters.Add("@CoverLimit", SqlDbType.VarChar).Value = txtCoverLimit.Text;
                        command.Parameters.Add("@CoverComment", SqlDbType.VarChar).Value = txtCoverComment.Text;

                        rows = command.ExecuteNonQuery();
                        if (rows > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            planBenefitGrid.Rebind();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                            dlBenefit.ClearSelection();
                            txtCoverLimit.Text = "0.00";
                            txtCoverComment.Text = "";
                        }
                    }
                    catch (Exception ex)
                    {
                        string errorMsg = ex.Message.Replace("'", "").Replace("\r\n", "");
                        if (errorMsg.Contains("IX_Plan_X_Benefit"))
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Benefit already exist for selected Plan', 'Error');", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + errorMsg + "', 'Error');", true);
                        }

                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string query = "update Plan_X_BenefitsLimits set PlanID=@PlanID, BenefitID=@BenefitID, CoverStatus=@CoverStatus, CoverLimit=@CoverLimit, CoverComment=@CoverComment where RowID = @RowID";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        connection.Open();
                        command.Parameters.Add("@PlanID", SqlDbType.Int).Value = hfPlanId.Value;
                        command.Parameters.Add("@BenefitID", SqlDbType.Int).Value = dlBenefit1.SelectedValue;
                        command.Parameters.Add("@CoverStatus", SqlDbType.VarChar).Value = dlCoverStatus1.SelectedText;
                        command.Parameters.Add("@CoverLimit", SqlDbType.VarChar).Value = txtCoverLimit1.Text;
                        command.Parameters.Add("@CoverComment", SqlDbType.VarChar).Value = txtCoverComment1.Text;
                        command.Parameters.Add("@RowID", SqlDbType.Int).Value = ViewState["RowID"].ToString();

                        rows = command.ExecuteNonQuery();
                        if (rows > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
                            planBenefitGrid.Rebind();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeeditModal();", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        string errorMsg = ex.Message.Replace("'", "").Replace("\r\n", "");
                        if (errorMsg.Contains("IX_Plan_X_Benefit"))
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Benefit already exist for selected Plan', 'Error');", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + errorMsg + "', 'Error');", true);
                        }
                    }
                }
            }
        }
        protected void dlBenefit1_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["Benefit"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["ID"].ToString();
        }

        protected void dlBenefit1_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)dlBenefit1.Footer.FindControl("BenefitCount1")).Text = Convert.ToString(dlBenefit1.Items.Count);
        }

        protected void dlBenefit1_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            String sql = "SELECT top(30) ID, Benefit FROM [Benefits] WHERE Benefit LIKE '%" + e.Text.ToUpper() + "%'";
            BenefitSource1.SelectCommand = sql;
            dlBenefit1.DataBind();
        }

        protected void planBenefitGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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

        protected void planBenefitGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["RowID"] = item["RowID"].Text;
                //dlPlan1.SelectedValue = item["PlanID"].Text;
                dlBenefit1.ClearSelection();
                string benefitId = item["BenefitID"].Text;
                BenefitSource1.SelectCommand = "SELECT ID, Benefit FROM [Benefits] WHERE ID = '" + benefitId + "'";
                dlBenefit1.DataBind();
                dlBenefit1.SelectedValue = benefitId;
                dlCoverStatus1.SelectedText = item["CoverStatus"].Text;
                txtCoverLimit1.Text = item["CoverLimit"].Text;
                txtCoverComment1.Text = item["CoverComment"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "editModal();", true);
                e.Canceled = true;
            }
        }
    }
}