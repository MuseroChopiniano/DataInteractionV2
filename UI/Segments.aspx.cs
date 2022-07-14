using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using BLL.Entities;
using Newtonsoft.Json;

namespace UI
{
    public partial class Segments : System.Web.UI.Page
    {
        SegmentManager manager = new SegmentManager();
        InteractionManager interactionManager = new InteractionManager();
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
                this.GenerateMostEngageSegment();
            }
            if (!userManager.HasPermission(this.contextUser, "Segment-Create"))
            {
                this.newBtnContainer.Visible = false;

            }
        }

        private void LoadGridView()
        {
            if (userManager.HasPermission(this.contextUser, "Segment-Read"))
            {
                SegmentsGridView.DataSource = manager.GetSegments();
                   SegmentsGridView.DataBind();
                noRowsDiv.Visible = SegmentsGridView.Rows.Count == 0;
                tableDiv.Visible = SegmentsGridView.Rows.Count > 0;
            }
        }

        protected void SegmentsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow" && e.CommandArgument != null)
            {
                int index = int.Parse((string)e.CommandArgument);
                manager.DeleteSegment(new Segment() { Id = (int)SegmentsGridView.DataKeys[index].Value, LastModifiedById = this.contextUser.Id })
               ;
                this.LoadGridView();
            }
        }

        protected void SegmentsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.SegmentsGridView.PageIndex = e.NewPageIndex;
            this.LoadGridView();
        }

        private void GenerateMostEngageSegment()
        {
            List<Interaction> interactions = interactionManager.GetInteractions();
            var result = interactions.FindAll(x=>x.Customer != null).GroupBy(x => x.Customer.Id).ToList();

            int numClusters = 3;
            double[][] data = new double[result.Count()][];
            for (int i = 0; i < result.Count(); i++)
            {
                data[i] = new double[] { result.ElementAt(i).Select(x => (double)x.Customer.Age).First(), result.ElementAt(i).Count() };

            }
            if(numClusters< data.Length) {
                int[] clusters = ClusterHelper.Cluster(data, numClusters);
                ShowSegmentData(data, clusters, numClusters);
            }
            
        }
        
        String[] colors = new string[]{ "#fe6384", "#36a2eb", "rgb(255, 205, 86)" };
        private void ShowSegmentData(double[][] data, int[] clusters, int numClusters)
        {
            List<SegmentChartData> datasets = new List<SegmentChartData>();
            for(int i = 0; i < numClusters; i++)
            {
                SegmentChartData chartData = new SegmentChartData();
                chartData.label = "Segment " + i.ToString();
                List<SegmentPoint> points = new List<SegmentPoint>();
                for(int j = 0; j < clusters.Length; j++)
                {
                    if (clusters[j] == i)
                    {
                        SegmentPoint point = new SegmentPoint();
                        point.x = data[j][0];
                        point.y = data[j][1];
                        points.Add(point);
                    }
                }
                chartData.data = points.ToArray();
                chartData.backgroundColor = colors[i];
                datasets.Add(chartData);
            }
            


            string xTitle = "Age";
            string yTitle = "Number of Interactions";
            
            string initialTag = "<script type=\"text/javascript\">";
            string endTag = "</script>";
            string xTitleScript = "var xTitle = \"" + xTitle + "\";";
            string yTitleScript = "var yTitle =\"" + yTitle + "\";";
            string dataScript = "var data = " + JsonConvert.SerializeObject(datasets.ToArray()) + ";";
          
            string script = initialTag + xTitleScript + yTitleScript + dataScript  + endTag;
            ClientScript.RegisterStartupScript(this.GetType(), "SegmentScript", script);
        }
        public class SegmentChartData
        {
            public string label;
            public SegmentPoint[] data;
            public string backgroundColor;
        }
        public class SegmentPoint
        {
            public double x;
            public double y;
        }

        protected bool HasDeletePermission()
        {
            return this.userManager.HasPermission(this.contextUser, "Segment-Delete");
        }

        protected void SegmentsGridView_DataBound(object sender, EventArgs e)
        {
            if (!this.HasDeletePermission())
            {
                SegmentsGridView.Columns[SegmentsGridView.Columns.Count - 1].Visible = false;
            }

        }

        protected void SaveSegmentBtn_Click(object sender, EventArgs e)
        {

        }
    }
}