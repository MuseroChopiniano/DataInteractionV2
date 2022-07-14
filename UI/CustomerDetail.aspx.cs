using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
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
        UserManager userManager = new UserManager();
        User contextUser = new User();

        protected void Page_Load(object sender, EventArgs e)
        {
            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            this.contextUser.Id = int.Parse(ticket.UserData);
            this.action = Request.Params.Get("action");
            if (this.action == null)
            {
                Response.Redirect("/CustomerDetail.aspx?action=new");
            }

            if (!IsPostBack)
            {
                this.LoadData();
            }
        }

        private void LoadData()
        {
            if (action == "edit")
            {
                if (!this.userManager.HasPermission(this.contextUser, "Customer-Edit"))
                {
                    Response.Redirect("/Auth/Unauthorized.aspx");
                }

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
            else if (action == "new")
            {
                if (!this.userManager.HasPermission(this.contextUser, "Customer-Create"))
                {
                    Response.Redirect("/Auth/Unauthorized.aspx");
                }
            }
         }
            private void BindData(Customer cust)
        {
            this.CustomerNameTxt.Text = cust.Name;
            this.CustomerEmailTxt.Text = cust.Email;
            this.CustomerDateOfBirthTxt.Text = cust.DateOfBirth.Value.Date.ToString("yyyy-MM-dd");
            this.CustomerExternalIdTxt.Text = cust.ExternalId;
        }

        protected void SaveBtn_Click(object sender, EventArgs e)
        {
            Customer saveCustomer = new Customer();
            if (action == "edit")
            {
                int custId = int.Parse(Request.Params.Get("id"));
                saveCustomer.Id = custId;
                saveCustomer.CreatedById = contextUser.Id;
            }
            saveCustomer.Name = this.CustomerNameTxt.Text;
            saveCustomer.Email = this.CustomerEmailTxt.Text;
            saveCustomer.DateOfBirth = DateTime.Parse(this.CustomerDateOfBirthTxt.Text);
            saveCustomer.ExternalId = this.CustomerExternalIdTxt.Text;
            saveCustomer.LastModifiedById = this.contextUser.Id;
            customerManager.SaveCustomer(saveCustomer);
            Response.Redirect("Customers.aspx");
        }
    }
}