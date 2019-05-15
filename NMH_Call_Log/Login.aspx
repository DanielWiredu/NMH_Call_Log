<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="NMH_Call_Log.Login" %>

<!DOCTYPE html>

<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Nationwide Medical Insurance</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="/Content/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="/Content/dist/css/AdminLTE.min.css">
       <!-- toastr references -->
    <link href="/Content/plugins/toastr/toastr.min.css" rel="stylesheet" />
  </head>
  <body class="hold-transition login-page" style="background-color:#157b0699">
    <div class="login-box">
      <div class="login-logo">
        <a style="color:white" href="Login.aspx"><b>NMH</b> CRM </a>
      </div><!-- /.login-logo -->
      <div class="login-box-body">
        <p class="login-box-msg">Sign in to start your session</p>
        <form  runat="server">
                  <asp:ScriptManager runat="server" ></asp:ScriptManager>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                     <div class="form-group has-feedback">
              <asp:TextBox runat="server" ID="txtUsername" CssClass="form-control" placeholder="Username"></asp:TextBox>
              <span class="glyphicon glyphicon-user form-control-feedback"></span>
              <asp:RequiredFieldValidator runat="server" ErrorMessage="Username is required" ControlToValidate="txtUsername" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
          </div>
          <div class="form-group has-feedback">
            <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control" TextMode="Password" placeholder="Password"></asp:TextBox>
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            <asp:RequiredFieldValidator runat="server" ErrorMessage="Password is required" ControlToValidate="txtPassword" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
          </div>
          <div class="row">
            <div class="col-xs-12">
              <button type="submit" id="btnSignIn" class="btn btn-primary btn-block btn-flat" runat="server" onserverclick="btnSignIn_ServerClick">Sign In</button>
            </div><!-- /.col -->
          </div>
                </ContentTemplate>
            </asp:UpdatePanel>
         
        </form>

      </div><!-- /.login-box-body -->
    </div><!-- /.login-box -->

    <!-- jQuery 2.1.4 -->
    <script src="/Content/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="/Content/bootstrap/js/bootstrap.min.js"></script>
      <!-- toastr references -->
    <script src="/Content/plugins/toastr/toastr.min.js"></script>
      <script>
          $(document).ready(function () {
              setTimeout(function () {
                  toastr.options = {
                      closeButton: true,
                      progressBar: true,
                      showMethod: 'slideDown',
                      timeOut: 4000
                  };

              }, 1300);
          });
    </script>
  </body>
</html>
