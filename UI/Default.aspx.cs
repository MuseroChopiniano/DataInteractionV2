using BLL;
using BLL.Entities;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace UI
{
    public partial class _Default : Page
    {

        InteractionManager interactionManager = new InteractionManager();
        List<Interaction> interactions;

        CampaignManager campaignManager = new CampaignManager();
        List<Campaign> campaigns;

        decimal TotalSpending = 0;
        decimal TotalRevenue = 0;
        decimal ROI = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.LoadInteractionsByChannel();
            this.LoadRevenueByChannel();
            this.LoadCampaignData();
        }

        private void LoadInteractionsByChannel()
        {
            if (this.interactions == null){
                this.interactions = interactionManager.GetInteractions();
            }
            this.TotalInteractionSpan.InnerText = this.interactions.Count.ToString();
            List<String> labelsList = new List<string>();
            DateTime start = DateTime.Now;
            List<DateTime> last12 = (from r in Enumerable.Range(1, 12) select start.AddMonths(0 - r)).ToList();
            last12.Reverse();
            foreach (var item in last12)
            {
                labelsList.Add(item.Month.ToString() + "/"+ item.Year.ToString());
            }
           
            String[] labels = labelsList.ToArray();

            var result = this.interactions.Where(x => x.Date > DateTime.Now.AddMonths(-12)).GroupBy(i => new
            {
                i.Channel.Name,
                i.Date.Year,
                i.Date.Month,
            }).Select(g => new
            {
                g.Key.Name,
                my = g.Key.Month.ToString()  + "/" + g.Key.Year.ToString(),
                count = g.Count()
            }).GroupBy(
                x => new { x.Name }
                ).ToList();



            List<LineChartData> data = new List<LineChartData>();
            
            
            foreach (var item in result)
            {
                List<int> currentData = new List<int>();
                LineChartData chartData = new LineChartData() { label = item.Key.Name.ToString() };
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

            List<String> intByTypeList = new List<string>();
            List<int> intByTypeDataList = new List<int>();
            var intByTypeResult = interactions.GroupBy(x => x.Type).Select(y => new {
                y.Key,
                Counter = y.Count()
            });
            intByTypeResult.ToList().ForEach(x => { intByTypeList.Add(x.Key); intByTypeDataList.Add(x.Counter); }) ;
            String[] intByTypeLabels = intByTypeList.ToArray();


            int[] intByTypeData = intByTypeDataList.ToArray();


            string initialTag = "<script type=\"text/javascript\">";
            string endTag = "</script>";
            string labelScript = "var intByChannelLabels = ['" + string.Join("','",labels) + "'];";
            string datascript = "var intByChanneldata = " + JsonConvert.SerializeObject(data)+ ";" ;
            string intByTypeLabelScript = "var intByTypeLabels = " + JsonConvert.SerializeObject(intByTypeLabels) + ";";
            string intByTypeDataScript = "var intByTypeData = " + JsonConvert.SerializeObject(intByTypeData) + ";";
            string script = initialTag + labelScript + datascript + intByTypeLabelScript + intByTypeDataScript +  endTag;
            ClientScript.RegisterStartupScript(this.GetType(), "IntByChannel", script);
        }

        private void LoadRevenueByChannel()
        {
            if (this.interactions == null)
            {
                this.interactions = interactionManager.GetInteractions();
            }
            var result = this.interactions.GroupBy(x=>
                x.Channel.Name).Select(y => new
            {
                y.First().Channel.Name,
                revenue = y.Sum(z=>z.Revenue) 
            }).ToList() ;


            this.TotalRevenue = result.Sum(x => x.revenue);
            this.TotalRevenueSpan.InnerText =  this.TotalRevenue.ToString("c", CultureInfo.CurrentCulture);

            string initialTag = "<script type=\"text/javascript\">";
            string endTag = "</script>";
            string labelScript = "var revByChannelLabels = ['" + string.Join("','", result.Select(x=>x.Name).ToArray()) + "'];";
            string datascript = "var revByChannelValues = " + JsonConvert.SerializeObject(result.Select(x=>x.revenue).ToArray()) + ";";
            string script = initialTag + labelScript + datascript + endTag;
            ClientScript.RegisterStartupScript(this.GetType(), "RevByChannel", script);
        }

        private void LoadCampaignData()
        {
            if (this.campaigns == null)
            {
                this.campaigns = campaignManager.GetCampaigns();
            }
            this.TotalSpending = campaigns.Sum(x => x.ActualCost);
            this.TotalSpendingSpan.InnerText = this.TotalSpending.ToString("c", CultureInfo.CurrentCulture);
            this.calculateROI();

            var result = this.campaigns.GroupBy(x => x.Status).Select(y=> new { y.Key,counter =y.Count() });
            List<string> statusList = new List<string>();
            List<int> statusCountList = new List<int>();
            result.ToList().ForEach(x => { statusList.Add(x.Key);statusCountList.Add(x.counter); });
            String[] campaignStatusLabels = statusList.ToArray();
            int[] campaignStatusData = statusCountList.ToArray();



            List<String> campaignsLabels = new List<string>();
            List<decimal> campaignActualCosts = new List<decimal>();
            List<decimal> campaignBudgetedCosts = new List<decimal>();

            this.campaigns.ForEach(x =>
            {
                campaignsLabels.Add(x.Name);
                campaignActualCosts.Add(x.ActualCost);
                campaignBudgetedCosts.Add(x.BudgetedCost);
            });

            String[] campaignBudgetLabels = campaignsLabels.ToArray();
            decimal[] campaignActualSpentData = campaignActualCosts.ToArray();
            decimal[] campaignBudgetedData = campaignBudgetedCosts.ToArray();
            string initialTag = "<script type=\"text/javascript\">";
            string endTag = "</script>";
            string labelScript = "var campaignStatusLabels = " + JsonConvert.SerializeObject(campaignStatusLabels) + ";";
            string datascript = "var campaignStatusData = " + JsonConvert.SerializeObject(campaignStatusData) + ";";
            string campaignLabelsScript = "var campaignBudgetLabels = " + JsonConvert.SerializeObject(campaignBudgetLabels) + ";"; ;
            string campaignActualSpentDataScript = "var campaignActualSpentData = " + JsonConvert.SerializeObject(campaignActualSpentData) + ";"; ;
            string campaignBudgetedCostsScript = "var campaignBudgetedData = " + JsonConvert.SerializeObject(campaignBudgetedData) + ";"; ;
            string script = initialTag + labelScript + datascript + campaignLabelsScript + campaignActualSpentDataScript + campaignBudgetedCostsScript + endTag;
            ClientScript.RegisterStartupScript(this.GetType(), "BudgetVariance", script);
        }
        private void calculateROI() {
            if(this.TotalSpending > 0)
            {
                this.ROI = (this.TotalRevenue - this.TotalSpending) / this.TotalSpending;
            }
            this.ROISpan.InnerText = ROI.ToString("c", CultureInfo.CurrentCulture);
        }


        public class LineChartData
        {
            public string label;
            public int[] data;
        }
    }
}
