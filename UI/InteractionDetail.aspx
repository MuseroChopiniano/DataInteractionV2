<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InteractionDetail.aspx.cs" Inherits="UI.InteractionDetail" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
<div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="InteractionTitle">Interaction</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
                <div class="card-header d-flex justify-content-end">
                </div>
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                        <div class="form-group">
                            <asp:Label runat="server" ID="InteractionTypeLbl" class="col-form-label" Text="Type"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="InteractionTypeTxt" required ></asp:TextBox>      
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="InteractionChannel" class="col-form-label" Text="Channel"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="InteractionChannelTxt" required ></asp:TextBox>      
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="InteractionCustomer" class="col-form-label" Text="Customer"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="InteractionCustomerTxt" ></asp:TextBox>      
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="InteractionCampaign" class="col-form-label" Text="Campaign"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="InteractionCampaignTxt"  ></asp:TextBox>      
                        </div>
                          <div class="form-group">
                            <asp:Label runat="server" ID="InteractionDate" class="col-form-label" Text="Date"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="InteractionDateTxt" TextMode="Date"  required></asp:TextBox>      
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="InteractionRevenue" class="col-form-label" Text="Revenue"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="InteractionRevenueTxt" TextMode="Number" step="any" required ></asp:TextBox>      
                        </div>
                       
                        <div class="form-group">
                            <asp:Button CssClass="btn btn-primary di-button-primary" runat="server" ID="SaveBtn" Text="Save" OnClick="SaveBtn_Click"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>