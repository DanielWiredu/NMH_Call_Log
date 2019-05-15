using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace NMH_Call_Log.CR.Main
{
    public partial class Refunds : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            refundGrid.Rebind();
        }

        protected void refundGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Items")
            {
                GridDataItem item = e.Item as GridDataItem;
                hfClaimNo.Value = item["ClaimsNo"].Text;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showRefundItemModal();", true);
            }
            else if (e.CommandName == "Advice")
            {
                GridDataItem item = e.Item as GridDataItem;
                hfClaimNo.Value = item["ClaimsNo"].Text;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showRefundAdviceModal();", true);
            }
        }
    }
}