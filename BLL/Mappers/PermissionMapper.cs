using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Entities;
using DAL;

namespace BLL.Mappers
{
    public class PermissionMapper : IMapper<Permission>
    {
        private Access access;
        public PermissionMapper()
        {
            this.access = new Access();
        }
        public int Delete(Permission entity)
        {
            int result = 0;
            try
            {
                SqlParameter parameter = new SqlParameter("Id", entity.Id);
                SqlParameter parameterLastModified = new SqlParameter("LastModifiedById", entity.LastModifiedById);
                List<SqlParameter> parameters = new List<SqlParameter>();
                parameters.Add(parameter);
                parameters.Add(parameterLastModified);
                result = this.access.Save("dbo.DeletePermission",parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                result = -2;
            }

            return result;
        }

        public List<Permission> ReadChildren(User user)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("UserId", user.Id));
            return MapEntityFromTable(this.access.Read("dbo.GetUserPermissions", parameters));
        }

        public List<SqlParameter> GenerateParameters(Permission entity)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            if (entity.Id != 0)
            {
                parameters.Add(this.access.BuildParameter("Id", entity.Id));
            }
            parameters.Add(this.access.BuildParameter("Name", entity.Name));
            parameters.Add(this.access.BuildParameter("CreatedById", entity.CreatedById));
            parameters.Add(this.access.BuildParameter("LastModifiedById", entity.LastModifiedById));
            parameters.Add(this.access.BuildParameter("Type", entity.Type.ToString()));
            parameters.Add(this.access.BuildParameter("Description", entity.Description));


            return parameters;
        }

        public List<Permission> ReadChildren(Permission permission)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("Id", permission.Id));
            return MapEntityFromTable(this.access.Read("dbo.GetChildPermissions", parameters));
        }

        public List<Permission> MapEntityFromTable(DataTable table)
        {
            List<Permission> permissions = new List<Permission>();
            foreach (DataRow row in table.Rows)
            {
                Permission permission = new Permission();
                permission.Id = int.Parse(row["Id"].ToString());
                permission.Name = row["Name"].ToString();
                permission.Type = (PermissionType)Enum.Parse(typeof(PermissionType), row["Type"].ToString());
                permission.Description = row["Description"].ToString();
                permission.CreatedById = int.Parse(row["CreatedById"].ToString());
                permission.CreatedDate = DateTime.Parse(row["CreatedDate"].ToString());
                permission.LastModifiedById = int.Parse(row["LastModifiedById"].ToString());
                permission.LastModifiedDate = DateTime.Parse(row["LastModifiedDate"].ToString());


                permissions.Add(permission);
            }
            return permissions;
        }

        public Permission Read(Permission entity)
        {
            throw new NotImplementedException();
        }

        public List<Permission> ReadAll()
        {
            List<Permission> permissions = new List<Permission>();
            try
            {
                DataTable permissionTable = this.access.Read("dbo.GetPermissions", new List<SqlParameter>());
                permissions = MapEntityFromTable(permissionTable);
            }
            catch (Exception ex)
            {
                //TODO: Handle Exception
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return permissions;
        }

        private void UpsertChildPermissions(Permission permission)

        {
            DataTable table = new DataTable();
            table.Columns.Add("ChildId", typeof(int));
            table.Columns.Add("ParentId", typeof(int));

            foreach (Permission child in permission.ChildPermissions)
            {
                table.Rows.Add(child.Id, permission.Id );
            }
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("PermTable", table));
            parameters.Add(this.access.BuildParameter("Parent", permission.Id));
            this.access.Save("dbo.UpsertChildrenPermissions", parameters); 
        }
        public int Upsert(Permission entity)
        {
            int result = 0;
            this.access.InitiateTransaction();
            try
            {
                if(entity.Id == 0)
                {
                    int Id = this.access.Save("dbo.UpsertPermission", this.GenerateParameters(entity), true);
                    entity.Id = Id;
                }
                else
                {
                    this.access.Save("dbo.UpsertPermission", this.GenerateParameters(entity));
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
    }
}
