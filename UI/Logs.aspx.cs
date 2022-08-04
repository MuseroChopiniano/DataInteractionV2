using System;
using System.Collections.Generic;
using System.Data;
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
        string sortColumn = "CreatedDate";
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
                List<LogEntity> logs = logManager.GetLogs();
                if (direction == SortDirection.Ascending)
                {
                    logs = logs.OrderBy(x => x.GetType().GetProperty(sortColumn).GetValue(x)).ToList();
                }
                else
                {
                    logs = logs.OrderByDescending(x => x.GetType().GetProperty(sortColumn).GetValue(x)).ToList();
                }
                LogsGridView.DataSource = logs;
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
        public SortDirection direction
        {
            get
            {
                if (ViewState["directionState"] == null)
                {
                    ViewState["directionState"] = SortDirection.Ascending;
                }
                return (SortDirection)ViewState["directionState"];
            }
            set
            {
                ViewState["directionState"] = value;
            }
        }
        protected void LogsGridView_Sorting(object sender, GridViewSortEventArgs e)
        {
            this.sortColumn = e.SortExpression;
            if(direction == SortDirection.Ascending)
            {
                this.direction = SortDirection.Descending;
            }
            else
            {
                direction = SortDirection.Ascending;
            }
            this.LoadGridView();
        }
    }
}