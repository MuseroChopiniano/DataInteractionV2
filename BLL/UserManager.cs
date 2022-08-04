using BLL.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BLL.Mappers;
using System.Threading.Tasks;

namespace BLL
{
    public class UserManager
    {
        public User ValidateExistence(User aUser)
        {
            UserMapper userMapper = new UserMapper();
            aUser = userMapper.Read(aUser);
            return aUser;
        }
        
       
        public bool ValidatePassword(string password, User aUser)
        {
            Encryptor encryptorManager = new Encryptor();
            string hashPass = encryptorManager.GenerateHash(password);
            return (hashPass == aUser.Password);
        }

        public List<User> GetAll()
        {
            UserMapper userMapper = new UserMapper();
            return userMapper.ReadAll();
        }

        public List<Permission> GetUserPermissions(User user)
        {
            PermissionMapper mapper = new PermissionMapper();
            return mapper.ReadChildren(user);
        }

        public bool HasPermission(User user, String permission)
        {
            bool result = false;
            result = this.HasPermission(user.Permissions, permission);
            return result;
        }
        private bool HasPermission(List<Permission> permissions, string permission)
        {
            bool result = false;
            foreach(Permission perm in permissions)
            {
                if(perm.Type == PermissionType.Regular && permission == perm.Name)
                {
                    return true;
                }
                if(perm.Type == PermissionType.Group)
                {
                    result = this.HasPermission(perm.ChildPermissions, permission);
                    if (result)
                    {
                        return result;
                    }
                }
            }
            return result;

        }

        public void RestartBlockCounter(User aUser)
        {
            aUser.BlockCounter = 0;
        }

        public int UpsertUser(User user)
        {
            bool update = user.Id != 0;
            int result = 0;
            UserMapper userMapper = new UserMapper();
            result = userMapper.Upsert(user);
            if(result != -2)
            {
                LogManager logManager = new LogManager();
                logManager.SaveLog(new LogEntity()
                {
                    EventType = update ? EventType.ObjectUpdate : EventType.ObjectInsert,
                    Entity = "User",
                    Message = "The User with Id " + user.Id + " has been upserted by User with Id " + user.LastModifiedById,
                    LastModifiedById = user.LastModifiedById,
                    CreatedById = user.LastModifiedById
                }) ;
            }
            return result;
        }

        

        public int DeleteUser(User userToDelete)
        {
            int result = 0;
            UserMapper userMapper = new UserMapper();
            result = userMapper.Delete(userToDelete);
            if(result != -2) {
                LogManager logManager = new LogManager();
                logManager.SaveLog(new LogEntity()
                {
                    EventType = EventType.ObjectDelete,
                    Entity = "User",
                    Message = "The User with Id " + userToDelete.Id + " has been deleted by " + userToDelete.LastModifiedById,
                    LastModifiedById = userToDelete.LastModifiedById,
                    CreatedById = userToDelete.LastModifiedById

                }) ;
            }
            return result;
        }
    }
}
