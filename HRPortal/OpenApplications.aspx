<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OpenApplications.aspx.cs" Inherits="HRPortal.OpenApplications" %>
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
                <li class="breadcrumb-item active">Open Application</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            My Draft Applications
        </div>
        <div class="panel-body">
            <div runat="server" id="Div1"></div>
            <div class="table-responsive">
                <table id="example1" class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Application Status</th>
                            <th>Applicant Type</th>
                            <th>Institution Name</th>
                            <th>Primary Academic Focus</th>
                            <th>Principal Research Focus</th>
                            <th>Email Address</th>                            
                            <th>Amount</th>
                            <th>Edit</th>

                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var nav = new Config().ReturnNav();
                            string institutionNo = Convert.ToString(Session["InstitutionNo"]);
                            var data = nav.LicenceApplicationHeader.Where(x => x.Account_No == institutionNo && x.Applicant_Type == "Collaboration" && x.Application_Status == "Awaiting Finance").ToList();
                            int counter = 0;
                            foreach (var item in data)
                            {
                                counter++;
                        %>
                        <tr>
                            <td><%=counter %></td>
                            <td><% =item.Application_Status%></td>
                            <td><% =item.Type_of_Apply_Institution%></td>
                            <td><% =item.Name_of_Applying_Institution %></td>
                            <td><% =item.Institution_Name %></td>
                            <td><% =item.Local_Academic_Focus %></td>
                            <td><% =item.Local_Research_Focus %></td>                         
                            <td><% =item.City %></td>
                            <td>
                                <a href="NewApplication.aspx?ApplicationNo=<%=item.Application_No%>" class="btn btn-success"><i class="fa fa-edit"></i>Edit</a>  </td>

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
