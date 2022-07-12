using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using BLL.Entities;
using BLL.Mappers;

namespace UI
{
    public partial class Channels : System.Web.UI.Page
    {
        ChannelManager manager = new ChannelManager();
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
            if (!userManager.HasPermission(this.contextUser, "Channel-Create"))
            {
                this.newBtnContainer.Visible = false;

            }

        }

        private void LoadGridView()
        {
            if (userManager.HasPermission(this.contextUser, "Channel-Read"))
            {
                ChannelsGridView.DataSource = manager.GetChannels();
                ChannelsGridView.DataBind();
                noRowsDiv.Visible = ChannelsGridView.Rows.Count == 0;
                tableDiv.Visible = ChannelsGridView.Rows.Count > 0;
            }
            
        }

        protected void ChannelsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow" && e.CommandArgument != null)
            {
                int index = int.Parse((string)e.CommandArgument);
                manager.DeleteChannel(new Channel()
                {
                    Id = (int)ChannelsGridView.DataKeys[index].Value,
                    LastModifiedById = this.contextUser.Id
                });
               
                this.LoadGridView();
            }
        }

        protected void ChannelsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.ChannelsGridView.PageIndex = e.NewPageIndex;
            this.LoadGridView();
        }
        protected bool HasDeletePermission()
        {
            return this.userManager.HasPermission(this.contextUser, "Channel-Delete");
        }

        protected void ChannelsGridView_DataBound(object sender, EventArgs e)
        {
            if (!this.HasDeletePermission())
            {
                ChannelsGridView.Columns[ChannelsGridView.Columns.Count - 1].Visible = false;
            }
        }
    }
}