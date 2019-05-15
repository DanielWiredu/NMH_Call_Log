using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NMH_Call_Log
{
    public partial class Login : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlCommand command;
        SqlDataReader reader;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.IsAuthenticated && !string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                    // This is an unauthorized, authenticated request...
                    Response.Redirect("~/Errors/UnauthorizedAccess.aspx");

                FormsAuthentication.SignOut();
                Session.Abandon();

                //clear authentication cookie
                //HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, "");
                //cookie1.Expires = DateTime.Now.AddYears(-1);
                //Response.Cookies.Add(cookie1);

                //
                //HttpCookie cookie2 = new HttpCookie("ASP.NET_SessionId", "");
                //cookie2.Expires = DateTime.Now.AddYears(-1);
                //Response.Cookies.Add(cookie2);

                foreach (string key in Request.Cookies.AllKeys)
                {
                    HttpCookie c = Request.Cookies[key];
                    c.Expires = DateTime.Now.AddYears(-1);
                    Response.AppendCookie(c);
                }
            }
        }

        protected void btnSignIn_ServerClick(object sender, EventArgs e)
        {
            //Response.Redirect("/Dashboard.aspx");
            try
            {
                string query = "select Username,UserPass,AccountTypeID,UserRoles from tblUsers where UserName = @username";
                command = new SqlCommand(query, connection);
                command.Parameters.Add("@username", SqlDbType.VarChar).Value = txtUsername.Text.Trim();
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                reader = command.ExecuteReader();
                if (reader.Read())
                {
                    if (reader["UserPass"].ToString() == txtPassword.Text.Trim())
                    {
                        string userrole = reader["UserRoles"].ToString();
                        string accounttypeId = reader["AccountTypeID"].ToString();

                        HttpCookie ckAccountType = new HttpCookie("accounttype", accounttypeId);

                        FormsAuthentication.SetAuthCookie(txtUsername.Text.Trim(), false);
                        FormsAuthenticationTicket ticket1 = new FormsAuthenticationTicket(
                                   1,                                   // version
                                this.txtUsername.Text.Trim(),   // get username  from the form
                                DateTime.Now,                        // issue time is now
                                DateTime.Now.AddMinutes(120),         // expires in 25 minutes
                                false,      // cookie is not persistent
                                userrole                            // role assignment is stored in userData
                                );
                        HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, FormsAuthentication.Encrypt(ticket1));
                        Response.Cookies.Add(cookie1);

                        Response.Cookies.Add(ckAccountType);

                        // 4. Do the redirect. 
                        String returnUrl1 = "/Dashboard.aspx";
                        if (accounttypeId == "1")
                            returnUrl1 = "/Dashboard.aspx";
                        else if (accounttypeId == "2")
                            returnUrl1 = "/CR/Dashboard.aspx";
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Sorry, you are not permitted to use this system','Login Failed');", true);
                            return;
                        }

                        // the login is successful
                        //if (Request.QueryString["ReturnUrl"] == null || Request.QueryString["ReturnUrl"] == "/")
                        //{
                        //    returnUrl1 = "/Dashboard.aspx";
                        //}
                        ////login not unsuccessful 
                        //else
                        //{
                        //    returnUrl1 = Request.QueryString["ReturnUrl"];
                        //}
                        Response.Redirect(returnUrl1);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Wrong Password','Login Failed');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('User does not exist','Login Failed');", true);
                }
                reader.Close();

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Login Failed');", true);
            }
            finally
            {
                connection.Close();
            }
        }
    }
}