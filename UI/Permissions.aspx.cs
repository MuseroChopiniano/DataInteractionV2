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
    public partial class Permissions : System.Web.UI.Page
    {
        PermissionManager manager = new PermissionManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            this.LoadGridView();
        }
        private void LoadGridView()
        {
            PermissionsGridView.DataSource = manager.GetParentPermissions();
            PermissionsGridView.DataBind();
            noRowsDiv.Visible = PermissionsGridView.Rows.Count == 0;
            tableDiv.Visible = PermissionsGridView.Rows.Count > 0 ;

        }

        protected void PermissionsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow" && e.CommandArgument != null)
            {
                FormsIdentity id = (FormsIdentity)User.Identity;
                FormsAuthenticationTicket ticket = id.Ticket;
                int index = int.Parse((string)e.CommandArgument);
                manager.DeletePermission(new Permission() { Id = (int)PermissionsGridView.DataKeys[index].Value, LastModifiedById = int.Parse(ticket.UserData) })
               ;
                this.LoadGridView();
            }
        }
        protected void PermissionsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            PermissionsGridView.PageIndex = e.NewPageIndex;
            this.LoadGridView();
        }
    }
}