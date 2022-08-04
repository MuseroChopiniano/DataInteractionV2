<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="UI.ChangePassword" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
<div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="ChangePasswordTitle">ChangePassword</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
                <div class="card-header d-flex justify-content-end">
                </div>
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                         <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="CurrentPassLabel" class="col-form-label" Text="Current Password"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CurrentPasswordTxt" TextMode="Password" required ></asp:TextBox>   
                              <span id="errorMessage" runat="server" class="alert-danger" visible="false"></span>
                        </div></div>
                        <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="NewPasswordLabel" class="col-form-label" Text="New Password"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="NewPasswordTxt" TextMode="Password" required ></asp:TextBox>      
                        </div>
                      
                        </div>
                       <div class="container">
                            <div class="row">
                                  <div class="form-group col text-center">
                            <asp:Button CssClass="btn btn-primary di-button-primary" runat="server" ID="SaveBtn" Text="Save" OnClick="SaveBtn_Click"/>
                        <asp:Button CssClass="btn btn-secondary di-button-secondary" runat="server" ID="CancelBtn" Text="Cancel" OnClientClick="window.location.href='Default.aspx'; return false;"/>
                                  </div>
                            </div>
                        </div>
                      
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>