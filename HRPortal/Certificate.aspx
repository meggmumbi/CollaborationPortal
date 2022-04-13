<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Certificate.aspx.cs" Inherits="HRPortal.Certificate" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                <li class="breadcrumb-item active">My Licenses</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            My Licenses
        </div>
        <div class="panel-body">
            <div runat="server" id="renewLicense"></div>
            <div class="table-responsive">
            <table id="example1" class="table table-striped table-bordered">
                  <thead>
                    <tr>
                        <th>#</th>
                        <th>License No</th>
                        <th>License Type</th>
                        <th>Inspection Report No</th>
                        <th>Institution Name</th>
                        <th>Issue Date</th>
                        <th>Expiry Date</th>
                        <th>Renewal Status</th>   
                        <th>License</th>                     
                        <th>Apply</th>
                     
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
         
                        string institutionNo = Convert.ToString(Session["InstitutionNo"]);
                        var data = nav.collaborationLicenseEntries.Where(x=> x.Account_No == institutionNo).ToList();
                        int counter = 0;
                        foreach (var item in data)
                        {
                            counter++;
                    %>
                    <tr>
                        <td><%=counter %></td>
                        <td><% =item.License_No%></td>
                        <td><% =item.License_Type_Description %></td>
                        <td><% =item.Inspection_Report_No %></td>
                        <td><% =item.Institution_Name %></td>                      
                        <td><% = Convert.ToDateTime(item.Issue_Date).ToString("d/MM/yyyy") %></td>
                        <td><% = Convert.ToDateTime(item.Expiry_Date).ToString("d/MM/yyyy") %></td>
                        <td><% =item.Renewal_Status %></td>
                        <td><a href="LicensePrintOut.aspx?ApplicationNo=<%=item.License_No %>" class="btn btn-success"><i class="fa fa-file-pdf-o"></i></a></td>

                       

                       <td> <label class="btn btn-success" onclick="createRenewalVoucher('<%=item.License_No %>','<%=item.License_Type_Description %>');"><i class="fa fa-plus"></i> Apply for Renewal</label></td>                   
                        
                        <%
                            }
                        %>
                    </tr>
                </tbody>
            </table>
                </div>
        </div>
    </div>
           <script type="text/javascript">
               function createRenewalVoucher(LicenseNo,description) {
                   document.getElementById("licensetorenew").innerText = description;
                   document.getElementById("ContentPlaceHolder1_licenseNo").value = LicenseNo;

                $("#renewLicenseModal").modal();
            }
        </script>
        <div id="renewLicenseModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm License Renewal</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to Renew the licence <strong id="licensetorenew"></strong>?</p>
                    <asp:TextBox runat="server" ID="licenseNo" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Renew License" ID="renewlicensebutton" OnClick="renewlicensebutton_Click" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
