<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="Plan_Benefit.aspx.cs" Inherits="NMH_Call_Log.CR.Company.Plan_Benefit" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/dist/css/updateProgress.css" rel="stylesheet" />
    <link href="/Content/dist/css/telerikCombo.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title"> Plan Benefits </h3>
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
                                           <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Benefit..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                       </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                               <asp:Button runat="server" ID="btnAddNew" CssClass="btn-primary" Text="Add New" CausesValidation="false" OnClientClick="newModal();" />  
                                                <asp:Button runat="server" ID="btnReturn" CssClass="btn-warning" Text="Return" CausesValidation="false" PostBackUrl="~/CR/Company/Plan_Benefit_Main.aspx"/>   
                                            </div>
                                        </div>
                                    </div>
                        <hr />

                        <asp:HiddenField runat="server" ID="hfPlanId" />

                        <telerik:RadGrid ID="planBenefitGrid" runat="server" AllowPaging="true" AllowSorting="True" DataSourceID="planBenefitSource" GroupPanelPosition="Top" OnItemDeleted="planBenefitGrid_ItemDeleted" OnItemCommand="planBenefitGrid_ItemCommand">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <GroupHeaderItemStyle BackColor="#36C93E" ForeColor="Black" Font-Bold="true" Width="50px" Font-Size="Medium" />
                            <MasterTableView AutoGenerateColumns="False" DataSourceID="planBenefitSource" PageSize="100" GroupLoadMode="Server" EnableGroupsExpandAll="true" GroupsDefaultExpanded="true">
                                <GroupByExpressions>
                                           <telerik:GridGroupByExpression>
                                               <SelectFields>
                                                   <telerik:GridGroupByField FieldAlias="Plans" FieldName="Plans" HeaderText="Plan"></telerik:GridGroupByField>
                                               </SelectFields>
                                               <GroupByFields>
                                                   <telerik:GridGroupByField FieldName="Plans" SortOrder="Ascending"></telerik:GridGroupByField>
                                               </GroupByFields>
                                           </telerik:GridGroupByExpression>
                                    <telerik:GridGroupByExpression>
                                               <SelectFields>
                                                   <telerik:GridGroupByField FieldAlias="BenefitGroup" FieldName="BenefitGroup" HeaderText=" "></telerik:GridGroupByField>
                                               </SelectFields>
                                               <GroupByFields>
                                                   <telerik:GridGroupByField FieldName="BenefitGroup" SortOrder="Ascending"></telerik:GridGroupByField>
                                               </GroupByFields>
                                           </telerik:GridGroupByExpression>
                                       </GroupByExpressions>
                                <Columns>
                                    <telerik:GridBoundColumn Display="false" DataField="RowID" DataType="System.Int32" FilterControlAltText="Filter RowID column" HeaderText="RowID" SortExpression="RowID" UniqueName="RowID">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn Display="false" DataField="PlanID" DataType="System.Int32" SortExpression="PlanID" UniqueName="PlanID">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn Display="false" DataField="BenefitID" DataType="System.Int32" SortExpression="BenefitID" UniqueName="BenefitID">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Benefit" FilterControlAltText="Filter Benefit column" HeaderText="Benefit" SortExpression="Benefit" UniqueName="Benefit">
                                    <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CoverStatus" FilterControlAltText="Filter CoverStatus column" HeaderText="CoverStatus" SortExpression="CoverStatus" UniqueName="CoverStatus" EmptyDataText="">
                                    <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CoverLimit" FilterControlAltText="Filter CoverLimit column" HeaderText="CoverLimit" SortExpression="CoverLimit" UniqueName="CoverLimit" EmptyDataText="0.00" DataFormatString="{0:0.00}">
                                    <HeaderStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CoverComment" FilterControlAltText="Filter CoverComment column" HeaderText="CoverComment" SortExpression="CoverComment" UniqueName="CoverComment" EmptyDataText="">
                                    <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>

                                    <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" UniqueName="Edit" ButtonCssClass="btn-info" Text="Edit" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                    </telerik:GridButtonColumn>
                                    <%--<telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete this Plan Benefit?" ButtonType="PushButton" ButtonCssClass="btn-danger" Exportable="false">
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridButtonColumn>--%>
                                </Columns>
                            </MasterTableView>
                                        </telerik:RadGrid>

                                        <asp:SqlDataSource ID="planBenefitSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM Vw_Plan_X_Benefits WHERE (PlanID = @PlanId AND Benefit LIKE '%' + @Benefit + '%')" DeleteCommand="DELETE FROM Plan_X_BenefitsLimits WHERE RowID = @RowID">
                                            <%--<DeleteParameters>
                                                <asp:Parameter Name="RowID" Type="Int32" />
                                            </DeleteParameters>--%>
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="hfPlanId" Name="PlanId" PropertyName="Value" Type="String" ConvertEmptyStringToNull="false" />
                                                <asp:ControlParameter ControlID="txtSearch" Name="Benefit" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
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
                    <h4 class="modal-title">New Benefit</h4>
                </div>
                        <div class="modal-body">
                            <%--<div class="form-group">
                                    <label>Plan</label>
                                    <telerik:RadDropDownList runat="server" ID="dlPlan" Width="100%" DataSourceID="planSource" DataTextField="Plans" DataValueField="PlanID">
                                    </telerik:RadDropDownList>
                                    <asp:SqlDataSource ID="planSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [PlanId], [Plans] FROM [Vw_Actual_Plans]"></asp:SqlDataSource>
                                </div>--%>
                            <div class="form-group">
                                  <label>Benefit</label>
                                  <telerik:RadComboBox ID="dlBenefit" runat="server" Width="100%" DataSourceID="BenefitSource" MaxHeight="200" EmptyMessage="Select Benefit" Filter="Contains"
                                           OnItemDataBound="dlBenefit_ItemDataBound" OnDataBound="dlBenefit_DataBound" OnItemsRequested="dlBenefit_ItemsRequested" EnableLoadOnDemand="true"
                                            OnClientItemsRequested="UpdateBenefitItemCountField" HighlightTemplatedItems="true" MarkFirstMatch="true"  >
                                            <HeaderTemplate>
                <ul>
                    <li class="ncolfull">BENEFIT</li>
                </ul>
            </HeaderTemplate>
            <ItemTemplate>
                <ul>
                    <li class="ncolfull">
                        <%# DataBinder.Eval(Container.DataItem, "Benefit")%></li>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                A total of
                <asp:Literal runat="server" ID="BenefitCount" />
                items
            </FooterTemplate>
                                        </telerik:RadComboBox>
                                        <asp:SqlDataSource ID="BenefitSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ></asp:SqlDataSource>
                                  <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlBenefit" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                    <label>Status</label>
                                    <telerik:RadDropDownList runat="server" ID="dlCoverStatus" Width="100%">
                                        <Items>
                                            <telerik:DropDownListItem Text="Covered" />
                                            <telerik:DropDownListItem Text="Not Covered" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            <div class="form-group">
                                    <label>Limit</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtCoverLimit" Width="100%" Height="24px" MinValue="0" Value="0"></telerik:RadNumericTextBox>
                                </div>
                            <div class="form-group">
                                    <label>Comment</label>
                                    <asp:TextBox runat="server" ID="txtCoverComment" Width="100%" TextMode="MultiLine" Rows="5"></asp:TextBox>
                                </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success" OnClick="btnSave_Click" ValidationGroup="new" />
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
                    <h4 class="modal-title">Edit Benefit</h4>
                </div>
                        <div class="modal-body">
                            <%--<div class="form-group">
                                    <label>Plan</label>
                                    <telerik:RadDropDownList runat="server" ID="dlPlan1" Width="100%" DataSourceID="planSource" DataTextField="Plans" DataValueField="PlanID">
                                    </telerik:RadDropDownList>
                                </div>--%>
                            <div class="form-group">
                                  <label>Benefit</label>
                                  <telerik:RadComboBox ID="dlBenefit1" runat="server" Width="100%" DataSourceID="BenefitSource1" MaxHeight="200" EmptyMessage="Select Benefit" Filter="Contains"
                                           OnItemDataBound="dlBenefit1_ItemDataBound" OnDataBound="dlBenefit1_DataBound" OnItemsRequested="dlBenefit1_ItemsRequested" EnableLoadOnDemand="true"
                                            OnClientItemsRequested="UpdateBenefit1ItemCountField" HighlightTemplatedItems="true" MarkFirstMatch="true"  >
                                            <HeaderTemplate>
                <ul>
                    <li class="ncolfull">BENEFIT</li>
                </ul>
            </HeaderTemplate>
            <ItemTemplate>
                <ul>
                    <li class="ncolfull">
                        <%# DataBinder.Eval(Container.DataItem, "Benefit")%></li>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                A total of
                <asp:Literal runat="server" ID="BenefitCount1" />
                items
            </FooterTemplate>
                                        </telerik:RadComboBox>
                                <asp:SqlDataSource ID="BenefitSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ></asp:SqlDataSource>
                                  <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlBenefit1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                    <label>Status</label>
                                    <telerik:RadDropDownList runat="server" ID="dlCoverStatus1" Width="100%">
                                        <Items>
                                            <telerik:DropDownListItem Text="Covered" />
                                            <telerik:DropDownListItem Text="Not Covered" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            <div class="form-group">
                                    <label>Limit</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtCoverLimit1" Width="100%" Height="24px" MinValue="0"></telerik:RadNumericTextBox>
                                </div>
                            <div class="form-group">
                                    <label>Comment</label>
                                    <asp:TextBox runat="server" ID="txtCoverComment1" Width="100%" TextMode="MultiLine" Rows="5"></asp:TextBox>
                                </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-success" OnClick="btnUpdate_Click" ValidationGroup="edit" />
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
            function UpdateBenefitItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
            function UpdateBenefit1ItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
