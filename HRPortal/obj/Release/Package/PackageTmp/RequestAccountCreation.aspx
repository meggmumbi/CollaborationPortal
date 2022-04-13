<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RequestAccountCreation.aspx.cs" Inherits="HRPortal.RequestAccountCreation" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Account Creation - CUE</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <link href="images/logo.png" rel="shortcut icon" type="image/x-icon" />
    <link rel="stylesheet" href="kuddos/css/icomoon.css"/>
    <link rel="stylesheet" href="kuddos/css/style.css"/>
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css" />
    <link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet" />
    <link href="../dist/css/sb-admin-2.css" rel="stylesheet" />
    <link href="dist/css/sb-admin-2.css" rel="stylesheet" />
    <script src="js/http_ajax.googleapis.com_ajax_libs_jquery_3.2.1_jquery.min.js"></script>
    <link href="bower_components/morrisjs/morris.css" rel="stylesheet" />
    <link href="bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />

<style type="text/css">
    .modal
    {
        position: fixed;
        top: 0;
        left: 0;
        background-color: black;
        z-index: 99;
        opacity: 0.8;
        filter: alpha(opacity=80);
        -moz-opacity: 0.8;
        min-height: 100%;
        width: 100%;
    }
    .loading
    {
        font-family: Arial;
        font-size: 10pt;
        border: 5px solid #67CFF5;
        width: 200px;
        height: 100px;
        display: none;
        position: fixed;
        background-color: White;
        z-index: 999;
    }
</style>

    <script type="text/javascript">
    function ShowProgress() {
        setTimeout(function () {
            var modal = $('<div />');
            modal.addClass("modal");
            $('body').append(modal);
            var loading = $(".loading");
            loading.show();
            var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
            var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
            loading.css({ top: top, left: left });
        }, 200);
    }
    $('form').live("submit", function () {
        ShowProgress();
    });
