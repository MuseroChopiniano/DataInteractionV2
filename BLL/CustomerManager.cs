using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Entities;
using BLL.Mappers;


namespace BLL
{
    public class CustomerManager
    {
        public List<Customer> GetCustomers()
        {

            CustomerMapper customerMapper = new CustomerMapper();
            List<Customer> customers = customerMapper.ReadAll();
            return customers;
        }

        public void SaveCustomer(Customer customer)
        {
            bool update = customer.Id != 0;
            int result = 0;
            CustomerMapper customerMapper = new CustomerMapper();
            result = customerMapper.Upsert(customer);
            if (result == 0)
            {
                LogManager logManager = new LogManager();
                logManager.SaveLog(new LogEntity()
                {
                    EventType = update ? EventType.ObjectUpdate : EventType.ObjectInsert,
                    Entity = "Customer",
                    Message = "The Customer with Id " + customer.Id + " has been upserted by User with Id " + customer.LastModifiedById,
                    LastModifiedById = customer.LastModifiedById,
                    CreatedById = customer.LastModifiedById
                });
            }
        }

        public Customer GetCustomers(Customer customer)
        {
            CustomerMapper customerMapper = new CustomerMapper();
            return customerMapper.Read(customer);
         
        }

        public void DeleteCustomer(Customer customer)
        {
            int result = 0;
            CustomerMapper customerMapper = new CustomerMapper();
            result = customerMapper.Delete(customer);

            if (result != -2)
            {
                LogManager logManager = new LogManager();
                logManager.SaveLog(new LogEntity()
                {
                    EventType = EventType.ObjectDelete,
                    Entity = "Customer",
                    Message = "The Customer with Id " + customer.Id + " has been deleted by " + customer.LastModifiedById,
                    LastModifiedById = customer.LastModifiedById,
                    CreatedById = customer.LastModifiedById

                });
            }
        }
    }
}
