using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace BLL.Entities
{
    public class Interaction : SystemEntity
    {
        public string Type { get; set; }

        private Channel channel = new Channel();
        public Channel Channel { 
            get { 
                if(this.channel.Name == "")
                {
                    ChannelManager manager = new ChannelManager();
                    Channel tempChannel = manager.GetChannels(this.channel);
                    if(tempChannel != null)
                    {
                        this.channel = tempChannel;
                    }
                }
                return this.channel; 
            } 
            set { this.channel = value; } }

        private Customer customer = new Customer();
        public Customer Customer { get {
                if (this.customer != null && this.customer.Name == "" && this.customer.Id != 0){
                    CustomerManager manager = new CustomerManager();
                    Customer tempCust =   manager.GetCustomers(this.customer);
                    if(tempCust != null){
                        this.customer = tempCust;
                    }
                }
             
              return this.customer; 
        } set { this.customer = value; } }

        private Campaign campaign = new Campaign();
        public Campaign Campaign { 
            get {
                if(this.campaign.Name == "")
                {
                    CampaignManager manager = new CampaignManager();
                    Campaign campTemp = manager.GetCampaigns(this.campaign);
                    if(campTemp != null)
                    {
                        this.campaign = campTemp;
                    }
                }
                return this.campaign; 
            } 
            set { 
                this.campaign = value; 
            } 
        }

        public DateTime Date { get; set; }

        public decimal Revenue { get; set; }
    }
}
