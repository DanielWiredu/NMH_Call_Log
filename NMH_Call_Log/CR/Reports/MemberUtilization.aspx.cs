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

namespace NMH_Call_Log.CR.Reports
{
    public partial class MemberUtilization : System.Web.UI.Page
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
        protected void dlMember_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["MemberNo"].ToString() + " - " + ((DataRowView)e.Item.DataItem)["FullName"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["ID"].ToString();
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
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            claimGrid.Rebind();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("Get_Member_Utilization_Amount", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@MemberID", SqlDbType.Int).Value = dlMember.SelectedValue;
                    command.Parameters.Add("@OpdAmount", SqlDbType.Float).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@IpAmount", SqlDbType.Float).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retval = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retval == 0)
                        {
                            lblOPD.InnerText = Convert.ToDouble(command.Parameters["@OpdAmount"].Value).ToString("N02");
                            lblIPD.InnerText = Convert.ToDouble(command.Parameters["@IpAmount"].Value).ToString("N02");
                        }
                    }
                    catch (Exception ex)
                    {
                        string errormessage = ex.Message;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + errormessage.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            claimGrid.MasterTableView.ExportToExcel();
        }
    }
}