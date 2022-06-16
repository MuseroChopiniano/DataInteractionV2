using System;
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
    public class CampaignMapper : IMapper<Campaign>
    {
        private Access access;

        public CampaignMapper()
        {
            this.access = new Access();
        }
        public int Delete(Campaign entity)
        {
            int result = 0;
            try
            {
                SqlParameter parameter = new SqlParameter("Id", entity.Id);
                result = this.access.Save("dbo.DeleteCampaign", new List<SqlParameter>() { parameter });
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                result = -2;
            }

            return result;
        }

        public List<SqlParameter> GenerateParameters(Campaign entity)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            if (entity.Id != 0)
            {
                parameters.Add(this.access.BuildParameter("Id", entity.Id));
            }
            parameters.Add(this.access.BuildParameter("Status", entity.Status));
            parameters.Add(this.access.BuildParameter("Name", entity.Name));
            //parameters.Add(this.access.BuildParameter("CreatedById", entity.CreatedById));
            //parameters.Add(this.access.BuildParameter("LastModifiedById", entity.LastModifiedById));
            parameters.Add(this.access.BuildParameter("ActualCost", entity.ActualCost));
            parameters.Add(this.access.BuildParameter("BudgetedCost", entity.BudgetedCost));
            parameters.Add(this.access.BuildParameter("Description", entity.Description));
            parameters.Add(this.access.BuildParameter("ExpectedRevenue", entity.ExpectedRevenue));
            parameters.Add(this.access.BuildParameter("StartDate", entity.StartDate));
            parameters.Add(this.access.BuildParameter("EndDate", entity.EndDate));

            return parameters;
        }

        public List<Campaign> MapEntityFromTable(DataTable table)
        {
            List<Campaign> campaigns = new List<Campaign>();
            foreach (DataRow row in table.Rows)
            {
                Campaign campaign = new Campaign();
                campaign.Id = int.Parse(row["Id"].ToString());
                campaign.Name = row["Name"].ToString();
                campaign.Status = row["Status"].ToString();
                campaign.ActualCost = decimal.Parse(row["ActualCost"].ToString());
                campaign.BudgetedCost = decimal.Parse(row["BudgetedCost"].ToString());
                campaign.CreatedById = int.Parse(row["CreatedById"].ToString());
                campaign.CreatedDate = DateTime.Parse(row["CreatedDate"].ToString());
                campaign.LastModifiedById = int.Parse(row["LastModifiedById"].ToString());
                campaign.LastModifiedDate = DateTime.Parse(row["LastModifiedDate"].ToString());
                campaign.Description = row["Description"].ToString();
                campaign.ExpectedRevenue = decimal.Parse(row["ExpectedRevenue"].ToString());
                campaign.StartDate = DateTime.Parse(row["StartDate"].ToString());
                campaign.EndDate = DateTime.Parse(row["EndDate"].ToString());
                campaigns.Add(campaign);
            }
            return campaigns;
        }

        public Campaign Read(Campaign entity)
        {
            throw new NotImplementedException();
        }

        public List<Campaign> ReadAll()
        {
            List<Campaign> campaigns = new List<Campaign>();
            try
            {
                DataTable campaignTable = this.access.Read("dbo.GetCampaigns", new List<SqlParameter>());
                campaigns = MapEntityFromTable(campaignTable);
            }
            catch (Exception ex)
            {
                //TODO: Handle Exception
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return campaigns;
        }

        public int Upsert(Campaign entity)
        {
            int result = 0;
            try
            {
                result = this.access.Save("dbo.UpsertCampaign", this.GenerateParameters(entity));
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
