<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="HRPortal.Login" %>

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

    <!-- Bootstrap Core CSS -->
    <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

    <!-- MetisMenu CSS -->
    <link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css"/>

        <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css"/>
    <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css"/>

    <!-- Custom CSS -->
    <link href="dist/css/sb-admin-2.css" rel="stylesheet" />
      <link rel="stylesheet" href="kuddos/css/icomoon.css">
    <!-- Morris Charts CSS -->
    <link href="bower_components/morrisjs/morris.css" rel="stylesheet" />

      <link rel="stylesheet" href="kuddos/css/style.css">
    <!-- Custom Fonts -->
    <link href="bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

</head>
<body>


<%--      <div class="py-2 bg-primary">
    	<div class="container">
    		<div class="row no-gutters d-flex align-items-start align-items-center px-3 px-md-0">
	    		<div class="col-lg-12 d-block">
		    		<div class="row d-flex">
			    		<div class="col-md-5 pr-4 d-flex topper align-items-center">
			    			<div class="icon bg-fifth mr-2 d-flex justify-content-center align-items-center"><span class="icon-map"></span></div>
						    <span class="text">Red Hill Road, off Limuru Road, Gigiri P.O. Box 54999 – 00200, Nairobi, Kenya.</span>
					    </div>
					    <div class="col-md pr-4 d-flex topper align-items-center">
					    	<div class="icon bg-secondary mr-2 d-flex justify-content-center align-items-center"><span class="icon-paper-plane"></span></div>
						    <span class="text">info@cue.or.ke</span>
					    </div>
					    <div class="col-md pr-4 d-flex topper align-items-center">
					    	<div class="icon bg-tertiary mr-2 d-flex justify-content-center align-items-center"><span class="icon-phone2"></span></div>
						    <span class="text">020–7205000</span>
					    </div>
				    </div>
			    </div>
		    </div>
		  </div>
    </div>--%>
<%--    <nav class="navbar navbar-expand-lg navbar-dark bg-dark ftco_navbar ftco-navbar-light" id="ftco-navbar">
	    <div class="container d-flex align-items-center">
	    	
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span> Menu
	      </button>
	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto">
	        	<%--<li class="nav-item active"><a href="Index.apsx" class="nav-link pl-0">Home</a></li>
	        	<li class="nav-item"><a href="Login.aspx" class="nav-link">Login</a></li>
	        	<li class="nav-item"><a href="RequestAccountCreation.aspx" class="nav-link">Register</a></li>
	        	<li class="nav-item"><a href="https://www.cue.or.ke/index.php?option=com_phocadownload&view=category&id=16:standards-and-guidelines&Itemid=187" class="nav-link">Universities Standards and Guidelines</a></li>
	        	<li class="nav-item"><a href="FAQs.aspx" class="nav-link">FAQs</a></li>	        	
	          <li class="nav-item"><a href="ContactUs.aspx" class="nav-link">Contact</a></li>
	        </ul>
	      </div>
	    </div>
	  </nav>--%>

    <form id="form1" runat="server">
        <div class="row" style="width: 100%; display: block; margin: auto;">
            <div class="panel col-md-10 col-lg-10 col-sm-10 col-xs-12 col-md-offset-1 col-lg-offset-1 col-sm-offset-1" style="margin-top: 20px; border: 1px solid #d0dada; border-radius: 4px; padding-top: 5px; padding-bottom: 10px;">
                <div class="row ">
                    <div style="width:100%">
                        <img src="images/cue-header.jpg" width="100%" height="100px" />
                        <h3 style="width: 100%; text-align: center;">COMMISSION FOR UNIVERSITY EDUCATION COLLABORATION PORTAL</h3>
                        <hr />
                    </div>

                    <div class="col-md-6 col-sm-8 col-xs-12 col-md-offset-3 col-sm-offset-2" style="border: 1px solid #d0dada; border-radius: 1px; border-bottom-width: 0px; border-top-width: 0px;">
                   
                        <div class="panel">
                            <div style="padding: 20px;">
                                <div id="feedback" runat="server"></div>
                                <div class="form-group">
                                    <label>Email Address:</label>

                                    <asp:TextBox CssClass="form-control" runat="server" ID="email" Placeholder="Email Address" required Style="height: 42px;" />

                                </div>

                                <div class="form-group">
                                    <label>Account Password:</label>

                                    <asp:TextBox CssClass="form-control " runat="server" ID="password" Placeholder="Account Password" type="password" required Style="height: 42px;" />

                                </div>
                                <a href="ForgotPass.aspx">Forgot Your Password?</a>
                                <a href="RequestAccountCreation.aspx" class="pull-right">Create Account</a>
                            </div>

                            <div style="background-color: #ececec; padding: 10px;">
                                <asp:Button runat="server" CssClass="btn btn-success btn-block btn-ladda" data-style="contract-overlay" ID="login" Text="Login" Style="border-radius: 2px; font-size: 17px; line-height: 1.471; padding: 10px 19px;z-index: 10;" OnClick="login_Click" OnClientClick="$('.loading').show();" />
                            </div>
                        </div>
                       </div>
                    </div>                    <div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center;">
                        <hr />
                        Copyright  &copy; <%: DateTime.Now.Year %>  Terms and Conditions Apply | <a href="http://www.cue.or.ke/">Commission for University Education</a>
                    </div>
                
              </div>
            <div>
           </div>
        </div>
    </form>
   <script type="text/javascript">
        if (document.layers) {
            //Capture the MouseDown event.
            document.captureEvents(Event.MOUSEDOWN);

            //Disable the OnMouseDown event handler.
            document.onmousedown = function () {
                return false;
            };
        }
        else {
            //Disable the OnMouseUp event handler.
            document.onmouseup = function (e) {
                if (e != null && e.type == "mouseup") {
                    //Check the Mouse Button which is clicked.
                    if (e.which == 2 || e.which == 3) {
                        //If the Button is middle or right then disable.
                        return false;
                    }
                }
            };
        }

        //Disable the Context Menu event.
        document.oncontextmenu = function () {
            return false;
        };
    </script>
   <script language="JavaScript"> var message = 'Right Click is disabled.This is not allowed!!!';
        function clickIE() { if (event.button == 2) { alert(message); return false; } }
        function clickNS(e) {
            if (document.layers || (document.getElementById && !document.all)) {
                if (e.which == 2 || e.which == 3) { alert(message); return false; }
            }
        }
        if (document.layers) { document.captureEvents(Event.MOUSEDOWN); document.onmousedown = clickNS; }
        else if (document.all && !document.getElementById) { document.onmousedown = clickIE; }
        document.oncontextmenu = new Function('alert(message);return false')

    </script>
</body>
