<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="UI.Users" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="UsersTitle">Users</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
                <div id="newBtnContainer" runat="server" class="card-header d-flex justify-content-end">
                    <button id="HtmlNewBtn" type="button" Class="btn btn-primary di-button-primary m-1" onclick="window.location.href='UserDetail.aspx?action=new'"><i class="fas fa-plus"> </i>&nbsp;<span runat="server" ID="NewBtn">New</span></button>
                   
                </div>
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                        <div Id="tableDiv" runat="server" class="table table-bordered table-responsive">
                           <asp:GridView OnDataBound="UsersGridView_DataBound" ID="UsersGridView" runat="server" CssClass="table table-hover table-striped" AutoGenerateColumns="False" DataKeyNames="Id" OnRowCommand="UsersGridView_RowCommand" AllowPaging="True" OnPageIndexChanging="UsersGridView_PageIndexChanging">
                               <Columns>
                                
                                <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="UserDetail.aspx?Id={0}&action=edit" DataTextField="Username" Text="Username" HeaderText="Username" />
                                <asp:BoundField DataField="FirstName" HeaderText="FirstName"/>  
                                    <asp:BoundField DataField="LastName" HeaderText="LastName"/>
                                    <asp:BoundField DataField="Email" HeaderText="Email" />

                                   <asp:ButtonField ButtonType="Button" CommandName="DeleteRow" ControlStyle-CssClass="btn btn-danger di-button-danger" Text="Delete"  >
<ControlStyle CssClass="btn btn-danger di-button-danger"></ControlStyle>
                                   </asp:ButtonField>
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