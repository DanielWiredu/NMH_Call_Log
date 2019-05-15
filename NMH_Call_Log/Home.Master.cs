using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NMH_Call_Log
{
    public partial class Home : System.Web.UI.MasterPage
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //lblUser.InnerText = Context.User.Identity.Name;
                spUser.InnerText = Context.User.Identity.Name;
                //lblUser.Text = "Daniel Wiredu";
                //spUser.InnerText = "Daniel Wiredu";
                //imglogo.Src = "/Content/img/user.png";
                //getLowStock();
                //String activepage = Request.RawUrl;
                //if (activepage.Contains("Dashboard.aspx"))
                //{
                //    lkDashboard.Attributes["class"] = "active";
                //}
                //else if (activepage.Contains("Bidding"))
                //{
                //    lkAuction.Attributes["class"] = "active";
                //}
            }
        }
        //protected void getLowStock()
        //{
        //    string query = "select isnull(count(AssetNo),0) as lowAssets from tblAssetStock where StockStatus = 'Low'";
        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        using (SqlCommand command = new SqlCommand(query, connection))
        //        {
        //            try
        //            {
        //                connection.Open();
        //                using (SqlDataReader reader = command.ExecuteReader())
        //                {
        //                    int lowAssets = 0;
        //                    if (reader.Read())
        //                    {
        //                        lowAssets = Convert.ToInt32(reader["lowAssets"]);
        //                        if (lowAssets != 0)
        //                        {
        //                            spStockLevel.InnerText = lowAssets.ToString();
        //                            spStockLevel.Visible = true;
        //                            lkStockLevel.InnerText = lowAssets + " Asset(s) low in stock";
        //                        }
        //                        else
        //                        {
        //                            spStockLevel.Visible = false;
        //                            lkStockLevel.InnerText = "0 Asset(s) low in stock";
        //                        }
        //                    }
        //                }
        //            }
        //            catch (Exception ex)
        //            {
        //                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
        //            }
        //        }
        //    }
        //}

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Context.User.Identity.Name != spUser.InnerText)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "", "toastr.error('Error occured while changing password. Please login again and retry', 'Error');", true);
                return;
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spChangeUserPassword", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@userID", SqlDbType.Int).Value = Convert.ToInt32(Session["userID"].ToString());
                    command.Parameters.Add("@newPassword", SqlDbType.VarChar).Value = txtPassword.Text.Trim();
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retval = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retval == 0)
                        {
                            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "", "toastr.success('Password Changed Successfully', 'Success');", true);
                            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "pop", "closepassmodal();", true);
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
    }
}