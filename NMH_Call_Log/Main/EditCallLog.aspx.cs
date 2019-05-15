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

namespace NMH_Call_Log.Main
{
    public partial class EditCallLog : System.Web.UI.Page
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
                                bool nmhMember = Convert.ToBoolean(reader["NMHMember"]);
                                if (nmhMember) //get member details
                                {
                                    rdCallerType.SelectedValue = "1";
                                    txtMemberNo.Text = reader["MemberNo"].ToString();
                                    getMemberDetails(txtMemberNo.Text);
                                }
                                else
                                {
                                    rdCallerType.SelectedValue = "0";
                                }
                                string facilityId = reader["FacilityId"].ToString();
                                String sql = "SELECT ID, ServiceProvider FROM [ServiceProviders] WHERE ID = '" + facilityId + "'";
                                providerSource.SelectCommand = sql;
                                dlProvider.DataBind();
                                dlProvider.SelectedValue = facilityId;
                                txtLocation.Text = reader["Location"].ToString();
                                dlCallType.SelectedText = reader["CallType"].ToString();
                                dlServiceType.SelectedValue = reader["ServiceTypeId"].ToString();
                                dlCallReason.SelectedValue = reader["CallReasonId"].ToString();
                                txtDescription.Text = reader["Description"].ToString();
                                txtComment.Text = reader["Comment"].ToString();

                                bool escalated = Convert.ToBoolean(reader["escalated"].ToString());
                                if (escalated)
                                {
                                    lblEscalate.InnerText = "ESCALATED";
                                    dlDepartment.SelectedValue = reader["escalatedto"].ToString();
                                    dlEscalateStatus.SelectedText = reader["escalatedstatus"].ToString();
                                    txtEscalateComment.Text = reader["EscalateComment"].ToString();
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
        protected void getMemberDetails(string memberno)
        {
            string query = "select MemberNo,FullName,Status,[Plan],CompanyID,Company from Vw_Members where MemberNo = @MemberNo";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@MemberNo", SqlDbType.VarChar).Value = memberno;
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
            string query = "update tblCallLog set CallDate=@CallDate,CallerNumber=@CallerNumber,CallerName=@CallerName,NMHMember=@NMHMember,MemberNo=@MemberNo,CompanyId=@CompanyId,FacilityId=@FacilityId,Location=@Location,";
            query += "CallType=@CallType,ServiceTypeId=@ServiceTypeId,CallReasonId=@CallReasonId,Description=@Description,Comment=@Comment,UpdatedBy=@UpdatedBy where CallId = @CallId";
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
                    command.Parameters.Add("@UpdatedBy", SqlDbType.VarChar).Value = User.Identity.Name;
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
            getMemberDetails(txtMemberNo.Text);
            //string query = "select MemberNo,FullName,Status,[Plan],CompanyID,Company from Vw_Members where MemberNo = @MemberNo";
            //using (SqlConnection connection = new SqlConnection(connectionString))
            //{
            //    using (SqlCommand command = new SqlCommand(query, connection))
            //    {
            //        command.Parameters.Add("@MemberNo", SqlDbType.VarChar).Value = txtMemberNo.Text;
            //        try
            //        {
            //            connection.Open();
            //            SqlDataReader reader = command.ExecuteReader();
            //            if (reader.Read())
            //            {
            //                txtCallerName.Text = reader["FullName"].ToString();
            //                txtMemberCompany.Text = reader["Company"].ToString();
            //                txtMemberStatus.Text = reader["Status"].ToString();
            //                txtMemberPlan.Text = reader["Plan"].ToString();
            //                ViewState["CompanyID"] = reader["CompanyID"].ToString();
            //            }
            //            else
            //            {
            //                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Member not found','Error');", true);
            //                txtCallerName.Text = "";
            //                txtMemberCompany.Text = "";
            //                txtMemberStatus.Text = "";
            //                txtMemberPlan.Text = "";
            //                ViewState["CompanyID"] = 0;
            //            }
            //            reader.Close();
            //        }
            //        catch (Exception ex)
            //        {
            //            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
            //        }
            //    }
            //}
        }

        protected void btnSaveEscalate_Click(object sender, EventArgs e)
        {
            string query = "update tblCallLog set Escalated=@Escalated, EscalatedTo=@EscalatedTo, EscalatedStatus=@EscalatedStatus, EscalateComment=@EscalateComment where CallId = @CallId";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {

                    command.Parameters.Add("@Escalated", SqlDbType.Bit).Value = true;
                    command.Parameters.Add("@EscalatedTo", SqlDbType.Int).Value = dlDepartment.SelectedValue;
                    command.Parameters.Add("@EscalatedStatus", SqlDbType.VarChar).Value = dlEscalateStatus.SelectedText;
                    command.Parameters.Add("@EscalateComment", SqlDbType.VarChar).Value = txtEscalateComment.Text;
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

        protected void btnFollowUp_Click(object sender, EventArgs e)
        {
            string query = "insert into tblCallLog(CallDate,CallerNumber,CallerName,NMHMember,MemberNo,CompanyId,FacilityId,Location,CallType,ServiceTypeId,CallReasonId,";
            query += "Description,Comment,CreatedBy) select @CallDate,CallerNumber,CallerName,NMHMember,MemberNo,CompanyId,FacilityId,Location,";
            query += "CallType,ServiceTypeId,CallReasonId,Description,Comment,@CreatedBy from tblCallLog where CallId=@CallId";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@CallDate", SqlDbType.DateTime).Value = DateTime.Now;
                    command.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = User.Identity.Name;
                    command.Parameters.Add("@CallId", SqlDbType.Int).Value = ViewState["CallId"].ToString();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows != 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Follow Up Call Saved Successfully','Success');", true);
                            btnFollowUp.Enabled = false;
                        }
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