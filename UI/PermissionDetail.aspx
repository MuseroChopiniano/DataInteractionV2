<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PermissionDetail.aspx.cs" Inherits="UI.PermissionDetail" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
<div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="PermissionTitle">Permission</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
               
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                        <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="PermissionNameLbl" class="col-form-label" Text="Name"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="PermissionNameTxt" required ></asp:TextBox>      
                        </div>
                      </div>
                        <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="PermissionDescriptionLbl" class="col-form-label" Text="Description"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="PermissionDescriptionTxt" TextMode="MultiLine" required ></asp:TextBox>      
                        </div>
                            </div>
                        <div class="card mb-2">
                            <div class="card-header">Permissions</div>
                            <div class="container-fluid">
                                <div class="row">
                                    <asp:PlaceHolder runat="server" ID="PermissionsPlaceholder"></asp:PlaceHolder>
                                </div>
                            </div>
                        </div>
                        <div class="container">
                            <div class="row">
                                  <div class="form-group col text-center">
                                    <asp:Button CssClass="btn btn-primary di-button-primary" runat="server" ID="SaveBtn" Text="Save" OnClick="SaveBtn_Click"/>
                                      
                                     <asp:Button CssClass="btn btn-secondary di-button-secondary" runat="server" ID="CancelBtn" Text="Cancel" OnClientClick="window.location.href='Permissions.aspx'; return false;"/>
                                  </div>
                            </div>
                        </div>
                      

                      
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
