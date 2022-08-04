using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Entities
{
    public class Channel : SystemEntity, IComparable<Channel>
    {
        public Channel() { }
        public Channel(int Id)
        {
            this.Id = Id;
        }
        public string Name { get; set; } = "";
        public string Type { get; set; }

        public int CompareTo(Channel obj)
        {
            return this.Name.CompareTo(obj.Name);

        }
    }
}
