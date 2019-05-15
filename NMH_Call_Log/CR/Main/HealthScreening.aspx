<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="HealthScreening.aspx.cs" Inherits="NMH_Call_Log.CR.Main.HealthScreening" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="/Content/dist/css/telerikCombo.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Health Screening</h3>
            </div><!-- /.box-header -->
            <div class="box-body">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                                        <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Company / Health Facility..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                       </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAdd" CssClass="btn-primary" Text="Add New" CausesValidation="false" OnClientClick="newModal();"/>  
                                            </div>
                                        </div>
                                    </div>
                        <hr />

                        <telerik:RadGrid ID="screeningGrid" runat="server" AllowSorting="True" DataSourceID="screeningSource" GroupPanelPosition="Top" OnItemCommand="screeningGrid_ItemCommand" OnItemDeleted="screeningGrid_ItemDeleted">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="screeningSource" AllowAutomaticDeletes="false" PageSize="100">
                                <Columns>
                                    <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" ReadOnly="True" SortExpression="Id" UniqueName="Id">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Company" FilterControlAltText="Filter Company column" HeaderText="Company" SortExpression="Company" UniqueName="Company">
                                     <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ScreenDate" DataType="System.DateTime" FilterControlAltText="Filter ScreenDate column" HeaderText="ScreenDate" SortExpression="ScreenDate" UniqueName="ScreenDate" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ScreenType" FilterControlAltText="Filter ScreenType column" HeaderText="ScreenType" SortExpression="ScreenType" UniqueName="ScreenType">
                                     <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="HealthFacility" FilterControlAltText="Filter HealthFacility column" HeaderText="HealthFacility" SortExpression="HealthFacility" UniqueName="HealthFacility">
                                     <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ScreenResults" FilterControlAltText="Filter ScreenResults column" HeaderText="Results" SortExpression="ScreenResults" UniqueName="ScreenResults">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ScreenStats" FilterControlAltText="Filter ScreenStats column" HeaderText="ScreenStats" SortExpression="ScreenStats" UniqueName="ScreenStats">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ResourcePerson" FilterControlAltText="Filter ResourcePerson column" HeaderText="ResourcePerson" SortExpression="ResourcePerson" UniqueName="ResourcePerson">
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

                                        <asp:SqlDataSource ID="screeningSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM tblHealthScreening WHERE Id = @Id" SelectCommand="SELECT top(100) Id, Company, ScreenDate, ScreenType, HealthFacility, ScreenResults, ScreenStats, ResourcePerson, CreatedBy FROM vwHealthScreening WHERE (Company LIKE '%' + @SearchValue + '%' OR HealthFacility LIKE '%' + @SearchValue + '%') ORDER BY Id DESC">
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
    <div class="modal-dialog" style="width:70%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">New Health Screening</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
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
                                  <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlCompany" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                       <label>Date</label>
                                       <telerik:RadDatePicker runat="server" ID="dpDate" Width="100%" ></telerik:RadDatePicker>
                                       <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                                   </div>
                            <div class="form-group">
                                <label>Type of Screening</label>
                                <telerik:RadDropDownList ID="dlScreenType" runat="server" Width="100%">
                                    <Items>
                                        <telerik:DropDownListItem Text="Regular Wellness" />
                                        <telerik:DropDownListItem Text="Customized Wellness" />
                                    </Items>
                                </telerik:RadDropDownList>
                            </div>
                            
                            <div class="form-group">
                                    <label>Health Facility</label>
                                    <asp:TextBox runat="server" ID="txtHealthFacility" Width="100%" MaxLength="100"></asp:TextBox>
                                </div>
                            <div class="form-group">
                                    <label>Resource Person</label>
                                    <asp:TextBox runat="server" ID="txtResourcePerson" Width="100%" MaxLength="100"></asp:TextBox>
                                </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Results</label>
                                        <telerik:RadDropDownList ID="dlResults" runat="server" Width="100%">
                                            <Items>
                                                <telerik:DropDownListItem Text="Pending" />
                                                <telerik:DropDownListItem Text="Delivered" />
                                            </Items>
                                    </telerik:RadDropDownList>
                                    </div>
                                    <div class="col-md-6">
                                        <label>Statistics</label>
                                        <telerik:RadDropDownList ID="dlStatistics" runat="server" Width="100%">
                                            <Items>
                                                <telerik:DropDownListItem Text="Pending" />
                                                <telerik:DropDownListItem Text="Delivered" />
                                            </Items>
                                    </telerik:RadDropDownList>
                                    </div>
                                </div>
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
    <div class="modal-dialog" style="width:70%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit Health Screening</h4>
                </div>
                        <div class="modal-body">
                            <div class="alert alert-info" runat="server" id="lblCompany"></div>
                             <div class="form-group">
                                       <label>Date</label>
                                       <telerik:RadDatePicker runat="server" ID="dpDate1" Width="100%" ></telerik:RadDatePicker>
                                       <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpDate1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                   </div>
                            <div class="form-group">
                                <label>Type of Screening</label>
                                <telerik:RadDropDownList ID="dlScreenType1" runat="server" Width="100%">
                                    <Items>
                                        <telerik:DropDownListItem Text="Regular Wellness" />
                                        <telerik:DropDownListItem Text="Customized Wellness" />
                                    </Items>
                                </telerik:RadDropDownList>
                            </div>
                            
                            <div class="form-group">
                                    <label>Health Facility</label>
                                    <asp:TextBox runat="server" ID="txtHealthFacility1" Width="100%" MaxLength="100"></asp:TextBox>
                                </div>
                            <div class="form-group">
                                    <label>Resource Person</label>
                                    <asp:TextBox runat="server" ID="txtResourcePerson1" Width="100%" MaxLength="100"></asp:TextBox>
                                </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Results</label>
                                        <telerik:RadDropDownList ID="dlResults1" runat="server" Width="100%">
                                            <Items>
                                                <telerik:DropDownListItem Text="Pending" />
                                                <telerik:DropDownListItem Text="Delivered" />
                                            </Items>
                                    </telerik:RadDropDownList>
                                    </div>
                                    <div class="col-md-6">
                                        <label>Statistics</label>
                                        <telerik:RadDropDownList ID="dlStatistics1" runat="server" Width="100%">
                                            <Items>
                                                <telerik:DropDownListItem Text="Pending" />
                                                <telerik:DropDownListItem Text="Delivered" />
                                            </Items>
                                    </telerik:RadDropDownList>
                                    </div>
                                </div>
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
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function UpdateCompanyItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
