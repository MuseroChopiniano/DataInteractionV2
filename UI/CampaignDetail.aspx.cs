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
    public partial class CampaignDetail : System.Web.UI.Page
    {
        string action;
        CampaignManager manager = new CampaignManager();
        UserManager userManager = new UserManager();
        User contextUser = new User();
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            this.contextUser.Id = int.Parse(ticket.UserData);
            this.action = Request.Params.Get("action");
            if (this.action == null)
            {
                Response.Redirect("/CampaignDetail.aspx?action=new");
            }
            if (!IsPostBack)
            {
                this.LoadData();
            }
        }

        private void LoadData()
        {
            if (action == "edit")
            {
                if (!this.userManager.HasPermission(this.contextUser, "Campaign-Edit"))
                {
                    Response.Redirect("/Auth/Unauthorized.aspx");
                }
                int campId = int.Parse(Request.Params.Get("id"));
                List<Campaign> campaigns = manager.GetCampaigns();
                Campaign selectedCamp = (from Campaign c in campaigns
                                         where c.Id == campId
                                         select c).FirstOrDefault();
                if (selectedCamp != null)
                {
                    this.BindData(selectedCamp);
                }
            }
            else if (action == "new")
            {
                if (!this.userManager.HasPermission(this.contextUser, "Campaign-Create"))
                {
                    Response.Redirect("/Auth/Unauthorized.aspx");
                }
            }
        }
        private void BindData(Campaign camp)
        {
            this.CampaignNameTxt.Text = camp.Name;
            this.CampaignstatusTxt.Text = camp.Status;
            this.CampaignActualCostTxt.Text = camp.ActualCost.ToString().Replace(",",".");
            this.CampaignBudgetedCostTxt.Text = camp.BudgetedCost.ToString().Replace(",", ".");
            this.CampaignDescriptionTxt.Text = camp.Description;
            this.CampaignEndDateTxt.Text = camp.EndDate.Date.ToString("yyyy-MM-dd");
            this.CampaignExpectedRevenueTxt.Text = camp.ExpectedRevenue.ToString().Replace(",", ".");
            this.CampaignStartDateTxt.Text = camp.StartDate.Date.ToString("yyyy-MM-dd");


        }

        protected void SaveBtn_Click(object sender, EventArgs e)
        {
            Campaign campToSave = new Campaign();
            if (action == "edit")
            {
                int campId = int.Parse(Request.Params.Get("id"));
                campToSave.Id = campId;
            }
            if(action == "new")
            {
                campToSave.CreatedById = this.contextUser.Id;
            }
            campToSave.Name = this.CampaignNameTxt.Text;
            campToSave.Status = this.CampaignstatusTxt.Text;
            campToSave.ActualCost = decimal.Parse(this.CampaignActualCostTxt.Text);
            campToSave.BudgetedCost = decimal.Parse(this.CampaignBudgetedCostTxt.Text);
            campToSave.Description = this.CampaignDescriptionTxt.Text;
            campToSave.EndDate = DateTime.Parse(this.CampaignEndDateTxt.Text);
            campToSave.ExpectedRevenue = decimal.Parse(this.CampaignExpectedRevenueTxt.Text);
            campToSave.StartDate = DateTime.Parse(this.CampaignStartDateTxt.Text);
            campToSave.LastModifiedById = this.contextUser.Id;
            manager.UpsertCampaign(campToSave);
            Response.Redirect("Campaigns.aspx");
        }
        protected void CancelBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Campaigns.aspx");
        }
    }
}