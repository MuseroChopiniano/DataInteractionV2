using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using BLL.Entities;
using BLL;


namespace UI
{
    public partial class Login : System.Web.UI.Page
    {
        private UserManager manager = new UserManager();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LoginBtn_Click(object sender, EventArgs e)
        {
            String username = UsernameTxt.Text;
            String password = PasswordTxt.Text;
            User currentUser = new User() { Username = username, Password = password };
            //TODO: Validate Properly 
            if (this.ValidateExistence(ref currentUser))
            {
                if (manager.ValidatePassword(password, currentUser)) {
                    if (!currentUser.IsBlocked()) {
                        currentUser.BlockCounter = 0;
                        manager.UpsertUser(currentUser);
                        FormsAuthenticationTicket ticket;
                        string cookieString;
                        HttpCookie cookie;
                        ticket = new FormsAuthenticationTicket(1, username, DateTime.Now,
                        DateTime.Now.AddMinutes(30), Persist.Checked, currentUser.Id.ToString());
                        cookieString = FormsAuthentication.Encrypt(ticket);
                        cookie = new HttpCookie(FormsAuthentication.FormsCookieName, cookieString);
                        if (Persist.Checked)
                            cookie.Expires = ticket.Expiration;
                        cookie.Path = FormsAuthentication.FormsCookiePath;
                        Response.Cookies.Add(cookie);
                        string strRedirect;
                        strRedirect = Request["ReturnUrl"];
                        if (strRedirect == null)
                            strRedirect = "Default.aspx";
                        Response.Redirect(strRedirect, true);
                    }
                    else
                    {
                        this.errorMessage.InnerText = "The user is blocked";
                        this.errorMessage.Visible = true;
                       //TODO: show Blocked Message
                    }
                }
                else
                {
                    currentUser.IncreaseBlockCounter();
                    manager.UpsertUser(currentUser);
                    this.errorMessage.InnerText = "The user or Password that you're trying to use is wrong";
                    this.errorMessage.Visible = true;

                }
            }
            else
            {
                this.errorMessage.InnerText = "The user or Password that you're trying to use is wrong";
                this.errorMessage.Visible = true;
             //   Response.Redirect("Login.aspx", true);
            }
        }

        private bool ValidateExistence(ref User user)
        {
            user =  this.manager.ValidateExistence(user);
            return user.Id != 0;
        }   
    }
}