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
    public partial class Customers : System.Web.UI.Page
    {
        CustomerManager customerManager = new CustomerManager();
        UserManager userManager = new UserManager();
        User contextUser = new User();
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            this.contextUser.Id = int.Parse(ticket.UserData);
            if (!IsPostBack)
            {
                this.LoadGridView();
            }
            if (!userManager.HasPermission(this.contextUser, "Customer-Create"))
            {
                this.newBtnContainer.Visible = false;

            }
        }

        private void LoadGridView()
        {
            if (userManager.HasPermission(this.contextUser, "Customer-Read"))
            {
                List<Customer> customers = customerManager.GetCustomers();
                if (this.direction == SortDirection.Ascending)
                {
                    customers = customers.OrderBy(x => x.GetType().GetProperty(sortColumn).GetValue(x)).ToList();
                }
                else
                {
                    customers = customers.OrderByDescending(x => x.GetType().GetProperty(sortColumn).GetValue(x)).ToList();
                }
                CustomersGridView.DataSource = customers;
                CustomersGridView.DataBind();
                noRowsDiv.Visible = CustomersGridView.Rows.Count == 0;
                tableDiv.Visible = CustomersGridView.Rows.Count > 0;
            }
        }

        protected void CustomersGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow" && e.CommandArgument != null)
            {
                int index =int.Parse((string)e.CommandArgument);
                customerManager.DeleteCustomer(new Customer() {
                    Id = (int) CustomersGridView.DataKeys[index].Value,
                    LastModifiedById = this.contextUser.Id
                })
               ;
                this.LoadGridView();
            }
        }

        protected void CustomersGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.CustomersGridView.PageIndex = e.NewPageIndex;
            this.LoadGridView();
        }

        protected bool HasDeletePermission()
        {
            return this.userManager.HasPermission(this.contextUser, "Customer-Delete");
        }
        protected void CustomersGridView_DataBound(object sender, EventArgs e)
        {
            if (!this.HasDeletePermission())
            {
                CustomersGridView.Columns[CustomersGridView.Columns.Count - 1].Visible = false;
            }
        }

        protected void CustomersGridView_Sorting(object sender, GridViewSortEventArgs e)
        {
            this.sortColumn = e.SortExpression;
            if (direction == SortDirection.Ascending)
            {
                this.direction = SortDirection.Descending;
            }
            else
            {
                direction = SortDirection.Ascending;
            }
            this.LoadGridView();
        }
       
        public string sortColumn = "CreatedDate";

        public SortDirection direction
        {
            get
            {
                if (ViewState["directionState"] == null)
                {
                    ViewState["directionState"] = SortDirection.Ascending;
                }
                return (SortDirection)ViewState["directionState"];
            }
            set
            {
                ViewState["directionState"] = value;
            }
        }
    }
}