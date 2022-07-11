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
        UserManager manager = new UserManager();
        User contextUser = new User();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            this.contextUser.Id = int.Parse(ticket.UserData);
            if (!IsPostBack)
            {
                this.LoadData();
            }
            if (!manager.HasPermission(this.contextUser, "User-Create"))
            {
                this.newBtnContainer.Visible = false;
               
            }
        }

        private void LoadData()
        {
            if(manager.HasPermission(this.contextUser, "User-Read"))
            {
                UsersGridView.DataSource = manager.GetAll();
                UsersGridView.DataBind();
                noRowsDiv.Visible = UsersGridView.Rows.Count == 0;
                tableDiv.Visible = UsersGridView.Rows.Count > 0;
            }
           
        }

        protected void UsersGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow" && e.CommandArgument != null)
            {
                FormsIdentity id = (FormsIdentity)User.Identity;
                FormsAuthenticationTicket ticket = id.Ticket;
                int index = int.Parse((string)e.CommandArgument);
                manager.DeleteUser(new User() { Id = (int)UsersGridView.DataKeys[index].Value, LastModifiedById = int.Parse(ticket.UserData) })
               ;
                this.LoadData();
            }
        }

        protected void UsersGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            UsersGridView.PageIndex = e.NewPageIndex;
            this.LoadData();
        }
       
        protected bool HasDeletePermission()
        {
            return this.manager.HasPermission(this.contextUser, "User-Delete");
        }

        protected void UsersGridView_DataBound(object sender, EventArgs e)
        {
            if (!this.HasDeletePermission())
            {
                UsersGridView.Columns[UsersGridView.Columns.Count - 1].Visible=false;
            }
        }
    }
}