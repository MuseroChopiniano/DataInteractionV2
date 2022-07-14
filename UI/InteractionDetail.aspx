<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InteractionDetail.aspx.cs" Inherits="UI.InteractionDetail" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
<div class="container-fluid">
         <div class="col-12 mb-4">
              <h1 class="page-header rgba-primary-0" runat="server" ID="InteractionTitle">Interaction</h1> 
        </div>
        <div class="row">
            <div class="col-md-12 mb-4">
                <div class="card-header d-flex justify-content-end">
                </div>
                <div class="card shadow border-left-primary  pb-2">
                    <div class="card-body">
                        <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="InteractionTypeLbl" class="col-form-label" Text="Type"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="InteractionTypeTxt" required ></asp:TextBox>      
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="InteractionChannel" class="col-form-label" Text="Channel"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="InteractionChannelTxt" required ></asp:TextBox>      
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="InteractionCustomer" class="col-form-label" Text="Customer"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="InteractionCustomerTxt" ></asp:TextBox>      
                        </div>
                       <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="InteractionCampaign" class="col-form-label" Text="Campaign"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="InteractionCampaignTxt"  ></asp:TextBox>      
                        </div>
                          <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="InteractionDate" class="col-form-label" Text="Date"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="InteractionDateTxt" TextMode="Date"  required></asp:TextBox>      
                        <asp:CompareValidator
    id="dateValidator" runat="server" 
    Type="Date"
    Operator="DataTypeCheck"
    ControlToValidate="InteractionDateTxt" 
    ErrorMessage="Please enter a valid date."
                            cssClass="alert-danger">
</asp:CompareValidator>
                          </div>
                       <div class="form-group col-md-6">
                            <asp:Label runat="server" ID="InteractionRevenue" class="col-form-label" Text="Revenue"></asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="InteractionRevenueTxt" TextMode="Number" step="any" required ></asp:TextBox>      
                       <asp:RegularExpressionValidator ID="revNumber" runat="server" ControlToValidate="InteractionRevenueTxt"
     ErrorMessage="Not a valid value"  ValidationExpression="^\d+(\.\d\d)?$" CssClass="alert-danger"></asp:RegularExpressionValidator>
                         
                       </div>
                       </div>
                      <div class="container">
                            <div class="row">
                                  <div class="form-group col text-center">
                            <asp:Button CssClass="btn btn-primary di-button-primary" runat="server" ID="SaveBtn" Text="Save" OnClick="SaveBtn_Click"/>
                         <asp:Button CssClass="btn btn-secondary di-button-secondary" runat="server" ID="CancelBtn" Text="Cancel" OnClientClick="window.location.href='Interactions.aspx'; return false;"/>
                                  </div>
                            </div>
                                  </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#MainContentPlaceholder_InteractionChannelTxt").autocomplete({
                source: function (request, response) {
                    var param = { ChannelName: $('#MainContentPlaceholder_InteractionChannelTxt').val() };
                    $.ajax({
                        url: "InteractionDetail.aspx/getChannels",
                        data: JSON.stringify(param),
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataFilter: function (data) { return data; },
                        success: function (data) {
                            console.log(JSON.stringify(data));
                            response($.map(data.d, function (item) {
                                return {
                                    value: item.Name
                                }
                            }))
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            var err = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(err.Message)
                            // console.log("Ajax Error!");    
                        }
                    });
                },
                minLength: 1 //This is the Char length of inputTextBox    
            });
        });  
    }

</script>
</asp:Content>
