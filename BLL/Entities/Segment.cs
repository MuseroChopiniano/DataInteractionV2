using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Entities
{
    public class Segment : SystemEntity
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public string Type { get; set; }

        private List<Customer> customers;
        public List<Customer> Customers {
            get
            {
                if (this.customers == null)
                {
                    SegmentManager manager = new SegmentManager();
                    this.customers = manager.GetCustomers(this);
                    return this.customers;
                }
                else
                {
                    return this.customers;
                }
            }
            set
            {
                this.customers = value;
            }
        }
    }
}
