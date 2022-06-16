using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Entities;
using BLL.Mappers;
namespace BLL
{
    public class CampaignManager
    {
        public List<Campaign> GetCampaigns()
        {
            CampaignMapper mapper = new CampaignMapper();
            return mapper.ReadAll();
        }

        public void UpsertCampaign(Campaign campaign)
        {
            CampaignMapper mapper = new CampaignMapper();
            mapper.Upsert(campaign);
        }

        public void DeleteCampaign(Campaign campaign)
        {
            CampaignMapper mapper = new CampaignMapper();
            mapper.Delete(campaign);
        }
    }
}
