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
    public class CustomerMapper : IMapper<Customer>
    {
        private Access access;
        public int Delete(Customer entity)
        {
            int result = 0;
            try
            {
                SqlParameter parameter = new SqlParameter("Id", entity.Id);
                result = this.access.Save("dbo.DeleteCustomer", new List<SqlParameter>() { parameter });
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                result = -2;
            }

            return result;
        }

        public Customer Read(Customer entity)
        {
            List<Customer> customers = this.ReadAll();
            return customers.Find(x => x.Id == entity.Id);
        }

        public List<Customer> ReadAll()
        {
            List<Customer> customers = new List<Customer>();
            try
            {
                DataTable table = this.access.Read("dbo.GetCustomers", null);
                customers = MapEntityFromTable(table);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return customers;
        }

        public int Upsert(Customer entity)
        {
            int result = -2;
            try
            {
                string storeProcedure = "dbo.UpsertCustomer";
                result = this.access.Save(storeProcedure, this.GenerateParameters(entity));
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return result;
        }


       
        public CustomerMapper()
        {
            this.access = new Access();
        }

      

       
        public List<SqlParameter> GenerateParameters(Customer customer)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            if (customer.Id != 0)
            {
                parameters.Add(this.access.BuildParameter("Id", customer.Id));
            }

            parameters.Add(this.access.BuildParameter("Name", customer.Name));
            parameters.Add(this.access.BuildParameter("Email", customer.Email));
            parameters.Add(this.access.BuildParameter("Gender", customer.Gender));
            parameters.Add(this.access.BuildParameter("Age", customer.Age));
            return parameters;
        }
        public List<Customer> MapEntityFromTable(DataTable table)
        {
            List<Customer> customers = new List<Customer>();
            foreach (DataRow row in table.Rows)
            {
                Customer cust = new Customer();
                cust.Id = int.Parse(row["Id"].ToString());
                cust.Name = row["Name"].ToString();
                cust.Email = row["Email"].ToString();
                cust.Gender = row["Gender"].ToString();
                cust.Age = int.Parse(row["Age"].ToString());
                cust.CreatedById = int.Parse(row["CreatedById"].ToString());
                cust.LastModifiedById = int.Parse(row["LastModifiedById"].ToString());
                cust.CreatedDate = DateTime.Parse(row["CreatedDate"].ToString());
                cust.LastModifiedDate = DateTime.Parse(row["LastModifiedDate"].ToString());
                customers.Add(cust);
            }
            return customers;
        }

    }
}
