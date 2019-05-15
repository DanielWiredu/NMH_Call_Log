using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NMH_Call_Log
{
    public class MasterPageChange : System.Web.UI.Page
    {
        protected override void OnPreInit(EventArgs e)
        {
            this.MasterPageFile = "~/Home.Master";
            string accounttype = Request.Cookies["accounttype"].Value;
            if (accounttype != null)    //check the user weather user is logged in or not
            {
                if (accounttype == "1")
                {
                    this.MasterPageFile = "~/Home.Master";
                }
                else if (accounttype == "2")
                {
                    this.MasterPageFile = "~/CRHome.Master";
                }
            }
            base.OnPreInit(e);
        }
    }
}