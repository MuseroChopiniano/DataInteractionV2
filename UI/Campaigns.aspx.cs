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
    public partial class Campaigns : System.Web.UI.Page
    {
        CampaignManager manager = new CampaignManager();
        UserManager userManager = new UserManager();
        User contextUser = new User();
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            this.contextUser.Id = int.Parse(ticket.UserData);
            if (!IsPostBack) { 
                this.LoadGridView();
            }
            if (!userManager.HasPermission(this.contextUser, "Campaign-Create"))
            {
                this.newBtnContainer.Visible = false;
            }
        }

        private void LoadGridView()
        {
            if (userManager.HasPermission(this.contextUser, "Campaign-Read"))
            {
                List<Campaign> campaigns = manager.GetCampaigns();
                if (this.direction == SortDirection.Ascending)
                {
                    campaigns = campaigns.OrderBy(x => x.GetType().GetProperty(sortColumn).GetValue(x)).ToList();
                }
                else
                {
                    campaigns = campaigns.OrderByDescending(x => x.GetType().GetProperty(sortColumn).GetValue(x)).ToList();
                }
                CampaignsGridView.DataSource = campaigns;
                CampaignsGridView.DataBind();
                noRowsDiv.Visible = CampaignsGridView.Rows.Count == 0;
                tableDiv.Visible = CampaignsGridView.Rows.Count > 0;
            }
        }

        protected void CampaignsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow" && e.CommandArgument != null)
            {
                int index = int.Parse((string)e.CommandArgument);
                manager.DeleteCampaign(new Campaign() { Id = (int)CampaignsGridView.DataKeys[index].Value, LastModifiedById = this.contextUser.Id })
               ;
                this.LoadGridView();
            }
        }

        protected void CampaignsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.CampaignsGridView.PageIndex = e.NewPageIndex;
            this.LoadGridView();
        }

        protected bool HasDeletePermission()
        {
            return this.userManager.HasPermission(this.contextUser, "Campaign-Delete");
        }
        protected void CampaignsGridView_DataBound(object sender, EventArgs e)
        {
            if (!this.HasDeletePermission())
            {
                CampaignsGridView.Columns[CampaignsGridView.Columns.Count - 1].Visible = false;
            }

        }

        protected void CampaignsGridView_Sorting(object sender, GridViewSortEventArgs e)
        {
            this.sortColumn = e.SortExpression;
            if (direction == SortDirection.Ascending)
            {
                this.direction = SortDirection.Descending;
            }
            else
            {
                direction = SortDirection.Ascending;
            }
            this.LoadGridView();
        }
     
        public string sortColumn = "CreatedDate";

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
    }
}