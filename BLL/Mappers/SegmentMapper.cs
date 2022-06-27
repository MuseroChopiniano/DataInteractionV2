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
                result = this.access.Save("dbo.DeleteSegment", new List<SqlParameter>() { parameter });
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

        public int Upsert(Segment entity)
        {
            int result = 0;
            try
            {
                result = this.access.Save("dbo.UpsertSegment", this.GenerateParameters(entity));
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
