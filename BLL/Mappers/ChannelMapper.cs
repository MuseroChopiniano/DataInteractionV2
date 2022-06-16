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
    public class ChannelMapper : IMapper<Channel>
    {
        private Access access;

        public ChannelMapper()
        {
            this.access = new Access();
        }
        public int Delete(Channel entity)
        {
            int result = 0;
            try
            {
                SqlParameter parameter = new SqlParameter("Id", entity.Id);
                result = this.access.Save("dbo.DeleteChannel", new List<SqlParameter>() { parameter });
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                result = -2;
            }

            return result;
        }

        public List<SqlParameter> GenerateParameters(Channel entity)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            if (entity.Id != 0)
            {
                parameters.Add(this.access.BuildParameter("Id", entity.Id));
            }
            parameters.Add(this.access.BuildParameter("Type", entity.Type));
            parameters.Add(this.access.BuildParameter("Name", entity.Name));
            return parameters;
        }

        public List<Channel> MapEntityFromTable(DataTable table)
        {
            List<Channel> channels = new List<Channel>();
            foreach (DataRow row in table.Rows)
            {
                Channel channel = new Channel();
                channel.Id = int.Parse(row["Id"].ToString());
                channel.Name = row["Name"].ToString();
                channel.Type = row["Type"].ToString();
                channel.CreatedDate = DateTime.Parse(row["CreatedDate"].ToString());
                channels.Add(channel);
            }
            return channels;
        }

        public Channel Read(Channel entity)
        {
            throw new NotImplementedException();
        }

        public List<Channel> ReadAll()
        {
            List<Channel> channels = new List<Channel>();
            try
            {
                DataTable channelTable = this.access.Read("dbo.GetChannels", new List<SqlParameter>());
                channels = MapEntityFromTable(channelTable);
            }
            catch (Exception ex)
            {
                //TODO: Handle Exception
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return channels;
        }

        public int Upsert(Channel entity)
        {
            int result = 0;
            try
            {
                result = this.access.Save("dbo.UpsertChannel", this.GenerateParameters(entity));
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
