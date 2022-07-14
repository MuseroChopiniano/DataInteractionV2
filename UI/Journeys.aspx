<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Journeys.aspx.cs" Inherits="UI.Journeys" %>

<asp:Content ID="ContentHome" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
   <script src="https://cdn.plot.ly/plotly-2.12.1.min.js"></script>
    <script src="Charts/JourneyChart.js" type="text/javascript"></script>
    <div class="container-fluid">
        <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="JourneyTitle">Journeys</h1> 
        </div>
          <div class="row">
                <div class="col-md-6 col-xl-12 mb-4">
                    <div class="card shadow  pb-2" >
                        <div id="JourneySankey" runat="server" class=""></div>
                         <div id="noRowsDiv" visible="false" runat="server" class="row justify-content-center">
                            <div class="col-md-4">
                                <h5 class="rgba-primary-0">No Enough Interactions</h5>
                            </div>
                        </div>
                  </div>
              </div>
                    
        </div>
    </div>

     <script type='text/javascript'>
         $(document).ready(function () {
            
             plotyApp.sankey('MainContentPlaceholder_JourneySankey', labels, source, target, values, '');
         })
    </script>
</asp:Content>