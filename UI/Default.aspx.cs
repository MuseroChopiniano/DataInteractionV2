using BLL;
using BLL.Entities;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace UI
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.LoadInteractionsByChannel();   
        }

        private void LoadInteractionsByChannel()
        {
            InteractionManager interactionManager = new InteractionManager();
            List<Interaction> interactions = interactionManager.GetInteractions();

         
                     
            List<String> labelsList = new List<string>();
            DateTime start = DateTime.Now;
            List<DateTime> last12 = (from r in Enumerable.Range(1, 12) select start.AddMonths(0 - r)).ToList();
            last12.Reverse();
            foreach (var item in last12)
            {
                labelsList.Add(item.Month.ToString() + "/"+ item.Year.ToString());
            }
           
            String[] labels = labelsList.ToArray();

            var result = interactions.Where(x => x.Date > DateTime.Now.AddMonths(-12)).GroupBy(i => new
            {
                i.Channel.Id,
                i.Date.Year,
                i.Date.Month,
            }).Select(g => new
            {
                g.Key.Id,
                my = g.Key.Month.ToString()  + "/" + g.Key.Year.ToString(),
                count = g.Count()
            }).GroupBy(
                x => new { x.Id }
                ).ToList();



            List<LineChartData> data = new List<LineChartData>();
            string lastID = "";
            
            foreach (var item in result)
            {
                List<int> currentData = new List<int>();
                LineChartData chartData = new LineChartData() { label = item.Key.Id.ToString() };
                foreach (var month in labelsList)
                {
                    int counter = 0;
                    foreach (var group in item)
                    {
                        if(group.my == month)
                        {
                            counter = group.count;
                            break;
                        }
                    }
                    currentData.Add(counter);
                }
                chartData.data = currentData.ToArray();
                data.Add(chartData);
                currentData.Clear();

            }
           
            string initialTag = "<script type=\"text/javascript\">";
            string endTag = "</script>";
            string labelScript = "var intByChannelLabels = ['" + string.Join("','",labels) + "'];";
            string datascript = "var intByChanneldata = " + JsonConvert.SerializeObject(data)+ ";" ;
            string script = initialTag + labelScript + datascript +  endTag;
            ClientScript.RegisterStartupScript(this.GetType(), "IntByChannel", script);
        }

        public class LineChartData
        {
            public string label;
            public int[] data;
        }
    }
}
