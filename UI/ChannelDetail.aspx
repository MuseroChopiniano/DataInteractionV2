<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChannelDetail.aspx.cs" Inherits="UI.ChannelDetail" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
<div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="ChannelTitle">Channel</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
                <div class="card-header d-flex justify-content-end">
                </div>
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                         <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="ChannelNameLbl" class="col-form-label" Text="Name"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="ChannelNameTxt" required ></asp:TextBox>      
                        </div>
                        <div class="form-group col-md-6"">
                            <asp:Label runat="server" ID="ChannelTypeLbl" class="col-form-label" Text="Type"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="ChannelTypeTxt" required ></asp:TextBox>      
                        </div>
                       </div>
                         <div class="container">
                            <div class="row">
                                  <div class="form-group col text-center">
                                   
                            <asp:Button CssClass="btn btn-primary di-button-primary" runat="server" ID="SaveBtn" Text="Save" OnClick="SaveBtn_Click"/>
                       
                                      
                                     <asp:Button CssClass="btn btn-secondary di-button-secondary" runat="server" ID="CancelBtn" Text="Cancel" OnClientClick="window.location.href='Channels.aspx'; return false;"/>
                                  </div>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>