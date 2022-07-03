<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="UI.Users" %>
<asp:Content ID="ContentUsers" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <div class="container-fluid">
         <div class="col-12 mb-4">
                            <h1 class="page-header rgba-primary-0" runat="server" id="UsersTitle" >Usuarios</h1> 
            </div>
        <div class="row">
            <div class="col-md-12 mb-4">
                    <div class="card-header d-flex justify-content-end">
                    <button type="button" class="btn btn-primary di-button-primary m-1" data-toggle="modal" data-target="#formModal" data-action="New"><i class="fas fa-plus"> </i>&nbsp;<span runat="server" ID="NewBtn">New</span></button>
                    <button type="button" class="btn btn-primary di-button-primary m-1" data-toggle="modal" data-target="#formModal" data-action="Edit"><i class="fas fa-pen"></i>&nbsp;<span runat="server" id="EditBtn">Edit</span></button>
                    <button type="button" class="btn btn-primary di-button-primary m-1" data-toggle="modal" data-target="#confirmModal"><i class="fas fa-trash"></i>&nbsp;<span runat="server" id="DeleteBtn">Delete</span></button>
                        </div>
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                        <div class="table-responsive">
                            
                            <asp:GridView ID="UserGridView" AutoGenerateColumns="false" runat="server" CssClass="table table-hover table-striped" OnRowDataBound="UserGridView_RowDataBound" OnRowCreated="UserGridView_RowCreated" OnSelectedIndexChanged="UserGridView_SelectedIndexChanged" AllowPaging="True" OnPageIndexChanging="UserGridView_PageIndexChanging">
                                <columns>
                                    <asp:BoundField HeaderText="Id" DataField="Id" />
                                     <asp:BoundField HeaderText="Username" DataField="Username" />
                                     <asp:BoundField HeaderText="Email" DataField="Email" />
                                     <asp:BoundField HeaderText="Status" DataField="Status" />
                                    <asp:BoundField HeaderText="Created Date" DataField="CreatedDate" />
                                    <asp:BoundField HeaderText="Last Modified Date" DataField="LastModifiedDate" />
                              
                                </columns>
                                 <PagerSettings PageButtonCount="5" />
                               <PagerStyle HorizontalAlign = "Center" CssClass = "di-GridPager" />
                            </asp:GridView>

                        </div>
                        
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
                            <input type="text" hidden id="UserIdTxt" runat="server" />
                            <div class="form-group">
                              <label for="username" class="col-form-label">Username:</label>
                              <input runat="server" type="text" class="form-control" id="usernameTxt"/>
                            </div>
                            <div class="form-group">
                              <label for="email" class="col-form-label">Email:</label>
                              <input runat="server" type="text" class="form-control" id="emailTxt"/>
                            </div>
                            <div class="form-group">
                              <label for="status" class="col-form-label">Status:</label>
                              <select runat="server" class="form-control" id="statusTxt">
                                <option value="Active" selected="selected">Active</option>
                                <option value="Blocked">Blocked</option>
                                  </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-secondary bg-secondary" data-dismiss="modal">Close</button>
                            <asp:Button Id="SaveUserBtn" Text="Save" CssClass="btn btn-primary di-button-primary" onclick="SaveUserBtn_Click" runat="server" />
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
                            <asp:Button Id="ConfirmDeleteBtn" Text="Confirm" CssClass="btn btn-primary di-button-primary" onclick="ConfirmDeleteBtn_Click" runat="server" />
                        </div>
                      </div>
                    </div>
                  </div>
    </div>
     <script type="text/javascript">
         console.log($('#formModal'));
         console.log($('#UserGridView'));
         $('#formModal').on('show.bs.modal', function (event) {
                 console.log(event);
                 var button = $(event.relatedTarget) // Button that triggered the modal
                 var action = button.data('action') // Extract info from data-* attributes
                 var modal = $(this)
             modal.find('.modal-title').text(action + ' User')
             if (action == 'New') {
                 $('.selectedRowStyle').removeClass('selectedRowStyle');
                 modal.find('#MainContentPlaceholder_UserIdTxt').val('');
                 modal.find('#MainContentPlaceholder_emailTxt').val('');
                 modal.find('#MainContentPlaceholder_usernameTxt').val('');
                 modal.find('#MainContentPlaceholder_statusTxt').val('Active');
             }
             })
    </script>
    <script>
        $('table tbody tr').click(function () {
            $('.selectedRowStyle').removeClass('selectedRowStyle');
            $(this).addClass('selectedRowStyle');
            $('#MainContentPlaceholder_UserIdTxt').val($(this).find('td').eq(0).html());
            $('#MainContentPlaceholder_usernameTxt').val($(this).find('td').eq(1).html());
            $('#MainContentPlaceholder_emailTxt').val($(this).find('td').eq(2).html());
            $('#MainContentPlaceholder_statusTxt').val($(this).find('td').eq(3).html());

        });
    </script>
</asp:Content>
