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
            CustomerMapper customerMapper = new CustomerMapper();
            int result = customerMapper.Upsert(customer);
        }

        public Customer GetCustomers(Customer customer)
        {
            CustomerMapper customerMapper = new CustomerMapper();
            return customerMapper.Read(customer);
         
        }

        public void DeleteCustomer(Customer customer)
        {
            CustomerMapper customerMapper = new CustomerMapper();
            int result = customerMapper.Delete(customer);
        }
    }
}
