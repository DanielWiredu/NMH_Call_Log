using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Drawing;

namespace NMH_Call_Log.Main
{
    public partial class CallLog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            callGrid.Rebind();
        }

        protected void callGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/Main/EditCallLog.aspx?CallId=" + item["CallId"].Text);
            }
        }

        protected void callGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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

        protected void callGrid_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                if (item["EscalatedStatus"].Text == "Pending")
                {
                    item.BackColor = Color.LightPink;
                }
                else if (item["EscalatedStatus"].Text == "Completed")
                {
                    item.BackColor = Color.GreenYellow;
                }

                string description = item["Description"].Text;
                if (description.Length > 28)
                {
                    item["Description"].Text = description.Substring(0, 28);
                    item["Description"].ToolTip = description;
                }

                //if (item["Escalated"].Text == "True")
                //{
                //    if (item["EscalatedStatus"].Text == "Pending")
                //    {
                //        item.BackColor = Color.Orange;
                //    }
                //    else if (item["EscalatedStatus"].Text == "Completed")
                //    {
                //        item.BackColor = Color.GreenYellow;
                //    }
                //}

                //if (!User.IsInRole("1"))
                //{
                //    Button btnDel = (Button) item["Delete"].Controls[0];
                //    btnDel.Enabled = false;
                //}
            }
        }

        protected void callGrid_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            if (User.IsInRole("Call Center Admin"))
            {
                try
                {
                    callGrid.MasterTableView.PerformDelete(e.Item as GridDataItem);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error(''" + ex.Message.Replace("'", "").Replace("\r\n", "") + "'','Error');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Sorry, you cannot delete a log. Please contact the Administrator', 'Access Denied');", true);
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Main/NewCallLog.aspx?CallerNo=" + txtSearch.Text);
        }
    }
}