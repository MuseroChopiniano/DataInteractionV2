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
    public partial class ChannelDetail : System.Web.UI.Page
    {
        string action;
        ChannelManager manager = new ChannelManager();

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
            channelToSave.Name = this.ChannelNameTxt.Text;
            channelToSave.Type = this.ChannelTypeTxt.Text;
           
            manager.UpsertChannel(channelToSave);
            Response.Redirect("Channels.aspx");
        }
    }
}