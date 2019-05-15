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

namespace NMH_Call_Log.CR.Complaints
{
    public partial class NewComplaint : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dpDate.SelectedDate = DateTime.Now;
                //ViewState["CompanyId"] = "0";
                txtCallerNo.Text = Request.QueryString["CallerNo"].ToString();
                txtCallerNo.Focus();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(dlCompany.SelectedValue) || String.IsNullOrEmpty(dlMember.SelectedValue))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Inaccurate Member details provided','Error');", true);
                return;
            }

            string servicetype = "0";
            string callreason = "0";

            int facilityId = 0;

            string query = "insert into tblCallLog(CallDate,CallerNumber,CallerName,NMHMember,MemberNo,CompanyId,FacilityId,CallType,ServiceTypeId,CallReasonId,";
            query += "Description,Comment,CreatedBy,CRChannel,ComplaintSource,ComplaintType,Priority,ContactEmail) output INSERTED.CallId values(@CallDate,@CallerNumber,@CallerName,@NMHMember,@MemberNo,@CompanyId,@FacilityId,";
            query += "@CallType,@ServiceTypeId,@CallReasonId,@Description,@Comment,@CreatedBy,@CRChannel,@ComplaintSource,@ComplaintType,@Priority,@ContactEmail)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@CallDate", SqlDbType.DateTime).Value = dpDate.SelectedDate;
                    command.Parameters.Add("@CallerNumber", SqlDbType.VarChar).Value = txtCallerNo.Text;
                    command.Parameters.Add("@CallerName", SqlDbType.VarChar).Value = txtCallerName.Text;
                    command.Parameters.Add("@NMHMember", SqlDbType.Bit).Value = 1;
                    command.Parameters.Add("@MemberNo", SqlDbType.VarChar).Value = dlMember.SelectedValue;
                    command.Parameters.Add("@CompanyId", SqlDbType.Int).Value = dlCompany.SelectedValue;
                    command.Parameters.Add("@FacilityId", SqlDbType.Int).Value = facilityId;
                    command.Parameters.Add("@CallType", SqlDbType.VarChar).Value = "Complaint";
                    command.Parameters.Add("@ServiceTypeId", SqlDbType.Int).Value = servicetype;
                    command.Parameters.Add("@CallReasonId", SqlDbType.Int).Value = callreason;
                    command.Parameters.Add("@Description", SqlDbType.VarChar).Value = txtDescription.Text;
                    command.Parameters.Add("@Comment", SqlDbType.VarChar).Value = txtComment.Text;
                    command.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = User.Identity.Name;
                    command.Parameters.Add("@CRChannel", SqlDbType.VarChar).Value = "CR";
                    command.Parameters.Add("@ComplaintSource", SqlDbType.VarChar).Value = dlComplaintSource.SelectedText;
                    command.Parameters.Add("@ComplaintType", SqlDbType.Int).Value = dlComplaintType.SelectedValue;
                    command.Parameters.Add("@Priority", SqlDbType.VarChar).Value = dlPriority.SelectedText;
                    command.Parameters.Add("@ContactEmail", SqlDbType.VarChar).Value = txtContactEmail.Text;
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

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            Response.Redirect("/CR/Complaints/NewComplaint.aspx?CallerNo=");
        }

        //protected void btnFind_Click(object sender, EventArgs e)
        //{
        //    string query = "select MemberNo,FullName,Status,[Plan],CompanyID,Company from Vw_Members where MemberNo = @MemberNo";
        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        using (SqlCommand command = new SqlCommand(query, connection))
        //        {
        //            command.Parameters.Add("@MemberNo", SqlDbType.VarChar).Value = txtMemberNo.Text;
        //            try
        //            {
        //                connection.Open();
        //                SqlDataReader reader = command.ExecuteReader();
        //                if (reader.Read())
        //                {
        //                    txtMemberName.Text = reader["FullName"].ToString();
        //                    txtCallerName.Text = reader["FullName"].ToString();
        //                    txtMemberCompany.Text = reader["Company"].ToString();
        //                    txtMemberStatus.Text = reader["Status"].ToString();
        //                    txtMemberPlan.Text = reader["Plan"].ToString();
        //                    ViewState["CompanyId"] = reader["CompanyID"].ToString();
        //                }
        //                else
        //                {
        //                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Member not found','Error');", true);
        //                    txtMemberName.Text = "";
        //                    txtCallerName.Text = "";
        //                    txtMemberCompany.Text = "";
        //                    txtMemberStatus.Text = "";
        //                    txtMemberPlan.Text = "";
        //                    ViewState["CompanyId"] = 0;
        //                }
        //                reader.Close();
        //            }
        //            catch (Exception ex)
        //            {
        //                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
        //            }
        //        }
        //    }
        //}

        protected void btnSaveEscalate_Click(object sender, EventArgs e)
        {
            string query = "update tblCallLog set Escalated=@Escalated, EscalatedTo=@EscalatedTo, EscalatedStatus=@EscalatedStatus, EscalateComment=@EscalateComment, EscalationDate=@EscalationDate, FeedbackDate=@FeedbackDate where CallId = @CallId";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@Escalated", SqlDbType.Bit).Value = true;
                    command.Parameters.Add("@EscalatedTo", SqlDbType.Int).Value = dlDepartment.SelectedValue;
                    command.Parameters.Add("@EscalatedStatus", SqlDbType.VarChar).Value = "Pending";
                    command.Parameters.Add("@EscalateComment", SqlDbType.VarChar).Value = txtEscalateComment.Text;
                    command.Parameters.Add("@EscalationDate", SqlDbType.DateTime).Value = dpEscalationDate.SelectedDate;
                    command.Parameters.Add("@FeedbackDate", SqlDbType.DateTime).Value = dpFeedbackDate.SelectedDate;
                    command.Parameters.Add("@CallId", SqlDbType.Int).Value = ViewState["CallId"].ToString();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Referred Successfully','Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "closeEscalateModal();", true);
                            lblEscalate.InnerText = "REFERRED";
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
                    }
                }
            }
        }
        protected void btnSaveResolution_Click(object sender, EventArgs e)
        {
            string query = "update tblCallLog set Resolved=@Resolved, FinalResolution=@FinalResolution, ResolutionDate=@ResolutionDate where CallId = @CallId";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@Resolved", SqlDbType.Bit).Value = true;
                    command.Parameters.Add("@FinalResolution", SqlDbType.VarChar).Value = txtFinalResolution.Text;
                    command.Parameters.Add("@ResolutionDate", SqlDbType.DateTime).Value = dpResolutionDate.SelectedDate;
                    command.Parameters.Add("@CallId", SqlDbType.Int).Value = ViewState["CallId"].ToString();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Resolved Successfully','Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "closeResolveModal();", true);
                            lblResolve.InnerText = "RESOLVED";
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
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
        protected void dlMember_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["MemberNo"].ToString() + " - " + ((DataRowView)e.Item.DataItem)["FullName"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["MemberNo"].ToString();
        }

        protected void dlMember_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)dlMember.Footer.FindControl("memberCount")).Text = Convert.ToString(dlMember.Items.Count);
        }

        protected void dlMember_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            String sql = "SELECT top(100) ID, MemberNo, FullName, Dob2, Status FROM [Vw_Members] WHERE CompanyID = '"+ dlCompany.SelectedValue + "' AND (FullName LIKE '%" + e.Text.ToUpper() + "%' OR MemberNo LIKE '%" + e.Text.ToUpper() + "%')";
            memberSource.SelectCommand = sql;
            dlMember.DataBind();
        }

        protected void dlMember_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string query = "select FullName,Email,CompanyID from Vw_Members where MemberNo = @MemberNo";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@MemberNo", SqlDbType.VarChar).Value = dlMember.SelectedValue;
                    try
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.Read())
                        {
                            txtCallerName.Text = reader["FullName"].ToString();
                            txtContactEmail.Text = reader["Email"].ToString();
                            //ViewState["CompanyId"] = reader["CompanyID"].ToString();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Member not found','Error');", true);
                            txtCallerName.Text = "";
                            txtContactEmail.Text = "";
                            //ViewState["CompanyId"] = 0;
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
}