<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="ExpCompanies.aspx.cs" Inherits="NMH_Call_Log.CR.Reports.ExpCompanies" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Expiring/Expired Companies </h3>
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
                                           <%--<asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Company / Days..." AutoPostBack="true"></asp:TextBox>--%>
                                            <asp:Button runat="server" ID="btnExcel" CssClass="btn-success" Text="Excel" CausesValidation="false" OnClick="btnExcel_Click"/>  
                                       </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                
                                            </div>
                                        </div>
                                    </div>
                        <hr />

                        <telerik:RadGrid ID="expCompGrid" runat="server" AllowSorting="True" AllowFilteringByColumn="true" AllowPaging="true" DataSourceID="expSource" GroupPanelPosition="Top" OnItemDataBound="expCompGrid_ItemDataBound">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="expiring_list" HideStructureColumns="true"  >
                                        <Pdf AllowPrinting="true" AllowCopy="true" PaperSize="Letter" PageTitle="Expiring Company List" PageWidth="1250"></Pdf>
                                    </ExportSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="RowID" DataSourceID="expSource" AllowAutomaticDeletes="false" PageSize="100">
                                <Columns>
                                    <telerik:GridBoundColumn Display="false" DataField="RowID" DataType="System.Int32" FilterControlAltText="Filter RowID column" HeaderText="RowID" ReadOnly="True" SortExpression="RowID" UniqueName="RowID">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Company" FilterControlAltText="Filter Company column" HeaderText="Company" SortExpression="Company" UniqueName="Company" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="150px">
                                     <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PolicyStartDate" DataType="System.DateTime" FilterControlAltText="Filter PolicyStartDate column" HeaderText="PolicyStartDate" SortExpression="PolicyStartDate" UniqueName="PolicyStartDate" AllowFiltering="false" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PolicyEndDate" DataType="System.DateTime" FilterControlAltText="Filter PolicyEndDate column" HeaderText="PolicyEndDate" SortExpression="PolicyEndDate" UniqueName="PolicyEndDate" AllowFiltering="false" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="120px" />
                                    </telerik:GridBoundColumn>     
                                    <telerik:GridBoundColumn DataField="expiry" FilterControlAltText="Filter expiry column" HeaderText="Expiring/Expired(Days)" SortExpression="expiry" UniqueName="expiry" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="60px">
                                     <HeaderStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                                        </telerik:RadGrid>

                                        <asp:SqlDataSource ID="expSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="select RowID, Company, PolicyStartDate,PolicyEndDate, datediff(D,getdate(),PolicyEndDate) as expiry from Vw_CompanyPolicy_Active where (datediff(D,getdate(),PolicyEndDate) between -90 and 90) ORDER BY expiry">
                                        </asp:SqlDataSource>

                    </ContentTemplate>
                    <Triggers>
                                  <asp:PostBackTrigger ControlID="btnExcel" />
                              </Triggers>
                </asp:UpdatePanel>

            </div><!-- /.box-body -->
         
          </div><!-- /.box -->
</asp:Content>
