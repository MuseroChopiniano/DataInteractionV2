﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Campaigns.aspx.cs" Inherits="UI.Campaigns" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="CampaignsTitle">Campaigns</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
                 <div id="newBtnContainer" runat="server" class="card-header d-flex justify-content-end">
                    <button id="HtmlNewBtn" type="button" Class="btn btn-primary di-button-primary m-1" onclick="window.location.href='CampaignDetail.aspx?action=new'"><i class="fas fa-plus"> </i>&nbsp;<span runat="server" ID="NewBtn">New</span></button>
                </div>
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                        <div Id="tableDiv" runat="server" class="table table-bordered table-responsive">
                           <asp:GridView OnDataBound="CampaignsGridView_DataBound" AllowSorting="true" OnSorting="CampaignsGridView_Sorting" AllowPaging="true" OnPageIndexChanging="CampaignsGridView_PageIndexChanging" ID="CampaignsGridView" runat="server" CssClass="table table-hover table-striped" AutoGenerateColumns="False" DataKeyNames="Id" OnRowCommand="CampaignsGridView_RowCommand">
                               <Columns>
                                <asp:BoundField DataField="Id" Visible="False" />
                                <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="CampaignDetail.aspx?Id={0}&action=edit" DataTextField="Name" Text="Name" HeaderText="Name" SortExpression="Name" />
                                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"/>
                                    <asp:BoundField DataField="ActualCost" HeaderText="Actual Cost"  SortExpression="ActualCost"/>
                                <asp:BoundField DataField="StartDate" HeaderText="Start Date" SortExpression="StartDate"/>
                                <asp:BoundField DataField="EndDate" HeaderText="End Date" SortExpression="EndDate" />
                                    <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" SortExpression="CreatedDate" />

                                   <asp:ButtonField ButtonType="Button" CommandName="DeleteRow" ControlStyle-CssClass="btn btn-danger di-button-danger" Text="Delete" />
                            </Columns>
                                <PagerSettings PageButtonCount="5" />
                               <PagerStyle HorizontalAlign = "Center" CssClass = "di-GridPager" />
                           </asp:GridView>
                        </div>           
                        <div id="noRowsDiv" runat="server" class="row justify-content-center">
                            <div class="col-md-4">
                                <h5 class="rgba-primary-0">No Rows Found</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

