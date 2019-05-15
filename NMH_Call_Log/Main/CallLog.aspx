<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="CallLog.aspx.cs" Inherits="NMH_Call_Log.Main.CallLog" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Call Centre </h3>
              <%--<div class="box-tools pull-right">
                <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                <button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
              </div>--%>
            </div><!-- /.box-header -->
            <div class="box-body">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                                        <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Caller No / Member No..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                       </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAdd" CssClass="btn-primary" Text="Add New" CausesValidation="false" OnClick="btnAdd_Click"/>  
                                            </div>
                                        </div>
                                    </div>
                        <hr />

                        <telerik:RadGrid ID="callGrid" runat="server" AllowSorting="True" DataSourceID="callSource" GroupPanelPosition="Top" OnItemCommand="callGrid_ItemCommand" OnItemDataBound="callGrid_ItemDataBound" OnDeleteCommand="callGrid_DeleteCommand">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="CallId" DataSourceID="callSource" AllowAutomaticDeletes="false" PageSize="50">
                                <Columns>
                                    <telerik:GridBoundColumn Display="false" DataField="CallId" DataType="System.Int32" FilterControlAltText="Filter CallId column" HeaderText="CallId" ReadOnly="True" SortExpression="CallId" UniqueName="CallId">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CallDate" DataType="System.DateTime" FilterControlAltText="Filter CallDate column" HeaderText="CallDate" SortExpression="CallDate" UniqueName="CallDate">
                                    <HeaderStyle Width="140px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CallerNumber" FilterControlAltText="Filter CallerNumber column" HeaderText="CallerNumber" SortExpression="CallerNumber" UniqueName="CallerNumber">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MemberNo" FilterControlAltText="Filter MemberNo column" HeaderText="MemberNo" SortExpression="MemberNo" UniqueName="MemberNo">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CallerName" FilterControlAltText="Filter CallerName column" HeaderText="CallerName" SortExpression="CallerName" UniqueName="CallerName">
                                     <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Description" SortExpression="Description" UniqueName="Description">
                                     <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CallType" FilterControlAltText="Filter CallType column" HeaderText="CallType" SortExpression="CallType" UniqueName="CallType">
                                     <HeaderStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CreatedBy" FilterControlAltText="Filter CreatedBy column" HeaderText="Logged By" SortExpression="CreatedBy" UniqueName="CreatedBy">
                                     <HeaderStyle Width="130px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn Display="false" DataField="Escalated" FilterControlAltText="Filter Escalated column" SortExpression="Escalated" UniqueName="Escalated">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn Display="false" DataField="EscalatedStatus" FilterControlAltText="Filter EscalatedStatus column" SortExpression="EscalatedStatus" UniqueName="EscalatedStatus">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" UniqueName="Edit" ButtonCssClass="btn-info" Text="Edit" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger" Exportable="false">
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                                        </telerik:RadGrid>

                                        <asp:SqlDataSource ID="callSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [tblCallLog] WHERE [CallId] = @CallId" SelectCommand="SELECT top(100) [CallId], [CallDate], [CallerNumber], [MemberNo], [CallerName], [Description], [CallType], [CreatedBy], [Escalated], [EscalatedStatus] FROM [vwCallLog] WHERE (([CallerNumber] LIKE '%' + @CallerNumber + '%') OR ([MemberNo] LIKE '%' + @MemberNo + '%')) ORDER BY CallDate DESC">
                                            <DeleteParameters>
                                                <asp:Parameter Name="CallId" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="txtSearch" Name="CallerNumber" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                                                <asp:ControlParameter ControlID="txtSearch" Name="MemberNo" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                    </ContentTemplate>
                    <Triggers>
                                  <%--<asp:PostBackTrigger ControlID="btnExcelExport" />--%>
                              </Triggers>
                </asp:UpdatePanel>

            </div><!-- /.box-body -->
         
          </div><!-- /.box -->
</asp:Content>
