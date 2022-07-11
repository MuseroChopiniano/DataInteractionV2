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
                List<SqlParameter> parameters = new List<SqlParameter>();
                SqlParameter idParameter = new SqlParameter("Id", entity.Id);
                SqlParameter lastModifiedParameter = new SqlParameter("LastModifiedById", entity.LastModifiedById);
                parameters.Add(idParameter);
                parameters.Add(lastModifiedParameter);
                result = this.access.Save("dbo.DeleteUser", parameters);
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

        private void UpsertChildPermissions(User user)

        {
            DataTable table = new DataTable();
            table.Columns.Add("UserId", typeof(int));
            table.Columns.Add("PermissionId", typeof(int));

            foreach (Permission permission in user.Permissions)
            {
                table.Rows.Add(user.Id, permission.Id);
            }
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("PermTable", table));
            parameters.Add(this.access.BuildParameter("Parent", user.Id));
            this.access.Save("dbo.UpsertUserPermissions", parameters);
        }
        public int Upsert(User entity)
        {
            int result = 0;
            this.access.InitiateTransaction();
            try
            {
                if(entity.Id == 0)
                {
                    Encryptor encryptor = new Encryptor();
                    entity.Password = encryptor.GenerateHash("1234");
                    int Id = this.access.Save("dbo.UpsertUser", this.GenerateParameters(entity), true);
                    entity.Id = Id;
                }
                else
                {          
                    this.access.Save("dbo.UpsertUser", this.GenerateParameters(entity));
                }
                this.UpsertChildPermissions(entity);
                this.access.CommitTransaction();
            }
            catch (Exception ex)
            {
                this.access.RollbackTransaction();
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
                user.Status = (UserStatus) Enum.Parse(typeof(UserStatus),row["Status"].ToString());
                user.FirstName = row["FirstName"].ToString();
                user.LastName = row["LastName"].ToString();
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
            parameters.Add(this.access.BuildParameter("FirstName", user.FirstName));
            parameters.Add(this.access.BuildParameter("LastName", user.LastName));
            parameters.Add(this.access.BuildParameter("Status", user.Status.ToString()));
            if(user.Password != "" && user.Password != null)
            {
                parameters.Add(this.access.BuildParameter("Password", user.Password));
            }
            parameters.Add(this.access.BuildParameter("CreatedById", user.CreatedById));
            parameters.Add(this.access.BuildParameter("LastModifiedById", user.LastModifiedById));
            parameters.Add(this.access.BuildParameter("BlockCounter", user.BlockCounter));

          
            return parameters;
        }
    }
}
