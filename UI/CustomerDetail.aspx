<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomerDetail.aspx.cs" Inherits="UI.CustomerDetail" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
<div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="CustomerTitle">Customer</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
                <div class="card-header d-flex justify-content-end">
                </div>
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                        <div class="form-group">
                            <asp:Label runat="server" ID="CustomerNameLbl" class="col-form-label" Text="Name"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CustomerNameTxt" required ></asp:TextBox>      
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="CustomerEmail" class="col-form-label" Text="Email"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CustomerEmailTxt" required ></asp:TextBox>      
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="CustomerAge" class="col-form-label" Text="Age"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CustomerAgeTxt" TextMode="Number" required ></asp:TextBox>      
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="CustomerGender" class="col-form-label" Text="Gender"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="CustomerGenderTxt" required ></asp:TextBox>      
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