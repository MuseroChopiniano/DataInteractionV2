using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Entities
{
    public class LogEntity : SystemEntity
    {
        public EventType EventType { get; set; }

        public string Message { get; set; }

        public string Entity { get; set; }
    }

    public enum EventType
    {
        ObjectInsert,
        ObjectUpdate,
        ObjectDelete,
        Login,
        Logout,
        PermissionChange
    }
}
