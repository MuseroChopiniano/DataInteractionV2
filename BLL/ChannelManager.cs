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

        public void UpsertChannel(Channel channel) {
            ChannelMapper mapper = new ChannelMapper();
            mapper.Upsert(channel);
        }

        public void DeleteChannel(Channel channel)
        {
            ChannelMapper mapper = new ChannelMapper();
            mapper.Delete(channel);
        }
    }
}
