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
    public partial class Journeys : System.Web.UI.Page
    {
        InteractionManager interactionManager = new InteractionManager();
        List<Interaction> interactions;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.generateJourneyData();
        }

        private void generateJourneyData()
        {
            if(this.interactions == null)
            {
                this.interactions = this.interactionManager.GetInteractions();
            }

            var result = interactions.OrderBy(x => x.Date).GroupBy(y => y.Customer.Id).ToList();

            HashSet<string> labels = new HashSet<string>();
           
            Dictionary<String, int> sourceTargetDict = new Dictionary<string, int>();
            result.ForEach(x =>
            {
                for (int i = 1; i < x.Count(); i++)
                {
                    String sourceType = x.ElementAt(i - 1).Type;
                    labels.Add(sourceType);
                   
                    string targetType = x.ElementAt(i).Type;
                    labels.Add(targetType);


                    if (sourceTargetDict.ContainsKey(sourceType + "-" + targetType)){
                        sourceTargetDict[sourceType + "-" + targetType] = sourceTargetDict[sourceType + "-" + targetType] + 1;
                    }
                    else
                    {
                        sourceTargetDict.Add(x.ElementAt(i - 1).Type + "-" + x.ElementAt(i).Type, 1);
                    }
                }
            });
            String[] labelsArray = labels.ToArray();
            List<int> sources = new List<int>();
            List<int> targets = new List<int>();
            List<int> values = new List<int>();
            sourceTargetDict.Keys.ToList().ForEach(x =>
            {
                string[] splitString = x.Split('-');
                sources.Add(Array.IndexOf(labelsArray, splitString[0]));
                targets.Add(Array.IndexOf(labelsArray, splitString[1]));
                values.Add(sourceTargetDict[x]);
            });


            string initialTag = "<script type=\"text/javascript\">";
            string endTag = "</script>";
            string labelsScript = "var labels = " + JsonConvert.SerializeObject(labelsArray) + ";";
            string sourceScript = "var source =" + JsonConvert.SerializeObject(sources.ToArray()) + ";";
            string targetScript = "var target = " + JsonConvert.SerializeObject(targets.ToArray()) + ";";
            string valueScript = "var values = " + JsonConvert.SerializeObject(values.ToArray()) + ";";
           
            string script = initialTag + labelsScript+ sourceScript + targetScript + valueScript  + endTag;
            ClientScript.RegisterStartupScript(this.GetType(), "JourneysScript", script);


        }

        
    }
}