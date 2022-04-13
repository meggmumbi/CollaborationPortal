<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AppealApplication.aspx.cs" Inherits="HRPortal.AppealApplication" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

             %>
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                <li class="breadcrumb-item active">Create A New Application</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Create A New Application (<i style="color: yellow">Kindly note that all fields marked with asterisk (<span style="color: red">*</span>) are mandatory</i>)
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 11 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span> 
        </div>
        <div class="panel-body">
            <div runat="server" id="linesfeedback"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Appeal Reason:</strong> <span class="asterisk" style="color: red">*</span>
                        <asp:DropDownList runat="server" ID="AppealReason" CssClass="form-control select2" OnSelectedIndexChanged="AppealReason_SelectedIndexChanged" AutoPostBack="true" />

                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="AppealReason" InitialValue="--Select--" ErrorMessage="Please select Payment Type, it cannot be empty!" ForeColor="Red" />
                    </div>


                    <div class="form-group">
                        <strong>Date:</strong> <span class="asterisk" style="color: red">*</span>
                        <asp:TextBox runat="server" ID="txtDate" TextMode="DateTime" CssClass="form-control" ReadOnly />
                    </div>


                    <div id="others" runat="server" visible="false">

                        <div class="form-group">
                            <strong>Describe:</strong> <span class="asterisk" style="color: red">*</span>
                            <asp:TextBox runat="server" ID="TextBox1"  CssClass="form-control" TextMode="MultiLine" Rows="3"/>
                        </div>

                    </div>
                </div>
            </div>
        </div>





        <div class="panel-footer">
             <asp:Button runat="server" ID="addapplication" CssClass="btn btn-warning center-block" Text="Apply for Appeal" OnClick="addapplication_Click"/>               
               <asp:Button runat="server" ID="Nexttostep2" CssClass="btn btn-success pull-left" Text="Exit" CausesValidation="false"  OnClick="Nexttostep2_Click"/>
            <div class="clearfix"></div>
        </div>

    </div>
        </div>




</asp:Content>
