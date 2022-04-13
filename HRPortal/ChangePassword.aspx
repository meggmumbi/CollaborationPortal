<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="HRPortal.ChangePassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - CUE</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <link href="images/logo.png" rel="shortcut icon" type="image/x-icon" />
  
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css"/>
    <!-- Bootstrap Core CSS -->
    <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>

    <!-- MetisMenu CSS -->
    <link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet"/>

    <!-- Custom CSS -->
    <link href="../dist/css/sb-admin-2.css" rel="stylesheet"/>

    <script type="text/javascript" src="js/jquery-1.8.2.js"></script> 
    <!-- Morris Charts CSS -->
    <link href="../vendor/morrisjs/morris.css" rel="stylesheet"/>

    <script src="js/http_ajax.googleapis.com_ajax_libs_jquery_3.2.1_jquery.min.js"></script>
    <!-- Custom Fonts -->
    <link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

       <style type="text/css">
       

        #toggle_pwd {
            cursor: pointer;
        }
    </style>

</head>
<body>



    <form id="form1" runat="server">
        <div class="row" style="width: 100%; display: block; margin: auto;">
            <div class="panel col-md-10 col-lg-10 col-sm-10 col-xs-12 col-md-offset-1 col-lg-offset-1 col-sm-offset-1" style="margin-top: 20px; border: 1px solid #d0dada; border-radius: 4px; padding-top: 5px; padding-bottom: 10px;margin-left:10%">
              <div class="row" style="width: 100%; margin: 5px;">
                    <div style="width: 100%">
                        <img src="images/cue-header.jpg" width="100%" height="100px" />
                        <h3 style="width: 100%; text-align: center;">INSTITUTIONS COLLABORATION PORTAL</h3>
                        <hr />
                    </div>
                        <div class="panel panel-default" style="width: inherit">
                             <div class="overlay" id="overlay"></div>
                            <div class="panel-heading">Please Fill in all the Details to Reset your  Account Password</div>
                            <div class="panel-body">
                                <div class="panel">
                                    <div id="feedbacks" runat="server"></div>
                                    <div style="padding: 20px;">
                                         <div id="feedback" style="display: none"></div>
                                         <div class="row">
                                            <div class="col-md-6 col-lg-6">
                                                <div class="form-group">
                                                    <label>Email Address</label>
                                                    <input type="email" class="form-control" id="emailid" value="<%=Session["email"]%>"  Style="height: 42px;" />
<%--                                                    <asp:TextBox CssClass="form-control" runat="server" ID="emailaddress" Placeholder="Email Address" type="text"    Style="height: 42px;" />--%>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-lg-6">
                                                <div class="form-group">
                                                    <label>Original Account Password</label>
                                                       <input type="password" class="form-control" id="orginalpassid" value="<%=Session["passwordValue"]%>" Style="height: 42px;" />
<%--                                                    <asp:TextBox CssClass="form-control" runat="server" ID="originalpassword" Placeholder="Original Account Password" type="password"  Style="height: 42px;" />--%>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 col-lg-6">
                                                <div class="form-group">
                                                    <label>New Account Password</label>
                                                       <input type="password" class="form-control" id="newpassid" Style="height: 42px;"  />
                                                     <span id="toggle_pwd" class="fa fa-fw fa-eye field_icon"></span>
<%--                                                    <asp:TextBox CssClass="form-control" runat="server" ID="newpassword" Placeholder="New Account Password" type="password"  Style="height: 42px;" />--%>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-lg-6">
                                                <div class="form-group">
                                                    <label>Confirm New Password</label>
                                                       <input type="password" class="form-control" id="confirmpass" Style="height: 42px;" />
<%--                                                    <asp:TextBox CssClass="form-control" runat="server" ID="confirmpassword" Placeholder="Confirm New Password" type="password"  Style="height: 42px;" />--%>
                                                </div>
                                            </div>
                                          </div>    

                                    </div>
                                        <a href="Login.aspx" class="pull-right">Back to Login</a>
                                    </div>
                                    </div>
                                    </div>
                                  </div>
                                    <div style="background-color: #ececec; padding: 10px;">
                                          <button class="btn btn-primary btn-block account-btn btn_js_passcChangePassword backgroundcolor" id="btn_js_passcChangePassword" type="button">Change Password</button>
                                       
                                      
                                    </div>
                               <div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center;">
                             Copyright  &copy; <%: DateTime.Now.Year %>  Terms and Conditions Apply | <a href="http://www.cue.or.ke/">Commission for University Education</a> 
                                </div>
                                </div>
                             
                             </div>
                           <div>
                        </div>
    </form>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script type="text/javascript" src="js/CustomJs.js"></script>
    <!-- Sweet Alert Js -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

    <script type="text/javascript">
        $(function () {
            $("#toggle_pwd").click(function () {
                $(this).toggleClass("fa-eye fa-eye-slash");
                var type = $(this).hasClass("fa-eye-slash") ? "text" : "password";
                $("#newpassid").attr("type", type);
            });
        });
    </script>

</body>

</html>
