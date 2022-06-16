using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using BLL.Entities;
namespace UI
{
    public partial class CustomerDetail : System.Web.UI.Page
    {
        string action;
        BLL.CustomerManager customerManager = new BLL.CustomerManager();

        protected void Page_Load(object sender, EventArgs e)
        {
            this.action = Request.Params.Get("action");
            if (!IsPostBack)
            {
                this.LoadData();
            }
        }

        private void LoadData()
        {
            if (action == "edit")
            {
                int custId = int.Parse(Request.Params.Get("id"));
                List<Customer> customers = customerManager.GetCustomers();
                Customer selectedCust = (from Customer c in customers
                                         where c.Id == custId
                                         select c).FirstOrDefault();
                if (selectedCust != null)
                {
                    this.BindData(selectedCust);
                }
            }
        }
        private void BindData(Customer cust)
        {
            this.CustomerNameTxt.Text = cust.Name;
            this.CustomerEmailTxt.Text = cust.Email;
            this.CustomerAgeTxt.Text = cust.Age.ToString();
            this.CustomerGenderTxt.Text = cust.Gender;
        }

        protected void SaveBtn_Click(object sender, EventArgs e)
        {
            Customer saveCustomer = new Customer();
            if (action == "edit")
            {
                int custId = int.Parse(Request.Params.Get("id"));
                saveCustomer.Id = custId;
            }
            saveCustomer.Name = this.CustomerNameTxt.Text;
            saveCustomer.Email = this.CustomerEmailTxt.Text;
            saveCustomer.Gender = this.CustomerGenderTxt.Text;
            saveCustomer.Age = int.Parse(this.CustomerAgeTxt.Text);
            customerManager.SaveCustomer(saveCustomer);
            Response.Redirect("Customers.aspx");
        }
    }
}