<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StatusOfApplication.aspx.cs" Inherits="HRPortal.StatusOfApplication" %>
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
                <li class="breadcrumb-item active">Status of Applications</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Application Status
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
                            <th>Emai Address</th>
                            <th>City</th>
                            <th></th>
                            <th></th>
                           

                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var nav = new Config().ReturnNav();
                            string institutionNo = Convert.ToString(Session["InstitutionNo"]);
                            var data1 = nav.LicenceApplicationHeader.Where(x => x.Account_No == institutionNo && x.Applicant_Type == "Collaboration").ToList();
                            int counter = 0;
                            foreach (var item in data1)
                            {
                                counter++;
                        %>
                        <tr>
                            <td><%=counter %></td>
                            <td><% =item.Application_Status%></td>
                            <td><% =item.Applicant_Type %></td>
                            <td><% =item.Institution_Name %></td>                          
                            <td><% =item.Local_Academic_Focus %></td>
                            <td><% =item.Local_Research_Focus %></td>
                            <td><% = item.Email_Address%></td>
                            <td><% =item.City %></td>
                            <%if (item.Application_Status == "Closed" && item.Preliminary_Verdict == "Approved for Licensing")
                                {


                            %><td></td>
                            <%}
                            else
                            { %>
                            <td></td>
                            <%} %>
                            <td> <a href="ApplicationFinalReport.aspx?ApplicationNo=<%=item.Application_No%>" class="btn btn-success"><i class="fa fa-file-pdf-o"></i>Application Report</a></td>


                            <%
                                }
                            %>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
 
   
<%--        <div class="panel-heading">
            Application Awaiting Completeness Check
        </div>
        <div class="panel-body">
            <div runat="server" id="Div2"></div>
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
                            <th>Emai Address</th>
                            <th>City</th>
                           
                        </tr>
                    </thead>
                    <tbody>
                        <%
                           
                           
                            var data = nav.LicenceApplicationHeader.Where(x => x.Institution_No == institutionNo && x.Applicant_Type == "Collaboration" && x.Application_Status == "Awaiting Completeness Check").ToList();
                            int counter1 = 0;
                            foreach (var item in data)
                            {
                                counter1++;
                        %>
                        <tr>
                            <td><%=counter1 %></td>
                            <td><% =item.Application_Status%></td>
                            <td><% =item.Appeal_Status %></td>
                            <td><% =item.Institution_Name %></td>
                            <td><% =item.Institution_Name %></td>
                            <td><% =item.Local_Academic_Focus %></td>
                            <td><% =item.Local_Research_Focus %></td>
                            <td><% = item.Email_Address%></td>
                            <td><% =item.City %></td>
                            

                            <%
                                }
                            %>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    

   
        <div class="panel-heading">
            Application Awaiting Verification Check
        </div>
        <div class="panel-body">
            <div runat="server" id="Div3"></div>
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
                            <th>Emai Address</th>
                            <th>City</th>
                           

                        </tr>
                    </thead>
                    <tbody>
                        <%
                            
                            var data2 = nav.LicenceApplicationHeader.Where(x => x.Institution_No == institutionNo && x.Applicant_Type == "Collaboration" && x.Application_Status == "Awaiting Verification Check").ToList();
                            int counter2 = 0;
                            foreach (var item in data2)
                            {
                                counter2++;
                        %>
                        <tr>
                            <td><%=counter2 %></td>
                            <td><% =item.Application_Status%></td>
                            <td><% =item.Appeal_Status %></td>
                            <td><% =item.Institution_Name %></td>
                            <td><% =item.Institution_Name %></td>
                            <td><% =item.Local_Academic_Focus %></td>
                            <td><% =item.Local_Research_Focus %></td>
                            <td><% = item.Email_Address%></td>
                            <td><% =item.City %></td>                           

                            <%
                                }
                            %>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
   

    
        <div class="panel-heading">
            Application Awaiting Site Visit
        </div>
        <div class="panel-body">
            <div runat="server" id="Div4"></div>
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
                            <th>Emai Address</th>
                            <th>City</th>
                           

                        </tr>
                    </thead>
                    <tbody>
                        <%
                            
                            var data3 = nav.LicenceApplicationHeader.Where(x => x.Institution_No == institutionNo && x.Applicant_Type == "Collaboration" && x.Application_Status == "Awaiting Site Visit").ToList();
                            int counter3 = 0;
                            foreach (var item in data3)
                            {
                                counter3++;
                        %>
                        <tr>
                            <td><%=counter3 %></td>
                            <td><% =item.Application_Status%></td>
                            <td><% =item.Appeal_Status %></td>
                            <td><% =item.Institution_Name %></td>
                            <td><% =item.Institution_Name %></td>
                            <td><% =item.Local_Academic_Focus %></td>
                            <td><% =item.Local_Research_Focus %></td>
                            <td><% = item.Email_Address%></td>
                            <td><% =item.City %></td>                           

                            <%
                                }
                            %>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
   

    
    
        <div class="panel-heading">
           Application Awaiting Certification
        </div>
        <div class="panel-body">
            <div runat="server" id="Div5"></div>
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
                            <th>Emai Address</th>
                            <th>City</th>
                           

                        </tr>
                    </thead>
                    <tbody>
                        <%
                            
                            var data4 = nav.LicenceApplicationHeader.Where(x => x.Institution_No == institutionNo && x.Applicant_Type == "Collaboration" && x.Application_Status == "Awaiting Certification").ToList();
                            int counter4 = 0;
                            foreach (var item in data4)
                            {
                                counter4++;
                        %>
                        <tr>
                            <td><%=counter4 %></td>
                            <td><% =item.Application_Status%></td>
                            <td><% =item.Appeal_Status %></td>
                            <td><% =item.Institution_Name %></td>
                            <td><% =item.Institution_Name %></td>
                            <td><% =item.Local_Academic_Focus %></td>
                            <td><% =item.Local_Research_Focus %></td>
                            <td><% = item.Email_Address%></td>
                            <td><% =item.City %></td>                           

                            <%
                                }
                            %>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
   
        
    
        <div class="panel-heading">
          Approved For Licensing
        </div>
        <div class="panel-body">
            <div runat="server" id="Div6"></div>
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
                            <th>Emai Address</th>
                            <th>City</th>
                            <th>License</th>
                           

                        </tr>
                    </thead>
                    <tbody>
                        <%
                            
                            var data5 = nav.LicenceApplicationHeader.Where(x => x.Institution_No == institutionNo && x.Applicant_Type == "Collaboration" && x.Application_Status == "Closed" && x.Preliminary_Verdict=="Approved for Licensing").ToList();
                            int counter5 = 0;
                            foreach (var item in data5)
                            {
                                counter5++;
                        %>
                        <tr>
                            <td><%=counter5 %></td>
                            <td><% =item.Application_Status%></td>
                            <td><% =item.Appeal_Status %></td>
                            <td><% =item.Institution_Name %></td>
                            <td><% =item.Institution_Name %></td>
                            <td><% =item.Local_Academic_Focus %></td>
                            <td><% =item.Local_Research_Focus %></td>
                            <td><% = item.Email_Address%></td>
                            <td><% =item.City %></td>  
                            <td><a href="NewApplication.aspx?ApplicationNo=<%=item.Application_No%>" class="btn btn-success"><i class="fa fa-edit"></i>View License</a> </td>
                           
                            <%
                                }
                            %>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
 --%>



    
</asp:Content>
