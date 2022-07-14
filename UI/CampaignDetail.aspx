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
                         <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="CampaignNameLbl" class="col-form-label" Text="Name"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CampaignNameTxt" required ></asp:TextBox>      
                        </div></div>
                        <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="Campaignstatus" class="col-form-label" Text="Status"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CampaignstatusTxt" required ></asp:TextBox>      
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="CampaignActualCost" class="col-form-label" Text="Actual Cost"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CampaignActualCostTxt" TextMode="Number" asp-format="{0:#,###.00}" required step="any"></asp:TextBox>      
                            <asp:RegularExpressionValidator ID="revNumber" runat="server" ControlToValidate="CampaignActualCostTxt"
     ErrorMessage="Not a valid value"  ValidationExpression="^\d+(\.\d\d)?$" CssClass="alert-danger"></asp:RegularExpressionValidator>
                        </div>
                         <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="CampaignBudgetedCost" class="col-form-label" Text="Budgeted Cost"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CampaignBudgetedCostTxt" TextMode="Number" required step="any"></asp:TextBox>      
                        <asp:RegularExpressionValidator cssClass="alert-danger" ID="RegularExpressionValidator1" runat="server" ControlToValidate="CampaignBudgetedCostTxt"
     ErrorMessage="Not a valid value"  ValidationExpression="^\d+(\.\d\d)?$"></asp:RegularExpressionValidator>
                         </div>
                           <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="CampaignExpectedRevenue" class="col-form-label" Text="Expected Revenue"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CampaignExpectedRevenueTxt" TextMode="Number" required ></asp:TextBox>      
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="alert-danger" runat="server" ControlToValidate="CampaignExpectedRevenueTxt"
     ErrorMessage="Not a valid value"  ValidationExpression="^\d+(\.\d\d)?$"></asp:RegularExpressionValidator>
                           </div>
                         <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="CampaignStartDate" class="col-form-label" Text="Start Date"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CampaignStartDateTxt" TextMode="Date" required ></asp:TextBox>      
                        <asp:CompareValidator
    id="dateValidator" runat="server" 
    Type="Date"
    Operator="DataTypeCheck"
    ControlToValidate="CampaignStartDateTxt" 
    ErrorMessage="Please enter a valid date."
                            cssClass="alert-danger">
</asp:CompareValidator>
                         </div>
                         <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="CampaignEndDate" class="col-form-label" Text="End Date"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CampaignEndDateTxt" TextMode="Date" required ></asp:TextBox>      
                        <asp:CompareValidator
    id="CompareValidator1" runat="server" 
    Type="Date"
    Operator="DataTypeCheck"
    ControlToValidate="CampaignEndDateTxt" 
    ErrorMessage="Please enter a valid date."
                            cssClass="alert-danger">
</asp:CompareValidator>
                         </div>
                         <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="CampaignDescription" class="col-form-label" Text="Description"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CampaignDescriptionTxt" TextMode="MultiLine" required></asp:TextBox>      
                        </div>
                        </div>
                       <div class="container">
                            <div class="row">
                                  <div class="form-group col text-center">
                            <asp:Button CssClass="btn btn-primary di-button-primary" runat="server" ID="SaveBtn" Text="Save" OnClick="SaveBtn_Click"/>
                        <asp:Button CssClass="btn btn-secondary di-button-secondary" runat="server" ID="CancelBtn" Text="Cancel" OnClientClick="window.location.href='Campaigns.aspx'; return false;"/>
                                  </div>
                            </div>
                        </div>
                      
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>