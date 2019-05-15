<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="Benefits.aspx.cs" Inherits="NMH_Call_Log.CR.Company.Benefits" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title"> Benefits </h3>
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
                                            </div>
                                        </div>
                                    </div>
                        <hr />


                        <telerik:RadGrid ID="BenefitGrid" runat="server" AllowPaging="true" AllowSorting="True" DataSourceID="BenefitSource" GroupPanelPosition="Top" OnItemDeleted="BenefitGrid_ItemDeleted" OnItemCommand="BenefitGrid_ItemCommand">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false"  />
                            <GroupHeaderItemStyle BackColor="#36C93E" ForeColor="Black" Font-Bold="true" Width="50px" Font-Size="Medium" />
                            <MasterTableView AutoGenerateColumns="False" DataSourceID="BenefitSource" PageSize="50" GroupLoadMode="Server">
                                <GroupByExpressions>
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
                                    <telerik:GridBoundColumn Display="false" DataField="ID" DataType="System.Int32" FilterControlAltText="Filter ID column" HeaderText="ID" SortExpression="ID" UniqueName="ID">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Benefit" FilterControlAltText="Filter Benefit column" HeaderText="Benefit" SortExpression="Benefit" UniqueName="Benefit">
                                    
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn Display="false" DataField="BenefitGroupId" DataType="System.Int32" FilterControlAltText="Filter BenefitGroupId column" HeaderText="BenefitGroupId" SortExpression="BenefitGroupId" UniqueName="BenefitGroupId">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <%--<telerik:GridBoundColumn DataField="BenefitGroup" FilterControlAltText="Filter BenefitGroup column" HeaderText="BenefitGroup" SortExpression="BenefitGroup" UniqueName="BenefitGroup">
                                    <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>--%>

                                    <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" UniqueName="Edit" ButtonCssClass="btn-info" Text="Edit" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                    </telerik:GridButtonColumn>
                                    <%--<telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete this Benefit?" ButtonType="PushButton" ButtonCssClass="btn-danger" Exportable="false">
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridButtonColumn>--%>
                                </Columns>
                            </MasterTableView>
                                        </telerik:RadGrid>

                                        <asp:SqlDataSource ID="BenefitSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM Vw_Benefits WHERE (Benefit LIKE '%' + @Benefit + '%')">
                                            <SelectParameters>
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
                            <div class="form-group">
                                    <label>Benefit Group</label>
                                    <telerik:RadDropDownList runat="server" ID="dlBenefitGroup" Width="100%" DataSourceID="benefitGroupSource" DropDownHeight="250px" DataTextField="BenefitGroup" DataValueField="Id">
                                    </telerik:RadDropDownList>
                                    <asp:SqlDataSource ID="benefitGroupSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Id], [BenefitGroup] FROM [BenefitGroup]"></asp:SqlDataSource>
                                </div>
                            <div class="form-group">
                                <label>Benefit</label>
                                <asp:TextBox runat="server" ID="txtBenefit" Width="100%" TextMode="MultiLine" Rows="3"> </asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtBenefit" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
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
                            <div class="form-group">
                                    <label>Benefit Group</label>
                                    <telerik:RadDropDownList runat="server" ID="dlBenefitGroup1" Width="100%" DataSourceID="benefitGroupSource" DropDownHeight="250px" DataTextField="BenefitGroup" DataValueField="Id">
                                    </telerik:RadDropDownList>
                                </div>
                            <div class="form-group">
                                <label>Benefit</label>
                                <asp:TextBox runat="server" ID="txtBenefit1" Width="100%" TextMode="MultiLine" Rows="3"> </asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtBenefit1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
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
</asp:Content>
