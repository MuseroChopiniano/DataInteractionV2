﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SegmentDetail.aspx.cs" Inherits="UI.SegmentDetail" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
<div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="SegmentTitle">Segment</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
                <div class="card-header d-flex justify-content-end">
                </div>
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                        <div class="form-group">
                            <asp:Label runat="server" ID="SegmentNameLbl" class="col-form-label" Text="Name"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="SegmentNameTxt" required ></asp:TextBox>      
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="SegmentTypeLbl" class="col-form-label" Text="Type"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="SegmentTypeTxt" required ></asp:TextBox>      
                        </div>
                        
                       <div class="form-group">
                            <asp:Label runat="server" ID="SegmentDescription" class="col-form-label" Text="Description"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="SegmentDescriptionTxt" TextMode="MultiLine" ></asp:TextBox>      
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