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
                         <div Id="tableDiv" runat="server" class="table table-bordered table-responsive">
                           <asp:GridView AllowSorting="true" AllowPaging="true" OnSorting="LogsGridView_Sorting" OnPageIndexChanging="LogsGridView_PageIndexChanging" ID="LogsGridView" runat="server" CssClass="table table-hover table-striped" AutoGenerateColumns="False" DataKeyNames="Id" >
                               <Columns>
                                <asp:BoundField DataField="Id" Visible="true" HeaderText="Id" SortExpression="Id"/>
                                
                                     <asp:BoundField DataField="EventType" HeaderText="Event Type" SortExpression="EventType"/>
                                <asp:BoundField DataField="Entity" HeaderText="Entity" SortExpression="Entity"/>
                                   <asp:BoundField DataField="Message" HeaderText="Message" />
                                <asp:BoundField DataField="CreatedById" HeaderText="Created By Id" SortExpression="CreatedById" />
                                   <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" SortExpression="CreatedDate"/>

                                    </Columns>
                                <PagerSettings PageButtonCount="5" />
                               <PagerStyle HorizontalAlign = "Center" CssClass = "di-GridPager" />
                           </asp:GridView>
                        </div>                        
                         <div id="noRowsDiv" runat="server" class="row justify-content-center">
                            <div class="col-md-4">
                                <h5 class="rgba-primary-0">No Rows Found</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
