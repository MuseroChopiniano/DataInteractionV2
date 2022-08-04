using BLL;
using BLL.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private UserManager manager = new UserManager();
        protected void SaveBtn_Click(object sender, EventArgs e)
        {
            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            User contextUser = new User() { Id = int.Parse(ticket.UserData), Username = ticket.Name };
            string currentPass = CurrentPasswordTxt.Text;
            string newPass = NewPasswordTxt.Text;
            contextUser = manager.ValidateExistence(contextUser);
            if (manager.ValidatePassword(currentPass, contextUser))
            {
                Encryptor encryptor = new Encryptor();
                newPass = encryptor.GenerateHash(newPass);
                contextUser.Password = newPass;
                contextUser.LastModifiedById = contextUser.Id;
                manager.UpsertUser(contextUser);
                Response.Redirect("Default.aspx");
            }
            else
            {
                this.errorMessage.InnerText = "The password is wrong";
                this.errorMessage.Visible = true;
            }
                
        }
    }
}