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
    public partial class Customers : System.Web.UI.Page
    {
        CustomerManager customerManager = new CustomerManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            this.LoadGridView();

        }

        private void LoadGridView()
        {
            CustomersGridView.DataSource = customerManager.GetCustomers();
            CustomersGridView.DataBind();
        }

        protected void CustomersGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow" && e.CommandArgument != null)
            {
                int index =int.Parse((string)e.CommandArgument);
                customerManager.DeleteCustomer(new Customer() { Id = (int) CustomersGridView.DataKeys[index].Value })
               ;
                this.LoadGridView();
            }
        }

        protected void CustomersGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.CustomersGridView.PageIndex = e.NewPageIndex;
            this.LoadGridView();
        }
    }
}