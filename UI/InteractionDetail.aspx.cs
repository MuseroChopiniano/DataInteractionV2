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
    public partial class InteractionDetail : System.Web.UI.Page
    {
      
            string action;
            InteractionManager manager = new InteractionManager();

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
                    int interactionId = int.Parse(Request.Params.Get("id"));
                    List<Interaction> interactions = manager.GetInteractions();
                    Interaction selectedInteraction = (from Interaction c in interactions
                                             where c.Id == interactionId
                                             select c).FirstOrDefault();
                    if (selectedInteraction != null)
                    {
                        this.BindData(selectedInteraction);
                    }
                }
            }
            private void BindData(Interaction interaction)
            {
                this.InteractionTypeTxt.Text = interaction.Type;
                this.InteractionDateTxt.Text = interaction.Date.ToString("yyyy-MM-dd");
                this.InteractionRevenueTxt.Text = interaction.Revenue.ToString();
               

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
                    interactionToSave.LastModifiedDate = DateTime.Now;
                    interactionToSave.LastModifiedById = int.Parse(ticket.UserData);
                }
                interactionToSave.Type = this.InteractionTypeTxt.Text;
                interactionToSave.Date = DateTime.Parse(this.InteractionDateTxt.Text);
                interactionToSave.Revenue = decimal.Parse(this.InteractionRevenueTxt.Text);
              
                manager.UpsertInteraction(interactionToSave);
                Response.Redirect("Interactions.aspx");
            }
        }
    
}