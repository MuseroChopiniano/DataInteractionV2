<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomerDetail.aspx.cs" Inherits="UI.CustomerDetail" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
<div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="CustomerTitle">Contact</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
              
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                       <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="CustomerNameLbl" class="col-form-label" Text="Name"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CustomerNameTxt" required ></asp:TextBox>      
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="CustomerEmail" class="col-form-label" Text="Email"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CustomerEmailTxt" required  TextMode="Email"></asp:TextBox>      
                        </div>
                         <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="CustomerDateOfBirth" class="col-form-label" Text="Birthdate"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CustomerDateOfBirthTxt" TextMode="Date" ></asp:TextBox>      
                         <asp:CompareValidator
    id="dateValidator" runat="server" 
    Type="Date"
    Operator="DataTypeCheck"
    ControlToValidate="CustomerDateOfBirthTxt" 
    ErrorMessage="Please enter a valid date."
                            cssClass="alert-danger">
</asp:CompareValidator>
                         </div>
                         <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="CustomerExternalId" class="col-form-label" Text="External Id"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CustomerExternalIdTxt" required ></asp:TextBox>      
                        </div>
                         <div class="container">
                            <div class="row">
                                  <div class="form-group col text-center">
                            <asp:Button CssClass="btn btn-primary di-button-primary" runat="server" ID="SaveBtn" Text="Save" OnClick="SaveBtn_Click"/>
                           <asp:Button CssClass="btn btn-secondary di-button-secondary" runat="server" ID="CancelBtn" Text="Cancel" OnClientClick="window.location.href='Customers.aspx'; return false;"/>
                                  
                                      </div>
                                </div>
                             </div>

                       </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>