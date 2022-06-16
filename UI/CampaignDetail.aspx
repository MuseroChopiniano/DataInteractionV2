<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CampaignDetail.aspx.cs" Inherits="UI.CampaignDetail" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
<div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="CampaignTitle">Campaign</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
                <div class="card-header d-flex justify-content-end">
                </div>
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                        <div class="form-group">
                            <asp:Label runat="server" ID="CampaignNameLbl" class="col-form-label" Text="Name"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CampaignNameTxt" required ></asp:TextBox>      
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="Campaignstatus" class="col-form-label" Text="Status"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CampaignstatusTxt" required ></asp:TextBox>      
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="CampaignActualCost" class="col-form-label" Text="Actual Cost"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CampaignActualCostTxt" TextMode="Number"  step="any"></asp:TextBox>      
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="CampaignBudgetedCost" class="col-form-label" Text="Budgeted Cost"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CampaignBudgetedCostTxt" TextMode="Number"  ></asp:TextBox>      
                        </div>
                          <div class="form-group">
                            <asp:Label runat="server" ID="CampaignExpectedRevenue" class="col-form-label" Text="Expected Revenue"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CampaignExpectedRevenueTxt" TextMode="Number"  ></asp:TextBox>      
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="CampaignStartDate" class="col-form-label" Text="Start Date"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CampaignStartDateTxt" TextMode="Date" required ></asp:TextBox>      
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="CampaignEndDate" class="col-form-label" Text="End Date"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CampaignEndDateTxt" TextMode="Date" required ></asp:TextBox>      
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="CampaignDescription" class="col-form-label" Text="Description"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CampaignDescriptionTxt" TextMode="MultiLine" ></asp:TextBox>      
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