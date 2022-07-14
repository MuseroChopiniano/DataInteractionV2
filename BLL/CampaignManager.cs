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
            bool update = campaign.Id != 0;
            int result = 0;
            CampaignMapper mapper = new CampaignMapper();
            result = mapper.Upsert(campaign);
            if (result != -2)
            {
                LogManager logManager = new LogManager();
                logManager.SaveLog(new LogEntity()
                {
                    EventType = update ? EventType.ObjectUpdate : EventType.ObjectInsert,
                    Entity = "Campaign",
                    Message = "The Campaign with Id " + campaign.Id + " has been upserted by User with Id " + campaign.LastModifiedById,
                    LastModifiedById = campaign.LastModifiedById,
                    CreatedById = campaign.LastModifiedById
                });
            }
        }

        public void DeleteCampaign(Campaign campaign)
        {
            int result = 0;
            CampaignMapper mapper = new CampaignMapper();
            result = mapper.Delete(campaign);
            if (result != -2)
            {
                LogManager logManager = new LogManager();
                logManager.SaveLog(new LogEntity()
                {
                    EventType = EventType.ObjectDelete,
                    Entity = "Campaign",
                    Message = "The Campaign with Id " + campaign.Id + " has been deleted by " + campaign.LastModifiedById,
                    LastModifiedById = campaign.LastModifiedById,
                    CreatedById = campaign.LastModifiedById

                });
            }
        }

        public Campaign GetCampaigns(Campaign campaign)
        {
            List<Campaign> campaigns = this.GetCampaigns();
            return campaigns.Find(x => x.Id == campaign.Id);
        }
    }
}
