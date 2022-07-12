using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using BLL.Entities;
using BLL.Mappers;

namespace BLL
{
    public class ChannelManager
    {

        public List<Channel> GetChannels()
        {
            ChannelMapper mapper = new ChannelMapper();
            return mapper.ReadAll();
        }

        public void UpsertChannel(Channel channel)
        {
            bool update = channel.Id != 0;
            int result = 0;
            ChannelMapper mapper = new ChannelMapper();
            result = mapper.Upsert(channel);
            if (result != -2)
            {
                LogManager logManager = new LogManager();
                logManager.SaveLog(new LogEntity()
                {
                    EventType = update ? EventType.ObjectUpdate : EventType.ObjectInsert,
                    Entity = "Channel",
                    Message = "The Channel with Id " + channel.Id + " has been upserted by User with Id  " + channel.LastModifiedById,
                    LastModifiedById = channel.LastModifiedById,
                    CreatedById = channel.LastModifiedById
                });
            }
        }

        public void DeleteChannel(Channel channel)
        {

            ChannelMapper mapper = new ChannelMapper();
            int result = mapper.Delete(channel);
            if (result != -2)
            {
                LogManager logManager = new LogManager();
                logManager.SaveLog(new LogEntity()
                {
                    EventType = EventType.ObjectDelete,
                    Entity = "Channel",
                    Message = "The Channel with Id " + channel.Id + " has been deleted by " + channel.LastModifiedById,
                    LastModifiedById = channel.LastModifiedById,
                    CreatedById = channel.LastModifiedById
                });

            }
        }
    }
}
