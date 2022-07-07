using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
        protected void Page_Load(object sender, EventArgs e)
        {
            this.LoadGridView();
            this.GenerateMostEngageSegment();
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

        protected void SegmentsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.SegmentsGridView.PageIndex = e.NewPageIndex;
            this.LoadGridView();
        }

        private void GenerateMostEngageSegment()
        {
            List<Interaction> interactions = interactionManager.GetInteractions();
            var result = interactions.GroupBy(x => x.Customer.Id).ToList();

            int numClusters = 3;
            double[][] data = new double[result.Count()][];
            for (int i = 0; i < result.Count(); i++)
            {
                data[i] = new double[] { result.ElementAt(i).Select(x => (double)x.Customer.Age).First(), result.ElementAt(i).Count() };

            }

            int[] clusters = ClusterHelper.Cluster(data, numClusters);
            ShowSegmentData(data, clusters, numClusters);
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
    }
}