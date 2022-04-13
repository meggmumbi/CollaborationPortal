<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home_Payments.aspx.cs" Inherits="HRPortal.Home_Payments" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            Payment Options
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Description</th>  
                        <th>Currency</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>
                  <%
                     var nav = new Config().ReturnNav();
                     var data = nav.CollaborationFeeSetup;
                     int counter = 0;
                     foreach (var item in data)
                     {
                         counter++;
                     %>
                     <tr>
                         <td><%=counter %></td>
                         <td><% =item.Description%></td>                         
                         <td><% =item.Currency_Code %></td>
                         <td><% =item.Amount %></td>
                     <%
                         }
                     %>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
