using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Entities
{
    public class LogEntity : SystemEntity
    {
        public string EventType { get; set; }

        public string Message { get; set; }

    }
}
