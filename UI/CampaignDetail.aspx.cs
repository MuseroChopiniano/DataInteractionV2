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
    public partial class CampaignDetail : System.Web.UI.Page
    {
        string action;
        CampaignManager manager = new CampaignManager();

        protected void Page_Load(object sender, EventArgs e)
        {
            this.action = Request.Params.Get("action");
            if (!IsPostBack)
            {
                this.LoadData();
            }
        }

        private void LoadData()
        {
            if (action == "edit")
            {
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
        }
        private void BindData(Campaign camp)
        {
            this.CampaignNameTxt.Text = camp.Name;
            this.CampaignstatusTxt.Text = camp.Status;
            this.CampaignActualCostTxt.Text = camp.ActualCost.ToString();
            this.CampaignBudgetedCostTxt.Text = camp.BudgetedCost.ToString();
            this.CampaignDescriptionTxt.Text = camp.Description;
            this.CampaignEndDateTxt.Text = camp.EndDate.Date.ToString("yyyy-MM-dd");
            this.CampaignExpectedRevenueTxt.Text = camp.ExpectedRevenue.ToString();
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
            campToSave.Name = this.CampaignNameTxt.Text;
            campToSave.Status = this.CampaignstatusTxt.Text;
            campToSave.ActualCost = decimal.Parse(this.CampaignActualCostTxt.Text);
            campToSave.BudgetedCost = decimal.Parse(this.CampaignBudgetedCostTxt.Text);
            campToSave.Description = this.CampaignDescriptionTxt.Text;
            campToSave.EndDate = DateTime.Parse(this.CampaignEndDateTxt.Text);
            campToSave.ExpectedRevenue = decimal.Parse(this.CampaignExpectedRevenueTxt.Text);
            campToSave.StartDate = DateTime.Parse(this.CampaignStartDateTxt.Text);
            manager.UpsertCampaign(campToSave);
            Response.Redirect("Campaigns.aspx");
        }
    }
}