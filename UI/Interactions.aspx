<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Interactions.aspx.cs" Inherits="UI.Interactions" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="InteractionsTitle">Interactions</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
                <div id="newBtnContainer" runat="server" class="card-header d-flex justify-content-end">
                    <button id="HtmlNewBtn" type="button" Class="btn btn-primary di-button-primary m-1" onclick="window.location.href='InteractionDetail.aspx?action=new'"><i class="fas fa-plus"> </i>&nbsp;<span runat="server" ID="NewBtn">New</span></button>
                   <button id="bulkBtn" runat="server" type="button" class="btn btn-primary di-button-primary m-1" data-toggle="modal" data-target="#formModal" data-action="New"><i class="fas fa-plus"> </i>&nbsp;<span runat="server" ID="Span1">Bulk New</span></button>
                   
                </div>
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                       <div Id="tableDiv" runat="server" class="table table-bordered table-responsive">
                           <asp:GridView OnDataBound="InteractionsGridView_DataBound" AllowSorting="true" OnSorting="InteractionsGridView_Sorting" ID="InteractionsGridView" runat="server" CssClass="table table-hover table-striped" AutoGenerateColumns="False" DataKeyNames="Id" OnRowCommand="InteractionsGridView_RowCommand" AllowPaging="True" OnPageIndexChanging="InteractionsGridView_PageIndexChanging">
                               <Columns>
                                
                                <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="InteractionDetail.aspx?Id={0}&action=edit" DataTextField="Id" Text="Id" HeaderText="Id" SortExpression="Id" />
                                <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type"/>
                             
                                <asp:BoundField DataField="Channel.Name" HeaderText="Channel"/>
                                <asp:BoundField DataField="Customer.Name" HeaderText="Customer" /> 
                                <asp:BoundField DataField="Campaign.Name" HeaderText="Campaign" /> 
                                    <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                                    <asp:BoundField DataField="Revenue" HeaderText="Revenue" SortExpression="Revenue" />
                                    <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" SortExpression="CreatedDate" />

                                   <asp:ButtonField ButtonType="Button" CommandName="DeleteRow" ControlStyle-CssClass="btn btn-danger di-button-danger" Text="Delete" >
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
    <div class="modal fade" id="ErrorModal" role="alert"  >
        <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Something Went Wrong</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <div class="alert alert-block alert-danger">
                
                   Something went wrong trying to upload your file. Please check the data types and columns.
                </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
        
    </div>
    <div class="modal fade" id="formModal" tabindex="-1" role="dialog" aria-labelledby="formModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                      <div class="modal-content">
                        <div class="modal-header">
                          <h5 class="modal-title" id="formModalLabel"></h5>
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                          </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <asp:Button cssclass= "btn btn-primary di-button-primary m-1" Text="Download Template" Id="DonwloadTempBtn" OnClick="DonwloadTempBtn_Click" runat="server" />
                                </div>
                            <div class="form-group">
                              <asp:FileUpload ID="UploadControl" runat="server"  />
                 
                            </div>
                            
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-secondary bg-secondary" data-dismiss="modal">Close</button>
                            <asp:Button Id="SaveUserBtn"  OnClick="UploadBtn_Click" Text="Upload" CssClass="btn btn-primary di-button-primary"  runat="server" />
                        </div>
                      </div>
                    </div>
                  </div>
        <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                      <div class="modal-content">
                        <div class="modal-header">
                          <h5 class="modal-title" id="confirmModalLabel"></h5>
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                          </button>
                        </div>
                        <div class="modal-body">
                            <label>You're about to delete a record</label>
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-secondary bg-secondary" data-dismiss="modal">Close</button>
                            <asp:Button Id="ConfirmDeleteBtn" Text="Confirm" CssClass="btn btn-primary di-button-primary"  runat="server" />
                        </div>
                      </div>
                    </div>
                  </div>
     <script type="text/javascript">
         function showError() {
             $('#ErrorModal').modal();
         };
         console.log($('#formModal'));
         $('#formModal').on('show.bs.modal', function (event) {
                 console.log(event);
                 var button = $(event.relatedTarget) // Button that triggered the modal
                
                 var modal = $(this)
             modal.find('.modal-title').text('Upload File')
            
             })
    </script>
</asp:Content>
