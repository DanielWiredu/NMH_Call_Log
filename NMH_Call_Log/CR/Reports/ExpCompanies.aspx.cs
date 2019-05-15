using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace NMH_Call_Log.CR.Reports
{
    public partial class ExpCompanies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void expCompGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                int exp = Convert.ToInt32(item["expiry"].Text);
                if (exp <= 0)
                {
                    item.BackColor = Color.LightPink;
                }
                //else
                //{
                //    item.BackColor = Color.GreenYellow;
                //}
            }
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {
            expCompGrid.MasterTableView.ExportToExcel();
        }
    }
}