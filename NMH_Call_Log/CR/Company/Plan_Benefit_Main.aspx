<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="Plan_Benefit_Main.aspx.cs" Inherits="NMH_Call_Log.CR.Company.Plan_Benefit_Main" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title"> Plans </h3>
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
                                           <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Plan..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                       </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                               <%--<asp:Button runat="server" ID="btnAddNew" CssClass="btn-primary" Text="Add New" CausesValidation="false" OnClientClick="newModal();" />--%>   
                                            </div>
                                        </div>
                                    </div>
                        <hr />


                        <telerik:RadGrid ID="planGrid" runat="server" AllowPaging="true" AllowSorting="True" DataSourceID="planSource" GroupPanelPosition="Top" OnItemCommand="planGrid_ItemCommand">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView AutoGenerateColumns="False" DataSourceID="planSource" PageSize="50" GroupLoadMode="Server" EnableGroupsExpandAll="true" GroupsDefaultExpanded="true">
                                <Columns>
                                    <telerik:GridButtonColumn Text="Benefits" CommandName="Benefits" UniqueName="Benefits" Exportable="false">
                                        <HeaderStyle Width="70px" />
                                        <ItemStyle Font-Underline="true" ForeColor="Green" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridBoundColumn Display="false" DataField="PlanId" DataType="System.Int32" SortExpression="PlanId" UniqueName="PlanId">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Plans" FilterControlAltText="Filter Plans column" HeaderText="Plans" SortExpression="Plans" UniqueName="Plans">
                                    <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                                        </telerik:RadGrid>
                                        <asp:SqlDataSource ID="planSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [PlanId], [Plans] FROM [Vw_Actual_Plans] WHERE (Plans LIKE '%' + @Plan + '%')">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="txtSearch" Name="Plan" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
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
