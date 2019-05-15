﻿<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="EditClientSession.aspx.cs" Inherits="NMH_Call_Log.CR.Main.EditClientSession" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">New Client Session</h3>
            </div><!-- /.box-header -->
            <div class="box-body">
                <asp:UpdatePanel runat="server" >
                    <ContentTemplate>
                        <div class="form-group">
                               <div class="row">
                                   <div class="col-md-6">
                                  <label>Company</label>
                                  <telerik:RadComboBox ID="dlCompany" runat="server" Width="100%" DataSourceID="companySource" MaxHeight="200" EmptyMessage="Select Company" Filter="Contains"
                                           OnItemDataBound="dlCompany_ItemDataBound" OnDataBound="dlCompany_DataBound" OnItemsRequested="dlCompany_ItemsRequested" EnableLoadOnDemand="true"
                                            OnClientItemsRequested="UpdateCompanyItemCountField" HighlightTemplatedItems="true" MarkFirstMatch="true"  >
                                            <HeaderTemplate>
                <ul>
                    <li class="ncolfull">COMPANY</li>
                </ul>
            </HeaderTemplate>
            <ItemTemplate>
                <ul>
                    <li class="ncolfull">
                        <%# DataBinder.Eval(Container.DataItem, "Company")%></li>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                A total of
                <asp:Literal runat="server" ID="companyCount" />
                items
            </FooterTemplate>
                                        </telerik:RadComboBox>
                                        <asp:SqlDataSource ID="companySource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT top (30) ID, Company FROM [Companies]"></asp:SqlDataSource>
                                  <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlCompany" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                             </div>
                                   <div class="col-md-3">
                                       <label>Date</label>
                                       <telerik:RadDatePicker runat="server" ID="dpDate" Width="100%" ></telerik:RadDatePicker>
                                       <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                   </div>
                                   <div class="col-md-3">
                                       <label>Session Type</label>
                                       <telerik:RadDropDownList ID="dlSessionType" runat="server" Width="100%">
                                           <Items>
                                               <telerik:DropDownListItem Text="Info Session" />
                                               <telerik:DropDownListItem Text="A day with members" />
                                           </Items>
                                       </telerik:RadDropDownList>
                                   </div>
                                   
                               </div>
                           </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-6">
                                    <label>Theme</label>
                                    <asp:TextBox runat="server" ID="txtTheme" Width="100%" MaxLength="100"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label>Participants</label>
                                    <asp:TextBox runat="server" ID="txtParticipants" Width="100%" TextMode="Number"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-6">
                                    <label>Issues</label>
                                    <asp:TextBox runat="server" ID="txtIssues" Width="100%" MaxLength="500" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label>Resolutions</label>
                                    <asp:TextBox runat="server" ID="txtResolutions" Width="100%" MaxLength="500" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-6">
                                    <label>Feedback</label>
                                    <asp:TextBox runat="server" ID="txtFeedback" Width="100%" MaxLength="500" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button runat="server" ID="btnReturn" CssClass="btn btn-warning" Text="Return" PostBackUrl="~/CR/Main/ClientSessions.aspx" CausesValidation="false" />
                            <asp:Button runat="server" ID="btnUpdate" CssClass="btn btn-success" Text="Update" OnClick="btnUpdate_Click" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </div><!-- /.box-body -->
         
          </div><!-- /.box -->
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function UpdateCompanyItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
