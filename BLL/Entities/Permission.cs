using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Entities
{
    public class Permission : SystemEntity
    {

        private List<Permission> childPermissions;

        public string Name { get; set; }
        public PermissionType Type { get; set; }
        public string Description { get; set; }
        public List<Permission> ChildPermissions {
            get {
                if(this.childPermissions == null)
                {
                    PermissionManager manager = new PermissionManager();
                    this.childPermissions = manager.GetChildPermissions(this);
                    return this.childPermissions;
                }
                else
                {
                    return this.childPermissions;
                }
            }
            set {
                this.childPermissions = value;
            }
        }

    }


    public enum PermissionType
    {
        Group,
        Regular
    }
}
