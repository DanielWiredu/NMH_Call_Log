<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="MemberRefunds.aspx.cs" Inherits="NMH_Call_Log.CR.Reports.MemberRefunds" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/dist/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Refund Report </h3>
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
                                <telerik:RadGrid ID="refundGrid" runat="server" AllowSorting="True" DataSourceID="refundSource" GroupPanelPosition="Top">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                                    <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="Refund_Data" HideStructureColumns="true">
                                    </ExportSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="refundSource"  PageSize="100">
                                <Columns>
                                    <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" ReadOnly="True" SortExpression="Id" UniqueName="Id">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ClaimsBatchNo" FilterControlAltText="Filter ClaimsBatchNo column" HeaderText="BatchNo" SortExpression="ClaimsBatchNo" UniqueName="ClaimsBatchNo">
                                     <HeaderStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DateOfClaim" DataType="System.DateTime" FilterControlAltText="Filter DateOfClaim column" HeaderText="SubmissionDate" SortExpression="DateOfClaim" UniqueName="DateOfClaim" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ClaimsNo" FilterControlAltText="Filter ClaimsNo column" HeaderText="ClaimsNo" SortExpression="ClaimsNo" UniqueName="ClaimsNo">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MemberNo" FilterControlAltText="Filter MemberNo column" HeaderText="MemberNo" SortExpression="MemberNo" UniqueName="MemberNo">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MPhone" FilterControlAltText="Filter MPhone column" HeaderText="Phone No" SortExpression="MPhone" UniqueName="MPhone">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="FullName" FilterControlAltText="Filter FullName column" HeaderText="MemberName" SortExpression="FullName" UniqueName="FullName">
                                     <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DateofAttendance" DataType="System.DateTime" FilterControlAltText="Filter DateofAttendance column" HeaderText="DateofAttendance" SortExpression="DateofAttendance" UniqueName="DateofAttendance" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Company" FilterControlAltText="Filter Company column" HeaderText="Company" SortExpression="Company" UniqueName="Company">
                                     <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ProviderAmountClaimed" FilterControlAltText="Filter ProviderAmountClaimed column" HeaderText="AmountClaimed" SortExpression="ProviderAmountClaimed" UniqueName="ProviderAmountClaimed" DataFormatString="{0:0.00}">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SysAmountAwarded" FilterControlAltText="Filter SysAmountAwarded column" HeaderText="AmountAwarded" SortExpression="SysAmountAwarded" UniqueName="SysAmountAwarded" DataFormatString="{0:0.00}">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PaymentMode" FilterControlAltText="Filter PaymentMode column" HeaderText="PaymentMode" SortExpression="PaymentMode" UniqueName="PaymentMode">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MoMoNumber" FilterControlAltText="Filter MoMoNumber column" HeaderText="MoMoNumber" SortExpression="MoMoNumber" UniqueName="MoMoNumber">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MomoName" FilterControlAltText="Filter MomoName column" HeaderText="MomoName" SortExpression="MomoName" UniqueName="MomoName">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ChequeNo" FilterControlAltText="Filter ChequeNo column" HeaderText="ChequeNo" SortExpression="ChequeNo" UniqueName="ChequeNo">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ChequeAmount" FilterControlAltText="Filter ChequeAmount column" HeaderText="ChequeAmount" SortExpression="ChequeAmount" UniqueName="ChequeAmount">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RefundClaimStatus" FilterControlAltText="Filter RefundClaimStatus column" HeaderText="RefundClaimStatus" SortExpression="RefundClaimStatus" UniqueName="RefundClaimStatus">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                                        </telerik:RadGrid>
                                <asp:SqlDataSource ID="refundSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM Vw_RefundHeader WHERE (CAST(DateOfClaim as date) BETWEEN @StartDate AND @EndDate)">
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
