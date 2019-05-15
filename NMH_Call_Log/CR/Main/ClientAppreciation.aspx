<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="ClientAppreciation.aspx.cs" Inherits="NMH_Call_Log.CR.Main.ClientAppreciation" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Client Appreciation</h3>
            </div><!-- /.box-header -->
            <div class="box-body">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                                        <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Criteria / AwardType..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                       </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAdd" CssClass="btn-primary" Text="Add New" CausesValidation="false" OnClientClick="newModal();"/>  
                                            </div>
                                        </div>
                                    </div>
                        <hr />

                        <telerik:RadGrid ID="rewardGrid" runat="server" AllowSorting="True" DataSourceID="rewardSource" GroupPanelPosition="Top" OnItemCommand="rewardGrid_ItemCommand" OnItemDeleted="rewardGrid_ItemDeleted">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="rewardSource" AllowAutomaticDeletes="false" PageSize="100">
                                <Columns>
                                    <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" ReadOnly="True" SortExpression="Id" UniqueName="Id">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RewardType" FilterControlAltText="Filter RewardType column" HeaderText="RewardType" SortExpression="RewardType" UniqueName="RewardType">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Names" FilterControlAltText="Filter Names column" HeaderText="Names" SortExpression="Names" UniqueName="Names">
                                     <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Criteria" FilterControlAltText="Filter Criteria column" HeaderText="Criteria" SortExpression="Criteria" UniqueName="Criteria">
                                     <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AwardType" FilterControlAltText="Filter AwardType column" HeaderText="AwardType" SortExpression="AwardType" UniqueName="AwardType">
                                     <HeaderStyle Width="150px" />
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

                                        <asp:SqlDataSource ID="rewardSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM tblClientAppreciation WHERE Id = @Id" SelectCommand="SELECT top(100) Id, RewardType, Names, Criteria, AwardType, CreatedBy FROM tblClientAppreciation WHERE (Criteria LIKE '%' + @SearchValue + '%' OR AwardType LIKE '%' + @SearchValue + '%') ORDER BY Id DESC">
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
                    <h4 class="modal-title">New Client Appreciation</h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Appreciation For</label>
                                <telerik:RadDropDownList ID="dlRewardType" runat="server" Width="100%">
                                    <Items>
                                        <telerik:DropDownListItem Text="Corporate" />
                                        <telerik:DropDownListItem Text="Individual" />
                                    </Items>
                                </telerik:RadDropDownList>
                            </div>
                            
                            <div class="form-group">
                                    <label>Name(s) of Receipients</label>
                                    <asp:TextBox runat="server" ID="txtNames" Width="100%" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtNames" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                                </div>
                            <div class="form-group">
                                    <label>Criteria</label>
                                    <asp:TextBox runat="server" ID="txtCriteria" Width="100%" MaxLength="50"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtCriteria" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                                </div>
                            <div class="form-group">
                                    <label>Type of Award</label>
                                    <asp:TextBox runat="server" ID="txtAwardType" Width="100%" MaxLength="50"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtAwardType" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
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
                    <h4 class="modal-title">Edit Client Appreciation</h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Appreciation For</label>
                                <telerik:RadDropDownList ID="dlRewardType1" runat="server" Width="100%">
                                    <Items>
                                        <telerik:DropDownListItem Text="Corporate" />
                                        <telerik:DropDownListItem Text="Individual" />
                                    </Items>
                                </telerik:RadDropDownList>
                            </div>
                            
                            <div class="form-group">
                                    <label>Name(s) of Receipients</label>
                                    <asp:TextBox runat="server" ID="txtNames1" Width="100%" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtNames1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                </div>
                            <div class="form-group">
                                    <label>Criteria</label>
                                    <asp:TextBox runat="server" ID="txtCriteria1" Width="100%" MaxLength="50"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtCriteria1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                </div>
                            <div class="form-group">
                                    <label>Type of Award</label>
                                    <asp:TextBox runat="server" ID="txtAwardType1" Width="100%" MaxLength="50"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtAwardType1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
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
