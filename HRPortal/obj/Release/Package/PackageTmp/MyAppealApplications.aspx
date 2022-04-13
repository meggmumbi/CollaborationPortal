<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyAppealApplications.aspx.cs" Inherits="HRPortal.MyAppealApplications" %>
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
                <li class="breadcrumb-item active">Appeal Applications</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
           My Appeal Applications
        </div>
          <div id="feedback" runat="server"></div>
        <div class="panel-body">
             <div class="table-responsive">
                     <table id="example1" class="table table-striped table-bordered">
                  <thead>
                    <tr>
                        <th>#</th>
                        <th>Application No</th>                       
                        <th>Institution Name</th>                        
                        <th>Appeal Date</th>
                        <th>Appeal Reason</th>                      
                        <th>Appeal Status</th>
                        <th>Appeal Verdict</th>
                      
                     
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                       string institutionNo = Convert.ToString(Session["InstitutionNo"]);
                        var data = nav.LicenceApplicationHeader.Where(x=> x.Institution_No == institutionNo && x.Appealed==true).ToList();
                        int counter = 0;
                        foreach (var item in data)
                        {
                            counter++;
                    %>
                    <tr>
                        <td><%=counter %></td>
                        <td><%=item.Application_No %></td>                                      
                        <td><% =item.Institution_Name %></td>
                      <td><% = Convert.ToDateTime(item.Appeal_Date).ToString("dd/MM/yyyy") %></td>   
                        <td><% =item.Reason_for_Appeal %></td>                      
                         <td><% = item.Appeal_Status%></td>
                        <td><% = item.Appeal_Verdict%></td>
                                          
                        
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
