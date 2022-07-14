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

        

        public void UpsertPermission(Permission permission)
        {
            bool update = permission.Id != 0;
            int result = 0;
            PermissionMapper mapper = new PermissionMapper();
            result = mapper.Upsert(permission);
            if (result != -2)
            {
                LogManager logManager = new LogManager();
                logManager.SaveLog(new LogEntity()
                {
                    EventType = update ? EventType.ObjectUpdate : EventType.ObjectInsert,
                    Entity = "Permission",
                    Message = "The Permission with Id " + permission.Id + " has been upserted by User with Id " + permission.LastModifiedById,
                    LastModifiedById = permission.LastModifiedById,
                    CreatedById = permission.LastModifiedById
                });
            }
        }

        public void DeletePermission(Permission permission)
        {
            int result = 0;
            PermissionMapper mapper = new PermissionMapper();
            result = mapper.Delete(permission);
            if (result != -2)
            {
                LogManager logManager = new LogManager();
                logManager.SaveLog(new LogEntity()
                {
                    EventType = EventType.ObjectDelete,
                    Entity = "Permission",
                    Message = "The Permission with Id " + permission.Id + " has been deleted by " + permission.LastModifiedById,
                    LastModifiedById = permission.LastModifiedById,
                    CreatedById = permission.LastModifiedById

                });
            }
        }

    }
}
