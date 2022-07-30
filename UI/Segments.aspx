<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Segments.aspx.cs" Inherits="UI.Segments" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
     <script src="Scripts/chart.min.js" type="text/javascript"></script>
    <script src="Charts/SegmentCharts.js" type="text/javascript"></script>
    <div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="SegmentTitle">Segments</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
                  <div id="newBtnContainer" runat="server" class="card-header d-flex justify-content-end">
                   <!-- <button id="HtmlNewBtn" type="button" Class="btn btn-primary di-button-primary m-1" onclick="window.location.href='SegmentDetail.aspx?action=new'"><i class="fas fa-plus"> </i>&nbsp;<span runat="server" ID="NewBtn">New</span></button> -->
                    <button type="button" class="btn btn-primary di-button-primary m-1" onclick="window.location.href='SegmentGenerator.aspx?type=Engagement'"><i class="fas fa-plus"> </i>&nbsp;<span runat="server" ID="Span1">Generate Engagement Segments</span></button>
                   <button type="button" class="btn btn-primary di-button-primary m-1" onclick="window.location.href='SegmentGenerator.aspx?type=TotalSpend'"><i class="fas fa-plus"> </i>&nbsp;<span runat="server" ID="Span2">Generate Total Spend Segments</span></button>
                   
                </div>
                <div class="card shadow border-left-primary pb-2">
                    <div class="card-body">
                      <div visible="false" Id="tableDiv" runat="server" class="table table-bordered table-responsive">
                           <asp:GridView OnDataBound="SegmentsGridView_DataBound" AllowPaging="true" OnPageIndexChanging="SegmentsGridView_PageIndexChanging" ID="SegmentsGridView" runat="server" CssClass="table table-hover table-striped" AutoGenerateColumns="False" DataKeyNames="Id" OnRowCommand="SegmentsGridView_RowCommand">
                               <Columns>
                                <asp:BoundField DataField="Id" Visible="False" />
                                <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="SegmentDetail.aspx?Id={0}&action=edit" DataTextField="Name" Text="Name" HeaderText="Name" />
                                <asp:BoundField DataField="Type" HeaderText="Type"/>                               
                              
                                    <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" />

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
                           
                           <canvas id="SegmentChart"></canvas>
                            
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-secondary bg-secondary" data-dismiss="modal">Close</button>
                            <asp:Button Id="SaveSegmentBtn" Text="Save" CssClass="btn btn-primary di-button-primary" OnClick="SaveSegmentBtn_Click" runat="server" />
                        </div>
                      </div>
                    </div>
                  </div>
       
    <script type='text/javascript'>
         $(document).ready(function () {
             
             var segElement = document.getElementById('SegmentChart').getContext('2d');
             segmentApp.initSegmentChart(segElement, data, xTitle, yTitle);
         })
        console.log($('#formModal'));
        $('#formModal').on('show.bs.modal', function (event) {
            console.log(event);
            var button = $(event.relatedTarget) // Button that triggered the modal

            var modal = $(this)
            modal.find('.modal-title').text('Segmentation')

        })
    </script>
</asp:Content>
