using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Entities
{
    public class Channel : SystemEntity
    {
        public Channel() { }
        public Channel(int Id)
        {
            this.Id = Id;
        }
        public string Name { get; set; }
        public string Type { get; set; }
    }
}
