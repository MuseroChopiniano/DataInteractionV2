using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Entities
{
    public abstract class SystemEntity
    {
        public int Id { get; set; }
        public DateTime CreatedDate { get; set; }
        public int CreatedById { get; set; }

        public DateTime LastModifiedDate { get; set; }

        public int LastModifiedById { get; set; }
    }
}
