using BLL;
using BLL.Entities;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class SegmentGenerator : System.Web.UI.Page
    {
        InteractionManager interactionManager = new InteractionManager();
        SegmentManager manager = new SegmentManager();
        UserManager userManager = new UserManager();
        User contextUser = new User();
        string type;
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            this.contextUser.Id = int.Parse(ticket.UserData);
            this.type = Request.Params.Get("type");
            if (!IsPostBack)
            {
                if(this.type == "Engagement") {
                    this.GenerateMostEngageSegment();
                }
                if(this.type == "TotalSpend")
                {
                    this.GenerateBasedOnTotalSpend();
                }
                
            }
            if (!userManager.HasPermission(this.contextUser, "Segment-Create"))
            {
                //this.newBtnContainer.Visible = false;

            }

        }
        private void GenerateMostEngageSegment()
        {
            List<Interaction> interactions = interactionManager.GetInteractions();
            var result = interactions.FindAll(x => x.Customer.Age != 0).GroupBy(x => x.Customer.Id).ToList();

            int numClusters = 3;
            if(Request.Params.Get("clusters") != null)
            {
                int.TryParse(Request.Params.Get("clusters"), out numClusters);
            }
            double[][] data = new double[result.Count()][];
            for (int i = 0; i < result.Count(); i++)
            {
                data[i] = new double[] { result.ElementAt(i).Select(x => (double)x.Customer.Age).First(), result.ElementAt(i).Count(),result.ElementAt(i).Key };

            }
            if (numClusters < data.Length)
            {
                int[] clusters = ClusterHelper.Cluster(data, numClusters);
                string xTitle = "Age";
                string yTitle = "Number of Interactions";
                ShowSegmentData(data, clusters, numClusters,xTitle,yTitle);
                this.noRowsDiv.Visible = false;
            }
            else
            {
                this.canvasDiv.Visible = false;
                this.noRowsDiv.Visible = true;
                this.SaveBtn.Visible = false;
            }

        }
        private void GenerateBasedOnTotalSpend()
        {
            List<Interaction> interactions = interactionManager.GetInteractions();
            var result = interactions.FindAll(x => x.Customer.Id != 0).GroupBy(x => x.Customer.Id).ToList();

            int numClusters = 3;
            double[][] data = new double[result.Count()][];
            for (int i = 0; i < result.Count(); i++)
            {
                data[i] = new double[] {decimal.ToDouble(result.ElementAt(i).Sum(x=> x.Revenue)), result.ElementAt(i).Count(),result.ElementAt(i).Key };

            }
            if (numClusters < data.Length)
            {
                int[] clusters = ClusterHelper.Cluster(data, numClusters);
                string xTitle = "Total Spend";
                string yTitle = "Number of Interactions";
                this.canvasDiv.Visible = true;
                ShowSegmentData(data, clusters, numClusters, xTitle, yTitle);
                this.noRowsDiv.Visible = false;
            }
            else
            {
                this.canvasDiv.Visible = false;
                this.noRowsDiv.Visible = true;
                this.SaveBtn.Visible = false;
            }

        }

        String[] colors = new string[] { "#fe6384", "#36a2eb", "rgb(255, 205, 86)"};
        private void ShowSegmentData(double[][] data, int[] clusters, int numClusters,string xTitle, string yTitle)
        {
            Random rnd = new Random();
            List<SegmentChartData> datasets = new List<SegmentChartData>();
            for (int i = 0; i < numClusters; i++)
            {
                SegmentChartData chartData = new SegmentChartData();
                chartData.label = "Segment " + i.ToString();
                List<SegmentPoint> points = new List<SegmentPoint>();
                for (int j = 0; j < clusters.Length; j++)
                {
                    if (clusters[j] == i)
                    {
                        SegmentPoint point = new SegmentPoint();
                        point.x = data[j][0];
                        point.y = data[j][1];
                        point.id = Convert.ToInt32(data[j][2]);
                        points.Add(point);
                    }
                }
                chartData.data = points.ToArray();
               // chartData.backgroundColor = colors[i];
               
                datasets.Add(chartData);
            }

            string initialTag = "<script type=\"text/javascript\">";
            string endTag = "</script>";
            string xTitleScript = "var xTitle = \"" + xTitle + "\";";
            string yTitleScript = "var yTitle =\"" + yTitle + "\";";
            string dataScript = "var data = " + JsonConvert.SerializeObject(datasets.ToArray()) + ";";
            this.hiddenData.Value = JsonConvert.SerializeObject(datasets.ToArray());
            string script = initialTag + xTitleScript + yTitleScript + dataScript + endTag;
            ClientScript.RegisterStartupScript(this.GetType(), "SegmentScript", script);
        }
        protected void SaveBtn_Click(object sender, EventArgs e)
        {

            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            SegmentChartData[] data = JsonConvert.DeserializeObject<SegmentChartData[]>(this.hiddenData.Value);
            List<Segment> segmentsToSave = new List<Segment>();
            for (int i = 0; i < data.Length; i++)
            {
                Segment segment = new Segment();
                segment.Name = "Auto generated segment " + i.ToString() + " " + DateTime.Now.ToString();
                segment.Type = "Auto generated";
                segment.Description = "Auto generated segment";
                segment.CreatedById = this.contextUser.Id;
                segment.LastModifiedById = this.contextUser.Id;
                foreach (SegmentPoint item in data[i].data)
                {
                    segment.Customers.Add(new Customer() { Id = item.id });
                }
                segmentsToSave.Add(segment);
            }

            foreach (Segment item in segmentsToSave)
            {
                this.manager.UpsertSegment(item);
            }

            Response.Redirect("Segments.aspx");
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
            public int id;
        }

    }
}