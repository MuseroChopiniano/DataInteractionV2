using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using BLL.Entities;

namespace UI
{
    public partial class Users : System.Web.UI.Page
    {
        UserManager userManager = new UserManager();
        Encryptor encryptor = new Encryptor();
        LogManager logManager = new LogManager();
        FormsIdentity formsIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.LoadData();
            }
        }

        private void LoadData()
        {
            List<User> users = userManager.GetAll();
            UserGridView.DataSource = users;
            UserGridView.DataBind();
        }

        protected void UserGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
           // e.Row.Cells[4].Visible = false;
        }

        protected void SaveUserBtn_Click(object sender, EventArgs e)
        {
            LogEntity log = new LogEntity();
            string username = usernameTxt.Value;
            string email = emailTxt.Value;
            string status = statusTxt.Items[0].Value;
            User user = new User
            {
                Username = username,
                Email = email,
                Status = status 
            };
            if (UserIdTxt.Value != "")
            {
                user.Id = int.Parse(UserIdTxt.Value);
                log.Message = "User " + user.Username + " was modified";

            }
            else{ 
                user.Password = encryptor.GenerateHash("1234");
                log.Message = "User " + user.Username + " was created";
            }
            log.EventType = "User CRUD";
            userManager.UpsertUser(user);
            
            FormsAuthenticationTicket ticket = formsIdentity.Ticket;
            string userData = ticket.UserData;
            log.CreatedById = int.Parse(userData);
            log.LastModifiedById = int.Parse(userData);

            logManager.SaveLog(log);
            this.LoadData();
           


        }

        protected void UserGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = UserGridView.SelectedRow;
            UserIdTxt.Value = row.Cells[0].Text;
            usernameTxt.Value = row.Cells[1].Text;
            emailTxt.Value = row.Cells[2].Text;
        }
        protected void UserGridView_RowCreated(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            /*if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
                e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
                e.Row.ToolTip = "Click to select row";
                e.Row.Attributes["onclick"] = this.Page.ClientScript.GetPostBackClientHyperlink(this.UserGridView, "Select$" + e.Row.RowIndex);
            }*/
        }

        protected void ConfirmDeleteBtn_Click(object sender, EventArgs e)
        {
            User userToDelete = new User
            {
                Id = int.Parse(UserIdTxt.Value)

            };
            if (userManager.DeleteUser(userToDelete) == 1)
            {
                //logManager.Save(new BE.User() { Id = int.Parse(Session["Id"].ToString()) }, "The user " + userToDelete.Id + " has been deleted succesfully", "User Delete");
                this.LoadData();
            }
        }
    }
}