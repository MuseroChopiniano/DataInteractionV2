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
    public partial class Logs : System.Web.UI.Page
    {
        LogManager logManager = new LogManager();
        UserManager userManager = new UserManager();
        User contextUser = new User();
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            this.contextUser.Id = int.Parse(ticket.UserData);
            if (!IsPostBack)
            {
                this.LoadGridView();
            }
        }

        private void LoadGridView()
        {
            if (userManager.HasPermission(this.contextUser, "Log-Read"))
            {
                LogsGridView.DataSource = logManager.GetLogs();
                LogsGridView.DataBind();
                noRowsDiv.Visible = LogsGridView.Rows.Count == 0;
                tableDiv.Visible = LogsGridView.Rows.Count > 0;
            }
        }

        protected void LogsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.LogsGridView.PageIndex = e.NewPageIndex;
            this.LoadGridView();
        }
    }
}