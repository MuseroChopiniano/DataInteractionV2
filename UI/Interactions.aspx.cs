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
        protected void Page_Load(object sender, EventArgs e)
        {
            this.LoadGridView();

        }

        private void LoadGridView()
        {
            InteractionsGridView.DataSource = manager.GetInteractions();
            InteractionsGridView.DataBind();
        }

        protected void InteractionsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow" && e.CommandArgument != null)
            {
                int index = int.Parse((string)e.CommandArgument);
                manager.DeleteInteraction(new Interaction() { Id = (int)InteractionsGridView.DataKeys[index].Value })
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

            using (var reader = new StreamReader(path))
            {
                var csvConfig = new CsvConfiguration(CultureInfo.InvariantCulture) { Delimiter = ";" };
                using ( var csv = new CsvReader(reader, csvConfig))
                {
                    csv.Context.RegisterClassMap<InteractionMap>();
                    var records = csv.GetRecords<Interaction>();
                    List<Interaction> interactions = records.ToList();
                    interactions.ForEach(i => {
                        i.CreatedById = int.Parse(ticket.UserData);
                        i.LastModifiedById = int.Parse(ticket.UserData);
                    });

                    this.manager.UpsertInteraction(interactions);
                } }
         
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
    }
}
