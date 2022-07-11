<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserDetail.aspx.cs" Inherits="UI.UserDetail" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
<div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="UserTitle">User</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
               
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                        <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="UserNameLbl" class="col-form-label" Text="Username"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="UserNameTxt" TextMode="Email" required ></asp:TextBox>      
                        </div>
                      </div>
                        <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="UserFirstNameLbl" class="col-form-label" Text="First Name"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="UserFirstNameTx" required ></asp:TextBox>      
                        </div>
                             <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="UserLastNameLbl" class="col-form-label" Text="Last Name"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="UserLastNameTxt" required ></asp:TextBox>      
                        </div>
                             <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="UserEmailLbl" class="col-form-label" Text="Email"></asp:Label>       
                            <asp:TextBox runat="server" class="form-control" ID="UserEmailTxt" TextMode="Email" required ></asp:TextBox>      
                        </div>
                              <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="UserStatusLbl" class="col-form-label" Text="Status"></asp:Label>    
                            <asp:DropDownList runat="server" Id="UserStatusDropDown" CssClass="form-control">
                                <asp:ListItem Selected="True" Value="Active">Active</asp:ListItem>
                                <asp:ListItem Selected="True" Value="Active">Blocked</asp:ListItem>
                            </asp:DropDownList>
                                
                        </div>
                            </div>
                        <div class="card mb-2">
                            <div class="card-header">Permissions</div>
                            <div class="container-fluid">
                                <div class="row">
                                    <asp:PlaceHolder runat="server" ID="UsersPlaceholder"></asp:PlaceHolder>
                                </div>
                            </div>
                        </div>
                        <div class="container">
                            <div class="row">
                                  <div class="form-group col text-center">
                                    <asp:Button CssClass="btn btn-primary di-button-primary" runat="server" ID="SaveBtn" Text="Save" OnClick="SaveBtn_Click"/>
                                      
                                     <asp:Button CssClass="btn btn-secondary di-button-secondary" runat="server" ID="CancelBtn" Text="Cancel" OnClientClick="window.location.href='Users.aspx'; return false;"/>
                                  </div>
                            </div>
                        </div>
                      

                      
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
