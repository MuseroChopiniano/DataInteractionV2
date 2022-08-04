using BLL;
using BLL.Entities;
using System;
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
            this.LoadMenu();
           
        }
        private void LoadMenu()
        {
            FormsIdentity id = (FormsIdentity)Page.User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            User contextualUser = new User() { Id = int.Parse(ticket.UserData) };

            UserManager manager = new UserManager();
            this.usernameSpan.InnerText = ticket.Name;
            this.CampaignMenu.Visible = manager.HasPermission(contextualUser,"Campaign-Read"); 
            this.ChannelMenu.Visible = manager.HasPermission(contextualUser,"Channel-Read");
            this.CustomerMenu.Visible = manager.HasPermission(contextualUser, "Customer-Read");
            this.InteractionMenu.Visible = manager.HasPermission(contextualUser, "Interaction-Read");
            this.JourneyMenu.Visible = manager.HasPermission(contextualUser, "Journey-Read");
            this.LogMenu.Visible = manager.HasPermission(contextualUser, "Log-Read");
            this.PermissionMenu.Visible = manager.HasPermission(contextualUser, "Permission-Read");
            this.SegmentMenu.Visible = manager.HasPermission(contextualUser, "Segment-Read");
            this.UserMenu.Visible = manager.HasPermission(contextualUser, "User-Read");
        }

        private void translatePage()
        {
            
        }

        private void translateControl(Control control)
        {
            
        }



        protected void CloseSessionBtn_Click(object sender, EventArgs e)
        {
            FormsIdentity id = (FormsIdentity) Page.User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            int contextUserId = int.Parse(ticket.UserData);
            FormsAuthentication.SignOut();
            LogManager logManager = new LogManager();
            logManager.SaveLog(new LogEntity()
            {
                EventType = EventType.Logout,
                Entity = "User",
                Message = "The User with Id " + contextUserId  + " has logged out",
                LastModifiedById = contextUserId,
                CreatedById = contextUserId
            });
            Response.Redirect("Login.aspx", true);
        }

        private void loadLanguages()
        {
           
        }

        protected void LanguageList_SelectedIndexChanged(object sender, EventArgs e)
        {
           
        }

        protected void ChangePwdBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("ChangePassword.aspx");
        }
    }
}
