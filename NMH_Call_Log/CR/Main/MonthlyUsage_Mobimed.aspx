<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="MonthlyUsage_Mobimed.aspx.cs" Inherits="NMH_Call_Log.CR.Main.MonthlyUsage_Mobimed" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Mobimed Usage - Monthly</h3>
            </div><!-- /.box-header -->
            <div class="box-body">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                                        <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Period..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                       </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAdd" CssClass="btn-primary" Text="Add New" CausesValidation="false" OnClientClick="newModal();"/>  
                                            </div>
                                        </div>
                                    </div>
                        <hr />

                        <telerik:RadGrid ID="usageGrid" runat="server" AllowSorting="True" DataSourceID="usageSource" GroupPanelPosition="Top" OnItemCommand="usageGrid_ItemCommand" OnItemDeleted="usageGrid_ItemDeleted">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="usageSource" AllowAutomaticDeletes="true" PageSize="100">
                                <Columns>
                                    <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" ReadOnly="True" SortExpression="Id" UniqueName="Id">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="UsagePeriod" FilterControlAltText="Filter UsagePeriod column" HeaderText="UsagePeriod" SortExpression="UsagePeriod" UniqueName="UsagePeriod">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="WhatsappOrders" FilterControlAltText="Filter WhatsappOrders column" HeaderText="WhatsappOrders" SortExpression="WhatsappOrders" UniqueName="WhatsappOrders">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MobileAppOrders" FilterControlAltText="Filter MobileAppOrders column" HeaderText="MobileAppOrders" SortExpression="MobileAppOrders" UniqueName="MobileAppOrders">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SuppliedOrders" FilterControlAltText="Filter SuppliedOrders column" HeaderText="SuppliedOrders" SortExpression="SuppliedOrders" UniqueName="SuppliedOrders">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Downloads" FilterControlAltText="Filter Downloads column" HeaderText="Downloads" SortExpression="Downloads" UniqueName="Downloads">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NonSupplyReasons" FilterControlAltText="Filter NonSupplyReasons column" HeaderText="NonSupplyReasons" SortExpression="NonSupplyReasons" UniqueName="NonSupplyReasons">
                                     <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Remarks" FilterControlAltText="Filter Remarks column" HeaderText="Remarks" SortExpression="Remarks" UniqueName="Remarks">
                                     <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CreatedBy" FilterControlAltText="Filter CreatedBy column" HeaderText="Created By" SortExpression="CreatedBy" UniqueName="CreatedBy">
                                     <HeaderStyle Width="120px" />
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

                                        <asp:SqlDataSource ID="usageSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM tblMonthlyUsage_Mobimed WHERE Id = @Id" SelectCommand="SELECT top(100) Id, UsagePeriod, WhatsappOrders, MobileAppOrders, SuppliedOrders, NonSupplyReasons, Downloads, Remarks, CreatedBy FROM tblClientAppreciation WHERE (UsagePeriod LIKE '%' + @SearchValue + '%') ORDER BY Id DESC">
                                            <DeleteParameters>
                                                <asp:Parameter Name="Id" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="txtSearch" Name="SearchValue" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                    </ContentTemplate>
                    <Triggers>
                                  <%--<asp:PostBackTrigger ControlID="btnExcelExport" />--%>
                              </Triggers>
                </asp:UpdatePanel>

            </div><!-- /.box-body -->
         
          </div><!-- /.box -->

    <!-- new modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">New Usage</h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                    <label>Month</label>
                                    <telerik:RadMonthYearPicker ID="dpPeriod" runat="server" Width="100%"></telerik:RadMonthYearPicker>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpPeriod" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                                </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Whatsapp Orders</label>
                                        <telerik:RadNumericTextBox ID="txtWhatsappOrders" runat="server" Width="100%" MinValue="0" Value="0"></telerik:RadNumericTextBox>
                                    </div>
                                    <div class="col-md-6">
                                        <label>MoblieApp Orders</label>
                                        <telerik:RadNumericTextBox ID="txtMobileAppOrders" runat="server" Width="100%" MinValue="0" Value="0"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Supplied Orders</label>
                                        <telerik:RadNumericTextBox ID="txtSuppliedOrders" runat="server" Width="100%" MinValue="0" Value="0"></telerik:RadNumericTextBox>
                                    </div>
                                    <div class="col-md-6">
                                        <label>Downloads</label>
                                        <telerik:RadNumericTextBox ID="txtDownloads" runat="server" Width="100%" MinValue="0" Value="0"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                    <label>Non Supply Reasons</label>
                                    <asp:TextBox runat="server" ID="txtNonSupplyReasons" Width="100%" TextMode="MultiLine" Rows="3" MaxLength="500"></asp:TextBox>
                                </div>
                            <div class="form-group">
                                    <label>Remarks</label>
                                    <asp:TextBox runat="server" ID="txtRemarks" Width="100%" TextMode="MultiLine" Rows="3" MaxLength="500"></asp:TextBox>
                                </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success" ValidationGroup="new" OnClick="btnSave_Click" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

    <!-- edit modal -->
         <div class="modal fade" id="editmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit Usage</h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                    <label>Month</label>
                                    <telerik:RadMonthYearPicker ID="dpPeriod1" runat="server" Width="100%"></telerik:RadMonthYearPicker>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpPeriod" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Whatsapp Orders</label>
                                        <telerik:RadNumericTextBox ID="txtWhatsappOrders1" runat="server" Width="100%" MinValue="0" Value="0"></telerik:RadNumericTextBox>
                                    </div>
                                    <div class="col-md-6">
                                        <label>MoblieApp Orders</label>
                                        <telerik:RadNumericTextBox ID="txtMobileAppOrders1" runat="server" Width="100%" MinValue="0" Value="0"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Supplied Orders</label>
                                        <telerik:RadNumericTextBox ID="txtSuppliedOrders1" runat="server" Width="100%" MinValue="0" Value="0"></telerik:RadNumericTextBox>
                                    </div>
                                    <div class="col-md-6">
                                        <label>Downloads</label>
                                        <telerik:RadNumericTextBox ID="txtDownloads1" runat="server" Width="100%" MinValue="0" Value="0"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                    <label>Non Supply Reasons</label>
                                    <asp:TextBox runat="server" ID="txtNonSupplyReasons1" Width="100%" TextMode="MultiLine" Rows="3" MaxLength="500"></asp:TextBox>
                                </div>
                            <div class="form-group">
                                    <label>Remarks</label>
                                    <asp:TextBox runat="server" ID="txtRemarks1" Width="100%" TextMode="MultiLine" Rows="3" MaxLength="500"></asp:TextBox>
                                </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-success" ValidationGroup="edit" OnClick="btnUpdate_Click" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

        <script type="text/javascript">
            function newModal() {
                $('#newmodal').modal('show');
            }
            function closenewModal() {
                $('#newmodal').modal('hide');
            }
            function editModal() {
                $('#editmodal').modal('show');
            }
            function closeeditModal() {
                $('#editmodal').modal('hide');
            }
    </script>
</asp:Content>
