using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using BLL.Entities;

namespace UI
{
    public partial class Logs : System.Web.UI.Page
    {
        LogManager logManager = new LogManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            this.LoadGridView();

        }

        private void LoadGridView()
        {
            LogsGridView.DataSource = logManager.GetLogs();
            LogsGridView.DataBind();
        }

        protected void LogsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.LogsGridView.PageIndex = e.NewPageIndex;
            this.LoadGridView();
        }
    }
}