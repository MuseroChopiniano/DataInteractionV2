<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Logs.aspx.cs" Inherits="UI.Logs" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="LogTitle">Logs</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
                <div class="card-header d-flex justify-content-end">
                    </div>
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                        <div class="table table-bordered table-responsive">
                           <asp:GridView ID="LogsGridView" runat="server" CssClass="table table-hover table-striped" AutoGenerateColumns="False" DataKeyNames="Id" >
                               <Columns>
                                <asp:BoundField DataField="Id" Visible="true" HeaderText="Id"/>
                                 <asp:BoundField DataField="EventType" HeaderText="Event Type"/>
                                <asp:BoundField DataField="Message" HeaderText="Message" />
                                <asp:BoundField DataField="CreatedById" HeaderText="Created By Id" />
                                   <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" />

                                    </Columns>
                           </asp:GridView>
                        </div>                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
