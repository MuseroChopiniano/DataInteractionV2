using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;
using BLL.Entities;
using System.Data.SqlClient;
using System.Data;

namespace BLL.Mappers
{
    public class InteractionMapper : IMapper<Interaction>
    {
        private Access access;

        public InteractionMapper()
        {
            this.access = new Access();
        }
        public int Delete(Interaction entity)
        {
            int result = 0;
            try
            {
                SqlParameter parameter = new SqlParameter("Id", entity.Id);
                result = this.access.Save("dbo.DeleteInteraction", new List<SqlParameter>() { parameter });
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                result = -2;
            }

            return result;
        }

        public List<SqlParameter> GenerateParameters(Interaction entity)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            if (entity.Id != 0)
            {
                parameters.Add(this.access.BuildParameter("Id", entity.Id));
            }
            parameters.Add(this.access.BuildParameter("Type", entity.Type));
            parameters.Add(this.access.BuildParameter("CampaignId", entity.Campaign.Id));
            parameters.Add(this.access.BuildParameter("ChannelId", entity.Channel.Id));
            parameters.Add(this.access.BuildParameter("CustomerId", entity.Customer.Id));
            parameters.Add(this.access.BuildParameter("Date", entity.Date));
            parameters.Add(this.access.BuildParameter("Revenue", entity.Revenue));
            return parameters;
        }

        public List<Interaction> MapEntityFromTable(DataTable table)
        {
            List<Interaction> interactions = new List<Interaction>();
            foreach (DataRow row in table.Rows)
            {
                Interaction interaction = new Interaction();
                interaction.Id = int.Parse(row["Id"].ToString());
                interaction.Channel = new Channel() { Id = int.Parse(row["ChannelId"].ToString()) };
                interaction.Customer = new Customer() { Id = int.Parse(row["CustomerId"].ToString()) };
                interaction.Campaign = new Campaign() { Id = int.Parse(row["CampaignId"].ToString()) };
                interaction.Date = DateTime.Parse(row["Date"].ToString());
                interaction.Revenue = decimal.Parse(row["Revenue"].ToString());
                interaction.Type = row["Type"].ToString();
                interaction.CreatedDate = DateTime.Parse(row["CreatedDate"].ToString());
                interactions.Add(interaction);
            }
            return interactions;
        }

        public Interaction Read(Interaction entity)
        {
            throw new NotImplementedException();
        }

        public List<Interaction> ReadAll()
        {
            List<Interaction> interactions = new List<Interaction>();
            try
            {
                DataTable interactionTable = this.access.Read("dbo.GetInteractions", new List<SqlParameter>());
                interactions = MapEntityFromTable(interactionTable);
            }
            catch (Exception ex)
            {
                //TODO: Handle Exception
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return interactions;
        }

        public int Upsert(Interaction entity)
        {
            int result = 0;
            try
            {
                result = this.access.Save("dbo.UpsertInteraction", this.GenerateParameters(entity));
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
