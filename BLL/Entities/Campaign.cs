using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Entities
{
    public class Campaign : SystemEntity
    {

        public string Status { get; set; }
        public string Name { get; set; } = "";
        public decimal ActualCost { get; set; }

        public decimal BudgetedCost { get; set; }

        public string Description { get; set; }

        public decimal ExpectedRevenue { get; set; }

        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
    }
}
