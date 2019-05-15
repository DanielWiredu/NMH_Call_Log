using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace NMH_Call_Log.CR.Company
{
    public partial class CompanyList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            companyGrid.Rebind();
        }

        protected void companyGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Details")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/CR/Company/ViewCompany.aspx?cid=" + item["ID"].Text);
            }
        }
    }
}