using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using BLL.Entities;

namespace UI
{
    public partial class InteractionDetail : System.Web.UI.Page
    {
        
        UserManager userManager = new UserManager();
        User contextUser = new User();
        string action;
        InteractionManager manager = new InteractionManager();

        protected void Page_Load(object sender, EventArgs e)
        {
            
            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            this.contextUser.Id = int.Parse(ticket.UserData);
            this.action = Request.Params.Get("action");
            if (this.action == null && Context.Request.HttpMethod != "POST" )
            {
                Response.Redirect("/InteractionDetail.aspx?action=new");
            }
            LoadDropDowns();
            if (!IsPostBack)
            {
                this.LoadData();
            }
        }

        private void LoadData()
        {
            if (action == "edit")
            {
                if (!this.userManager.HasPermission(this.contextUser, "Interaction-Edit"))
                {
                    Response.Redirect("/Auth/Unauthorized.aspx");
                }
                int interactionId = int.Parse(Request.Params.Get("id"));
                List<Interaction> interactions = manager.GetInteractions();
                Interaction selectedInteraction = (from Interaction c in interactions
                                                   where c.Id == interactionId
                                                   select c).FirstOrDefault();
                if (selectedInteraction != null)
                {
                    this.BindData(selectedInteraction);
                }
                else if (action == "new")
                {
                    if (!this.userManager.HasPermission(this.contextUser, "Interaction-Create"))
                    {
                        Response.Redirect("/Auth/Unauthorized.aspx");
                    }
                }
            }
        }
        private void BindData(Interaction interaction)
        {
            this.InteractionTypeTxt.Text = interaction.Type;
            this.InteractionDateTxt.Text = interaction.Date.ToString("yyyy-MM-dd");
            this.InteractionRevenueTxt.Text = interaction.Revenue.ToString();
            this.InteractionChannelDropdown.SelectedValue = interaction.Channel.Id.ToString();
            this.InteractionCustomerDropdown.SelectedValue = interaction.Customer.Id.ToString();
            this.InteractionCampaignDropdown.SelectedValue = interaction.Campaign.Id.ToString();
        }

        protected void SaveBtn_Click(object sender, EventArgs e)
        {

            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            Interaction interactionToSave = new Interaction();
            if (action == "edit")
            {
                int interactionId = int.Parse(Request.Params.Get("id"));
                interactionToSave.Id = interactionId;
                interactionToSave.LastModifiedById = int.Parse(ticket.UserData);
            }
            if (action == "new")
            {
                interactionToSave.CreatedById = this.contextUser.Id;
            }
            interactionToSave.Channel = new Channel(int.Parse(this.InteractionChannelDropdown.SelectedValue));
            interactionToSave.Customer = new Customer() { Id = int.Parse(this.InteractionCustomerDropdown.SelectedValue) };
            interactionToSave.Campaign = new Campaign() {Id = int.Parse(this.InteractionCampaignDropdown.SelectedValue)};
            interactionToSave.LastModifiedById = int.Parse(ticket.UserData);
            interactionToSave.Type = this.InteractionTypeTxt.Text;
            interactionToSave.Date = DateTime.Parse(this.InteractionDateTxt.Text);
            interactionToSave.Revenue = decimal.Parse(this.InteractionRevenueTxt.Text);

            manager.UpsertInteraction(interactionToSave);
            Response.Redirect("Interactions.aspx");
        }

        private void LoadDropDowns()
        {
            foreach (Channel channel in this.getChannels())
            {
                InteractionChannelDropdown.Items.Add(
                    new ListItem(channel.Name, channel.Id.ToString())
                    ) ;
            }
            foreach (Customer cust in this.GetCustomers())
            {
                InteractionCustomerDropdown.Items.Add(
                    new ListItem(cust.Name, cust.Id.ToString())
                    );
            }
            foreach (Campaign camp in this.GetCampaigns())
            {
                InteractionCampaignDropdown.Items.Add(
                    new ListItem(camp.Name, camp.Id.ToString())
                    );
            }
        }

        private List<Channel> getChannels()
        {
            ChannelManager channelManager = new ChannelManager();
            List<Channel> channels = channelManager.GetChannels();
            return channels;
        }
        private List<Campaign> GetCampaigns()
        {
            CampaignManager campMamager = new CampaignManager();
            List<Campaign> campaigns = campMamager.GetCampaigns();
            return campaigns;
        }
        private List<Customer> GetCustomers()
        {
            CustomerManager custManager = new CustomerManager();
            List<Customer> customers = custManager.GetCustomers();
            return customers;
        }
    }
}