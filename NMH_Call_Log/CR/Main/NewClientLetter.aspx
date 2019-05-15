<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="NewClientLetter.aspx.cs" Inherits="NMH_Call_Log.CR.Main.NewClientLetter" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">New Client Letter</h3>
            </div><!-- /.box-header -->
            <div class="box-body">
                <asp:UpdatePanel runat="server" >
                    <ContentTemplate>
                        <div class="form-group">
                               <div class="row">
                                   <div class="col-md-6">
                                  <label>CR Officer</label>
                                       <telerik:RadDropDownList ID="dlCROfficer" runat="server" Width="100%" DefaultMessage="Select CR Officer" DataSourceID="crSource" DataValueField="ID" DataTextField="CRName" DropDownHeight="300px"></telerik:RadDropDownList>
                                        <asp:SqlDataSource ID="crSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT ID, FName + ' ' + LName as CRName from tblUsers WHERE AccountTypeID = 2"></asp:SqlDataSource>
                                  <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlCROfficer" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                             </div>
                                   <div class="col-md-3">
                                       <label>Letter Type</label>
                                       <telerik:RadDropDownList ID="dlLetterType" runat="server" Width="100%">
                                           <Items>
                                               <telerik:DropDownListItem Text="BDU Bulletin" />
                                               <telerik:DropDownListItem Text="Newsletter" />
                                               <telerik:DropDownListItem Text="Broadcast" />
                                           </Items>
                                       </telerik:RadDropDownList>
                                   </div>
                                   <div class="col-md-3">
                                       <label>Mode</label>
                                       <telerik:RadDropDownList ID="dlMode" runat="server" Width="100%">
                                           <Items>
                                               <telerik:DropDownListItem Text="Email" />
                                               <telerik:DropDownListItem Text="SMS" />
                                           </Items>
                                       </telerik:RadDropDownList>
                                   </div>
                               </div>
                           </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <label>Month</label>
                                    <telerik:RadMonthYearPicker ID="dpPeriod" runat="server" Width="100%"></telerik:RadMonthYearPicker>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpPeriod" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                       <label>Due Date</label>
                                       <telerik:RadDatePicker runat="server" ID="dpDate" Width="100%" ></telerik:RadDatePicker>
                                       <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                   </div>
                                <div class="col-md-6">
                                    <label>Topic</label>
                                    <asp:TextBox runat="server" ID="txtTopic" Width="100%" MaxLength="50"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button runat="server" ID="btnReturn" CssClass="btn btn-warning" Text="Return" PostBackUrl="~/CR/Main/ClientLetters.aspx" CausesValidation="false" />
                            <asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-primary" Text="Add New" OnClick="btnAddNew_Click" CausesValidation="false" />
                            <asp:Button runat="server" ID="btnSave" CssClass="btn btn-success" Text="Save" OnClick="btnSave_Click" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </div><!-- /.box-body -->
         
          </div><!-- /.box -->
</asp:Content>
