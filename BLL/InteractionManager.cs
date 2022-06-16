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
            InteractionMapper mapper = new InteractionMapper();
            mapper.Upsert(interaction);
        }

        public void DeleteInteraction(Interaction interaction)
        {
            InteractionMapper mapper = new InteractionMapper();
            mapper.Delete(interaction);
        }
    }
}
