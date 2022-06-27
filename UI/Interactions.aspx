<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Interactions.aspx.cs" Inherits="UI.Interactions" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="InteractionsTitle">Interactions</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
                <div class="card-header d-flex justify-content-end">
                    <button id="HtmlNewBtn" type="button" Class="btn btn-primary di-button-primary m-1" onclick="window.location.href='/InteractionDetail.aspx?action=new'"><i class="fas fa-plus"> </i>&nbsp;<span runat="server" ID="NewBtn">New</span></button>
                    <asp:FileUpload ID="UploadControl" runat="server"  />
                    <asp:button id="UploadBtn" CssClass="btn btn-primary di-button-primary m-1" runat="server" OnClick="UploadBtn_Click" text="Upload"/>
                </div>
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                        <div class="table table-bordered table-responsive">
                           <asp:GridView ID="InteractionsGridView" runat="server" CssClass="table table-hover table-striped" AutoGenerateColumns="False" DataKeyNames="Id" OnRowCommand="InteractionsGridView_RowCommand">
                               <Columns>
                                
                                <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="InteractionDetail.aspx?Id={0}&action=edit" DataTextField="Id" Text="Id" HeaderText="Id" />
                                <asp:BoundField DataField="Type" HeaderText="Type"/>
                               <%-- 
                                <asp:BoundField DataField="Channel.Name" HeaderText="Channel" />
                                <asp:BoundField DataField="Customer.Name" HeaderText="Customer" /> 
                                <asp:BoundField DataField="Campaign.Name" HeaderText="Campaign" /> --%>
                                    <asp:BoundField DataField="Date" HeaderText="Date" />
                                    <asp:BoundField DataField="Revenue" HeaderText="Revenue" />
                                    <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" />

                                   <asp:ButtonField ButtonType="Button" CommandName="DeleteRow" ControlStyle-CssClass="btn btn-danger di-button-danger" Text="Delete" />
                            </Columns>
                           </asp:GridView>
                        </div>                        
                    </div>
                </div>
            </div> 
        </div>
    </div>
</asp:Content>
