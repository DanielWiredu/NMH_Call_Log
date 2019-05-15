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
    public partial class ClientRefunds : System.Web.UI.Page
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
            refundGrid.Rebind();
        }

        protected void refundGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["Id"] = item["Id"].Text;
                lblCompany.InnerText = item["Company"].Text;
                txtMemberName1.Text = item["MemberName"].Text;
                txtBatchNo1.Text = item["BatchNo"].Text;
                dpSubmissionDate1.SelectedDate = Convert.ToDateTime(item["SubmissionDate"].Text);
                txtAmountClaimed1.Text = item["AmountClaimed"].Text;
                dlPaymentMode1.SelectedText = item["PaymentMode"].Text;
                dlStatus1.SelectedText = item["Status"].Text;
                dlOutcome1.SelectedText = item["Outcome"].Text;
                txtOutcomeReason1.Text = item["OutcomeReason"].Text;

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
            string query = "insert into tblClientRefunds(CompanyId,MemberName,BatchNo,SubmissionDate,AmountClaimed,PaymentMode,Status,Outcome,OutcomeReason,CreatedBy) values(@CompanyId,@MemberName,@BatchNo,@SubmissionDate,@AmountClaimed,@PaymentMode,@Status,@Outcome,@OutcomeReason,@CreatedBy)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@CompanyId", SqlDbType.Int).Value = dlCompany.SelectedValue;
                    command.Parameters.Add("@MemberName", SqlDbType.VarChar).Value = txtMemberName.Text;
                    command.Parameters.Add("@BatchNo", SqlDbType.Int).Value = txtBatchNo.Text;
                    command.Parameters.Add("@SubmissionDate", SqlDbType.DateTime).Value = dpSubmissionDate.SelectedDate;
                    command.Parameters.Add("@AmountClaimed", SqlDbType.Float).Value = txtAmountClaimed.Text;
                    command.Parameters.Add("@PaymentMode", SqlDbType.VarChar).Value = dlPaymentMode.SelectedText;
                    command.Parameters.Add("@Status", SqlDbType.VarChar).Value = dlStatus.SelectedText;
                    command.Parameters.Add("@Outcome", SqlDbType.VarChar).Value = dlOutcome.SelectedText;
                    command.Parameters.Add("@OutcomeReason", SqlDbType.VarChar).Value = txtOutcomeReason.Text;
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
            string query = "update tblClientRefunds set MemberName=@MemberName,BatchNo=@BatchNo,SubmissionDate=@SubmissionDate,AmountClaimed=@AmountClaimed,PaymentMode=@PaymentMode,Status=@Status,Outcome=@Outcome,OutcomeReason=@OutcomeReason where Id = @Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@MemberName", SqlDbType.VarChar).Value = txtMemberName1.Text;
                    command.Parameters.Add("@BatchNo", SqlDbType.Int).Value = txtBatchNo1.Text;
                    command.Parameters.Add("@SubmissionDate", SqlDbType.DateTime).Value = dpSubmissionDate1.SelectedDate;
                    command.Parameters.Add("@AmountClaimed", SqlDbType.Float).Value = txtAmountClaimed1.Text;
                    command.Parameters.Add("@PaymentMode", SqlDbType.VarChar).Value = dlPaymentMode1.SelectedText;
                    command.Parameters.Add("@Status", SqlDbType.VarChar).Value = dlStatus1.SelectedText;
                    command.Parameters.Add("@Outcome", SqlDbType.VarChar).Value = dlOutcome1.SelectedText;
                    command.Parameters.Add("@OutcomeReason", SqlDbType.VarChar).Value = txtOutcomeReason1.Text;
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

        protected void refundGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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