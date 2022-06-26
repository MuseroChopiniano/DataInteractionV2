using BLL.Entities;
using CsvHelper.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UI.CsvHelpers
{
    public class InteractionMap : ClassMap<Interaction>
    {
        public InteractionMap()
        {
            Map(m => m.Type).Name("Type");
            Map(m => m.Date).Ignore();
            Map(m => m.Revenue).Name("Revenue");
        }
    }
}
