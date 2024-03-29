﻿using System;
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
                SqlParameter parameterLastModified = new SqlParameter("LastModifiedById", entity.LastModifiedById);
                List<SqlParameter> parameters = new List<SqlParameter>();
                parameters.Add(parameter);
                parameters.Add(parameterLastModified);
                result = this.access.Save("dbo.DeleteChannel", parameters);
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
            parameters.Add(this.access.BuildParameter("CreatedById", entity.CreatedById));
            parameters.Add(this.access.BuildParameter("LastModifiedById", entity.LastModifiedById));
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
                channel.CreatedById = int.Parse(row["CreatedById"].ToString());
                channel.LastModifiedById = int.Parse(row["LastModifiedById"].ToString());
                channel.LastModifiedDate = DateTime.Parse(row["LastModifiedDate"].ToString());
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
                if (entity.Id == 0)
                {
                    int id = this.access.Save("dbo.UpsertChannel", this.GenerateParameters(entity), true);
                    entity.Id = id;
                }
                else
                {
                    result = this.access.Save("dbo.UpsertChannel", this.GenerateParameters(entity));
                }
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
