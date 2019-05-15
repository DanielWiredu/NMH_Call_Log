<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="ClientRefunds.aspx.cs" Inherits="NMH_Call_Log.CR.Main.ClientRefunds" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/dist/css/telerikCombo.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Client Refunds</h3>
            </div><!-- /.box-header -->
            <div class="box-body">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                                        <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Company / Member Name..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                       </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAdd" CssClass="btn-primary" Text="Add New" CausesValidation="false" OnClientClick="newModal();"/>  
                                            </div>
                                        </div>
                                    </div>
                        <hr />

                        <telerik:RadGrid ID="refundGrid" runat="server" AllowSorting="True" DataSourceID="refundSource" GroupPanelPosition="Top" OnItemCommand="refundGrid_ItemCommand" OnItemDeleted="refundGrid_ItemDeleted">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="refundSource" AllowAutomaticDeletes="false" PageSize="100">
                                <Columns>
                                    <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" ReadOnly="True" SortExpression="Id" UniqueName="Id">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Company" FilterControlAltText="Filter Company column" HeaderText="Company" SortExpression="Company" UniqueName="Company">
                                     <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MemberName" FilterControlAltText="Filter MemberName column" HeaderText="MemberName" SortExpression="MemberName" UniqueName="MemberName">
                                     <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="BatchNo" FilterControlAltText="Filter BatchNo column" HeaderText="BatchNo" SortExpression="BatchNo" UniqueName="BatchNo">
                                     <HeaderStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SubmissionDate" DataType="System.DateTime" FilterControlAltText="Filter SubmissionDate column" HeaderText="SubmissionDate" SortExpression="SubmissionDate" UniqueName="SubmissionDate" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmountClaimed" FilterControlAltText="Filter AmountClaimed column" HeaderText="AmountClaimed" SortExpression="AmountClaimed" UniqueName="AmountClaimed">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PaymentMode" FilterControlAltText="Filter PaymentMode column" HeaderText="PaymentMode" SortExpression="PaymentMode" UniqueName="PaymentMode">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Status" FilterControlAltText="Filter Status column" HeaderText="Status" SortExpression="Status" UniqueName="Status">
                                     <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Outcome" FilterControlAltText="Filter Outcome column" HeaderText="Outcome" SortExpression="Outcome" UniqueName="Outcome">
                                     <HeaderStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn Display="false" DataField="OutcomeReason" FilterControlAltText="Filter OutcomeReason column" HeaderText="OutcomeReason" SortExpression="OutcomeReason" UniqueName="OutcomeReason">
                                     <HeaderStyle Width="120px" />
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

                                        <asp:SqlDataSource ID="refundSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM tblClientRefunds WHERE Id = @Id" SelectCommand="SELECT top(100) Id, Company, MemberName, BatchNo, SubmissionDate, AmountClaimed, PaymentMode, Status, Outcome, OutcomeReason, CreatedBy FROM vwClientRefunds WHERE (Company LIKE '%' + @SearchValue + '%' OR MemberName LIKE '%' + @SearchValue + '%') ORDER BY Id DESC">
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
                    <h4 class="modal-title">New Client Refund</h4>
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
                                <div class="row">
                                    <div class="col-md-6">
                                    <label>Member Name</label>
                                    <asp:TextBox runat="server" ID="txtMemberName" Width="100%" MaxLength="100"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtMemberName" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                                </div>
                            <div class="col-md-6">
                                    <label>Batch No</label>
                                    <asp:TextBox runat="server" ID="txtBatchNo" Width="100%" TextMode="Number"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtBatchNo" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                                </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                       <label>Submisstion Date</label>
                                       <telerik:RadDatePicker runat="server" ID="dpSubmissionDate" Width="100%" ></telerik:RadDatePicker>
                                       <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpSubmissionDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                                   </div>
                                    <div class="col-md-6">
                                        <label>Amount Claimed</label>
                                        <telerik:RadNumericTextBox ID="txtAmountClaimed" runat="server" Width="100%" MinValue="0" Value="0"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Payment Mode</label>
                                        <telerik:RadDropDownList ID="dlPaymentMode" runat="server" Width="100%">
                                            <Items>
                                                <telerik:DropDownListItem Text="Cheque" />
                                                <telerik:DropDownListItem Text="Mobile Money" />
                                            </Items>
                                    </telerik:RadDropDownList>
                                    </div>
                                    <div class="col-md-6">
                                        <label>Status</label>
                                        <telerik:RadDropDownList ID="dlStatus" runat="server" Width="100%">
                                            <Items>
                                                <telerik:DropDownListItem Text="Request for further documentation" />
                                                <telerik:DropDownListItem Text="Sent for Payment" />
                                                <telerik:DropDownListItem Text="Payment Withheld" />
                                            </Items>
                                    </telerik:RadDropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Outcome</label>
                                        <telerik:RadDropDownList ID="dlOutcome" runat="server" Width="100%">
                                            <Items>
                                                <telerik:DropDownListItem Text="Full Payment" />
                                                <telerik:DropDownListItem Text="Part Payment" />
                                                <telerik:DropDownListItem Text="Rejected" />
                                            </Items>
                                    </telerik:RadDropDownList>
                                    </div>
                                    <div class="col-md-6">
                                        <label>Outcome Reason(s)</label>
                                        <asp:TextBox runat="server" ID="txtOutcomeReason" Width="100%" TextMode="MultiLine" Rows="3"></asp:TextBox>
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
                    <h4 class="modal-title">Edit Client Refund</h4>
                </div>
                        <div class="modal-body">
                            <div class="alert alert-info" runat="server" id="lblCompany"></div>
                             
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                    <label>Member Name</label>
                                    <asp:TextBox runat="server" ID="txtMemberName1" Width="100%" MaxLength="100"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtMemberName1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                </div>
                            <div class="col-md-6">
                                    <label>Batch No</label>
                                    <asp:TextBox runat="server" ID="txtBatchNo1" Width="100%" TextMode="Number"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtBatchNo1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                       <label>Submisstion Date</label>
                                       <telerik:RadDatePicker runat="server" ID="dpSubmissionDate1" Width="100%" ></telerik:RadDatePicker>
                                       <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpSubmissionDate1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                   </div>
                                    <div class="col-md-6">
                                        <label>Amount Claimed</label>
                                        <telerik:RadNumericTextBox ID="txtAmountClaimed1" runat="server" Width="100%" MinValue="0" Value="0"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Payment Mode</label>
                                        <telerik:RadDropDownList ID="dlPaymentMode1" runat="server" Width="100%">
                                            <Items>
                                                <telerik:DropDownListItem Text="Cheque" />
                                                <telerik:DropDownListItem Text="Mobile Money" />
                                            </Items>
                                    </telerik:RadDropDownList>
                                    </div>
                                    <div class="col-md-6">
                                        <label>Status</label>
                                        <telerik:RadDropDownList ID="dlStatus1" runat="server" Width="100%">
                                            <Items>
                                                <telerik:DropDownListItem Text="Request for further documentation" />
                                                <telerik:DropDownListItem Text="Sent for Payment" />
                                                <telerik:DropDownListItem Text="Payment Withheld" />
                                            </Items>
                                    </telerik:RadDropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Outcome</label>
                                        <telerik:RadDropDownList ID="dlOutcome1" runat="server" Width="100%">
                                            <Items>
                                                <telerik:DropDownListItem Text="Full Payment" />
                                                <telerik:DropDownListItem Text="Part Payment" />
                                                <telerik:DropDownListItem Text="Rejected" />
                                            </Items>
                                    </telerik:RadDropDownList>
                                    </div>
                                    <div class="col-md-6">
                                        <label>Outcome Reason(s)</label>
                                        <asp:TextBox runat="server" ID="txtOutcomeReason1" Width="100%" TextMode="MultiLine" Rows="3"></asp:TextBox>
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
