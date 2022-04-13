<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewApplication.aspx.cs" Inherits="HRPortal.NewApplication" %>
<%@ Import Namespace="HRPortal" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
    $(function () {
        $('[id*=txtDateInc]').datepicker({
            changeMonth: true,
            changeYear: true,
            format: "dd/mm/yyyy",
            language: "tr"
        });
    });
</script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step>11||step<1)
            {
                step = 1;
            }
        }
        catch (Exception)
        { step = 1;
        }
        if (step == 1)
        {
           %>
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                <li class="breadcrumb-item active">Applying Institution Details</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
           Applying Institution Details (<i style="color: yellow">Kindly note that all fields marked with asterisk (<span style="color: red">*</span>) are mandatory</i>)
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 11 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span> 
        </div>
        <div class="panel-body">
            <div runat="server" id="linesfeedback"></div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="span2">Name of collaborating institution<span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="NameCollab" CssClass="form-control span3" placeholder="Name" ReadOnly />
                           <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="validateapplicanttype" ControlToValidate="NameCollab" InitialValue="--Select--" ErrorMessage="Name of Applying Institution, it cannot be empty!" ForeColor="Red" />
                    </div>

                </div>  
                   <div class="col-md-6">
                        <div class="form-group">
                            <label class="span2">Applicant Type<span style="color: red">*</span></label>
                            <asp:DropDownList runat="server" ID="applicantType" AppendDataBoundItems="true" CssClass="form-control select2">
                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                <asp:ListItem Value="1">Kenyan</asp:ListItem>
                                 <asp:ListItem Value="2">Foreign</asp:ListItem>
                            </asp:DropDownList>                           
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator26" ControlToValidate="applicantType" InitialValue="--Select--" ErrorMessage="Select ApplicantType, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>           
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="span2">Physical Location <i>(Street name,Building name,Floor number,Room number)</i><span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="PhysicalLocation" CssClass="form-control span3" placeholder="Please Enter Your Physical Location" />
                          <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator1" ControlToValidate="PhysicalLocation" InitialValue="--Select--" ErrorMessage="Physical Address, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Postal code:</label>
                        <asp:DropDownList CssClass="form-control" runat="server" ID="PostCode" Placeholder="Select Post Code" OnSelectedIndexChanged="PostCode_SelectedIndexChanged" AutoPostBack="true" />
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label>City: </label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="localCity" ReadOnly="true" />
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Postal Address <span class="text-danger">*</span></label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="postaLAddressPoBox" Placeholder="PO Box XXX" type="text" />
                          <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator2" ControlToValidate="postaLAddressPoBox" InitialValue="--Select--" ErrorMessage="Postal Address, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Telephone Number. <span class="text-danger">*</span></label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="telephoneNoLocal" Placeholder="Phone Number" TextMode="Number" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator3" ControlToValidate="telephoneNoLocal" InitialValue="--Select--" ErrorMessage="Telephone Number, it cannot be empty!" ForeColor="Red" />

                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Email Address. <span class="text-danger">*</span></label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="emailAddrelocal" Placeholder="cue@example.com" TextMode="Email" />
                          <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator4" ControlToValidate="emailAddrelocal" InitialValue="--Select--" ErrorMessage="Email Address, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Website.</label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="website" Placeholder="website url"/>
                    </div>
                </div>
                 <div class="col-md-6">
                        <div class="form-group">
                            <label class="span2">Accreditation Status<span style="color: red">*</span></label>
                            <asp:DropDownList runat="server" ID="AcrreditationStatusLocal" AppendDataBoundItems="true" CssClass="form-control select2">
                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                <asp:ListItem Value="1">Accredited</asp:ListItem>
                            </asp:DropDownList>                           
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator5" ControlToValidate="AcrreditationStatusLocal" InitialValue="--Select--" ErrorMessage="Select Accreditation Status, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                   <div class="col-md-6">
                    <div class="form-group">
                        <label>Accrediting Body.</label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="accreditingBodyLocal" />
                          <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator6" ControlToValidate="accreditingBodyLocal" InitialValue="--Select--" ErrorMessage="accrediting Body  value, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                  <div class="col-md-6">
                    <div class="form-group">
                        <label>Present Capital Budget<i>(Ksh)</i><span class="text-danger">*</span></label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="CapitalBudget" TextMode="Number"/>
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator7" ControlToValidate="CapitalBudget" InitialValue="--Select--" ErrorMessage="Present Capital Budgtet, it cannot be empty!" ForeColor="Red" />
                           <asp:RangeValidator  Display="dynamic" ID="RangeValidator2" runat="server" ErrorMessage="Value cannot be negative or 0" forecolor="Red" ControlExtender="numberFilterMaskedEditExtender" controltovalidate="CapitalBudget" minimumvalue="1" maximumvalue="100000000000" type="Double"></asp:RangeValidator> 
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Present Recurrent Budget.<i>(Ksh)</i></label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="recurrentBudget" TextMode="Number"/>
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator8" ControlToValidate="recurrentBudget" InitialValue="--Select--" ErrorMessage="Recuurent Budget, it cannot be empty!" ForeColor="Red" />
                         <asp:RangeValidator  Display="dynamic" ID="RangeValidator1" runat="server" ErrorMessage="Value cannot be negative or 0" forecolor="Red" ControlExtender="numberFilterMaskedEditExtender" controltovalidate="recurrentBudget" minimumvalue="1" maximumvalue="100000000000"   type="Double"></asp:RangeValidator> 
                    </div>
                </div>



                            <div class="col-md-6">
                    <div class="form-group">
                        <label>Principle Research Focus. <span class="text-danger">*</span></label>
                        <asp:DropdownList CssClass="form-control select2" runat="server" ID="localPrinciples"/>
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator13" ControlToValidate="localPrinciples"  ErrorMessage="Principle Research Focus, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                   
                </div>
         

         

            </div>
             <div class="row" style="align-content:center">
                <asp:Button runat="server" ID="addapplication" CssClass="btn btn-warning center-block" Text="Add Application" OnClick="addapplication_Click" Visible="false"/>
                 <asp:Button runat="server" ID="editButton" CssClass="btn btn-warning center-block" Text="Edit Application" OnClick="addapplication_Click" Visible="false"/>
            </div>
          
           
       
          
        <div class="panel-footer">
            
               <asp:Button runat="server" ID="Nexttostep2" CssClass="btn btn-success pull-right" Text="Next" CausesValidation="false" OnClick="addapplication_Click"/>
            <div class="clearfix"></div>
        </div>

    </div>




       
    <% 
        }



         else if (step == 2)
        {
            %>

    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Programme Details</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
             Programme Details
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 11 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="Programme"></div>          
            <div class="row">
                     <div class="col-md-6">
                    <div class="form-group">
                        <label>Name of the programme offered<span class="text-danger">*</span></label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="ProgrammeNameOff" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator9" ControlToValidate="ProgrammeNameOff" ErrorMessage="Name of the Programme offered, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Academic Level and Specialization:</label>
                        <span class="asterisk" style="color: red">*</span>
                        <asp:DropDownList runat="server" ID="AcademicQualification" CssClass="form-control" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator25" ControlToValidate="AcademicQualification" ErrorMessage="Academic Qualification and Specialization, it cannot be empty!" ForeColor="Red" />

                    </div>
                </div>
           
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Student: Staff Ratio<span class="text-danger">*</span></label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="studentRation" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator10" ControlToValidate="studentRation" ErrorMessage="Student: Staff Ratio, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Staff Teaching Load Per Programme<span class="text-danger">*</span></label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="staffLoad" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator11" ControlToValidate="staffLoad" ErrorMessage="Staff Teaching Load Per Programme, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                      <div class="col-md-6">
                        <div class="form-group">
                            <label class="span2">Accredited By<span style="color: red">*</span></label>
                            <asp:DropDownList runat="server" ID="AccreditedBy" AppendDataBoundItems="true" CssClass="form-control select2" OnSelectedIndexChanged="AccreditedBy_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                <asp:ListItem Value="1">By Regulator</asp:ListItem>
                                  <asp:ListItem Value="2">Internally</asp:ListItem>
                            </asp:DropDownList>                           
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator27" ControlToValidate="AccreditedBy" InitialValue="--Select--" ErrorMessage="Accredited By, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                <div runat="server" id="evidence" visible="false">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Regulating body (Accrediting Body)<span class="text-danger">*</span></label>
                            <asp:TextBox CssClass="form-control" runat="server" ID="regulatorBody" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator30" ControlToValidate="regulatorBody" ErrorMessage="Regulating body (Accrediting Body), it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Evidence of accreditation of the proposed academic programme<i>(pdf only)  </i><span class="text-danger">*</span></label>
                            <asp:FileUpload runat="server" CssClass="form-control" ID="FileUpload1"></asp:FileUpload>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ErrorMessage="Only PDF files are allowed!" ValidationExpression="^.*\.(pdf|PDF)$" ControlToValidate="FileUpload1" CssClass="text-red"></asp:RegularExpressionValidator>
                             <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator31" ControlToValidate="FileUpload1" InitialValue="--Select--" ErrorMessage="Please upload Evidence of accreditation of the proposed academic programme, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label>Principle Academic Focus <span class="text-danger">*</span></label>
                        <asp:DropdownList CssClass="form-control select2" runat="server" ID="LocalAcademics" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator12" ControlToValidate="LocalAcademics" ErrorMessage="Principle Academic Focuss, it cannot be empty!" ForeColor="Red"   eColor="Red" />
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label>Envisaged benefit of the collaboration for education in Kenya generally.<span class="text-danger">*</span></label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="benefit" TextMode="MultiLine" Rows="3" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator14" ControlToValidate="benefit" ErrorMessage="Envisaged benefit of the collaboration for education in Kenya genrally, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div runat="server" id="internally" visible="false">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Explanation of accreditation/Approval of the proposed academic programme.</label>
                            <asp:TextBox CssClass="form-control" runat="server" ID="remarks" TextMode="MultiLine" Rows="3" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
       
    </div>
      <div class="panel-footer">     
      
        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" CausesValidation="false" OnClick="previousstep_Click" />
       
        <asp:Button runat="server" CssClass="btn btn-success pull-right" ID="Button4" Text="Next"  OnClick="Button4_Click"  />
        <div class="clearfix"></div>
    </div>
    
            
   

                <% 
                    }



        else if (step == 3)
        {
            %>

    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Source of Income Details</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Local Institution/University Details <i><strong>(Cont...)</strong></i>
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 11 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="sources"></div>          
                      <div class="row">
         
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Please provide primary source(s) of funds: </strong><span class="asterisk" style="color: red">*</span>
                        <asp:TextBox runat="server" ID="sourceFunds" CssClass="form-control" />    
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator28" ControlToValidate="sourceFunds" ErrorMessage="Please provide primary source(s) of fundsy, it cannot be empty!" ForeColor="Red" />                 
                    </div>
                </div>
                 </div>
               <div class="row" style="align-content: center">
                    <asp:Button runat="server" CssClass="btn btn-success center-block" Text="Add Source(s) of funds" ID="funds" OnClick="funds_Click"/>

                </div>
        </div>
          <div class="panel-body">
        <div class="table-responsive">
            <table id="example8" class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Source of funds</th>
                        <th>delete</th>
                     
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        string docNo= Request.QueryString["ApplicationNo"];
                        var data = nav.sourceOfFunds.Where(x => x.Application_No == docNo).ToList();
                        int counter = 0;
                        foreach (var item in data)
                        {
                            sourceOfIncome.Visible = true;
                            counter++;
                    %>
                    <tr>
                        <td><%=counter %></td>
                        <td><% =item.Description%></td>
                       
                    <td>
                             <label class="btn btn-danger" onclick="removeSourceFunds('<%=item.entry_No %>','<%=item.Description %>');"><i class="fa fa-trash-o"></i> Remove</label></td>
                        <%
                            }
                        %>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    </div>
     <div class="panel-footer">     
      
        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" CausesValidation="false" OnClick="previousstep_Click" />
       
        <asp:Button runat="server" CssClass="btn btn-success pull-right" ID="sourceOfIncome" Text="Next" OnClick="nextstep_Click" CausesValidation="false" Visible="false" />
        <div class="clearfix"></div>
    </div>
            
   

                <% 
                    }
                    else if (step == 4)
                    {
            %>

      <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Collaborating Local Institution/University Details</li>
            </ol>
        </div>
    </div>
        <div class="panel panel-primary">
            <div class="panel-heading">
                Collaborating Local Institution/University Details <i><strong></strong></i>
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of 11 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="physicalLocations"></div>
              
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputEmail1">Collaborating Local Institution/University Details <span class="text-danger">*</span></label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="foreignInst"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator15" ControlToValidate="foreignInst"  ErrorMessage="Name of the foreign/local institution, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>           
              
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="exampleInputEmail1">country of the institution<span class="text-danger">*</span></label>
                            <asp:DropDownList runat="server" ID="foreignCountry" AppendDataBoundItems="true" CssClass="form-control select2">
                            </asp:DropDownList>
                              <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator16" ControlToValidate="foreignCountry"  ErrorMessage="country of the institution, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>             
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputEmail1">Postal Address<span class="text-danger">*</span></label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="postalAddressF"  ></asp:TextBox>
                          <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator17" ControlToValidate="postalAddressF"  ErrorMessage="Postal Address, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                  
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputEmail1">Physical Address<span class="text-danger">*</span></label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="physicalAddressF" ></asp:TextBox>
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator18" ControlToValidate="physicalAddressF"  ErrorMessage="Physical Address, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                  
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputEmail1">Telephone Number<span class="text-danger">*</span></label>
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="telephoneNumberF"></asp:TextBox>
                          <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator19" ControlToValidate="telephoneNumberF"  ErrorMessage="Telephone Number, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="city">Email Address</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="foreignEmail" TextMode="Email"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="foreignEmail" ErrorMessage="Invalid Email Format" ForeColor="Red"></asp:RegularExpressionValidator>
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator20" ControlToValidate="foreignEmail"  ErrorMessage="Email Address, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="city">Website<span class="text-danger">*</span></label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="websiteF"></asp:TextBox>
                    </div>

                </div>
                       <div class="col-md-6">
                        <div class="form-group">
                            <label class="span2">Accreditation Status<span style="color: red">*</span></label>
                            <asp:DropDownList runat="server" ID="acreeditationStatusForeign" AppendDataBoundItems="true" CssClass="form-control select2">
                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                <asp:ListItem Value="1">Accredited</asp:ListItem>
                            </asp:DropDownList>                           
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator21" ControlToValidate="acreeditationStatusForeign"  ErrorMessage="Accreditation Status, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                   <div class="col-md-6">
                    <div class="form-group">
                        <label>Accrediting Body.</label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="accreditingForeign" />
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator22" ControlToValidate="accreditingForeign"  ErrorMessage="Accreditping Body, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                     <div class="col-md-6">
                    <div class="form-group">
                        <label>Principle Academic Focus. <span class="text-danger">*</span></label>
                        <asp:DropdownList CssClass="form-control" runat="server" ID="ForeignAcademics" />
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator23" ControlToValidate="ForeignAcademics"  ErrorMessage="Principle Academic Focus., it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                  <div class="col-md-6">
                    <div class="form-group">
                        <label>Principle Research Focus. <span class="text-danger">*</span></label>
                        <asp:DropdownList CssClass="form-control" runat="server" ID="ForeignResearchs" />
                           <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator24" ControlToValidate="ForeignResearchs"  ErrorMessage="Principle Research Focus., it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
            </div>             
            </div>
        </div>
     
      <div class="row" style="align-content:center">
                <asp:Button runat="server" ID="foreignDetailz" CssClass="btn btn-warning center-block" Text="save Institution Details" OnClick="ForeignDetails_Click" Visible="false"/>
               
            </div>

   
            <div class="panel-footer">
             <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" id="ForeignDetails" OnClick="ForeignDetails_Click" CausesValidation="false"/>
             <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="backtostep1" CausesValidation="false" OnClick="previousstep_Click"/>
            <div class="clearfix"></div>
        </div>



    
           <% 
               }
               else if (step == 5)
               {
            %>

      <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Institution Facilities</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
             Facilities <i><strong>(Please indicate the facilities available to support the academic program under collaboration)</strong></i>
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 5 of 11 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
         <div class="panel-body">
            <div runat="server" id="AgencyFacilities"></div>
          <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <strong>Facility </strong><span class="asterisk" style="color: red">*</span>
                        <asp:DropDownList runat="server" ID="FacilitiesList" CssClass="form-control" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator37" ControlToValidate="FacilitiesList"  ErrorMessage="Select Item, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div runat="server" id="Div1" visible="false">
                    <div class="col-md-6">
                        <div class="form-group">
                            <strong>Facility Name</strong><span class="asterisk" style="color: red">*</span>
                            <asp:TextBox runat="server" ID="FacilityName" CssClass="form-control" />
                             <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator38" ControlToValidate="FacilityName"  ErrorMessage="Item Name, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>         
            <div class="col-md-6">
                <div class="form-group">
                    <strong>Total Number</strong><span class="asterisk" style="color: red">*</span>
                    <asp:TextBox runat="server" ID="TotalFacilitie" CssClass="form-control" TextMode="Number" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator40" ControlToValidate="TotalFacilitie"  ErrorMessage="Enter total number of the item, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <strong>Capacity</strong><span class="asterisk" style="color: red">*</span>
                    <asp:TextBox runat="server" ID="capacityFacility" CssClass="form-control" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator41" ControlToValidate="capacityFacility"  ErrorMessage="Capacity, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <strong>Number of Shared facilities</strong>
                    <asp:TextBox runat="server" ID="facilityshared" CssClass="form-control" TextMode="Number" />
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <strong>Number Specific to department </strong>
                    <asp:TextBox runat="server" ID="facilityspecific" CssClass="form-control" TextMode="Number" />
                </div>
            </div>
            </div>
          <div class="m-t-20 text-center">

                <asp:Button runat="server" CssClass="btn btn-success" Text="Save Institution Facilities Details " ID="submitFacilities" onclick="submitFacilities_Click"/>
            </div>
      <%--  <div class="panel-body">
            <div runat="server" id="AgencyFacilities"></div>



                <div class="row" style="justify-content:center">
                <input type="hidden" value="<% =Request.QueryString["ApplicationNo"] %>" id="txtAppNo" />
                <div class="col-md-12">
                <div class="table-responsive">
                    <table class="table table-bordered table-striped tblselectedFacilities" id="example1">
                        <thead>
                            <tr>

                                <th>Select (tick)</th>    
                                <th>Item Number</th>                            
                                <th>Name</th>
                                <th>Number</th>
                                <th>Total Capacity (Sq m)</th>                               
                                <th>Specific to department</th>
                                <th>Shared</th>
                            </tr>
                        </thead>
                        <tbody>

                            <% 
                                var nav = new Config().ReturnNav();
                                var Activities = nav.CollaborationResourcesList.Where(r=>r.Resource_Type=="Facilities").ToList();

                                foreach (var activity in Activities)

                                {
                            %>
                            <tr>
                                <td>
                                <input type="checkbox" id="FacilitySelected" name="FacilitySelected" class="checkboxes" value="<% =activity.Item_No %>" /></td>
                                <td><%=activity.Item_No %></td>
                                <td><%=activity.Name %></td>
                               <td><input type="number" class="form-control" autocomplete="off" id="Tnumber"  min="0" /></td> 
                               <td><input type="number" class="form-control" autocomplete="off" id="Tcapacity"  min="0" /></td> 
                              <%--  <td><select id="Tusage" class="form-control"> <option value="0">--select--</option>
                                            <option value="1">Specific to Department</option>
                                            <option value="2">Shared</option></select></td>
                                 <td><input type="number" class="form-control" autocomplete="off" id="tspecific"  min="0" /></td> 
                                 <td><input type="number" class="form-control" autocomplete="off" id="tshared"  min="0" /></td> 

                                <%} %>
                            </tr>
                        </tbody>
                    </table>


                </div>
                    </div>
                <div class="col-md-12 col-lg-12">
                    <input type="button" id="btn_apply_SubmitFacilities" class="btn btn-success center-block btn_apply_SubmitFacilities" name="btn_apply_SubmitFacilities" value="Submit Selected Facilities" />
                </div>
            </div>


            <%-- <div class="row" style="align-content:center">
                 <asp:Button runat="server" CssClass="btn btn-success center-block" Text="Add Agency Facilities" ID="Facility" OnClick="c" />
            </div>
        </div>--%>


    </div>
        </div>

   
    <div class="panel-heading">
        Institution Facilities
    </div>
    <div class="panel-body">
        <div class="table-responsive">
            <table id="example4" class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Facility Description</th>
                        <th>Number</th>                       
                        <th>Capacity</th>
                        <th>Specific to Department</th>
                        <th>Shared</th>
                        <th>Delete</th>
                      
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        string docNo = Request.QueryString["ApplicationNo"];
                        var data = nav.CollaborationResources.Where(x => x.Application_No == docNo && x.Resource_Type=="Facilities").ToList();
                        int counter = 0;
                        foreach (var item in data)
                        {
                            counter++;
                    %>
                    <tr>
                        <td><%=counter %></td>
                        <td><% =item.Name%></td>   
                        <td><% =item.Number%></td>                       
                        <td><% =item.Capacity %></td>   
                        <td><% =item.Specific_to_Department %></td> 
                        <td><% =item.Shared %></td>             
                        <td>
                             <label class="btn btn-danger" onclick="removeFacilities('<%=item.Line_No %>','<%=item.Name %>');"><i class="fa fa-trash-o"></i> Remove</label></td>
                        <%
                            }
                        %>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="panel-footer">        
      
        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="backToPhysical" CausesValidation="false" OnClick="previousstep_Click" />
       
        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextstep_Click" CausesValidation="false" />
        <div class="clearfix"></div>
    </div>



 <%--       <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active"> Services Offered to Students</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
           Services Offered to Students <i><strong>(The services rendered to students before and after they join the universities and institutions they are recruited for)</strong></i>
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of 11 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="studentsServices"></div>
                <div class="row" style="justify-content:center">
                <input type="hidden" value="<% =Request.QueryString["ApplicationNo"] %>" id="txtAppNo" />
                <div class="col-md-12">
                <div class="table-responsive">
                    <table class="table table-bordered table-striped tblselectedServices" id="example8">
                        <thead>
                            <tr>

                                <th>#</th>
                                <th>Code</th>
                                <th>Description</th>
                                <th>Comment</th>
                            </tr>
                        </thead>
                        <tbody>

                            <% 
                                var nav = new Config().ReturnNav();
                                var Activities = nav.AgencyActivitiesSetup.ToList();

                                foreach (var activity in Activities)

                                {
                            %>
                            <tr>
                                <td>
                                <input type="checkbox" id="servicesSelected" name="servicesSelected" class="checkboxes" value="<% =activity.Code %>" /></td>
                                <td><%=activity.Code %></td>
                                <td><%=activity.Description %></td>
                                <td><input type="text" class="form-control" autocomplete="off" id="comment"  min="0" /></td> 

                                <%} %>
                            </tr>
                        </tbody>
                    </table>


                </div>
                    </div>
                <div class="col-md-12 col-lg-12">
                    <input type="button" id="btn_apply_SubmitServices" class="btn btn-success center-block btn_apply_SubmitServices" name="btn_apply_SubmitServices" value="Submit Selected services" />
                </div>
            </div>


            <%-- <div class="row" style="align-content:center">
                 <asp:Button runat="server" CssClass="btn btn-success center-block" Text="Add Agency Facilities" ID="Facility" OnClick="c" />
            </div>--%>
     
   
    <%--<div class="panel-heading">
       Services Offered 
    </div>--%>
  <%--  <div class="panel-body">
        <div class="table-responsive">
            <table id="example2" class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>#</th>

                        <th>Service Offered</th>                      
                        <th>Comment</th>                   
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <%

                        string docNo = Request.QueryString["ApplicationNo"];
                        var data = nav.AgencyActivities.Where(x => x.Application_No == docNo && x.Type == "Student Service").ToList();
                        int counter = 0;
                        foreach (var item in data)
                        {
                            counter++;
                    %>
                    <tr>
                        <td><%=counter %></td>
                        <td><% =item.Description%></td>
                        <td><% =item.Comments %></td>                      
                        <td>
                             <label class="btn btn-danger" onclick="removeAgencyActivity('<%=item.Entry_No %>','<%=item.Application_No %>');"><i class="fa fa-trash-o"></i> Remove</label></td>
                        <%
                            }
                        %>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>--%>

   
    
        <%
            }

            else if (step == 6)
            {
        %>
   
     <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Institution Equipment and teaching materials</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
             Institution Equipment and teaching materials <i><strong>((Please indicate the  Institution Equipment and teaching materials available to support the academic program under collaboration)</strong></i>
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 6 of 11 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
     
        <div class="panel-body">
            <div runat="server" id="Equipments"></div>

              <%--   <div class="col-xs-8 text-right m-b-30">
                    <a href="#" class="btn btn-primary pull-right rounded" data-toggle="modal" data-target="#add_banks"><i class="fa fa-plus"></i> Add Institution Equipment and teaching materials</a>
          </div>--%>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <strong>Item </strong><span class="asterisk" style="color: red">*</span>
                        <asp:DropDownList runat="server" ID="itemList" CssClass="form-control" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator32" ControlToValidate="itemList"  ErrorMessage="Select Item, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div runat="server" id="itemNm" visible="false">
                    <div class="col-md-6">
                        <div class="form-group">
                            <strong>Item Name</strong><span class="asterisk" style="color: red">*</span>
                            <asp:TextBox runat="server" ID="ItemName" CssClass="form-control" />
                             <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator33" ControlToValidate="ItemName"  ErrorMessage="Item Name, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
            <div class="col-md-6">
                <div class="form-group">
                    <strong>Type </strong><span class="asterisk" style="color: red">*</span>
                    <asp:TextBox runat="server" ID="TypeEquip" CssClass="form-control" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator34" ControlToValidate="TypeEquip"  ErrorMessage="Enter type of equipment, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <strong>Total Number</strong><span class="asterisk" style="color: red">*</span>
                    <asp:TextBox runat="server" ID="NumberEquip" CssClass="form-control" TextMode="Number" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator35" ControlToValidate="NumberEquip"  ErrorMessage="Enter total number of the item, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <strong>Capacity</strong><span class="asterisk" style="color: red">*</span>
                    <asp:TextBox runat="server" ID="capacity" CssClass="form-control" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator36" ControlToValidate="capacity"  ErrorMessage="Capacity, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <strong>Number of Shared facilities </strong><span class="asterisk" style="color: red">*</span>
                    <asp:TextBox runat="server" ID="Shared" CssClass="form-control" TextMode="Number" />
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <strong>Number Specific to department </strong><span class="asterisk" style="color: red">*</span>
                    <asp:TextBox runat="server" ID="specific" CssClass="form-control" TextMode="Number" />
                </div>
            </div>
            </div>
            <div class="m-t-20 text-center">

                <asp:Button runat="server" CssClass="btn btn-success" Text="Save Institution Equipment and teaching materials " ID="Button5" OnClick="submitEquip_Click" />
            </div>


            <%--  <div class="row" style="justify-content:center">
                <input type="hidden" value="<% =Request.QueryString["ApplicationNo"] %>" id="txtAppNo" />
                <div class="col-md-12">
                <div class="table-responsive">
                    <table class="table table-bordered table-striped tblselectedServices" id="example1">
                        <thead>
                            <tr>

                                <th>select(tick) available(Equipment and teaching materials)</th>    
                                <th>Item Number</th>                            
                                <th>Name</th>
                                <th>Type</th>
                                <th>Number</th>
                                <th>Capacity</th>
                                <th>Usage</th>
                            </tr>
                        </thead>
                        <tbody>

                            <% 
                                var nav = new Config().ReturnNav();
                                var Activities = nav.CollaborationResourcesList.Where(r=>r.Resource_Type=="Equipment and Teaching materials").ToList();

                                foreach (var activity in Activities)

                                {
                            %>
                            <tr>
                                <td>
                                <input type="checkbox" id="EquipmentSelected" name="EquipmentSelected" class="checkboxes" value="<% =activity.Item_No %>" /></td>
                                <td><%=activity.Item_No %></td>
                                <td><%=activity.Name %></td>
                               <td><input type="text" class="form-control" autocomplete="off" id="typeField"  min="0" /></td> 
                               <td><input type="number" class="form-control" autocomplete="off" id="Tnumber"  min="0" /></td> 
                               <td><input class="form-control" autocomplete="off" id="Tcapacity"  min="0" /></td> 
                               <%-- <td><select id="Tusage" class="form-control"> <option value="0">--select--</option>
                                            <option value="1">Specific to Department</option>
                                            <option value="2">Shared</option></select></td> 
                                 <td><input type="number" class="form-control" autocomplete="off" id="tspecific"  min="0" /></td> 
                                 <td><input type="number" class="form-control" autocomplete="off" id="tshared"  min="0" /></td> 

                                <%} %>
                            </tr>
                        </tbody>
                    </table>


                </div>
                    </div>
                <div class="col-md-12 col-lg-12">
                                    
                </div>
            </div>--%>


            <%-- <div class="row" style="align-content:center">
                 <asp:Button runat="server" CssClass="btn btn-success center-block" Text="Add Agency Facilities" ID="Facility" OnClick="c" />
            </div>--%>
      
 
    </div>
   </div>
   
    <div class="panel-body">
        <div class="table-responsive">
            <table id="example1" class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Facility Description</th>
                        <th>Type</th>
                        <th>Number</th>                       
                        <th>Capacity</th>
                        <th>Number Shared</th>    
                        <th>Number specific to department</th>                  
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                         var nav = new Config().ReturnNav();
                        string docNo = Request.QueryString["ApplicationNo"];
                        var data = nav.CollaborationResources.Where(x => x.Application_No == docNo && x.Resource_Type=="Equipment and Teaching materials").ToList();
                        int counter = 0;
                        foreach (var item in data)
                        {
                            counter++;
                    %>
                    <tr>
                        <td><%=counter %></td>
                        <td><% =item.Name%></td>
                        <td><%=item.Type %></td>
                        <td><% =item.Number %></td>       
                          <td><% =item.Capacity %></td>   
                         <td><% =item.Shared %></td>  
                         <td><% =item.Specific_to_Department %></td>    
                                
                        <td>
                              <label class="btn btn-danger" onclick="removeFacilities('<%=item.Line_No %>','<%=item.Name %>');"><i class="fa fa-trash-o"></i> Remove</label></td>
                        <%
                            }
                        %>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="panel-footer">        
      
        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="Button1" CausesValidation="false" OnClick="previousstep_Click" />
       
        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextstep_Click" CausesValidation="false" />
        <div class="clearfix"></div>
    </div>
   



   
   
   
        <%
            }


            else if (step == 7)
            {
        %>
    
    
         <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Core Texts and Journals</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
          Core Texts and Journals <i><strong>(Please indicate the Core Texts and Journals available to support the academic program under collaboration)</strong>
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 7 of 11 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="academicCollaboration"></div>
            <div class="row">
       
                <div class="col-md-6">
                    <div class="form-group">
                        <strong>Subject Area </strong><span class="asterisk" style="color: red">*</span>
                        <asp:TextBox runat="server" ID="SubjectArea" CssClass="form-control" />                       
                    </div>
                </div>
                    <div class="col-md-6">
                    <div class="form-group">
                        <strong>No. of Titles </strong><span class="asterisk" style="color: red">*</span>
                        <asp:TextBox runat="server" ID="titles" CssClass="form-control"  TextMode="Number"/>                       
                    </div>
                </div>
                    <div class="col-md-6">
                    <div class="form-group">
                        <strong>Volumes </strong><span class="asterisk" style="color: red">*</span>
                        <asp:TextBox runat="server" ID="volumes" CssClass="form-control" />                       
                    </div>
                </div>
                    <div class="col-md-6">
                    <div class="form-group">
                        <strong>Journals <i>(No. of Titles)</i> </strong><span class="asterisk" style="color: red">*</span>
                        <asp:TextBox runat="server" ID="journals" CssClass="form-control" TextMode="Number" />                       
                    </div>
                </div>
                    <div class="col-md-6">
                    <div class="form-group">
                        <strong>Remarks </strong><span class="asterisk" style="color: red">*</span>
                        <asp:TextBox runat="server" ID="remarksCoreText" CssClass="form-control" TextMode="MultiLine" Rows="3"/>                       
                    </div>
                </div>
               
            
     
                  

            </div>
               <div class="row" style="align-content:center">
                    <asp:Button runat="server" CssClass="btn btn-success center-block" Text="Add Core Texts and Journals" ID="academicProgram" OnClick="academicProgram_Click" />
               
            </div>
        </div>
    </div>


    <div class="panel-heading">
         Core Texts and Journals
    </div>
    <div class="panel-body">
        <div class="table-responsive">
            <table id="example2" class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Subject Area</th>
                        <th>Number</th>                   
                        <th>Volumes</th>
                        <th>Journals</th>
                        <th>Remarks</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        string docNo = Request.QueryString["ApplicationNo"];
                        var data = nav.CollaborationResources.Where(x => x.Application_No == docNo && x.Resource_Type=="Core-texts and journals").ToList();
                        int counter = 0;
                        foreach (var item in data)
                        {
                            counter++;
                    %>
                    <tr>
                        <td><%=counter %></td>
                        <td><% =item.Name%></td>
                        <td><% =item.Number %></td>
                        <td><% =item.Volumes %></td>
                        <td><%=item.Journals_No_Of_Titles %></td>
                        <td><%=item.Remarks %></td>
                        <td>
                               <label class="btn btn-danger" onclick="removeFacilities('<%=item.Line_No %>','<%=item.Name %>');"><i class="fa fa-trash-o"></i> Remove</label></td>
                      
                        <%
                            }
                        %>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
        <div class="panel-footer">        
      
        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="Button2" CausesValidation="false" OnClick="previousstep_Click" />
       
        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextstep_Click" CausesValidation="false" />
        <div class="clearfix"></div>
    </div>

   
        <%
            }



            else if (step == 8)
            {
        %>
        
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Academic Staff</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Academic Staff <i><strong>(Please indicate the relevant Academic Staff available to support the academic program under collaboration)</strong></i>
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 8 of 11 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="keyStaff"></div>
            <div class="row">

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="span2">Name of the staff<span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="staffName" CssClass="form-control span3" placeholder="Please Enter the name of the Staff" />
                       
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="span2">Gender<span style="color: red">*</span></label>
                        <asp:DropDownList runat="server" ID="gender" AppendDataBoundItems="true" CssClass="form-control">
                            <asp:ListItem Value="0">--Select--</asp:ListItem>
                            <asp:ListItem Value="1">Male</asp:ListItem>
                            <asp:ListItem Value="2">Female</asp:ListItem>
                            <asp:ListItem Value="3">Others</asp:ListItem>
                        </asp:DropDownList>
                  
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Rank: </strong><span class="asterisk" style="color: red">*</span>
                        <asp:TextBox runat="server" ID="rank" CssClass="form-control" placeholder="eg Senior Lecturer...etc" />
                     
                    </div>
                </div>

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Academic Level:</strong> <span class="asterisk" style="color: red">*</span>                     
                        <asp:DropDownList runat="server" ID="academic" CssClass="form-control">
                        </asp:DropDownList>
                    
                </div>
                    </div>
                <div runat="server" visible="false">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <label class="span2">Qualification</label>
                            <asp:TextBox runat="server" ID="qualificationText" CssClass="form-control" />
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="span2">Area of Specialization<span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="AreaSpecialization" CssClass="form-control" placeholder="Area of Specialization" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="span2">Graduation Date<span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="gradDate" CssClass="form-control" TextMode="Date" />
                        
                    </div>
                </div>
                 <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="span2">Institution of study<span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="instStudies" CssClass="form-control" />
                        
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="span2">Experience in University teaching <i>(Years)</i><span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="experience" CssClass="form-control" TextMode="Number" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="span2">Terms of Service<span style="color: red">*</span></label>
                        <asp:DropDownList runat="server" ID="termsOfService" AppendDataBoundItems="true" CssClass="form-control">
                            <asp:ListItem Value="0">--Select--</asp:ListItem>
                            <asp:ListItem Value="1">Part-time</asp:ListItem>
                            <asp:ListItem Value="2">Full-time</asp:ListItem>
                        </asp:DropDownList>
                      
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="span2">Remarks <i>(Head...etc)</i><span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="remarksStaff" CssClass="form-control" TextMode="MultiLine" Rows="3" />
                    </div>
                </div>
           
        </div>
        <div class="row" style="align-content: center">
            <asp:Button runat="server" CssClass="btn btn-success center-block" Text="Add Staff Member" ID="staffButton" OnClick="staffButton_Click" />

        </div>
    </div>
    <div class="panel-heading">
         Academic Staff Profile
    </div>
    <div class="panel-body">
        <div class="table-responsive">
            <table id="example5" class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Name of Staff</th>
                        <th>Gender</th>  
                        <th>Rank</th>  
                        <th>Terms of Service</th>  
                        <th>Remarks</th> 
                        <th>Qualification</th>
                        <th>Experience</th>   
                        <th>Area of Specialization</th>
                        <th>Terms of Service</th>
                        <th>Institution Attended</th>
                        <th>Completion Date</th>
                        <th>Edit</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        string docNo = Request.QueryString["ApplicationNo"];
                        var data = nav.CollaborationResources.Where(x => x.Application_No == docNo && x.Resource_Type=="Academic Staff").ToList();
                        int counter = 0;
                        foreach (var item in data)
                        {
                            counter++;
                    %>
                    <tr>
                        <td><%=counter %></td>
                        <td><% =item.Name%></td>
                        <td><% =item.Gender %></td>
                        <td><% =item.Rank %></td>
                        <td><% =item.Terms_of_Service %></td>
                        <td><% =item.Remarks %></td>                      
                        <td><% =item.Qualification_Type %></td>
                        <td><% =item.Number %></td>
                        <td><%=item.Area_of_Specialization %></td>
                        <td><% =item.Terms_of_Service %></td>
                        <td><%=item.Institution %></td>
                          <td><% = Convert.ToDateTime(item.Completion_Date).ToString("dd/MM/yyyy") %></td>


                        <td>
                            <label class="btn btn-success" onclick="editStaffProfile('<%=item.Line_No%>','<%=item.Name %>','<%=item.Rank %>','<%=item.Qualification %>','<%=item.Area_of_Specialization %>','<%=item.Institution %>');"><i class="fa fa-edit">Edit</i></label></td>

                        <td>
                              <label class="btn btn-danger" onclick="removeFacilities('<%=item.Line_No %>','<%=item.Name %>');"><i class="fa fa-trash-o"></i> Remove</label></td>
                        <%
                            }
                        %>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

        </div>


    <div class="panel-footer">
       
               <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextstep_Click" CausesValidation="false" />
        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" CausesValidation="false" OnClick="previousstep_Click" />
        <div class="clearfix"></div>
    </div>
  <%
      }

      else if (step == 9)
      {
        %>


    <div class="panel panel-primary">
        <div class="panel-heading">
            Supporting Documents <i><strong>PDF Documents only</strong></i>
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 9 of 11 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="documentsfeedback"></div>
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <div class="table-responsive">
                        <table class="table table-striped custom-table datatable" id="example9">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Code</th>
                                    <th>Description</th>
                                    <th>Attach Document</th>
                                </tr>

                            </thead>
                            <tbody>
                                <% 
                                    var nav = new Config().ReturnNav();
                                    int programesCounter = 0;
                                    var details = nav.AgencyDocuments.Where(r => r.Application_Type == "Collaboration" && r.Blocked == false).ToList();

                                    var attacheddoc = nav.AgencyAttachedDocuments.Where(x => x.Application_No == Convert.ToString(Request.QueryString["ApplicationNo"])).ToList();






                                    if (attacheddoc.Count > 0)
                                    {
                                        List<AttachedDoc> attachaedDocuments = new List<AttachedDoc>();

                                        foreach (var exemptionEntrys in attacheddoc)
                                        {

                                            AttachedDoc list1 = new AttachedDoc();
                                            list1.code = exemptionEntrys.Code;

                                            attachaedDocuments.Add(list1);

                                        }
                                        List<NotAttachedDoc> studetnExemptEntries = new List<NotAttachedDoc>();
                                        NotAttachedDoc[] exemptEntryArray = studetnExemptEntries.ToArray();



                                        foreach (var subtopic in details)
                                        {

                                            NotAttachedDoc list = new NotAttachedDoc();
                                            list.code = subtopic.Code;
                                            list.description = subtopic.Description;
                                            studetnExemptEntries.Add(list);
                                        }

                                        HashSet<string> diffidsz = new HashSet<string>(attachaedDocuments.Select(s => s.code));

                                        var result = studetnExemptEntries.Where(m => !diffidsz.Contains(m.code)).ToList();





                                        int counter1 = 0;
                                        foreach (var detail in result)
                                        {

                                            counter1++;
                                            programesCounter++;
                                %>
                                <tr>
                                    <td><%=programesCounter %></td>
                                    <td><%=detail.code %></td>
                                    <td><%=detail.description %></td>

                                    <% %>


                                    <td>
                                        <label class="btn btn-success" onclick="Collaborationtattachdocuments('<%=detail.code%>','<%=detail.description%>');">Attach Document</label>
                                    </td>
                                </tr>
                                <%  
                                        }
                                    }
                                    else
                                    {
                                        foreach (var detail in details)
                                        {
                                %>
                                <tr>
                                    <td><%=programesCounter %></td>
                                    <td><%=detail.Code %></td>
                                    <td><%=detail.Description %></td>
                                    
                                    <td>
                                        <label class="btn btn-success" onclick="Collaborationtattachdocuments('<%=detail.Code%>','<%=detail.Description%>');">Attach Document</label>
                                    </td>
                                </tr>


                                <%}
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="table-responsive">
                <table id="mytable" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Code</th>
                            <th>Description</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>


                        <%

                            string docNo = Request.QueryString["ApplicationNo"];
                            var data = nav.AgencyAttachedDocuments.Where(x => x.Application_No == docNo && x.Attached == true).ToList();
                            int counter3 = 0;
                            foreach (var item in data)
                            {
                                counter3++;
                        %>
                        <tr>
                            <td><%=counter3 %></td>
                            <td><% =item.Code%></td>
                            <td><% =item.Description %></td>



                            <td>
                                <label class="btn btn-danger" onclick="removeDoc('<%=item.Entry_No %>','<%=item.Code %>');"><i class="fa fa-trash-o"></i>Remove</label></td>
                            <%
                                }
                            %>
                        </tr>
                    </tbody>                   
                </table>
            </div>
        </div>

        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" CausesValidation="false" OnClick="previousstep_Click" />         
             <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" id="nextInvoice" OnClick="nextInvoice_Click" CausesValidation="false" />
            <div class="clearfix"></div>
        </div>
    </div>


        <%
            }

            else if (step == 10)
            {
              %>
      <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Payment</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Payments 
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 10 of 11 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">

            <div runat="server" id="feedback"></div>
            <h4 style="color: red"><u>Note:</u></h4>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Select mode of payment</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="PaymentModes" OnSelectedIndexChanged="PaymentModes_SelectedIndexChanged" AutoPostBack="true">  
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Application Amount</strong>
                        <asp:TextBox runat="server" ID="ApllicationAmount" CssClass="form-control" ReadOnly></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Amount Paid</strong>
                        <asp:TextBox runat="server" ID="amountPaide" CssClass="form-control" TextMode="Number" ></asp:TextBox>
                    </div>
                </div>
                  <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Currency</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="currency" OnSelectedIndexChanged="PaymentModes_SelectedIndexChanged" AutoPostBack="true">  
                        </asp:DropDownList>
                    </div>
                </div>
                   <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Payment Reference Number</strong>
                        <asp:TextBox runat="server" ID="PayRef" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                    <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Total Amount Paid</strong>
                        <asp:TextBox runat="server" ID="TotalAmount" CssClass="form-control" ReadOnly></asp:TextBox>
                    </div>
                </div>
                <div runat="server" id="attachdoc" visible="false">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Attach Evidence of Payment:</strong>
                        <asp:FileUpload runat="server" CssClass="form-control" ID="FileUpload2"></asp:FileUpload>
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator29" ControlToValidate="FileUpload2"  ErrorMessage="Attach Evidence of Payment, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                    </div>
                <div class="col-md-6 col-lg-6" style="display:none">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button3" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Submit evidence of payment" ID ="evidencePayment" OnClick="evidencePayment_Click"/>
                    </div>
                </div>
                </div>
            </div>
           </div>
    <div class="panel-heading">
        Payments
    </div>
    <div class="panel-body">
        <div class="table-responsive">
     <div class="table-responsive">
                <table id="example6" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Payment Mode</th>
                            <th>Description</th>
                            <th>Payment Reference</th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tbody>


                        <%
                            var nav = new Config().ReturnNav();
                            string docNo = Request.QueryString["ApplicationNo"];
                            var data = nav.ApplicationPayments.Where(x => x.Application_No == docNo).ToList();
                            int counter3 = 0;
                            foreach (var item in data)
                            {
                                counter3++;
                        %>
                        <tr>
                            <td><%=counter3 %></td>
                            <td><% =item.Payment_Mode%></td>
                            <td><% =item.Description %></td>
                              <td><% =item.Payment_Reference %></td>
                              <td><% =item.Amount %></td>



                          
                            <%
                                }
                            %>
                        </tr>
                    </tbody>                   
                </table>
            </div>
            </div>
        </div>
             <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousSteps_Click1" />
                   <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" Text="Next" ID="previewReport" OnClick="previewReport_Click" />   
                <div class="clearfix"></div>
            </div>
     

    <%
        }

 
            else if (step == 11)
            {
              %>


    <div class="panel panel-default">
        <div class="panel-heading">
            Declaration<div class="pull-right"><i class="fa fa-angle-left"></i>Step 11 of 11<i class="fa fa-angle-right"></i></div>
            <div class="clearfix"></div>
        </div>
        <div id="submit" runat="server"></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard </a></li>
                        <li class="breadcrumb-item active">Declarations</li>
                    </ol>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <%
                            string docNo = Request.QueryString["ApplicationNo"];
                            if (docNo != null)
                            {
                                var nav = new Config().ReturnNav();
                                var data = nav.LicenceApplicationHeader.Where(x => x.Application_No == docNo).ToList();
                                if (data.Count > 0)
                                {

                                    foreach (var item in data)
                                    {


                        %>
                        <p>
                            I hereby apply for the Commission's authority for Collaboration with the University/Institution known as 
                       <b>  <%=item.Name_of_Foreign_University %></b>
                            of Post Office Box Number 
                        <b>  <%=item.Postal_Address %></b>
                            physical address 
                        <b> <%=item.Physical_Address %></b>
                            Email address 
                        <b> <%=item.Email_Address %></b>
                            Website 
                       <b>   <%=item.Web_site %></b>
                            for purposes of offering an academic programme known as 
                        <b>  <%=item.Name_of_the_Programme_offered %></b>
                            that will lead to an award of 
                         <b>    <%=item.Name_of_the_Programme_offered %></b>
                            (Academic qualification) and attach hereto a copy of a statement of the terms of the contactual agreement together with document of accreditation of the Collaborating University.                            
                        </p>
                        <%}
                            }
                        } %>
                    </div>
                    <div class="col-lg-12">
                        <div class="form-group">
                            <ol>
                                 <li>I confirm information provided is true and accurate.</li>
                                <li>I will adhere to the Standards and Guidelines for this service issued by the Commission</li>
                               
                            </ol>
                            <asp:CheckBox runat="server" ID="declaration" />
                            <label class="font-noraml" for="acceptTerms">I agree with the Terms and Conditions.</label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="text-center padding-15">
                    <center>
                     
                        <asp:Button runat="server" Text="Submit Application" ID="submitApplication" OnClick="submitApplication_Click" CssClass="btn btn-primary" Visible="true" />
                    </center>
                </div>
            </div>
        </div>
        <div class="panel-footer">
          <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previousSteps" CausesValidation="false" OnClick="previousstep_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Visible="false" Text="Submit Application" ID="SubmitApkk" OnClick="submitApplication_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
<%}
    



         %>
         <script>


        $("body").delegate(" .saveresponce", "click", function (event) {
            //To prevent form submit after ajax call

            event.preventDefault();

           
            //Loop through the Table rows and build a JSON array.
            var allrfqitems = new Array();
            //declare an array
            var i = 0;


            $(".txtstep1").each(function () {
                var row = $(this);
                var onerfqitem = {};
                i++;

                onerfqitem.applicationNo = row.attr("id", "txtapplicationNo" + i).find(".txtapplicationNo").val();
                onerfqitem.qnCategory = row.attr("id", "txtqnCategory" + i).find(".txtqnCategory").val();

                onerfqitem.questionCode = row.attr("id", "qncd" + i).find(".qncd").val();

                onerfqitem.response = row.attr("id", "respn" + i).find(".respn").val();

              

                allrfqitems.push(onerfqitem);

            });




            $.ajax({
                type: "POST",
                url: "NewApplication.aspx/InsertResponse",
                data: '{cmpitems: ' + JSON.stringify(allrfqitems) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (status) {
                    switch (status.d) {
                        case "success":
                            Swal.fire
                            ({
                                title: "Response Added!",
                                text: "Response saved successfully!",
                                type: "success"

                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $('#feedback').attr("class", "alert alert-success");
                                $("#feedback").html("Response saved successfully!");
                                document.querySelector('.btn2').style.display = 'block';
                            });
                            break;

                        case "componentnull":
                            Swal.fire
                            ({
                                title: "Component not filled!",
                                text: "Component field empty!",
                                type: "danger"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "red");
                                $('#feedback').attr("class", "alert alert-danger");
                                $("#feedback").html("Component field empty!");
                            });
                            break;
                        default:
                            Swal.fire
                            ({
                                title: "Error!!!",
                                text: "Error Occured",
                                type: "error"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "red");
                                $('#feedback').addClass('alert alert-danger');
                                $("#feedback").html(status.d);
                            });

                            break;
                    }
                    
                    e.preventDefault();
                },
                error: function (err) {
                    console.log(err.statusText);
                    console.log(status.d);
                }

            });

           

          
                

                console.log(allrfqitems);

        });

         </script>   
    <script>
        function Collaborationtattachdocuments(code, description) {
            document.getElementById("ContentPlaceHolder1_ModalDocCode").value = code;
            document.getElementById("ContentPlaceHolder1_modalDocDescription").value = description;
            $("#DocumentsAttach").modal();
        }
    </script>
        <script>
            function deleteFile(fileName) {
                document.getElementById("filetoDeleteName").innerText = fileName;
                document.getElementById("ContentPlaceHolder1_fileName").value = fileName;
                $("#deleteFileModal").modal();
            }
        </script>

      <script>
          function editItem(entryNO, No, address, physicalLoc) {
              document.getElementById("ContentPlaceHolder1_originalItemNo").value = entryNO;
              document.getElementById("ContentPlaceHolder1_modalAppNo").value = No;
            document.getElementById("ContentPlaceHolder1_modalAddress").value = address;
            document.getElementById("ContentPlaceHolder1_modalPhysicalLoc").value = physicalLoc;    
            $("#editItemModel").modal();
        }
    </script>

      <script>
          function editStaffProfile(entryNO, Name, nationality, IdNo, workPermitNo, goodConduct) {
              document.getElementById("ContentPlaceHolder1_staffProfEntryNo").value = entryNO;
              document.getElementById("ContentPlaceHolder1_modalstaffName").value = Name;
              document.getElementById("ContentPlaceHolder1_modalStaffNationality").value = nationality;
              document.getElementById("ContentPlaceHolder1_modalIDPassp").value = IdNo;
              document.getElementById("ContentPlaceHolder1_modalWorkP").value = workPermitNo;
              document.getElementById("ContentPlaceHolder1_modalGoodCond").value = goodConduct;
              $("#editStaffProfileModel").modal();
        }
    </script>
    <script>
     function remove(entryNo, No) {
              document.getElementById("applicationToRemove").innerText = No;
              document.getElementById("ContentPlaceHolder1_entryNoRemove").value = entryNo;
              $("#removeDetailsModal").modal();
     } 
      </script> 
        <script>
            function removeSourceFunds(entryNo, No) {
                document.getElementById("activityToRemove").innerText = No;
                document.getElementById("ContentPlaceHolder1_activityEntry").value = entryNo;
                $("#removeActivityModal").modal();
            }
        </script>

       <script>
           function removeDoc(entryNo, No) {
               document.getElementById("documentDel").innerText = No;
               document.getElementById("ContentPlaceHolder1_docEntry").value = entryNo;
                $("#removeDocumentModal").modal();
            }
        </script>

         <script>
             function removeGovernance(entryNo, No) {
                 document.getElementById("GovernanceToRemove").innerText = No;
                 document.getElementById("ContentPlaceHolder1_governEntry").value = entryNo;
                $("#removeGovernanceModal").modal();
            }
        </script>
                 <script>
                     function removeStaff(entryNo, Name) {
                         document.getElementById("staffToRemove").innerText = Name;
                 document.getElementById("ContentPlaceHolder1_StaffEntry").value = entryNo;
                $("#removeStaffModal").modal();
            }
        </script>
       <script>
           function removeFacilities(entryNo, No) {
               document.getElementById("FacilityToRemove").innerText = No;
              document.getElementById("ContentPlaceHolder1_entryNoRemove").value = entryNo;
              $("#removeFacilitiesModal").modal();
          }
      </script>
               <script>
                   function removeRecruitingUniversitites(entryNo, No) {
                       document.getElementById("UnitDeleteName").innerText = No;
                       document.getElementById("ContentPlaceHolder1_uniEntryDelete").value = entryNo;
              $("#removerecruitingUniModal").modal();
          }
      </script> 
        <script>
        $(document).ready(function () {
            new ExcelUploader({
                maxInAGroup: 100,
                serverColumnNames: ["100"],
                importTypeSelector: "#dataType",
                fileChooserSelector: "#fileUploader",
                outputSelector: "#tableOutput",
                extraData: { _token: "23333323323223323232" },
                receiverUrl: ["addStudent"],
                username: "<% = Session["Code"] %>",
            password: "<% =Session["Password"] %>"
        });
        loadData();
    });
    </script>
      <div id="DocumentsAttach" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Attach the Document</h4>

                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <strong>Document Type</strong><span class="text-danger" style="font-size: 25px">*</span>
                        <asp:TextBox runat="server" ID="ModalDocCode" CssClass="form-control"/>
                         
                    </div>
                    <div class="form-group">
                        <label>Description:</label>
                         <asp:TextBox CssClass="form-control" runat="server" ID="modalDocDescription" ReadOnly/>

                    </div>
                    <%--<div class="form-group">
                        <label>Expiry Date:</label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="txtexpiry" TextMode="Date" />

                    </div>--%>
                    <div class="form-group">
                        <strong>Upload Document</strong><span class="text-danger" style="font-size: 25px">*</span>
                        <asp:FileUpload runat="server" CssClass="form-control" ID="uploadfile" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDoc" OnClick="uploadDoc_Click" />
                </div>
            </div>

        </div>
    </div>
            <div id="removeDocumentModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="documentDel"></strong>?</p>
                    <asp:TextBox runat="server" ID="docEntry" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" id="docDelete" OnClick="docDelete_Click"  />
                </div>
            </div>

        </div>
    </div>
            <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click" />
                </div>
            </div>

        </div>
    </div>

  

    <div id="editItemModel" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div runat="server" id="teamFeedback"></div>
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Location Details</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="originalItemNo" type="hidden" />




                    <div class="form-group">
                        <strong>ApplicationNo:</strong> <span class="asterisk" style="color: red">*</span>
                        <asp:TextBox runat="server" ID="modalAppNo" CssClass="form-control" />
                    </div>


                    <div class="form-group">
                        <strong>Address:</strong> <span class="asterisk" style="color: red">*</span>
                        <asp:TextBox runat="server" ID="modalAddress" CssClass="form-control" />
                    </div>


                    <div class="form-group">
                        <strong>Physical Location:</strong> <span class="asterisk" style="color: red">*</span>
                        <asp:TextBox runat="server" ID="modalPhysicalLoc" CssClass="form-control" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" ID="EditDetails" OnClick="EditDetails_Click" Text="Edit Details" />

                </div>
                </div>
            </div>
            </div>
       
           <div id="editStaffProfileModel" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div runat="server" id="Div3"></div>
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Agency Staff Profile</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="staffProfEntryNo" type="hidden" />


                    <div class="form-group">
                        <strong>Name of the staff:</strong> <span class="asterisk" style="color: red">*</span>
                        <asp:TextBox runat="server" ID="modalstaffName" CssClass="form-control" />
                    </div>


                    <div class="form-group">
                        <strong>Rank Of Staff:</strong> <span class="asterisk" style="color: red">*</span>
                        <asp:TextBox runat="server" ID="modalStaffNationality" CssClass="form-control" />
                    </div>
                    
                    <div class="form-group">
                        <strong>Qualification:</strong> <span class="asterisk" style="color: red">*</span>
                        <asp:TextBox runat="server" ID="modalIDPassp" CssClass="form-control" />
                    </div>
                         <div class="form-group">
                        <strong>Area of Specialization:</strong> <span class="asterisk" style="color: red">*</span>
                        <asp:TextBox runat="server" ID="modalWorkP" CssClass="form-control" />
                    </div>

                         <div class="form-group">
                        <strong>Institution:</strong> <span class="asterisk" style="color: red">*</span>
                        <asp:TextBox runat="server" ID="modalGoodCond" CssClass="form-control" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" ID="EditstaffProf" OnClick="EditstaffProf_Click" Text="Edit Details" />

                </div>
                </div>
            </div>
            </div>
    <div id="removeDetailsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deletion</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the details of  <strong id="applicationToRemove"></strong>?</p>
                    <asp:TextBox runat="server" ID="entryNoRemove" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete" OnClick="Unnamed_Click"/>
                </div>
            </div>

        </div>
    </div>

         <div id="removeStaffModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deletion</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the details of  <strong id="staffToRemove"></strong>?</p>
                    <asp:TextBox runat="server" ID="StaffEntry" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete" id="removestaff" OnClick="removestaff_Click"/>
                </div>
            </div>

        </div>
    </div>
          <div id="removeActivityModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deletion</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the details of  <strong id="activityToRemove"></strong>?</p>
                    <asp:TextBox runat="server" ID="activityEntry" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete" OnClick="removeActivity_Click" />
                </div>
            </div>

        </div>
    </div>
        <div id="removeFacilitiesModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deletion</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the details of  <strong id="FacilityToRemove"></strong>?</p>
                    <asp:TextBox runat="server" ID="TextBox1" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete" ID="facilities" OnClick="facilities_Click"/>
                </div>
            </div>

        </div>
    </div>


      <div id="add_banks" class="modal custom-modal fade" role="dialog">        
            <div class="modal-dialog">
                  <div runat="server" id="equipmentsError"></div>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add Institution Equipment and teaching materials</h5>
                    </div>
                    <div class="modal-body">

                  
                        <div class="m-t-20 text-center">
                              
                             <asp:Button runat="server" CssClass="btn btn-success" Text="Save Institution Equipment and teaching materials " ID="submitEquip" OnClick="submitEquip_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>


