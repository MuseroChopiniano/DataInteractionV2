using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BLL;
using BLL.Entities;

namespace UI
{
    public partial class UserDetail : System.Web.UI.Page
    {
        string action;
        UserManager manager = new UserManager();
        User contextUser = new User();
        User userEdit = new User();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            this.contextUser.Id = int.Parse(ticket.UserData);
            this.action = Request.Params.Get("action");
            if(this.action == null)
            {
                Response.Redirect("/UserDetail.aspx?action=new");
            }
            if (!IsPostBack)
            {
                this.LoadData();
            }
            else
            {
                this.LoadPermissions(this.userEdit);
            }
        }
        private void LoadData()
        {
            if (action == "edit")
            {
                if (!this.manager.HasPermission(this.contextUser, "User-Edit"))
                {
                    Response.Redirect("/Auth/Unauthorized.aspx");
                }
                int userId = int.Parse(Request.Params.Get("id"));
                List<User> users = manager.GetAll();
                User selectedUser = (from User c in users
                                                 where c.Id == userId
                                                 select c).FirstOrDefault();
                if (selectedUser != null)
                {
                    this.userEdit = selectedUser;
                    this.BindData(selectedUser);
                    this.LoadPermissions(selectedUser);
                }
            }
            else if (action == "new")
            {
                if (!this.manager.HasPermission(this.contextUser, "User-Create"))
                {
                    Response.Redirect("/Auth/Unauthorized.aspx");
                }
                this.LoadPermissions(this.userEdit);
            }
        }
        private void BindData(User user)
        {
   
            this.UserNameTxt.Text = user.Username;
            this.UserFirstNameTx.Text = user.FirstName;
            this.UserLastNameTxt.Text = user.LastName;
            this.UserEmailTxt.Text = user.Email;
            this.UserStatusDropDown.SelectedValue = user.Status.ToString();

        }

        protected void SaveBtn_Click(object sender, EventArgs e)
        {

            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            User userToSave = new User();
            if (action == "edit")
            {
                int userId = int.Parse(Request.Params.Get("id"));
                userToSave.Id = userId;
                userToSave.LastModifiedDate = DateTime.Now;
            }
            else
            {
                userToSave.CreatedById = int.Parse(ticket.UserData);
            }
            userToSave.LastModifiedById = int.Parse(ticket.UserData);
            userToSave.Username = this.UserNameTxt.Text;
            userToSave.Email = this.UserEmailTxt.Text;
            userToSave.FirstName = this.UserFirstNameTx.Text;
            userToSave.LastName = this.UserLastNameTxt.Text;
            userToSave.Status = (UserStatus) Enum.Parse(typeof(UserStatus),this.UserStatusDropDown.SelectedValue);

            this.getCheckboxesValues(userToSave);
            manager.UpsertUser(userToSave);
            Response.Redirect("Users.aspx");

        }


        private void getCheckboxesValues(User user)
        {

            foreach (Control divs in UsersPlaceholder.Controls)
            {
                foreach (Control control in divs.Controls)
                {
                    if (control.ClientID.Contains("checkbox"))
                    {
                        HtmlInputCheckBox checkbox = (HtmlInputCheckBox)control;
                        Boolean permissionExists = user.Permissions.Exists(x => x.Id == int.Parse(checkbox.Value));
                        if (checkbox.Checked && !permissionExists)
                        {
                            Permission permissionToAdd = new Permission()
                            {
                                Id = int.Parse(checkbox.Value)
                            };
                            user.Permissions.Add(permissionToAdd);
                        }
                        if(!checkbox.Checked && permissionExists)
                        {
                            user.Permissions.RemoveAt(user.Permissions.FindIndex(x => x.Id == int.Parse(checkbox.Value)));
                        }
                    }
                }
            }

        }


        private void LoadPermissions(User currentUser)
        {
            PermissionManager permManager = new PermissionManager();
            List<Permission> permissionsToShow = permManager.GetParentPermissions();


            foreach (Permission permission in permissionsToShow)
            {
               
                    HtmlGenericControl divControl = new HtmlGenericControl("div");
                    divControl.Attributes.Add("class", "custom-control custom-switch m-2 col-md-5");
                    HtmlGenericControl labelControl = new HtmlGenericControl("label");
                    labelControl.Attributes.Add("class", "custom-control-label");
                    labelControl.InnerText = permission.Name;
                    labelControl.Attributes.Add("for", "checkbox" + permission.Id);

                    HtmlInputCheckBox checkboxControl = new HtmlInputCheckBox();


                    checkboxControl.Attributes.Add("class", "custom-control-input");
                    checkboxControl.ID = "checkbox" + permission.Id;
                    checkboxControl.Value = permission.Id.ToString();
                    checkboxControl.ClientIDMode = ClientIDMode.Static;
                    checkboxControl.Checked = currentUser.Permissions.Exists(x => x.Id == int.Parse(checkboxControl.Value));

                    divControl.Controls.Add(checkboxControl);
                    divControl.Controls.Add(labelControl);


                    UsersPlaceholder.Controls.Add(divControl);
                
            }


        }

        protected void CancelBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Users.aspx");
        }
    }
}