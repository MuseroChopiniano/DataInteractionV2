<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Campaigns.aspx.cs" Inherits="UI.Campaigns" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="CampaignsTitle">Campaigns</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
                <div class="card-header d-flex justify-content-end">
                    <button id="HtmlNewBtn" type="button" Class="btn btn-primary di-button-primary m-1" onclick="window.location.href='/CampaignDetail.aspx?action=new'"><i class="fas fa-plus"> </i>&nbsp;<span runat="server" ID="NewBtn">New</span></button>
                </div>
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                        <div class="table table-bordered table-responsive">
                           <asp:GridView AllowPaging="true" OnPageIndexChanging="CampaignsGridView_PageIndexChanging" ID="CampaignsGridView" runat="server" CssClass="table table-hover table-striped" AutoGenerateColumns="False" DataKeyNames="Id" OnRowCommand="CampaignsGridView_RowCommand">
                               <Columns>
                                <asp:BoundField DataField="Id" Visible="False" />
                                <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="CampaignDetail.aspx?Id={0}&action=edit" DataTextField="Name" Text="Name" HeaderText="Name" />
                                <asp:BoundField DataField="Status" HeaderText="Status"/>
                                    <asp:BoundField DataField="ActualCost" HeaderText="Actual Cost" />
                                <asp:BoundField DataField="StartDate" HeaderText="Start Date" />
                                <asp:BoundField DataField="EndDate" HeaderText="End Date" />
                                    <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" />

                                   <asp:ButtonField ButtonType="Button" CommandName="DeleteRow" ControlStyle-CssClass="btn btn-danger di-button-danger" Text="Delete" />
                            </Columns>
                                <PagerSettings PageButtonCount="5" />
                               <PagerStyle HorizontalAlign = "Center" CssClass = "di-GridPager" />
                           </asp:GridView>
                        </div>                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

