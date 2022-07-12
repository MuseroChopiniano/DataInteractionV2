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
    public partial class PermissionDetail : System.Web.UI.Page
    {

        string action;
        PermissionManager manager = new PermissionManager();
        UserManager userManager = new UserManager();
        User contextUser = new User();


        Permission currentPerm = new Permission();
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            this.contextUser.Id = int.Parse(ticket.UserData);
            this.action = Request.Params.Get("action");
            if (this.action == null)
            {
                Response.Redirect("/PermissionDetail.aspx?action=new");
            }

            if (!IsPostBack)
            {
                this.LoadData();
            }
            else
            {
                this.loadPermissions(this.currentPerm);
            }
        }
        private void LoadData()
        {
            if (action == "edit")
            {
                if (!this.userManager.HasPermission(this.contextUser, "Permission-Edit"))
                {
                    Response.Redirect("/Auth/Unauthorized.aspx");
                }

                int permissionId = int.Parse(Request.Params.Get("id"));
                List<Permission> permissions = manager.GetPermissions();
                Permission selectedPermission = (from Permission c in permissions
                                                   where c.Id == permissionId
                                                   select c).FirstOrDefault();
                if (selectedPermission != null)
                {
                    this.currentPerm = selectedPermission;
                    this.BindData(selectedPermission);
                    this.loadPermissions(selectedPermission);
                }
            }
            else if (action == "new"){
                if (!this.userManager.HasPermission(this.contextUser, "Permission-Create"))
                {
                    Response.Redirect("/Auth/Unauthorized.aspx");
                }

                this.loadPermissions(this.currentPerm);
            }
        }
        private void BindData(Permission permission)
        {
            this.PermissionNameTxt.Text = permission.Name;
            this.PermissionDescriptionTxt.Text = permission.Description;

        }

        protected void SaveBtn_Click(object sender, EventArgs e)
        {
            
            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            Permission permissionToSave = new Permission();
            if (action == "edit")
            {
                int permissionId = int.Parse(Request.Params.Get("id"));
                permissionToSave.Id = permissionId;
                permissionToSave.LastModifiedDate = DateTime.Now;     
            }
            else{
                permissionToSave.CreatedById = int.Parse(ticket.UserData);
            }
            permissionToSave.LastModifiedById = int.Parse(ticket.UserData);
            permissionToSave.Name = this.PermissionNameTxt.Text;
            permissionToSave.Description =this.PermissionDescriptionTxt.Text;
            permissionToSave.Type = PermissionType.Group;

            this.getCheckboxesValues(permissionToSave);
            manager.UpsertPermission(permissionToSave);
            Response.Redirect("Permissions.aspx");
            
        }

        
        private void getCheckboxesValues(Permission permission)
        {
            
            foreach (Control divs in PermissionsPlaceholder.Controls)
            {
                foreach(Control control in divs.Controls)
                {
                    if (control.ClientID.Contains("checkbox"))
                    {
                        HtmlInputCheckBox checkbox = (HtmlInputCheckBox)control;
                        Boolean permissionExists = permission.ChildPermissions.Exists(x => x.Id == int.Parse(checkbox.Value));
                        if (checkbox.Checked && !permissionExists)
                        {
                            Permission permissionToAdd = new Permission()
                            {
                                Id = int.Parse(checkbox.Value)
                            };
                            permission.ChildPermissions.Add(permissionToAdd);
                            
                        }
                        if (!checkbox.Checked && permissionExists)
                        {
                            permission.ChildPermissions.RemoveAt(permission.ChildPermissions.FindIndex(x => x.Id == int.Parse(checkbox.Value)));
                        }
                    }   
                }
            }
            
        }
      

        private void loadPermissions(Permission currentPermission)
        {
            List<Permission> permissionsToShow = manager.GetPermissions();
            
            
            foreach (Permission permission in permissionsToShow)
            {
                if (permission.Id != currentPermission.Id)
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
                    checkboxControl.Checked = currentPermission.ChildPermissions.Exists(x => x.Id == int.Parse(checkboxControl.Value));

                  

                    divControl.Controls.Add(checkboxControl);
                    divControl.Controls.Add(labelControl);


                    PermissionsPlaceholder.Controls.Add(divControl);
                }
            }
          
           
        }

        protected void CancelBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Permissions.aspx");
        }
    }
}