</script>
</head>
<body>


    <%--    <div class="py-2 bg-primary">
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
   <%-- <nav class="navbar navbar-expand-lg navbar-dark bg-dark ftco_navbar ftco-navbar-light" id="ftco-navbar">
        <div class="container d-flex align-items-center">

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="oi oi-menu"></span>Menu
	     
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
        <div id="loader" class="loader" style="display: none">
            <div class="center">
                <img alt="" src="images/loader.gif" />
            </div>
        </div>
        <div class="row" style="width: 100%; display: block; margin: auto;">
            <div class="panel col-md-10 col-lg-10 col-sm-10 col-xs-12 col-md-offset-1 col-lg-offset-1 col-sm-offset-1" style="margin-top: 20px; border: 1px solid #d0dada; border-radius: 4px; padding-top: 5px; padding-bottom: 10px;">
                <div class="row" style="width: 100%; margin: 5px;">
                    <div style="width: 100%">
                        <img src="images/cue-header.jpg" width="100%" height="100px" />
                        <h3 style="width: 100%; text-align: center;">INSTITUTIONS COLLABORATION PORTAL</h3>
                        <hr />
                    </div>
                    <div class="panel panel-default" style="width: inherit">
                        <div class="panel-heading">Please Fill in all the Details to Request for Account Creation</div>
                        <div class="panel-body">
                            <div class="panel">
                                <div style="padding: 20px;">
                                    <div id="feedback" runat="server"></div>
                                    <div id="acccountfeedback" runat="server" data-dismiss="alert"></div>
                                    <div class="row">
                                        <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>Institution/University seeking collaboration<span class="text-danger">*</span></label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="agencyName" Placeholder="Institution/University seeking collaboration" type="text" Style="height: 42px;" />
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label class="span2">Applicant Type<span style="color: red">*</span></label>
                                                <asp:DropDownList runat="server" ID="applicantType" AppendDataBoundItems="true" CssClass="form-control select2" OnSelectedIndexChanged="applicantType_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                    <asp:ListItem Value="1">Kenyan</asp:ListItem>
                                                    <asp:ListItem Value="2">Foreign</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator26" ControlToValidate="applicantType" InitialValue="--Select--" ErrorMessage="Select ApplicantType, it cannot be empty!" ForeColor="Red" />
                                            </div>
                                        </div>
                                        <div id="AppCountry" runat="server" visible="false" class="col-md-6 col-lg-6">
                                            <div class="col-md-6 col-lg-6">
                                                <div class="form-group">
                                                    <label for="exampleInputEmail1">country of the Applying Institution<span class="text-danger">*</span></label>
                                                    <asp:DropDownList runat="server" ID="foreignCountry" AppendDataBoundItems="true" CssClass="form-control"/>                                                    
                                                </div>
                                            </div>
                                        </div>
                                        <div id="local" runat="server" visible="false" class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                                            <div class="col-md-6 col-lg-6">
                                                <div class="form-group">
                                                    <label>Postal code: </label>
                                                    <asp:DropDownList CssClass="form-control" runat="server" ID="postalAddress" Placeholder="Select Post Code" Style="height: 42px;" OnSelectedIndexChanged="postalAddress_SelectedIndexChanged" AutoPostBack="true" />
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-lg-6">
                                                <div class="form-group">
                                                    <label>City: </label>
                                                    <asp:TextBox CssClass="form-control" runat="server" ID="city" ReadOnly="true" Style="height: 42px;" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>Physical Location. <i>(Street name,Building name,Floor number,Room number,Town)</i> <span class="text-danger">*</span></label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="residentialAddress" Placeholder="Physical Location" type="text" Style="height: 42px;" />
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>Postal Address <span class="text-danger">*</span></label>
                                                <asp:TextBox CssClass="form-control select2" runat="server" ID="postaLAddressPoBox" Placeholder="PO Box XXX" type="text" Style="height: 42px;" />
                                            </div>
                                        </div>                                   

                                           <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>Telephone Number. <span class="text-danger">*</span></label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="telephoneNo" Placeholder="Phone Number" TextMode="Number" Style="height: 42px;" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="telephoneNo" ErrorMessage="Please Enter a valid Phone Number" ForeColor="Red" ValidationExpression="[0-9]{10}"></asp:RegularExpressionValidator>

                                            </div>
                                        </div>                                      

                                 
                                        <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>Alternative telephone Number</label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="alternativePhoneNumber" TextMode="Number" Style="height: 42px;" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="alternativePhoneNumber" ErrorMessage="Please Enter a valid Phone Number" ForeColor="Red" ValidationExpression="[0-9]{10}"></asp:RegularExpressionValidator>
                                            </div>
                                        </div>
                                           <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>Email Address. <span class="text-danger">*</span></label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="emailAddress" Placeholder="cue@example.com" TextMode="Email" required Style="height: 42px;" />
                                                <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="emailAddress" ErrorMessage="Invalid Email Format" ForeColor="Red"></asp:RegularExpressionValidator>
                                            </div>
                                        </div>
                                    
                                   
                                        <div id="selectUniversityName" class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                                            <div class="form-group">
                                                <label>Website.</label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="website" Placeholder="website url" Style="height: 42px;" />
                                            </div>
                                        </div>
                                        </div>
                                   

                                     <i><p><strong>--Contact Person Details--</strong></p></i>
                                    <div class="row">
                                           <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>Contact person Name: <span class="text-danger">*</span></label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="contactName" Placeholder="contact name" required Style="height: 42px;" />

                                            </div>
                                        </div>
                                           <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>Contact Person Phone Number. <span class="text-danger">*</span></label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="contactPhoneNo" TextMode="Number" Style="height: 42px;" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="contactPhoneNo" ErrorMessage="Please Enter a valid Phone Number" ForeColor="Red" ValidationExpression="[0-9]{10}"></asp:RegularExpressionValidator>

                                            </div>
                                        </div>

                                   
                                   
                                           <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>Contact Person Email Address. <span class="text-danger">*</span></label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="contactEmailAdd" TextMode="Email" Style="height: 42px;" />

                                            </div>
                                           </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <a href="Login.aspx" class="pull-right">Back to Login</a>
                        <div style="background-color: #ececec; padding: 10px;">
                            <div id="v
                                "
                                style="display: none" class="modal">
                                <img src="images/loader.gif" />
                            </div>
                            <asp:Button runat="server" CssClass="btn btn-success btn-block btn_registration" ID="btn_registration" Text="Submit Registration" Style="border-radius: 2px; font-size: 17px; line-height: 1.471; padding: 10px 19px;" />
                        </div>

                        <div style="display: none;" class="ui-widget-overlay overlayforaddNote">
                        </div>
                        <div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center;">
                            <hr />
                            Copyright  &copy; <%: DateTime.Now.Year %>  Terms and Conditions Apply | <a href="http://www.cue.or.ke/">Commission for University Education</a>
                        </div>
                    </div>
                    <div>
                    </div>
                </div>
            </div>
    </form>
    <script>
        $('select').on('change', function () {
            var type = this.selectedIndex;
            var tproposedname = document.getElementById("proposedname");
            var tevidences = document.getElementById("evidences");
            var tselectUniversityName = document.getElementById("selectUniversityName");
            if (type == 0) {
                tproposedname.style.display = "block";
                tevidences.style.display = "block";
                tselectUniversityName.style.display = "none";
            } else {
                tproposedname.style.display = "none";
                tevidences.style.display = "none";
                tselectUniversityName.style.display = "block";
            }
        });
    </script>

        <script>
        $(document).ready(function () {
            $('form').submit(function () {
                if (!someValidations()) {
                    return false;
                } else {
                    $('form #loader').show();
                }
                return true;
            });

            function someValidations() {
                return true;
            }

        });
    </script>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script type="text/javascript" src="js/CustomJs.js"></script>
    <!-- Sweet Alert Js -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
</body>
