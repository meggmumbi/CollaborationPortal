<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OpenRenewalApplications.aspx.cs" Inherits="HRPortal.OpenRenewalApplications" %>
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
                <li class="breadcrumb-item active">Open Renewal Application</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
          Open  Applications pending Self Assessment
        </div>
          <div id="feedback" runat="server"></div>
        <div class="panel-body">
             <div class="table-responsive">
                     <table id="example1" class="table table-striped table-bordered">
                  <thead>
                    <tr>
                        <th>#</th>
                        <th>Application No</th>
                        <th>Application Status</th>
                        <th>Application Category</th>
                        <th>Applicant Type</th>
                        <th>Institution Name</th>
                        <th>Registration Certificate</th>
                       
                        <th>Licence Type</th>
                        <th>Registration Date</th>
                     
                        <th>Edit</th>
                     
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                       string institutionNo = Convert.ToString(Session["InstitutionNo"]);
                        var data = nav.LicenceApplicationHeader.Where(x=> x.Institution_No == institutionNo && x.License_Type=="Renewal").ToList();
                        int counter = 0;
                        foreach (var item in data)
                        {
                            counter++;
                    %>
                    <tr>
                        <td><%=counter %></td>
                        <td><%=item.Application_No %></td>
                        <td><% =item.Application_Status%></td>
                        <td><% =item.Application_Category %></td>
                        <td><% =item.Applicant_Type %></td>
                        <td><% =item.Institution_Name %></td>
                        <td><% =item.Registration_Certificate %></td>
                        <td><% = item.Licence_Type_Description%></td>
                        <td><% = Convert.ToDateTime(item.Registration_Date).ToString("d/MM/yyyy") %></td>

                        <%if (item.Application_Status == "Draft")
                            { %>

                        <td><a href="NewApplication.aspx?ApplicationNo=<%=item.Application_No%>" class="btn btn-success"><i class="fa fa-edit"></i>Edit</a></td>
                        <%}
                        else
                        { %>
                        <td> <a href="LicensingRenewReport.aspx?ApplicationNo=<%=item.Application_No%>" class="btn btn-success"><i class="fa fa-pdf"></i>View Application Report</a></td>
                        <%} %>

                        <%
                            }
                        %>
                    </tr>
                </tbody>
                     </table>
                 </div>
        </div>
    </div>

       

</asp:Content>
