<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="UI.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <link rel="stylesheet" href="Content/bootstrap.css" />
    <link rel="stylesheet" href="Content/Brand.css" />
    <title>Data Interaction</title>
</head>
<body>
    <div class="container" >
        <div class="row">
            <div class="col-md-6 offset-md-3 col-lg-4 offset-lg-4">
                <img src="Content/Images/DILogo.png" class="img-fluid"  alt="Company Logo">
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 offset-md-3 col-lg-4 offset-lg-4">
                <div class="card">
                    <div class="card-header text-center di-card-header">
                        <span>Inicio de Sesión</span>
                    </div>
                    <div class="card-body">
                        <form runat="server">
                            <div class="form-group">
                                <label class="control-label"><span>Username</span></label>
                                <asp:TextBox ID="UsernameTxt" CssClass="form-control" placeholder="Ex: Gaston@DataInteraction.com" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredUsernameValidator" 
                                        ControlToValidate="UsernameTxt"
                                        Display="Dynamic" 
                                        ErrorMessage="Cannot be empty." 
                                        runat="server" />
                            </div>
                            <div class="form-group">
                                <label class="control-label"><span>Password</span></label>
                                <asp:TextBox runat="server" ID="PasswordTxt" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredPasswordValidator" 
                                        ControlToValidate="PasswordTxt"
                                        Display="Dynamic" 
                                        ErrorMessage="Cannot be empty." 
                                        runat="server" />
                            </div>
                             <div class="form-group">
                             <asp:CheckBox cssClass="form-input-checkbox" ID="Persist" runat="server" /> <label class="control-label">Remember me?</label>
                           </div>
                                 <div class="form-group">
                                <asp:Button ID="LoginBtn" OnClick="LoginBtn_Click" CssClass="btn btn-primary btn-block di-button-primary" runat="server" Text="Login"/>
                            </div> 
                           
                           
                            
                                <div class="form-group text-center">
 
                                <a href="/ForgotPass.aspx"><span>Forgot Password?</span></a>
                                
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer style="position:absolute; bottom:0;width:100%" class="text-center text-lg-start bg-light text-muted" >
        <span class="footer-copyright"> Made with &hearts; by Gastón Suárez &copy;All rights reserved.</span>
    </footer>
</body>
</html>
