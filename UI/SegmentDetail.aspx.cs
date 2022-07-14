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
        UserManager userManager = new UserManager();
        User contextUser = new User();
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            this.contextUser.Id = int.Parse(ticket.UserData);
            this.action = Request.Params.Get("action");
            if (this.action == null)
            {
                Response.Redirect("/SegmentDetail.aspx?action=new");
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
                if (!this.userManager.HasPermission(this.contextUser, "Segment-Edit"))
                {
                    Response.Redirect("/Auth/Unauthorized.aspx");
                }

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
            else if (action == "new")
            {
                if (!this.userManager.HasPermission(this.contextUser, "Segment-Create"))
                {
                    Response.Redirect("/Auth/Unauthorized.aspx");
                }
            }
            }
        private void BindData(Segment segment)
        {
            this.SegmentTypeTxt.Text = segment.Type;
            this.SegmentNameTxt.Text = segment.Name;
            this.SegmentDescriptionTxt.Text = segment.Description;
            this.LoadCustomers(segment);

        }

        private void LoadCustomers(Segment segment)
        {
            this.CustomersGridView.DataSource = segment.Customers;
            this.CustomersGridView.DataBind();
            noRowsDiv.Visible = CustomersGridView.Rows.Count == 0;
            tableDiv.Visible = CustomersGridView.Rows.Count > 0;
        }
        protected void CustomersGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow" && e.CommandArgument != null)
            {
                int index = int.Parse((string)e.CommandArgument);
                
            }
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

            }
            else
            {
                segmentToSave.CreatedById = this.contextUser.Id;
            }
            segmentToSave.Type = this.SegmentTypeTxt.Text;
            segmentToSave.Name = this.SegmentNameTxt.Text;
            segmentToSave.Description = this.SegmentDescriptionTxt.Text;
            segmentToSave.LastModifiedById = int.Parse(ticket.UserData);
            manager.UpsertSegment(segmentToSave);
            Response.Redirect("Segments.aspx");
        }
    }
}