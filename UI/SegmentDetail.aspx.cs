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
    public partial class SegmentDetail : System.Web.UI.Page
    {
        string action;
        SegmentManager manager = new SegmentManager();

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
                int segmentId = int.Parse(Request.Params.Get("id"));
                List<Segment> segments = manager.GetSegments();
                Segment selectedSegment = (from Segment c in segments
                                                   where c.Id == segmentId
                                                   select c).FirstOrDefault();
                if (selectedSegment != null)
                {
                    this.BindData(selectedSegment);
                }
            }
        }
        private void BindData(Segment segment)
        {
            this.SegmentTypeTxt.Text = segment.Type;
            this.SegmentNameTxt.Text = segment.Name;
            this.SegmentDescriptionTxt.Text = segment.Description;


        }

        protected void SaveBtn_Click(object sender, EventArgs e)
        {

            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            Segment segmentToSave = new Segment();
            if (action == "edit")
            {
                int segmentId = int.Parse(Request.Params.Get("id"));
                segmentToSave.Id = segmentId;
                segmentToSave.LastModifiedDate = DateTime.Now;
                segmentToSave.LastModifiedById = int.Parse(ticket.UserData);
            }
            segmentToSave.Type = this.SegmentTypeTxt.Text;
            segmentToSave.Name = this.SegmentNameTxt.Text;
            segmentToSave.Description = this.SegmentDescriptionTxt.Text;

            manager.UpsertSegment(segmentToSave);
            Response.Redirect("Segments.aspx");
        }
    }
}