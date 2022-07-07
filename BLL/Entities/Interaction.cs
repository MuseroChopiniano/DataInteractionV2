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
        public Channel Channel { get { return this.channel; } set { this.channel = value; } }

        private Customer customer = new Customer();
        public Customer Customer { get {
                if (this.customer.Age == 0 && this.customer.Id != 0){
                    CustomerManager manager = new CustomerManager();
                    this.customer = manager.GetCustomers(this.customer);
                }
              return this.customer; 
        } set { this.customer = value; } }

        private Campaign campaign = new Campaign();
        public Campaign Campaign { get { return this.campaign; } set { this.campaign = value; } }

        public DateTime Date { get; set; }

        public decimal Revenue { get; set; }
    }
}
