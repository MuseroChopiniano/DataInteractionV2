using BLL.Entities;
using CsvHelper.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UI.CsvHelpers
{
    public class InteractionMap : ClassMap<Interaction>
    {
        public InteractionMap()
        {
            Map(m => m.Type).Name("Type");
            Map(m => m.Date).Name("Date");
            Map(m => m.Revenue).Name("Revenue");
            Map(m => m.Campaign).Convert(row =>
            {
                Campaign camp = new Campaign();
                camp.Id = int.Parse(row.Row.GetField("CampaignId"));
                return camp;
            });
            Map(m => m.Customer).Convert(row =>
            {
                Customer cust = new Customer();
                cust.Id = int.Parse(row.Row.GetField("CustomerId"));
                return cust;
            });
            Map(m => m.Channel).Convert(row =>
            {
                Channel channel = new Channel();
                channel.Id = int.Parse(row.Row.GetField("ChannelId"));
                return channel;
            });
          
            
        }
    }
}
