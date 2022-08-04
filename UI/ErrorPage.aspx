<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorPage.aspx.cs" Inherits="UI.ErrorPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Error</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/Brand.css" rel="stylesheet" />
</head>
<body>
     <div class="container-fluid vh-100 align-middle text-center" >
      
    <form id="form1" runat="server">
        
            <h1>OOOPS...</h1>
 <p>Something went wrong. Contact your Admin for support or try again later.</p>
        <asp:Button CssClass="btn btn-primary di-button-primary" Text="Go Back Home" runat="server" OnClientClick="window.location.href='Default.aspx'; return false;" />
               </form>
         
         </div>
</body>
</html>
