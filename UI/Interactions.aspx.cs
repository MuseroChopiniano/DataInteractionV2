using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using BLL.Entities;
using CsvHelper;
using CsvHelper.Configuration;
using UI.CsvHelpers;

namespace UI
{
    public partial class Interactions : System.Web.UI.Page
    {
        InteractionManager manager = new InteractionManager();
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
            if (!userManager.HasPermission(this.contextUser, "Interaction-Create"))
            {
                this.newBtnContainer.Visible = false;

            }
            if (!userManager.HasPermission(this.contextUser, "Interaction-Bulk Create"))
            {
                this.bulkBtn.Visible = false;

            }
        }

        private void LoadGridView()
        {
            if (userManager.HasPermission(this.contextUser, "Interaction-Read"))
            {
                InteractionsGridView.DataSource = manager.GetInteractions();
            InteractionsGridView.DataBind();
                noRowsDiv.Visible = InteractionsGridView.Rows.Count == 0;
                tableDiv.Visible = InteractionsGridView.Rows.Count > 0;
            }
        }

        protected void InteractionsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow" && e.CommandArgument != null)
            {
                int index = int.Parse((string)e.CommandArgument);
                manager.DeleteInteraction(new Interaction() { Id = (int)InteractionsGridView.DataKeys[index].Value, LastModifiedById = this.contextUser.Id})
               ;
                this.LoadGridView();
            }
        }

        protected void UploadBtn_Click(object sender, EventArgs e)
        {
           

            String tempPathForFile = AppDomain.CurrentDomain.GetData("DataDirectory").ToString();
            if (UploadControl.HasFile)
            {
                String fileName = UploadControl.FileName;
                tempPathForFile += fileName;
                UploadControl.SaveAs(tempPathForFile);
                ReadCsv(tempPathForFile);
            }
            
        }
        private void ReadCsv(String path)
        {
            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;
            try
            {
                using (var reader = new StreamReader(path))
                {
                    var csvConfig = new CsvConfiguration(CultureInfo.InvariantCulture);
                    using (var csv = new CsvReader(reader, csvConfig))
                    {
                        csv.Context.RegisterClassMap<InteractionMap>();
                        var records = csv.GetRecords<Interaction>();
                        List<Interaction> interactions = records.ToList();
                        interactions.ForEach(i =>
                        {
                            i.CreatedById = int.Parse(ticket.UserData);
                            i.LastModifiedById = int.Parse(ticket.UserData);
                        });

                        this.manager.UpsertInteraction(interactions);

                    }
                }
                this.LoadGridView();
            } catch (Exception ex)
            {
                String csname = "PopupScript";
                Type cstype = this.GetType();
                ClientScriptManager cs = Page.ClientScript;
                if (!cs.IsStartupScriptRegistered(cstype, csname))
                {
                    String cstext = "showError();";
                    cs.RegisterStartupScript(cstype, csname, cstext, true);
                }
                }
           
        }

        protected void DonwloadTempBtn_Click(object sender, EventArgs e)
        {
            Response.ContentType = "text/csv";
            Response.AppendHeader("Content-Disposition", "attachment; filename=InteractionsTemplate.csv");
            Response.TransmitFile(Server.MapPath("~/App_Data/InteractionsTemplate.csv"));
            Response.End();
        }

        protected void InteractionsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            InteractionsGridView.PageIndex = e.NewPageIndex;
            this.LoadGridView();
        }

        protected bool HasDeletePermission()
        {
            return this.userManager.HasPermission(this.contextUser, "Interaction-Delete");
        }
        protected void InteractionsGridView_DataBound(object sender, EventArgs e)
        {
            if (!this.HasDeletePermission())
            {
                InteractionsGridView.Columns[InteractionsGridView.Columns.Count - 1].Visible = false;
            }
        }
    }
}
