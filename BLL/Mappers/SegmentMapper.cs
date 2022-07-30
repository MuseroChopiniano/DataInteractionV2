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
    public class SegmentMapper : IMapper<Segment>
    {
        private Access access;

        public SegmentMapper()
        {
            this.access = new Access();
        }
        public int Delete(Segment entity)
        {
            int result = 0;
            try
            {
                SqlParameter parameter = new SqlParameter("Id", entity.Id);
                SqlParameter parameterLastModified = new SqlParameter("LastModifiedById", entity.LastModifiedById);
                List<SqlParameter> parameters = new List<SqlParameter>();
                parameters.Add(parameter);
                parameters.Add(parameterLastModified);
                result = this.access.Save("dbo.DeleteSegment", parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                result = -2;
            }

            return result;
        }

        public List<SqlParameter> GenerateParameters(Segment entity)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            if (entity.Id != 0)
            {
                parameters.Add(this.access.BuildParameter("Id", entity.Id));
            }
            parameters.Add(this.access.BuildParameter("Type", entity.Type));
            parameters.Add(this.access.BuildParameter("Name", entity.Name));
            parameters.Add(this.access.BuildParameter("Description", entity.Description));
            parameters.Add(this.access.BuildParameter("CreatedById", entity.CreatedById));
            parameters.Add(this.access.BuildParameter("LastModifiedById", entity.LastModifiedById));
            
            return parameters;
        }

        public List<Segment> MapEntityFromTable(DataTable table)
        {
            List<Segment> segments = new List<Segment>();
            foreach (DataRow row in table.Rows)
            {
                Segment segment = new Segment();
                segment.Id = int.Parse(row["Id"].ToString());
                segment.Name = row["Name"].ToString();
                segment.Type = row["Type"].ToString();
                segment.Description = row["Description"].ToString();
                segment.CreatedDate = DateTime.Parse(row["CreatedDate"].ToString());
                segment.CreatedById = int.Parse(row["CreatedById"].ToString());
                segment.LastModifiedById = int.Parse(row["LastModifiedById"].ToString());
                segment.LastModifiedDate = DateTime.Parse(row["LastModifiedDate"].ToString());
                segments.Add(segment);
            }
            return segments;
        }

        public Segment Read(Segment entity)
        {
            throw new NotImplementedException();
        }

        public List<Segment> ReadAll()
        {
            List<Segment> segments = new List<Segment>();
            try
            {
                DataTable table = this.access.Read("dbo.GetSegments", new List<SqlParameter>());
                segments = MapEntityFromTable(table);
            }
            catch (Exception ex)
            {
                //TODO: Handle Exception
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return segments;
        }

        private void UpsertChildCustomers(Segment segment)

        {
            DataTable table = new DataTable();
            table.Columns.Add("SegmentId", typeof(int));
            table.Columns.Add("CustomerId", typeof(int));

            foreach (Customer customer in segment.Customers)
            {
                table.Rows.Add(segment.Id, customer.Id);
            }
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("PermTable", table));
            parameters.Add(this.access.BuildParameter("Parent", segment.Id));
            this.access.Save("dbo.UpsertSegmentCustomers", parameters);
        }
        public int Upsert(Segment entity)
        {
            int result = 0;
            this.access.InitiateTransaction();
            try
            {
                if (entity.Id == 0)
                {
                    int Id = this.access.Save("dbo.UpsertSegment", this.GenerateParameters(entity), true);
                    entity.Id = Id;
                }
                else
                {
                    this.access.Save("dbo.UpsertSegment", this.GenerateParameters(entity));
                }
                this.UpsertChildCustomers(entity);
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
