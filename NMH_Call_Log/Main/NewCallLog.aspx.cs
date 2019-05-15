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

namespace NMH_Call_Log.Main
{
    public partial class NewCallLog : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dpDate.SelectedDate = DateTime.Now;
                txtCallerNo.Text = Request.QueryString["CallerNo"].ToString();
                txtCallerNo.Focus();
            }
        }

        protected void rdCallerType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdCallerType.SelectedValue == "0")
            {
                txtMemberNo.Text = "";
                txtCallerName.Text = "";
                txtMemberCompany.Text = "";
                txtMemberStatus.Text = "";
                txtMemberPlan.Text = "";
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "openMemberModal();", true);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (rdCallerType.SelectedValue == "1" && txtMemberCompany.Text == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Inaccurate Member details provided','Error');", true);
                return;
            }
            string servicetype = dlServiceType.SelectedValue;
            string callreason = dlCallReason.SelectedValue;
            if (dlCallType.SelectedText == "Drop Call")
            {
                servicetype = "0";
                callreason = "0";
            }
            if (rdCallerType.SelectedValue == "0")
            {
                ViewState["CompanyId"] = 0;
                txtMemberNo.Text = "";
            }
            int facilityId = 0;
            if (!String.IsNullOrEmpty(dlProvider.SelectedValue))
            {
                facilityId = Convert.ToInt32(dlProvider.SelectedValue);
            }
            string query = "insert into tblCallLog(CallDate,CallerNumber,CallerName,NMHMember,MemberNo,CompanyId,FacilityId,Location,CallType,ServiceTypeId,CallReasonId,";
            query += "Description,Comment,CreatedBy,CRChannel,ComplaintSource) output INSERTED.CallId values(@CallDate,@CallerNumber,@CallerName,@NMHMember,@MemberNo,@CompanyId,@FacilityId,@Location,";
            query += "@CallType,@ServiceTypeId,@CallReasonId,@Description,@Comment,@CreatedBy,@CRChannel,@ComplaintSource)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@CallDate", SqlDbType.DateTime).Value = dpDate.SelectedDate;
                    command.Parameters.Add("@CallerNumber", SqlDbType.VarChar).Value = txtCallerNo.Text;
                    command.Parameters.Add("@CallerName", SqlDbType.VarChar).Value = txtCallerName.Text;
                    command.Parameters.Add("@NMHMember", SqlDbType.Bit).Value = Convert.ToInt16(rdCallerType.SelectedValue);
                    command.Parameters.Add("@MemberNo", SqlDbType.VarChar).Value = txtMemberNo.Text;
                    command.Parameters.Add("@CompanyId", SqlDbType.Int).Value = ViewState["CompanyId"].ToString();
                    command.Parameters.Add("@FacilityId", SqlDbType.Int).Value = facilityId;
                    command.Parameters.Add("@Location", SqlDbType.VarChar).Value = txtLocation.Text;
                    command.Parameters.Add("@CallType", SqlDbType.VarChar).Value = dlCallType.SelectedText;
                    command.Parameters.Add("@ServiceTypeId", SqlDbType.Int).Value = servicetype;
                    command.Parameters.Add("@CallReasonId", SqlDbType.Int).Value = callreason;
                    command.Parameters.Add("@Description", SqlDbType.VarChar).Value = txtDescription.Text;
                    command.Parameters.Add("@Comment", SqlDbType.VarChar).Value = txtComment.Text;
                    command.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = User.Identity.Name;
                    command.Parameters.Add("@CRChannel", SqlDbType.VarChar).Value = "CC";
                    command.Parameters.Add("@ComplaintSource", SqlDbType.VarChar).Value = "Call";
                    try
                    {
                        connection.Open();
                        int CallId = 0;
                        CallId = (int)command.ExecuteScalar();
                        if (CallId != 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully','Success');", true);
                            ViewState["CallId"] = CallId;
                            btnEscalate.Enabled = true;
                            btnSave.Enabled = false;
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
                    }
                }
            }
        }
        protected void dlProvider_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["ServiceProvider"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["ID"].ToString();
        }

        protected void dlProvider_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)dlProvider.Footer.FindControl("providerCount")).Text = Convert.ToString(dlProvider.Items.Count);
        }

        protected void dlProvider_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            String sql = "SELECT top(30) ID, ServiceProvider FROM [ServiceProviders] WHERE ServiceProvider LIKE '%" + e.Text.ToUpper() + "%'";
            providerSource.SelectCommand = sql;
            dlProvider.DataBind();
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Main/NewCallLog.aspx?CallerNo=");
        }

        protected void btnFind_Click(object sender, EventArgs e)
        {
            string query = "select MemberNo,FullName,Status,[Plan],CompanyID,Company from Vw_Members where MemberNo = @MemberNo";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@MemberNo", SqlDbType.VarChar).Value = txtMemberNo.Text;
                    try
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.Read())
                        {
                            txtMemberName.Text = reader["FullName"].ToString();
                            txtMemberCompany.Text = reader["Company"].ToString();
                            txtMemberStatus.Text = reader["Status"].ToString();
                            txtMemberPlan.Text = reader["Plan"].ToString();
                            ViewState["CompanyId"] = reader["CompanyID"].ToString();
                            rdCallerType.SelectedValue = "1";
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Member not found','Error');", true);
                            txtCallerName.Text = "";
                            txtMemberCompany.Text = "";
                            txtMemberStatus.Text = "";
                            txtMemberPlan.Text = "";
                            ViewState["CompanyId"] = 0;
                            rdCallerType.SelectedValue = "0";
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

        protected void btnSaveEscalate_Click(object sender, EventArgs e)
        {
            string query = "update tblCallLog set Escalated=@Escalated, EscalatedTo=@EscalatedTo, EscalatedStatus=@EscalatedStatus, EscalateComment=@EscalateComment, EscalationDate=@EscalationDate where CallId = @CallId";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@Escalated", SqlDbType.Bit).Value = true;
                    command.Parameters.Add("@EscalatedTo", SqlDbType.Int).Value = dlDepartment.SelectedValue;
                    command.Parameters.Add("@EscalatedStatus", SqlDbType.VarChar).Value = dlEscalateStatus.SelectedText;
                    command.Parameters.Add("@EscalateComment", SqlDbType.VarChar).Value = txtEscalateComment.Text;
                    command.Parameters.Add("@EscalationDate", SqlDbType.DateTime).Value = DateTime.UtcNow;
                    command.Parameters.Add("@CallId", SqlDbType.Int).Value = ViewState["CallId"].ToString();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Escalated Successfully','Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "closeEscalateModal();", true);
                            lblEscalate.InnerText = "ESCALATED";
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
                    }
                }
            }
        }

        protected void dlCallType_ItemSelected(object sender, DropDownListEventArgs e)
        {
            if (dlCallType.SelectedText == "Drop Call")
            {
                dlServiceType.ClearSelection();
                dlCallReason.ClearSelection();
            }
        }
    }
}