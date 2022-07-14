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
                SqlParameter parameterLastModified = new SqlParameter("LastModifiedById", entity.LastModifiedById);
                List<SqlParameter> parameters = new List<SqlParameter>();
                parameters.Add(parameter);
                parameters.Add(parameterLastModified);
                result = this.access.Save("dbo.DeleteInteraction", parameters);
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
            parameters.Add(this.access.BuildParameter("CreatedById", entity.CreatedById));
            parameters.Add(this.access.BuildParameter("LastModifiedById", entity.LastModifiedById));
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
                interaction.LastModifiedDate= DateTime.Parse(row["LastModifiedDate"].ToString());
                interaction.CreatedById = int.Parse(row["CreatedById"].ToString());
                interaction.LastModifiedById= int.Parse(row["LastModifiedById"].ToString());

                interactions.Add(interaction);
            }
            return interactions;
        }

        public void BulkSave(List<Interaction> interactions)
        {
            List<SqlBulkCopyColumnMapping> mappings = new List<SqlBulkCopyColumnMapping>();
            mappings.Add(new SqlBulkCopyColumnMapping(nameof(Interaction.Id), "Id"));
            mappings.Add(new SqlBulkCopyColumnMapping("CampaignId", "CampaignId"));
            mappings.Add(new SqlBulkCopyColumnMapping("ChannelId", "ChannelId"));
            mappings.Add(new SqlBulkCopyColumnMapping("CustomerId", "CustomerId"));
            mappings.Add(new SqlBulkCopyColumnMapping(nameof(Interaction.Date), "Date"));
            mappings.Add(new SqlBulkCopyColumnMapping(nameof(Interaction.Type), "Type"));
            mappings.Add(new SqlBulkCopyColumnMapping(nameof(Interaction.Revenue), "Revenue"));
            mappings.Add(new SqlBulkCopyColumnMapping(nameof(Interaction.CreatedById), "CreatedById"));
            mappings.Add(new SqlBulkCopyColumnMapping(nameof(Interaction.LastModifiedById), "LastModifiedById"));

            this.access.BulkSave("dbo.Interaction", mappings, ToDatatable(interactions));
        }

        private DataTable ToDatatable(List<Interaction> interactions)
        {
            DataTable table = new DataTable();
            table.Columns.Add("Id");
            table.Columns.Add("Date");
            table.Columns.Add("Type");
            table.Columns.Add("Revenue");
            table.Columns.Add("CampaignId");
            table.Columns.Add("ChannelId");
            table.Columns.Add("CustomerId");
            table.Columns.Add("CreatedById");
            table.Columns.Add("LastModifiedById");

            foreach (Interaction item in interactions)
            {
               DataRow newRow =  table.NewRow();
                if(item.Id != 0)
                {
                    newRow["Id"] = item.Id;
                }
                newRow["Date"] = item.Date;
                newRow["Type"] = item.Type;
                newRow["Revenue"] = item.Revenue;
                newRow["CampaignId"] = item.Campaign.Id;
                newRow["ChannelId"] = item.Channel.Id;
                newRow["CustomerId"] = item.Customer.Id;
                newRow["CreatedById"] = item.CreatedById;
                newRow["LastModifiedById"] = item.LastModifiedById;
                table.Rows.Add(newRow);
            }
            return table; 
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
                if (entity.Id == 0)
                {
                    int Id = this.access.Save("dbo.UpsertInteraction", this.GenerateParameters(entity), true);
                    entity.Id = Id;
                }
                else
                {
                    this.access.Save("dbo.UpsertInteraction", this.GenerateParameters(entity));
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
