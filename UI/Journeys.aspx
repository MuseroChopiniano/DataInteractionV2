<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Journeys.aspx.cs" Inherits="UI.Journeys" %>

<asp:Content ID="ContentHome" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
   <script src="https://cdn.plot.ly/plotly-2.12.1.min.js"></script>
    <script src="Charts/JourneyChart.js" type="text/javascript"></script>
    <div class="container-fluid">
          <div class="row">
                <div class="col-md-6 col-xl-12 mb-4">
                    <div class="card shadow  pb-2" >
                        <div id="JourneySankey" class=""></div>
                  </div>
              </div>
                    
        </div>
    </div>

     <script type='text/javascript'>
         $(document).ready(function () {
            
             plotyApp.sankey('JourneySankey', labels, source, target, values, 'Customer Journey');
         })
    </script>
</asp:Content>