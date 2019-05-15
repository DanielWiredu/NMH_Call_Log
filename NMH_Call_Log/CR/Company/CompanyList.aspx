<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="CompanyList.aspx.cs" Inherits="NMH_Call_Log.CR.Company.CompanyList" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Company Plans </h3>
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
                                           <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Company..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                       </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                               
                                            </div>
                                        </div>
                                    </div>
                        <hr />

                        <telerik:RadGrid ID="companyGrid" runat="server" AllowPaging="true" AllowSorting="True" DataSourceID="companySource" GroupPanelPosition="Top" OnItemCommand="companyGrid_ItemCommand">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView AutoGenerateColumns="False" DataSourceID="companySource" PageSize="50">
                                <Columns>
                                    <telerik:GridButtonColumn Text="Details" CommandName="Details" UniqueName="Details" Exportable="false">
                                        <HeaderStyle Width="70px" />
                                        <ItemStyle Font-Underline="true" ForeColor="Green" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridBoundColumn Display="false" DataField="ID" DataType="System.Int32" FilterControlAltText="Filter ID column" HeaderText="ID" ReadOnly="True" SortExpression="ID" UniqueName="ID">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Company" FilterControlAltText="Filter Company column" HeaderText="Company" SortExpression="Company" UniqueName="Company">
                                    <HeaderStyle Width="300px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="InitialJoin_Date" FilterControlAltText="Filter InitialJoin_Date column" HeaderText="Initial Join Date" SortExpression="InitialJoin_Date" UniqueName="InitialJoin_Date" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="StartDate" FilterControlAltText="Filter StartDate column" HeaderText="StartDate" SortExpression="StartDate" UniqueName="StartDate" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ExpiryDate" FilterControlAltText="Filter ExpiryDate column" HeaderText="ExpiryDatee" SortExpression="ExpiryDate" UniqueName="ExpiryDate" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ContactPerson" FilterControlAltText="Filter ContactPerson column" HeaderText="ContactPerson" SortExpression="ContactPerson" UniqueName="ContactPerson">
                                    <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ContactNumber" FilterControlAltText="Filter ContactNumber column" HeaderText="ContactNumber" SortExpression="ContactNumber" UniqueName="ContactNumber">
                                    <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridCheckBoxColumn DataField="SpecialConcession" DataType="System.Boolean" FilterControlAltText="Filter SpecialConcession column" HeaderText="Concession" SortExpression="SpecialConcession" UniqueName="SpecialConcession" StringTrueValue="1" StringFalseValue="0" >
                                         <HeaderStyle Width="80px" />
                                         </telerik:GridCheckBoxColumn>
                                </Columns>
                            </MasterTableView>
                                        </telerik:RadGrid>

                                        <asp:SqlDataSource ID="companySource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT ID, Company, InitialJoin_Date, StartDate, ExpiryDate, ContactPerson, ContactNumber, SpecialConcession FROM Companies WHERE (Company LIKE '%' + @Company + '%') ORDER BY Company">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="txtSearch" Name="Company" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
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
