using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;

namespace NMH_Call_Log.CR.Complaints
{
    public partial class EditComplaint : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string CallId = Request.QueryString["CallId"].ToString();
                string query = "select * from tblCallLog where CallId = @CallId";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@CallId", SqlDbType.Int).Value = CallId;
                        try
                        {
                            connection.Open();
                            SqlDataReader reader = command.ExecuteReader();
                            if (reader.Read())
                            {
                                ViewState["CallId"] = reader["CallId"].ToString();
                                dpDate.SelectedDate = Convert.ToDateTime(reader["CallDate"]);
                                txtCallerNo.Text = reader["CallerNumber"].ToString();
                                txtCallerName.Text = reader["CallerName"].ToString();
                                dlComplaintSource.SelectedText = reader["ComplaintSource"].ToString();
                                dlComplaintType.SelectedValue = reader["ComplaintType"].ToString();
                                dlPriority.SelectedText = reader["Priority"].ToString();
                                //getMemberDetails(txtMemberNo.Text);
                                string companyId = reader["CompanyId"].ToString();
                                query = "SELECT ID, Company FROM Companies WHERE ID ='" + companyId + "'";
                                companySource.SelectCommand = query;
                                dlCompany.DataBind();
                                dlCompany.SelectedValue = companyId;
                                //txtMemberNo.Text = reader["MemberNo"].ToString();
                                string memberNo = reader["MemberNo"].ToString();
                                query = "SELECT ID, MemberNo, FullName, Dob2, Status FROM [Vw_Members] WHERE MemberNo ='" + memberNo + "'";
                                memberSource.SelectCommand = query;
                                dlMember.DataBind();
                                dlMember.SelectedValue = memberNo;

                                txtDescription.Text = reader["Description"].ToString();
                                txtComment.Text = reader["Comment"].ToString();

                                bool escalated = Convert.ToBoolean(reader["escalated"].ToString());
                                if (escalated)
                                {
                                    lblEscalate.InnerText = "REFERRED";
                                    dlDepartment.SelectedValue = reader["escalatedto"].ToString();
                                    //dlEscalateStatus.SelectedText = reader["escalatedstatus"].ToString();
                                    txtEscalateComment.Text = reader["EscalateComment"].ToString();
                                    dpEscalationDate.SelectedDate = Convert.ToDateTime(reader["EscalationDate"]);
                                    if (!Convert.IsDBNull(reader["FeedbackDate"]))
                                        dpFeedbackDate.SelectedDate = Convert.ToDateTime(reader["FeedbackDate"]);
                                }

                                bool resolved = Convert.ToBoolean(reader["resolved"].ToString());
                                if (resolved)
                                {
                                    lblResolve.InnerText = "RESOLVED";
                                    txtFinalResolution.Text = reader["FinalResolution"].ToString();
                                    dpResolutionDate.SelectedDate = Convert.ToDateTime(reader["ResolutionDate"]);
                                }
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
        //protected void getMemberDetails(string memberno)
        //{
        //    string query = "select MemberNo,FullName,Status,[Plan],CompanyID,Company from Vw_Members where MemberNo = @MemberNo";
        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        using (SqlCommand command = new SqlCommand(query, connection))
        //        {
        //            command.Parameters.Add("@MemberNo", SqlDbType.VarChar).Value = memberno;
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

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(dlCompany.SelectedValue) || String.IsNullOrEmpty(dlMember.SelectedValue))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Inaccurate Member details provided','Error');", true);
                return;
            }

            string query = "update tblCallLog set CallDate=@CallDate,CallerNumber=@CallerNumber,CallerName=@CallerName,MemberNo=@MemberNo,CompanyId=@CompanyId,";
            query += "ComplaintSource=@ComplaintSource,ComplaintType=@ComplaintType,Priority=@Priority,Description=@Description,Comment=@Comment,UpdatedBy=@UpdatedBy,ContactEmail=@ContactEmail where CallId = @CallId";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@CallDate", SqlDbType.DateTime).Value = dpDate.SelectedDate;
                    command.Parameters.Add("@CallerNumber", SqlDbType.VarChar).Value = txtCallerNo.Text;
                    command.Parameters.Add("@CallerName", SqlDbType.VarChar).Value = txtCallerName.Text;
                    command.Parameters.Add("@MemberNo", SqlDbType.VarChar).Value = dlMember.SelectedValue;
                    command.Parameters.Add("@CompanyId", SqlDbType.Int).Value = dlCompany.SelectedValue;
                    command.Parameters.Add("@ComplaintSource", SqlDbType.VarChar).Value = dlComplaintSource.SelectedText;
                    command.Parameters.Add("@ComplaintType", SqlDbType.Int).Value = dlComplaintType.SelectedValue;
                    command.Parameters.Add("@Priority", SqlDbType.VarChar).Value = dlPriority.SelectedText;
                    command.Parameters.Add("@Description", SqlDbType.VarChar).Value = txtDescription.Text;
                    command.Parameters.Add("@Comment", SqlDbType.VarChar).Value = txtComment.Text;
                    command.Parameters.Add("@UpdatedBy", SqlDbType.VarChar).Value = User.Identity.Name;
                    command.Parameters.Add("@ContactEmail", SqlDbType.VarChar).Value = txtContactEmail.Text;
                    command.Parameters.Add("@CallId", SqlDbType.Int).Value = ViewState["CallId"].ToString();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully','Success');", true);
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
        //    getMemberDetails(txtMemberNo.Text);
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
            String sql = "SELECT top(100) ID, MemberNo, FullName, Dob2, Status FROM [Vw_Members] WHERE CompanyID = '" + dlCompany.SelectedValue + "' AND (FullName LIKE '%" + e.Text.ToUpper() + "%' OR MemberNo LIKE '%" + e.Text.ToUpper() + "%')";
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