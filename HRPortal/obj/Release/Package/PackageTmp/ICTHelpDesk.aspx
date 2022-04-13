<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ICTHelpDesk.aspx.cs" Inherits="HRPortal.ICTHelpDesk" %>
<%@ Import Namespace="HRPortal" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="row" style="width: 100%; margin: 5px;">
        <div class="panel panel-default">
            <div class="panel-heading">Compose New Message(CUE Help Desk)</div>
            <div class="panel-body">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <center><h3 class="box-title">Compose New Message</h3></center>
                    </div>
                    <div class="box-body">
                        <div class="form-group">
                          <h5>Message From:<strong><% =Session["Name"] %></strong></h5> 
                            <input class="form-control" value="<%=Session["EmailAddress"] %>" id="useremailaddress" name="useremailaddress" placeholder="Message From:">
                        </div>
                         <% 
                             var nav = new Config().ReturnNav();
                             string LicensingEmail = "";
                             var datacollections= nav.LicensingSetup;
                             foreach (var datacollection in datacollections)
                             {
                                 LicensingEmail = datacollection.SREQ_Email;
                        %>
                           <% } %>

                        <div class="form-group">
                           <h5>Message To:<strong>CUE Help Desk</strong></h5>
                              <input class="form-control" value="<% =LicensingEmail %>" id="cueemailaddress" name="cueemailaddress" placeholder="To:" readonly>
                        </div>
                       
                        <div class="form-group">
                             <h5>Message Subject:</h5>
                            <input class="form-control" id="emailsubject" name="emailsubject" placeholder="Subject:">
                        </div>
                        <div class="form-group">
                            <textarea name="emailassitancerequest"class="form-control emailassitancerequest" id="emailassitancerequest" style="height: 300px">Please Enter text here...</textarea>
                        </div>
                    </div>
                    <div class="box-footer">
                        <div class="pull-right">
                            <button type="button" id="btn_request_assistance" name="btn_request_assistance" class="btn btn-primary btn_request_assistance"><i class="fa fa-envelope-o"></i>Send</button>
                        </div>
                        <button type="reset" class="btn btn-default"><i class="fa fa-times"></i>Discard</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
