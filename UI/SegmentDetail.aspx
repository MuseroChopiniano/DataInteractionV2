<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SegmentDetail.aspx.cs" Inherits="UI.SegmentDetail" %>
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
                         <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="SegmentNameLbl" class="col-form-label" Text="Name"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="SegmentNameTxt" required ></asp:TextBox>      
                        </div> </div>
                              <div class="row">
                       <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="SegmentTypeLbl" class="col-form-label" Text="Type"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="SegmentTypeTxt" required ></asp:TextBox>      
                        </div>
                        
                       <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="SegmentDescription" class="col-form-label" Text="Description"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="SegmentDescriptionTxt" TextMode="MultiLine" required></asp:TextBox>      
                        </div>
                       </div>
                         <div class="card mb-2">
                            <div class="card-header">Contacts</div>
                              <div class="card-body">
                        <div Id="tableDiv" runat="server" class="table table-bordered table-responsive">
                           <asp:GridView  ID="CustomersGridView" runat="server" CssClass="table table-hover table-striped" AutoGenerateColumns="False" DataKeyNames="Id" OnRowCommand="CustomersGridView_RowCommand">
                               <Columns>
                                <asp:BoundField DataField="Id" Visible="False" />
                                <asp:BoundField  DataField="Name" HeaderText="Name" />
                                <asp:BoundField DataField="Email" HeaderText="Email"/>
                                <asp:BoundField DataField="Age" HeaderText="Age" />
                                <asp:BoundField DataField="DateOfBirth" HeaderText="Birthdate" />
                                                   </Columns></asp:GridView>
                        </div>           
                         <div id="noRowsDiv" runat="server" class="row justify-content-center">
                            <div class="col-md-4">
                                <h5 class="rgba-primary-0">No Rows Found</h5>
                            </div>
                        </div>
                    </div>
                            </div>

                       <div class="container">
                            <div class="row">
                                  <div class="form-group col text-center">
                            <asp:Button CssClass="btn btn-primary di-button-primary" runat="server" ID="SaveBtn" Text="Save" OnClick="SaveBtn_Click"/>
                         <asp:Button CssClass="btn btn-secondary di-button-secondary" runat="server" ID="CancelBtn" Text="Cancel" OnClientClick="window.location.href='Segments.aspx'; return false;"/>
                                  </div>
                            </div>
                                  </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>