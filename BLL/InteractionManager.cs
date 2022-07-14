using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Entities;
using BLL.Mappers;

namespace BLL
{
    public class InteractionManager
    {

        public List<Interaction> GetInteractions()
        {
            InteractionMapper mapper = new InteractionMapper();
            return mapper.ReadAll();
        }

        public void UpsertInteraction(Interaction interaction)
        {
            bool update = interaction.Id != 0;
            int result = 0;
            InteractionMapper mapper = new InteractionMapper();
            result = mapper.Upsert(interaction);
            if (result != -2)
            {
                LogManager logManager = new LogManager();
                logManager.SaveLog(new LogEntity()
                {
                    EventType = update ? EventType.ObjectUpdate : EventType.ObjectInsert,
                    Entity = "Interaction",
                    Message = "The Interaction with Id " + interaction.Id + " has been upserted by User with Id " + interaction.LastModifiedById,
                    LastModifiedById = interaction.LastModifiedById,
                    CreatedById = interaction.LastModifiedById
                });
            }
        }

        public void DeleteInteraction(Interaction interaction)
        {
            int result = 0;
            InteractionMapper mapper = new InteractionMapper();
            result = mapper.Delete(interaction);
            if (result != -2)
            {
                LogManager logManager = new LogManager();
                logManager.SaveLog(new LogEntity()
                {
                    EventType = EventType.ObjectDelete,
                    Entity = "Interaction",
                    Message = "The Interaction with Id " + interaction.Id + " has been deleted by " + interaction.LastModifiedById,
                    LastModifiedById = interaction.LastModifiedById,
                    CreatedById = interaction.LastModifiedById

                });
            }
        }
        public void UpsertInteraction(List<Interaction> interactions)
        {
            InteractionMapper mapper = new InteractionMapper();
            mapper.BulkSave(interactions);
            LogManager logManager = new LogManager();
            logManager.SaveLog(new LogEntity()
            {
                EventType = EventType.BulkOperation,
                Entity = "Interaction",
                Message = "A Bulk Interaction Upsert has been made by the user with Id " + interactions[0].LastModifiedById,
                LastModifiedById = interactions[0].LastModifiedById,
                CreatedById = interactions[0].LastModifiedById

            });
        }
    }
}
