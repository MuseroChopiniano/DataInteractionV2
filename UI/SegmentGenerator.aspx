<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SegmentGenerator.aspx.cs" Inherits="UI.SegmentGenerator" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
     <script src="Scripts/chart.min.js" type="text/javascript"></script>
    <script src="Charts/SegmentCharts.js" type="text/javascript"></script>
    <div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="SegmentTitle">Segment Generator</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
 
                <div class="card shadow border-left-primary pb-2">
                    <div class="card-body">
                        <div runat="server" id="canvasDiv" css="col-ms-12">
                            <canvas id="SegmentChart"></canvas>
                        </div>
                      
                        <div id="noRowsDiv" runat="server" class="row justify-content-center">
                            <div class="col-md-4">
                                <h5 class="rgba-primary-0">No Enough Interactions</h5>
                            </div>
                        </div>
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
   
                                          
                            
                        
       
    <script type='text/javascript'>
         $(document).ready(function () {
             
             var segElement = document.getElementById('SegmentChart').getContext('2d');
             segmentApp.initSegmentChart(segElement, data, xTitle, yTitle);
         })
       
    </script>
</asp:Content>
