using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace NMH_Call_Log.Main
{
    public partial class MemberBenefits : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            memberBenefitGrid.Rebind();
        }

        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            memberBenefitGrid.MasterTableView.UseAllDataFields = true;
            memberBenefitGrid.MasterTableView.GroupsDefaultExpanded = true;
            memberBenefitGrid.MasterTableView.ExportToExcel();
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
            String sql = "SELECT top(100) ID, MemberNo, FullName, Company, [Plan], Status FROM [Vw_Members] WHERE FullName LIKE '%" + e.Text.ToUpper() + "%' OR MemberNo LIKE '%" + e.Text.ToUpper() + "%'";
            memberSource.SelectCommand = sql;
            dlMember.DataBind();
        }

        protected void dlMember_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            memberBenefitGrid.Rebind();
        }
    }
}