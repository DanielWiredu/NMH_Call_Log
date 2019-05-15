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
    public partial class ViewCompany : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfCompanyId.Value = Request.QueryString["cid"].ToString();

                string query = "select Company,InitialJoin_Date,StartDate,ExpiryDate,PostalAddress,ContactPerson,ContactNumber,Email,CompanyPhone,SpecialConcession from Companies where ID=@ID";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@ID", SqlDbType.Int).Value = hfCompanyId.Value;
                        try
                        {
                            connection.Open();
                            SqlDataReader reader = command.ExecuteReader();
                            if (reader.Read())
                            {
                                hdCompany.InnerText += " - " + reader["Company"].ToString();
                                if (!DBNull.Value.Equals(reader["InitialJoin_Date"]))
                                    dpJoinDate.SelectedDate = Convert.ToDateTime(reader["InitialJoin_Date"]);
                                if (!DBNull.Value.Equals(reader["StartDate"]))
                                    dpStartDate.SelectedDate = Convert.ToDateTime(reader["StartDate"]);
                                if (!DBNull.Value.Equals(reader["ExpiryDate"]))
                                    dpExpiryDate.SelectedDate = Convert.ToDateTime(reader["ExpiryDate"]);
                                txtPostalAddress.Text = reader["PostalAddress"].ToString();
                                txtContactPerson.Text = reader["ContactPerson"].ToString();
                                txtContactNumber.Text = reader["ContactNumber"].ToString();
                                txtEmail.Text = reader["Email"].ToString();
                                txtCompanyPhone.Text = reader["CompanyPhone"].ToString();
                                chkConcession.Checked = Convert.ToBoolean(reader["SpecialConcession"]);
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

        protected void companyContactGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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

        protected void crOfficerGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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

        protected void btnSaveCROfficer_Click(object sender, EventArgs e)
        {
            string query = "insert into tblCompanyCROfficer(CompanyId,CROfficerId,DateAssigned,CreatedBy) values(@CompanyId,@CROfficerId,@DateAssigned,@CreatedBy)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@CompanyId", SqlDbType.Int).Value = hfCompanyId.Value;
                    command.Parameters.Add("@CROfficerId", SqlDbType.Int).Value = dlCROfficer.SelectedValue;
                    command.Parameters.Add("@DateAssigned", SqlDbType.DateTime).Value = dpAssignedDate.SelectedDate;
                    command.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = User.Identity.Name;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows != 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully','Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "closeNewCROfficerModal();", true);
                            crOfficerGrid.Rebind();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
                    }
                }
            }
        }

        protected void btnUpdatePolicy_Click(object sender, EventArgs e)
        {
            string query = "update CompanyPolicy set Premium = @Premium, Comments = @Comments where RowId = @RowId";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@Premium", SqlDbType.Float).Value = txtPremium.Text;
                    command.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments.Text;
                    command.Parameters.Add("@RowId", SqlDbType.Int).Value = ViewState["CompanyPolicyId"].ToString();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows != 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully','Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "closePolicyDetailsModal();", true);
                            companyPolicyGrid.Rebind();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
                    }
                }
            }
        }

        protected void btnSaveContact_Click(object sender, EventArgs e)
        {
            string query = "insert into tblCompanyContacts(CompanyId,ContactName,ContactNo,EmailAddress,Rank,CreatedBy) values(@CompanyId,@ContactName,@ContactNo,@EmailAddress,@Rank,@CreatedBy)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@CompanyId", SqlDbType.Int).Value = hfCompanyId.Value;
                    command.Parameters.Add("@ContactName", SqlDbType.VarChar).Value = txtContactName.Text;
                    command.Parameters.Add("@ContactNo", SqlDbType.VarChar).Value = txtContactNo.Text;
                    command.Parameters.Add("@EmailAddress", SqlDbType.VarChar).Value = txtContactEmail.Text;
                    command.Parameters.Add("@Rank", SqlDbType.VarChar).Value = dlRank.SelectedText;
                    command.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = User.Identity.Name;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows != 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully','Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "closeNewContactModal();", true);
                            companyContactGrid.Rebind();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
                    }
                }
            }
        }

        protected void crOfficerGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "InitInsert")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "showNewCROfficerModal();", true);
                e.Canceled = true;
            }
        }

        protected void companyContactGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "InitInsert")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "showNewContactModal();", true);
                e.Canceled = true;
            }
        }

        protected void companyPolicyGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["CompanyPolicyId"] = item["RowId"].Text;
                txtPremium.Text = item["Premium"].Text;
                txtComments.Text = item["Comments"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "showPolicyDetailsModal();", true);
                e.Canceled = true;
            }
        }

        protected void btnUpdateCompany_Click(object sender, EventArgs e)
        {
            string query = "update Companies set PostalAddress=@PostalAddress,ContactPerson=@ContactPerson,ContactNumber=@ContactNumber,Email=@Email,CompanyPhone=@CompanyPhone,SpecialConcession=@SpecialConcession where ID = @ID";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@PostalAddress", SqlDbType.VarChar).Value = txtPostalAddress.Text;
                    command.Parameters.Add("@ContactPerson", SqlDbType.VarChar).Value = txtContactPerson.Text;
                    command.Parameters.Add("@ContactNumber", SqlDbType.VarChar).Value = txtContactNumber.Text;
                    command.Parameters.Add("@Email", SqlDbType.VarChar).Value = txtEmail.Text;
                    command.Parameters.Add("@CompanyPhone", SqlDbType.VarChar).Value = txtCompanyPhone.Text;
                    command.Parameters.Add("@SpecialConcession", SqlDbType.Bit).Value = chkConcession.Checked;
                    command.Parameters.Add("@ID", SqlDbType.Int).Value = hfCompanyId.Value;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows != 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Changes Saved Successfully','Success');", true);
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