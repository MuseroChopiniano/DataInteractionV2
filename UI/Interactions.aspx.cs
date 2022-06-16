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
    public partial class Interactions : System.Web.UI.Page
    {
        InteractionManager manager = new InteractionManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            this.LoadGridView();

        }

        private void LoadGridView()
        {
            InteractionsGridView.DataSource = manager.GetInteractions();
            InteractionsGridView.DataBind();
        }

        protected void InteractionsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow" && e.CommandArgument != null)
            {
                int index = int.Parse((string)e.CommandArgument);
                manager.DeleteInteraction(new Interaction() { Id = (int)InteractionsGridView.DataKeys[index].Value })
               ;
                this.LoadGridView();
            }
        }
    }
}