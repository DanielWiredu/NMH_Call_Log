<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="Company_Plan_Benefits.aspx.cs" Inherits="NMH_Call_Log.CR.Company.Company_Plan_Benefits" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/dist/css/telerikCombo.css" rel="stylesheet" />
    <link href="/Content/dist/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Company Plan Benefits </h3>
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
                                                <asp:Button runat="server" ID="btnReturn" CssClass="btn-warning" Text="Return" CausesValidation="false" PostBackUrl="~/CR/Company/Company_Plan_Map.aspx"/>  
                                            </div>
                                        </div>
                                    </div>
                        <hr />

                        <%--<div class="alert alert-info" runat="server" id="lblCompany"></div>--%>
                        <div style="text-align:center;vertical-align:middle">
                             <h3 runat="server" id="lblCompany" style="color:black; background-color:white; font-weight:bold"></h3>
                        </div>
                       

                        <asp:HiddenField runat="server" ID="hfCompanyId" />
                        <asp:HiddenField runat="server" ID="hfPlanId" />

                        <telerik:RadGrid ID="companyBenefitGrid" runat="server" AllowPaging="true" AllowSorting="True" DataSourceID="companyBenefitSource" GroupPanelPosition="Top" OnItemCommand="companyBenefitGrid_ItemCommand">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <GroupHeaderItemStyle BackColor="#36C93E" ForeColor="Black" Font-Bold="true" Width="50px" Font-Size="Medium" />
                            <MasterTableView AutoGenerateColumns="False" DataSourceID="companyBenefitSource" PageSize="100" GroupLoadMode="Server">
                                <GroupByExpressions>
                                           <telerik:GridGroupByExpression>
                                               <SelectFields>
                                                   <telerik:GridGroupByField FieldAlias="Plans" FieldName="Plans" HeaderText="Plan"></telerik:GridGroupByField>
                                               </SelectFields>
                                               <GroupByFields>
                                                   <telerik:GridGroupByField FieldName="Plans" SortOrder="Ascending"></telerik:GridGroupByField>
                                               </GroupByFields>
                                           </telerik:GridGroupByExpression>
                                       </GroupByExpressions>
                                <Columns>
                                    <telerik:GridBoundColumn Display="false" DataField="RowId" DataType="System.Int32" FilterControlAltText="Filter RowId column" HeaderText="RowId" SortExpression="RowId" UniqueName="RowId">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn Display="false" DataField="PlanId" DataType="System.Int32" FilterControlAltText="Filter PlanId column" HeaderText="PlanId" SortExpression="PlanId" UniqueName="PlanId">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn Display="false" DataField="Plans" FilterControlAltText="Filter Plans column" HeaderText="Plans" SortExpression="Plans" UniqueName="Plans">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn Display="false" DataField="BenefitId" DataType="System.Int32" FilterControlAltText="Filter BenefitId column" HeaderText="BenefitId" SortExpression="BenefitId" UniqueName="BenefitId">
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
                                   <%-- <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete this Company Plan and all associated Benefits?" ButtonType="PushButton" ButtonCssClass="btn-danger" Exportable="false">
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridButtonColumn>--%>
                                </Columns>
                            </MasterTableView>
                                        </telerik:RadGrid>

                                        <asp:SqlDataSource ID="companyBenefitSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM Vw_Company_X_Plan_Benefits_Limits_New WHERE (([CompanyId] = @CompanyId) AND ([PlanID] = @PlanId) AND ([Benefit] LIKE '%' + @Benefit + '%')) ORDER BY Benefit">
                                            <%--<DeleteParameters>
                                                <asp:Parameter Name="CompanyId" Type="Int32" />
                                                <asp:Parameter Name="PlanId" Type="Int32" />
                                            </DeleteParameters>--%>
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="hfCompanyId" Name="CompanyId" PropertyName="Value" Type="Int32" ConvertEmptyStringToNull="false" />
                                                <asp:ControlParameter ControlID="hfPlanId" Name="PlanId" PropertyName="Value" Type="Int32" ConvertEmptyStringToNull="false" />
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

         <!-- edit modal -->
         <div class="modal fade" id="editmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Benefit Settings</h4>
                </div>
                        <div class="modal-body">
                            <div runat="server" id="lblBenefit" class="alert alert-info"></div>
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
                                    <telerik:RadNumericTextBox runat="server" ID="txtCoverLimit" Width="100%" Height="24px" MinValue="0"></telerik:RadNumericTextBox>
                                </div>
                            <div class="form-group">
                                    <label>Comment</label>
                                    <asp:TextBox runat="server" ID="txtCoverComment" Width="100%" TextMode="MultiLine" Rows="5"></asp:TextBox>
                                </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-success" OnClick="btnUpdate_Click" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

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

                            <div class="form-group">
                                  <label>Benefit</label>
                                  <telerik:RadComboBox ID="dlBenefitNew" runat="server" Width="100%" DataSourceID="BenefitSource" MaxHeight="200" EmptyMessage="Select Benefit" Filter="Contains"
                                           OnItemDataBound="dlBenefit_ItemDataBound" OnDataBound="dlBenefit_DataBound" OnItemsRequested="dlBenefit_ItemsRequested" EnableLoadOnDemand="true"
                                            OnClientItemsRequested="UpdateBenefitItemCountField" HighlightTemplatedItems="true" MarkFirstMatch="true" OnSelectedIndexChanged="dlBenefitNew_SelectedIndexChanged" AutoPostBack="true" >
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
                                  <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlBenefitNew" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                    <label>Status</label>
                                    <telerik:RadDropDownList runat="server" ID="dlCoverStatusNew" Width="100%">
                                        <Items>
                                            <telerik:DropDownListItem Text="Covered" />
                                            <telerik:DropDownListItem Text="Not Covered" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            <div class="form-group">
                                    <label>Limit</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtCoverLimitNew" Width="100%" Height="24px" MinValue="0" Value="0"></telerik:RadNumericTextBox>
                                </div>
                            <div class="form-group">
                                    <label>Comment</label>
                                    <asp:TextBox runat="server" ID="txtCoverCommentNew" Width="100%" TextMode="MultiLine" Rows="5"></asp:TextBox>
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
    <script type="text/javascript">
            function editModal() {
                $('#editmodal').modal('show');
            }
            function closeeditModal() {
                $('#editmodal').modal('hide');
            }
            function newModal() {
                $('#newmodal').modal('show');
            }
            function closenewModal() {
                $('#newmodal').modal('hide');
            }
    </script>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            //function UpdateCompanyItemCountField(sender, args) {
            //    //Set the footer text.
            //    sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            //}
            function UpdateBenefitItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
