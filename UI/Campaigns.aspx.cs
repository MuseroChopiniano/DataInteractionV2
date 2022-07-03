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
    public partial class Campaigns : System.Web.UI.Page
    {
        CampaignManager manager = new CampaignManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            this.LoadGridView();

        }

        private void LoadGridView()
        {
            CampaignsGridView.DataSource = manager.GetCampaigns();
            CampaignsGridView.DataBind();
        }

        protected void CampaignsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow" && e.CommandArgument != null)
            {
                int index = int.Parse((string)e.CommandArgument);
                manager.DeleteCampaign(new Campaign() { Id = (int)CampaignsGridView.DataKeys[index].Value })
               ;
                this.LoadGridView();
            }
        }

        protected void CampaignsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.CampaignsGridView.PageIndex = e.NewPageIndex;
            this.LoadGridView();
        }
    }
}