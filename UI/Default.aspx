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
                                        <span class="kpi-value">$12.356.789</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3 mb-4">
                            <div class="card shadow border-left-primary pb-2">
                                <div class="card-body">
                                    <span class="kpi-header">Total Interactions</span>
                                    <div>
                                        <span class="kpi-value">123.456.789</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3 mb-4">
                            <div class="card shadow border-left-primary pb-2">
                                <div class="card-body">
                                   <span class="kpi-header">Total Revenue</span>
                                    <div>
                                        <span class="kpi-value">$12.356.789</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3 mb-4">
                            <div class="card shadow border-left-primary pb-2">
                                <div class="card-body">
                                <span class="kpi-header">ROI</span>
                                    <div>
                                        <span class="kpi-value">$12.356.789</span>
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
                       
                    </div>
                </div>

     <script type='text/javascript'>
         $(document).ready(function () {
             var intByChannelChart = document.getElementById("IntByChannelChart").getContext("2d");
             var revByChannelChart = document.getElementById("RevByChannelChart").getContext("2d");

             
            

             var pieData = [300, 50, 123, 133, 14];
             var pieLabel = ['red', 'blue', 'green'];
             chartApp.initInteractionsByChannelChart(intByChannelChart, intByChanneldata, intByChannelLabels,'Interactions By Channel');
             chartApp.initRevByChannelChart(revByChannelChart, pieData, pieLabel, 'Revenue By Channel');
         })
    </script>
</asp:Content>

