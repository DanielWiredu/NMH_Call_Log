<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="CallLogRecords.aspx.cs" Inherits="NMH_Call_Log.Reports.CallLogRecords" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="/Content/dist/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Call Log Records </h3>
              <div class="box-tools pull-right">
                <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                <button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
              </div>
            </div><!-- /.box-header -->
            <div class="box-body">
                <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="upProcess">
                           <ProgressTemplate>
                            <div class="divWaiting">            
	                            <asp:Label ID="lblWait" runat="server" Text="Processing... " />
	                              <asp:Image ID="imgWait" runat="server" ImageAlign="Top" ImageUrl="/Content/dist/img/loader.gif" />
                                </div>
                             </ProgressTemplate>
                       </asp:UpdateProgress>

                   <asp:Panel runat="server" DefaultButton="btnSearch">
            <asp:UpdatePanel runat="server" ID="upProcess">
            <ContentTemplate>
                 <div class="modal-content">
                        <div class="modal-body">
                             <div class="form-group">
                                 <div class="row">
                                    <div class="col-md-3">
                                    <label>Start Date</label>
                                        <telerik:RadDatePicker ID="dpStartDate" runat="server" Width="100%"></telerik:RadDatePicker>
                                     <asp:RequiredFieldValidator runat="server" ControlToValidate="dpStartDate" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                     <label>End Date</label>
                                    <telerik:RadDatePicker ID="dpEndDate" runat="server" Width="100%"></telerik:RadDatePicker>
                                     <asp:RequiredFieldValidator runat="server" ControlToValidate="dpEndDate" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div> 
                                 </div>
                                  
                             </div>
                            <div>
                                <telerik:RadGrid ID="callLogGrd" runat="server" ShowFooter="true" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" DataSourceID="callLogSource" GroupPanelPosition="Top">
                                    <ClientSettings>
                                        <Selecting AllowRowSelect="True" />
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                    </ClientSettings>
                                    <GroupingSettings CaseSensitive="false" />
                                    <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="Call_Log" HideStructureColumns="true">
                                    </ExportSettings>
                                    <MasterTableView AutoGenerateColumns="False" DataSourceID="callLogSource" PageSize="100">
                                        <Columns>
                                            <telerik:GridDateTimeColumn Aggregate="Count" FooterText="Count: " DataField="CallDate" DataType="System.DateTime" FilterControlAltText="Filter CallDate column" HeaderText="CallDate" SortExpression="CallDate" UniqueName="CallDate" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="120px" AllowFiltering="false">
                                            <HeaderStyle Width="150px" />
                                            </telerik:GridDateTimeColumn>
                                            <telerik:GridBoundColumn DataType="System.String" DataField="CallerNumber" FilterControlAltText="Filter CallerNumber column" HeaderText="CallerNumber" SortExpression="CallerNumber" UniqueName="CallerNumber" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100px">
                                            <HeaderStyle Width="120px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="CallerName" FilterControlAltText="Filter CallerName column" HeaderText="CallerName" SortExpression="CallerName" UniqueName="CallerName" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="140px">
                                            <HeaderStyle Width="180px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridCheckBoxColumn DataField="NMHMember" DataType="System.Boolean" FilterControlAltText="Filter NMHMember column" HeaderText="Member" SortExpression="NMHMember" UniqueName="NMHMember" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="50px">
                                            <HeaderStyle Width="80px" />
                                            </telerik:GridCheckBoxColumn>
                                            <telerik:GridBoundColumn DataField="MemberNo" FilterControlAltText="Filter MemberNo column" HeaderText="MemberNo" SortExpression="MemberNo" UniqueName="MemberNo" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
                                            <HeaderStyle Width="100px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Company" FilterControlAltText="Filter Company column" HeaderText="Company" SortExpression="Company" UniqueName="Company" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="150px">
                                            <HeaderStyle Width="180px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ServiceProvider" FilterControlAltText="Filter ServiceProvider column" HeaderText="ServiceProvider" SortExpression="ServiceProvider" UniqueName="ServiceProvider" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="150px">
                                            <HeaderStyle Width="180px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Location" FilterControlAltText="Filter Location column" HeaderText="Location" SortExpression="Location" UniqueName="Location" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="120px">
                                            <HeaderStyle Width="150px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="CallType" FilterControlAltText="Filter CallType column" HeaderText="CallType" SortExpression="CallType" UniqueName="CallType" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
                                            <HeaderStyle Width="100px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ServiceType" FilterControlAltText="Filter ServiceType column" HeaderText="ServiceType" SortExpression="ServiceType" UniqueName="ServiceType" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="140px">
                                            <HeaderStyle Width="170px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="CallReason" FilterControlAltText="Filter CallReason column" HeaderText="CallReason" SortExpression="CallReason" UniqueName="CallReason" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="140px">
                                            <HeaderStyle Width="170px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Description" SortExpression="Description" UniqueName="Description" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                            <HeaderStyle Width="200px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Comment" FilterControlAltText="Filter Comment column" HeaderText="Comment" SortExpression="Comment" UniqueName="Comment" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                            <HeaderStyle Width="200px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridCheckBoxColumn DataField="Escalated" DataType="System.Boolean" FilterControlAltText="Filter Escalated column" HeaderText="Escalated" SortExpression="Escalated" UniqueName="Escalated" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="60px">
                                            <HeaderStyle Width="80px" />
                                            </telerik:GridCheckBoxColumn>
                                            <telerik:GridBoundColumn DataField="Department" FilterControlAltText="Filter Department column" HeaderText="Department" SortExpression="Department" UniqueName="Department" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
                                            <HeaderStyle Width="100px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="EscalatedStatus" FilterControlAltText="Filter EscalatedStatus column" HeaderText="Status" SortExpression="EscalatedStatus" UniqueName="EscalatedStatus" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="70px">
                                            <HeaderStyle Width="90px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="EscalateComment" FilterControlAltText="Filter EscalateComment column" HeaderText="EscalateComment" SortExpression="EscalateComment" UniqueName="EscalateComment" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="140px">
                                            <HeaderStyle Width="170px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="CreatedBy" FilterControlAltText="Filter CreatedBy column" HeaderText="CreatedBy" SortExpression="CreatedBy" UniqueName="CreatedBy" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="120px">
                                            <HeaderStyle Width="150px" />
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                                <asp:SqlDataSource ID="callLogSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [CallDate], [CallerNumber], [CallerName], [NMHMember], [MemberNo], [Company], [ServiceProvider], [Location], [CallType], [ServiceType], [CallReason], [Description], [Comment], [Escalated], [Department], [EscalatedStatus], [EscalateComment], [CreatedBy] FROM [vwCallLog] WHERE (CAST(CallDate as date) BETWEEN @StartDate AND @EndDate)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="dpStartDate" DefaultValue="2000-01-01" Name="StartDate" PropertyName="SelectedDate" Type="DateTime" />
                                        <asp:ControlParameter ControlID="dpEndDate" DefaultValue="2000-01-01" Name="EndDate" PropertyName="SelectedDate" Type="DateTime" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                       </div>

                <div class="modal-footer">
                    <asp:Button ID="btnSearch" runat="server" Text="Generate Data" CssClass="btn btn-primary"  OnClick="btnSearch_Click" />
                    <asp:Button ID="btnExcelExport" runat="server" Text="Excel" CssClass="btn btn-success" OnClick="btnExcelExport_Click" CausesValidation="false" />
                </div>
            </div>
            </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnExcelExport" />
                </Triggers>
        </asp:UpdatePanel>
        </asp:Panel>
            </div><!-- /.box-body -->
         
          </div><!-- /.box -->
</asp:Content>
