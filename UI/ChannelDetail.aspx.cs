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
    public partial class ChannelDetail : System.Web.UI.Page
    {
        string action;
        ChannelManager manager = new ChannelManager();
        User contextUser = new User();
        UserManager userManager = new UserManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            this.contextUser.Id = int.Parse(ticket.UserData);
            this.action = Request.Params.Get("action");
            if (this.action == null)
            {
                Response.Redirect("/ChannelDetail.aspx?action=new");
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
                if (!this.userManager.HasPermission(this.contextUser, "Channel-Edit"))
                {
                    Response.Redirect("/Auth/Unauthorized.aspx");
                }
                int channelId = int.Parse(Request.Params.Get("id"));
                List<Channel> channels = manager.GetChannels();
                Channel selectedChannel = (from Channel c in channels
                                           where c.Id == channelId
                                           select c).FirstOrDefault();
                if (selectedChannel != null)
                {
                    this.BindData(selectedChannel);
                }
            }
            else if (action == "new")
            {
                if (!this.userManager.HasPermission(this.contextUser, "Channel-Create"))
                {
                    Response.Redirect("/Auth/Unauthorized.aspx");
                }
            }
        }
        private void BindData(Channel channel)
        {
            this.ChannelNameTxt.Text = channel.Name;
            this.ChannelTypeTxt.Text = channel.Type;
        }

        protected void SaveBtn_Click(object sender, EventArgs e)
        {
            Channel channelToSave = new Channel();
            if (action == "edit")
            {
                int channelId = int.Parse(Request.Params.Get("id"));
                channelToSave.Id = channelId;
               
            }
            else
            {
                channelToSave.CreatedById = this.contextUser.Id;
            }
            channelToSave.Name = this.ChannelNameTxt.Text;
            channelToSave.Type = this.ChannelTypeTxt.Text;
            channelToSave.LastModifiedById = this.contextUser.Id;
            manager.UpsertChannel(channelToSave);
            Response.Redirect("Channels.aspx");
        }
    }
}