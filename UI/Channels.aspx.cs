using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
        protected void Page_Load(object sender, EventArgs e)
        {
            this.LoadGridView();

        }

        private void LoadGridView()
        {
            ChannelsGridView.DataSource = manager.GetChannels();
            ChannelsGridView.DataBind();
        }

        protected void ChannnelsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow" && e.CommandArgument != null)
            {
                int index = int.Parse((string)e.CommandArgument);
                manager.DeleteChannel(new Channel() { Id = (int)ChannelsGridView.DataKeys[index].Value })
               ;
                this.LoadGridView();
            }
        }
    }
}