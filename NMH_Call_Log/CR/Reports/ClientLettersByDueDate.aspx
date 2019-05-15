<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="ClientLettersByDueDate.aspx.cs" Inherits="NMH_Call_Log.CR.Reports.ClientLettersByDueDate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/dist/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Client Letters Report </h3>
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
                                    <label>Start Due Date</label>
                                        <telerik:RadDatePicker ID="dpStartDate" runat="server" Width="100%"></telerik:RadDatePicker>
                                     <asp:RequiredFieldValidator runat="server" ControlToValidate="dpStartDate" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                     <label>End Due Date</label>
                                    <telerik:RadDatePicker ID="dpEndDate" runat="server" Width="100%"></telerik:RadDatePicker>
                                     <asp:RequiredFieldValidator runat="server" ControlToValidate="dpEndDate" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div> 
                                 </div>
                                 
                             </div>
                            <div>
                                <telerik:RadGrid ID="letterGrid" runat="server" AllowSorting="True" DataSourceID="letterSource" GroupPanelPosition="Top">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                                    <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="Client_Letters" HideStructureColumns="true">
                                    </ExportSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="letterSource" AllowAutomaticDeletes="false" PageSize="100">
                                <Columns>
                                    <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" ReadOnly="True" SortExpression="Id" UniqueName="Id">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CROfficerName" FilterControlAltText="Filter CROfficerName column" HeaderText="CROfficerName" SortExpression="CROfficerName" UniqueName="CROfficerName">
                                     <HeaderStyle Width="180px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LType" FilterControlAltText="Filter LType column" HeaderText="Type" SortExpression="LType" UniqueName="LType">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LMode" FilterControlAltText="Filter LMode column" HeaderText="Mode" SortExpression="LMode" UniqueName="LMode">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LPeriod" FilterControlAltText="Filter LPeriod column" HeaderText="Period" SortExpression="LPeriod" UniqueName="LPeriod">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Topic" FilterControlAltText="Filter Topic column" HeaderText="Topic" SortExpression="Topic" UniqueName="Topic">
                                     <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DueDate" DataType="System.DateTime" FilterControlAltText="Filter DueDate column" HeaderText="DueDate" SortExpression="DueDate" UniqueName="DueDate" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="140px" />
                                    </telerik:GridBoundColumn>  
                                    <telerik:GridBoundColumn DataField="CreatedBy" FilterControlAltText="Filter CreatedBy column" HeaderText="Created By" SortExpression="CreatedBy" UniqueName="CreatedBy">
                                     <HeaderStyle Width="130px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CreatedDate" DataType="System.DateTime" FilterControlAltText="Filter CreatedDate column" HeaderText="CreatedDate" SortExpression="CreatedDate" UniqueName="CreatedDate" >
                                    <HeaderStyle Width="140px" />
                                    </telerik:GridBoundColumn> 
                                </Columns>
                            </MasterTableView>
                                        </telerik:RadGrid>
                                <asp:SqlDataSource ID="letterSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id, CROfficerName, LType, LMode, LPeriod, Topic, DueDate, CreatedBy, CreatedDate FROM vwClientLetters WHERE (CAST(DueDate as date) BETWEEN @StartDate AND @EndDate)">
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
