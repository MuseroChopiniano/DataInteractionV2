using BLL.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Mappers
{
    public class UserMapper : IMapper<User>
    {
        private DAL.Access access;

        public UserMapper()
        {
            this.access = new DAL.Access();
        }
        public int Delete(User entity)
        {
            int result = 0;
            try
            {
                SqlParameter parameter = new SqlParameter("Id", entity.Id);
                result = this.access.Save("dbo.DeleteUser", new List<SqlParameter>() { parameter });
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                result = -2;
            }

            return result;
        }

        public User Read(User entity)
        {
            try
            {
                SqlParameter parameter = new SqlParameter("Username", entity.Username);
                DataTable UserTable = this.access.Read("dbo.GetUserByUsername", new List<SqlParameter>() { parameter });
                entity = MapEntityFromTable(UserTable)[0];
            }
            catch (Exception ex)
            {
                //TODO: Handle Exception
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return entity;
        }
       
        public List<User> ReadAll()
        {
            List<User> users = new List<User>();
            try
            {
                DataTable UserTable = this.access.Read("dbo.GetUsers", new List<SqlParameter>());
                users = MapEntityFromTable(UserTable);
            }
            catch (Exception ex)
            {
                //TODO: Handle Exception
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return users;
        }
    

        public int Upsert(User entity)
        {
            int result = 0;
            try
            {
                result = this.access.Save("dbo.UpsertUser", this.GenerateParameters(entity));
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                result = -2;
            }
            return result;
        }

        public List<User> MapEntityFromTable(DataTable table)
        {
            List<User> users = new List<User>();
            foreach (DataRow row in table.Rows)
            {
                User user = new User();
                user.Id = int.Parse(row["Id"].ToString());
                user.Username = row["Username"].ToString();
                if (table.Columns.Contains("Password"))
                {
                    user.Password = row["Password"].ToString();
                }
                user.Email = row["Email"].ToString();
                user.Status = row["Status"].ToString();
                user.BlockCounter = int.Parse(row["BlockCounter"].ToString());
                user.CreatedById = int.Parse(row["CreatedById"].ToString());
                user.CreatedDate = DateTime.Parse(row["CreatedDate"].ToString());
                user.LastModifiedById = int.Parse(row["LastModifiedById"].ToString());
                user.LastModifiedDate = DateTime.Parse(row["LastModifiedDate"].ToString());
                users.Add(user);
            }
            return users;
        }
        public List<SqlParameter> GenerateParameters(User user)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            if (user.Id != 0)
            {
                parameters.Add(this.access.BuildParameter("Id", user.Id));
            }
            parameters.Add(this.access.BuildParameter("Username", user.Username));
            parameters.Add(this.access.BuildParameter("Email", user.Email));
            parameters.Add(this.access.BuildParameter("Status", user.Status));
            parameters.Add(this.access.BuildParameter("Password", user.Password));
            parameters.Add(this.access.BuildParameter("BlockCounter", user.BlockCounter));

          
            return parameters;
        }
    }
}
