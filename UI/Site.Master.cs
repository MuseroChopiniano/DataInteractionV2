﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class SiteMaster : MasterPage
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        private void translatePage()
        {
            
        }

        private void translateControl(Control control)
        {
            
        }



        protected void CloseSessionBtn_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("Login.aspx", true);
        }

        private void loadLanguages()
        {
           
        }

        protected void LanguageList_SelectedIndexChanged(object sender, EventArgs e)
        {
           
        }

    }
}