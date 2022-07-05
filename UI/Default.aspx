<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UI._Default" MasterPageFile="~/Site.Master" %>

<asp:Content ID="ContentHome" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <script src="Scripts/chart.min.js" type="text/javascript"></script>
    <script src="Charts/HomeCharts.js" type="text/javascript"></script>
    <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-6 col-xl-3 mb-4">
                     
                            <div class="card shadow border-left-primary pb-2">
                                <div class="card-body">
                                 
                                     <span class="kpi-header">Total Spending</span>
                                    <div>
                                        <span class="kpi-value"  id="TotalSpendingSpan" runat="server"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3 mb-4">
                            <div class="card shadow border-left-primary pb-2">
                                <div class="card-body">
                                    <span class="kpi-header">Total Interactions</span>
                                    <div>
                                        <span class="kpi-value" runat="server" id="TotalInteractionSpan"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3 mb-4">
                            <div class="card shadow border-left-primary pb-2">
                                <div class="card-body">
                                   <span class="kpi-header">Total Revenue</span>
                                    <div>
                                        <span id="TotalRevenueSpan" runat="server" class="kpi-value"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3 mb-4">
                            <div class="card shadow border-left-primary pb-2">
                                <div class="card-body">
                                <span class="kpi-header">ROI</span>
                                    <div>
                                        <span class="kpi-value" id="ROISpan" runat="server">$12.356.789</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-xl-6 mb-4">
                            <div class="card shadow  pb-2">
                                <canvas id="IntByChannelChart" class=""></canvas>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3 mb-4">
                            <div class="card shadow  pb-2">
                               <canvas id="RevByChannelChart" ></canvas>
                            </div>
                        </div>
                      <div class="col-md-6 col-xl-3 mb-4">
                    <div class="card shadow pb-2">
                        <canvas id="CampaignByStatusChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md6 col-xl-6 mb-4">
                    <div class="card shadow pb-2">
                        <canvas id="InteractionsByTypeChart"></canvas>
                    </div>
                </div>
                <div class="col-md6 col-xl-6 mb-4">
                    <div class="card shadow pb-2">
                        <canvas id="CampaignBudgetChart"></canvas>
                    </div>
                </div>
                </div>
                </div>

     <script type='text/javascript'>
         $(document).ready(function () {
             var intByChannelChart = document.getElementById("IntByChannelChart").getContext("2d");
             var revByChannelChart = document.getElementById("RevByChannelChart").getContext("2d");

             
             var campaignByStatusChart = document.getElementById('CampaignByStatusChart').getContext("2d");


          
             var interactionsByTypeChart = document.getElementById('InteractionsByTypeChart').getContext("2d");

             var campaignBudgetChart = document.getElementById('CampaignBudgetChart').getContext("2d");
          /*   var campaignActualSpendData = [100, 321, 234];
             var campaignBudgetedData = [200, 300, 250];
             var campaignBudgetLabels = ["Campaign1", "Campaign2", "Campaign3"]; */


             chartApp.initInteractionsByChannelChart(intByChannelChart, intByChanneldata, intByChannelLabels,'Interactions By Channel');
             chartApp.initRevByChannelChart(revByChannelChart, revByChannelValues, revByChannelLabels, 'Revenue By Channel');
             chartApp.initCampaignStatusChart(campaignByStatusChart, campaignStatusData, campaignStatusLabels, 'Campaigns by Status');
             chartApp.initIntByTypeChart(interactionsByTypeChart, intByTypeData, intByTypeLabels, 'Interactions By Type');
             chartApp.initCampaignBudgetVariance(campaignBudgetChart, campaignActualSpentData, campaignBudgetedData, campaignBudgetLabels, 'Budget Variance by Campaign');

         })
    </script>
</asp:Content>

