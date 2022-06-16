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

        public void RestartBlockCounter(User aUser)
        {
            aUser.BlockCounter = 0;
        }

        public int UpsertUser(User user)
        {
            int result = 0;
            UserMapper userMapper = new UserMapper();
            result = userMapper.Upsert(user);
            return result;
        }

        

        public int DeleteUser(User userToDelete)
        {
            int result = 0;
            UserMapper userMapper = new UserMapper();
            result = userMapper.Delete(userToDelete);
            return result;
        }
    }
}
