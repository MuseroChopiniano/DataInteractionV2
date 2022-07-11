using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Entities;
using BLL.Mappers;

namespace BLL
{
    public class PermissionManager
    {

        public List<Permission> GetPermissions()
        {
            PermissionMapper mapper = new PermissionMapper();
            List<Permission> permissions = mapper.ReadAll();
            return permissions;
        }

        public List<Permission> GetParentPermissions()
        {
            List<Permission> permissions = this.GetPermissions().FindAll(x => x.Type == PermissionType.Group);
            return permissions;
        }
        public List<Permission> GetChildPermissions(Permission permission)
        {
            if(permission.Type != PermissionType.Group)
            {
                return new List<Permission>();
            }
            PermissionMapper mapper = new PermissionMapper();
            return mapper.ReadChildren(permission);
            
        }

        public void CreatePermission(Permission permission)
        {
            //TODO: 
        } 

        public void UpsertPermission(Permission permission)
        {
            PermissionMapper mapper = new PermissionMapper();
            mapper.Upsert(permission);
        }

        public void DeletePermission(Permission permission)
        {
            PermissionMapper mapper = new PermissionMapper();
            mapper.Delete(permission);
        }

    }
}
