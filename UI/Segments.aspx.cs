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
    public partial class Segments : System.Web.UI.Page
    {
        SegmentManager manager = new SegmentManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            this.LoadGridView();

        }

        private void LoadGridView()
        {
            SegmentsGridView.DataSource = manager.GetSegments();
            SegmentsGridView.DataBind();
        }

        protected void SegmentsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow" && e.CommandArgument != null)
            {
                int index = int.Parse((string)e.CommandArgument);
                manager.DeleteSegment(new Segment() { Id = (int)SegmentsGridView.DataKeys[index].Value })
               ;
                this.LoadGridView();
            }
        }
    }
}