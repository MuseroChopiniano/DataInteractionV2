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
    public class LogMapper : IMapper<LogEntity>
    {
        private Access access;

        public LogMapper()
        {
            this.access = new Access();
        }
        public int Delete(LogEntity entity)
        {
            throw new NotImplementedException();
        }

        public List<SqlParameter> GenerateParameters(LogEntity entity)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            
            parameters.Add(this.access.BuildParameter("EventType", entity.EventType.ToString()));
            parameters.Add(this.access.BuildParameter("Message", entity.Message));
            parameters.Add(this.access.BuildParameter("Entity", entity.Entity));
            parameters.Add(this.access.BuildParameter("CreatedById",entity.CreatedById));
            parameters.Add(this.access.BuildParameter("LastModifiedById", entity.LastModifiedById));

            return parameters;
        }

        public List<LogEntity> MapEntityFromTable(DataTable table)
        {
            List<LogEntity> logs = new List<LogEntity>();
            foreach (DataRow row in table.Rows)
            {
                LogEntity log = new LogEntity();
                log.Id = int.Parse(row["Id"].ToString());
                log.EventType = (EventType) Enum.Parse(typeof(EventType),row["EventType"].ToString());
                log.Message = row["Message"].ToString();
                log.Entity = row["Entity"].ToString();
                log.CreatedById = int.Parse(row["CreatedById"].ToString());
                log.CreatedDate = DateTime.Parse(row["CreatedDate"].ToString());
                log.LastModifiedById = int.Parse(row["LastModifiedById"].ToString());
                log.LastModifiedDate = DateTime.Parse(row["LastModifiedDate"].ToString());
                logs.Add(log);
            }
            return logs;
        }

        public LogEntity Read(LogEntity entity)
        {
            throw new NotImplementedException();
        }

        public List<LogEntity> ReadAll()
        {
            List<LogEntity> logs = new List<LogEntity>();
            try
            {
                DataTable logTable = this.access.Read("dbo.GetLogs", new List<SqlParameter>());
                logs = MapEntityFromTable(logTable);
            }
            catch (Exception ex)
            {
                //TODO: Handle Exception
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return logs;
        }

        public int Upsert(LogEntity entity)
        {
            int result = 0;
            try
            {
                result = this.access.Save("dbo.CreateLog", this.GenerateParameters(entity));
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                result = -2;
            }
            return result;
        }
    }
}
