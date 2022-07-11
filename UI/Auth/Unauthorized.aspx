<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Unauthorized.aspx.cs" Inherits="UI.Unauthorized" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
<div class="container min-vh-100 d-flex align-items-center">
     
    <div class="col-md-12 text-center">
        <h3>You don't have permission to access this page</h3>
        <div class="mt-4">
        <asp:Button CssClass="btn btn-primary di-button-primary" runat="server" ID="BackBtn" Text="Back to Home" OnClientClick="window.location.href='../Default.aspx'; return false;"/>
        </div>
    </div>
</div>
</asp:Content>