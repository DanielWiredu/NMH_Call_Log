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

namespace NMH_Call_Log.CR.Company
{
    public partial class Company_Plan_Benefits : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfCompanyId.Value = Request.QueryString["cid"].ToString();
                hfPlanId.Value = Request.QueryString["pid"].ToString();
                lblCompany.InnerText = Request.QueryString["cname"].ToString();
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            companyBenefitGrid.Rebind();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string query = "update Company_X_Plan_Benefits_Limits set CoverStatus=@CoverStatus,CoverLimit=@CoverLimit,CoverComment=@CoverComment where RowId=@RowId";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        connection.Open();
                        command.Parameters.Add("@CoverStatus", SqlDbType.VarChar).Value = dlCoverStatus.SelectedText;
                        command.Parameters.Add("@CoverLimit", SqlDbType.Float).Value = txtCoverLimit.Text;
                        command.Parameters.Add("@CoverComment", SqlDbType.VarChar).Value = txtCoverComment.Text;
                        command.Parameters.Add("@RowId", SqlDbType.Int).Value = int.Parse(ViewState["RowId"].ToString());
                        int rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
                            companyBenefitGrid.Rebind();
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

        protected void companyBenefitGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["RowId"] = item["RowId"].Text;
                lblBenefit.InnerText = item["Benefit"].Text;
                dlCoverStatus.SelectedText = item["CoverStatus"].Text;
                txtCoverLimit.Text = item["CoverLimit"].Text;
                txtCoverComment.Text = item["CoverComment"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "editModal();", true);
                e.Canceled = true;
            }
        }

        protected void companyBenefitGrid_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                string benefit = item["Benefit"].Text;
                if (benefit.Length > 28)
                {
                    item["Benefit"].Text = benefit.Substring(0, 28);
                    item["Benefit"].ToolTip = benefit;
                }

                string covercomment = item["CoverComment"].Text;
                if (covercomment.Length > 28)
                {
                    item["CoverComment"].Text = covercomment.Substring(0, 28);
                    item["CoverComment"].ToolTip = covercomment;
                }
            }
        }
        protected void dlBenefit_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["Benefit"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["BenefitID"].ToString();
        }

        protected void dlBenefit_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)dlBenefitNew.Footer.FindControl("BenefitCount")).Text = Convert.ToString(dlBenefitNew.Items.Count);
        }

        protected void dlBenefit_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            String sql = "SELECT top(30) BenefitID, Benefit FROM [Vw_Plan_X_Benefits] WHERE PlanID = '" + hfPlanId.Value + "' AND Benefit LIKE '%" + e.Text.ToUpper() + "%'";
            BenefitSource.SelectCommand = sql;
            dlBenefitNew.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string query = "insert into Company_X_Plan_Benefits_Limits(CompanyID, PlanID, BenefitID, CoverStatus, CoverLimit, CoverComment) values(@CompanyID, @PlanID, @BenefitID, @CoverStatus, @CoverLimit, @CoverComment)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        connection.Open();
                        command.Parameters.Add("@CompanyID", SqlDbType.Int).Value = hfCompanyId.Value;
                        command.Parameters.Add("@PlanID", SqlDbType.Int).Value = hfPlanId.Value;
                        command.Parameters.Add("@BenefitID", SqlDbType.Int).Value = dlBenefitNew.SelectedValue;
                        command.Parameters.Add("@CoverStatus", SqlDbType.VarChar).Value = dlCoverStatusNew.SelectedText;
                        command.Parameters.Add("@CoverLimit", SqlDbType.VarChar).Value = txtCoverLimitNew.Text;
                        command.Parameters.Add("@CoverComment", SqlDbType.VarChar).Value = txtCoverCommentNew.Text;

                        int rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            companyBenefitGrid.Rebind();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                            dlBenefitNew.ClearSelection();
                            txtCoverLimitNew.Text = "0.00";
                            txtCoverCommentNew.Text = "";
                        }
                    }
                    catch (Exception ex)
                    {
                        string errorMsg = ex.Message.Replace("'", "").Replace("\r\n", "");
                        if (errorMsg.Contains("IX_Company_X_Plan_Benefit"))
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Benefit already exist for selected Company and Plan', 'Error');", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + errorMsg + "', 'Error');", true);
                        }

                    }
                }
            }
        }

        protected void dlBenefitNew_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string query = "select CoverStatus, CoverLimit, CoverComment from Plan_X_BenefitsLimits where BenefitID = @BenefitID and PlanID = @PlanId";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@BenefitID", SqlDbType.Int).Value = dlBenefitNew.SelectedValue;
                    command.Parameters.Add("@PlanId", SqlDbType.Int).Value = hfPlanId.Value;
                    try
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.Read())
                        {
                            dlCoverStatusNew.SelectedText = reader["CoverStatus"].ToString();
                            txtCoverLimitNew.Text = reader["CoverLimit"].ToString();
                            txtCoverCommentNew.Text = reader["CoverComment"].ToString();
                        }
                        reader.Close();
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