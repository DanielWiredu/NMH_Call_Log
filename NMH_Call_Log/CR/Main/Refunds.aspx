<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="Refunds.aspx.cs" Inherits="NMH_Call_Log.CR.Main.Refunds" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/dist/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Member Refunds</h3>
            </div><!-- /.box-header -->
            <div class="box-body">
                <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="upMain">
                           <ProgressTemplate>
                            <div class="divWaiting">            
	                            <asp:Label ID="lblWait" runat="server" Text="Processing... " />
	                              <asp:Image ID="imgWait" runat="server" ImageAlign="Top" ImageUrl="/Content/dist/img/loader.gif" />
                                </div>
                             </ProgressTemplate>
                       </asp:UpdateProgress>

                <asp:UpdatePanel runat="server" ID="upMain">
                    <ContentTemplate>
                                        <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Company/ Member No / Member Name..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                       </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <%--<asp:Button runat="server" ID="btnAdd" CssClass="btn-primary" Text="Add New" CausesValidation="false" OnClientClick="newModal();"/>--%>  
                                            </div>
                                        </div>
                                    </div>
                        <hr />

                        <telerik:RadGrid ID="refundGrid" runat="server" AllowSorting="True" DataSourceID="refundSource" GroupPanelPosition="Top" OnItemCommand="refundGrid_ItemCommand">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="refundSource" AllowAutomaticDeletes="false" PageSize="50">
                                <Columns>
                                    <telerik:GridButtonColumn CommandName="Items" Text="Items" CommandArgument="Items">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle Font-Underline="true" ForeColor="Green" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridButtonColumn CommandName="Advice" Text="Advice" CommandArgument="Advice">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle Font-Underline="true" ForeColor="Orange" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" ReadOnly="True" SortExpression="Id" UniqueName="Id">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ClaimsBatchNo" FilterControlAltText="Filter ClaimsBatchNo column" HeaderText="BatchNo" SortExpression="ClaimsBatchNo" UniqueName="ClaimsBatchNo">
                                     <HeaderStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DateOfClaim" DataType="System.DateTime" FilterControlAltText="Filter DateOfClaim column" HeaderText="SubmissionDate" SortExpression="DateOfClaim" UniqueName="DateOfClaim" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ClaimsNo" FilterControlAltText="Filter ClaimsNo column" HeaderText="ClaimsNo" SortExpression="ClaimsNo" UniqueName="ClaimsNo">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MemberNo" FilterControlAltText="Filter MemberNo column" HeaderText="MemberNo" SortExpression="MemberNo" UniqueName="MemberNo">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MPhone" FilterControlAltText="Filter MPhone column" HeaderText="Phone No" SortExpression="MPhone" UniqueName="MPhone">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="FullName" FilterControlAltText="Filter FullName column" HeaderText="MemberName" SortExpression="FullName" UniqueName="FullName">
                                     <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DateofAttendance" DataType="System.DateTime" FilterControlAltText="Filter DateofAttendance column" HeaderText="DateofAttendance" SortExpression="DateofAttendance" UniqueName="DateofAttendance" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Company" FilterControlAltText="Filter Company column" HeaderText="Company" SortExpression="Company" UniqueName="Company">
                                     <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ProviderAmountClaimed" FilterControlAltText="Filter ProviderAmountClaimed column" HeaderText="AmountClaimed" SortExpression="ProviderAmountClaimed" UniqueName="ProviderAmountClaimed" DataFormatString="{0:0.00}">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SysAmountAwarded" FilterControlAltText="Filter SysAmountAwarded column" HeaderText="AmountAwarded" SortExpression="SysAmountAwarded" UniqueName="SysAmountAwarded" DataFormatString="{0:0.00}">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PaymentMode" FilterControlAltText="Filter PaymentMode column" HeaderText="PaymentMode" SortExpression="PaymentMode" UniqueName="PaymentMode">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MoMoNumber" FilterControlAltText="Filter MoMoNumber column" HeaderText="MoMoNumber" SortExpression="MoMoNumber" UniqueName="MoMoNumber">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MomoName" FilterControlAltText="Filter MomoName column" HeaderText="MomoName" SortExpression="MomoName" UniqueName="MomoName">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ChequeNo" FilterControlAltText="Filter ChequeNo column" HeaderText="ChequeNo" SortExpression="ChequeNo" UniqueName="ChequeNo">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ChequeAmount" FilterControlAltText="Filter ChequeAmount column" HeaderText="ChequeAmount" SortExpression="ChequeAmount" UniqueName="ChequeAmount">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RefundClaimStatus" FilterControlAltText="Filter RefundClaimStatus column" HeaderText="RefundClaimStatus" SortExpression="RefundClaimStatus" UniqueName="RefundClaimStatus">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                                        </telerik:RadGrid>

                                        <asp:SqlDataSource ID="refundSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT top(50) * FROM Vw_RefundHeader WHERE (Company LIKE '%' + @SearchValue + '%' OR MemberNo LIKE '%' + @SearchValue + '%' OR FullName LIKE '%' + @SearchValue + '%') ORDER BY StampDate DESC">
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


    <asp:HiddenField runat="server" ID="hfClaimNo" />

         <div class="modal fade" id="refundAdvicemodal">
    <div class="modal-dialog" style="width:70%">
            <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Refund Advice</h4>
                </div>
                        <div class="modal-body">
                            <div>
                                <telerik:RadGrid ID="refundAdviceGrid" ShowFooter="true" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowFilteringByColumn="False" AllowPaging="False" AllowSorting="False" CellSpacing="-1" GridLines="Both" DataSourceID="refundAdviceSource">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="300px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />

                                 <MasterTableView DataSourceID="refundAdviceSource">
                                     <Columns>
                                         <telerik:GridBoundColumn DataField="ClaimsNo" HeaderText="ClaimsNo" SortExpression="ClaimsNo" UniqueName="ClaimsNo">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Item" HeaderText="Item" SortExpression="Item" UniqueName="Item">
                                         <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridNumericColumn DataField="qty" HeaderText="Qty" SortExpression="qty" UniqueName="qty">
                                         <HeaderStyle Width="50px" />
                                         </telerik:GridNumericColumn>
                                          <telerik:GridNumericColumn DataField="Claimed" Aggregate="Sum" FooterText="Total : " HeaderText="Claimed" SortExpression="Claimed" UniqueName="Claimed" DataFormatString="{0:0.00}">
                                         <HeaderStyle Width="80px" />
                                         </telerik:GridNumericColumn>
                                         <telerik:GridNumericColumn DataField="ApprovedAmount" Aggregate="Sum" FooterText="Total : " HeaderText="ApprovedAmount" SortExpression="ApprovedAmount" UniqueName="ApprovedAmount" DataFormatString="{0:0.00}">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridNumericColumn>
                                         <telerik:GridBoundColumn DataField="Tariff_X_RejectionComments" HeaderText="Rejection Comment" SortExpression="Tariff_X_RejectionComments" UniqueName="Tariff_X_RejectionComments">
                                         <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="refundAdviceSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [VW_Refunds_Advice] WHERE [ClaimsNo] = @ClaimsNo">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hfClaimNo" Name="ClaimsNo" PropertyName="Value"/>
                    </SelectParameters>
                        </asp:SqlDataSource>
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

    <div class="modal fade" id="refundItemmodal">
    <div class="modal-dialog" style="width:70%">
            <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Refund Item(s)</h4>
                </div>
                        <div class="modal-body">
                            <div>
                                <telerik:RadGrid ID="refundItemGrid" ShowFooter="true" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowFilteringByColumn="False" AllowPaging="False" AllowSorting="False" CellSpacing="-1" GridLines="Both" DataSourceID="refundItemSource">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="300px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />

                                 <MasterTableView DataSourceID="refundItemSource">
                                     <Columns>
                                         <telerik:GridBoundColumn DataField="ClaimsNo" HeaderText="ClaimsNo" SortExpression="ClaimsNo" UniqueName="ClaimsNo">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="TariffName" HeaderText="Item" SortExpression="TariffName" UniqueName="TariffName">
                                         <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridNumericColumn DataField="qty" HeaderText="Qty" SortExpression="qty" UniqueName="qty">
                                         <HeaderStyle Width="50px" />
                                         </telerik:GridNumericColumn>
                                          <telerik:GridNumericColumn DataField="Claimed" Aggregate="Sum" FooterText="Total : " HeaderText="Claimed" SortExpression="Claimed" UniqueName="Claimed" DataFormatString="{0:0.00}">
                                         <HeaderStyle Width="80px" />
                                         </telerik:GridNumericColumn>
                                         <telerik:GridNumericColumn DataField="ApprovedAmount" Aggregate="Sum" FooterText="Total : " HeaderText="ApprovedAmount" SortExpression="ApprovedAmount" UniqueName="ApprovedAmount" DataFormatString="{0:0.00}">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridNumericColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="refundItemSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT ClaimsHeader.ClaimsNo, Tariff.TariffName, ClaimsDetails1.Qty, ClaimsDetails1.Claimed, ClaimsDetails1.ApprovedAmount, Tariff_X_RejectionComment.Tariff_X_RejectionComments FROM ClaimsHeader INNER JOIN ClaimsDetails1 ON ClaimsHeader.ClaimsNo = ClaimsDetails1.ClaimsNo INNER JOIN Tariff ON ClaimsDetails1.ProductID = Tariff.TariffID INNER JOIN Tariff_X_RejectionComment ON ClaimsDetails1.VettingID = Tariff_X_RejectionComment.Tariff_X_RejectionCommentID WHERE (ClaimsHeader.ClaimsNo = @ClaimsNo)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hfClaimNo" Name="ClaimsNo" PropertyName="Value"/>
                    </SelectParameters>
                        </asp:SqlDataSource>
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

    <script type="text/javascript">
        function showRefundAdviceModal() {
                $('#refundAdvicemodal').modal('show');
        }
        function showRefundItemModal() {
            $('#refundItemmodal').modal('show');
        }
    </script>
</asp:Content>
