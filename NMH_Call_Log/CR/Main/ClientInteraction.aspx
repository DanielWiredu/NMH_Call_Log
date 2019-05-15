<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="ClientInteraction.aspx.cs" Inherits="NMH_Call_Log.CR.Main.ClientInteraction" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Client Interaction</h3>
            </div><!-- /.box-header -->
            <div class="box-body">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                                        <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Venue / Company..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                       </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAdd" CssClass="btn-primary" Text="Add New" CausesValidation="false" OnClientClick="newModal();"/>  
                                            </div>
                                        </div>
                                    </div>
                        <hr />

                        <telerik:RadGrid ID="eventGrid" runat="server" AllowSorting="True" DataSourceID="eventSource" GroupPanelPosition="Top" OnItemCommand="eventGrid_ItemCommand" OnItemDeleted="eventGrid_ItemDeleted">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="eventSource" AllowAutomaticDeletes="false" PageSize="100">
                                <Columns>
                                    <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" ReadOnly="True" SortExpression="Id" UniqueName="Id">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EventDate" DataType="System.DateTime" FilterControlAltText="Filter EventDate column" HeaderText="EventDate" SortExpression="EventDate" UniqueName="EventDate" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Venue" FilterControlAltText="Filter Venue column" HeaderText="Venue" SortExpression="Venue" UniqueName="Venue">
                                     <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Participants" FilterControlAltText="Filter Participants column" HeaderText="Participants" SortExpression="Participants" UniqueName="Participants">
                                     <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Issues" FilterControlAltText="Filter Issues column" HeaderText="Issues" SortExpression="Issues" UniqueName="Issues">
                                     <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Recommendations" FilterControlAltText="Filter Recommendations column" HeaderText="Recommendations" SortExpression="Recommendations" UniqueName="Recommendations">
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

                                        <asp:SqlDataSource ID="eventSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM tblClientInteraction WHERE Id = @Id" SelectCommand="SELECT top(100) Id, EventDate, Venue, Participants, Issues, Recommendations, CreatedBy FROM tblClientInteraction WHERE (Venue LIKE '%' + @SearchValue + '%' OR Participants LIKE '%' + @SearchValue + '%') ORDER BY Id DESC">
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
                    <h4 class="modal-title">New Client Service</h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Event Date</label>
                                <telerik:RadDatePicker ID="dpEventDate" runat="server" Width="100%"></telerik:RadDatePicker>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpEventDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                            </div>
                            
                            <div class="form-group">
                                    <label>Venue</label>
                                    <asp:TextBox runat="server" ID="txtVenue" Width="100%" MaxLength="100"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtVenue" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                                </div>
                            <div class="form-group">
                                    <label>List of Participants</label>
                                    <asp:TextBox runat="server" ID="txtParticipants" Width="100%" MaxLength="500" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtParticipants" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                                </div>
                            <div class="form-group">
                                    <label>Issues</label>
                                    <asp:TextBox runat="server" ID="txtIssues" Width="100%" MaxLength="500" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                </div>
                            <div class="form-group">
                                    <label>Recommendations</label>
                                    <asp:TextBox runat="server" ID="txtRecommendations" Width="100%" MaxLength="500" TextMode="MultiLine" Rows="3"></asp:TextBox>
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
                    <h4 class="modal-title">Edit Client Service</h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Event Date</label>
                                <telerik:RadDatePicker ID="dpEventDate1" runat="server" Width="100%"></telerik:RadDatePicker>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpEventDate1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                    <label>Venue</label>
                                    <asp:TextBox runat="server" ID="txtVenue1" Width="100%" MaxLength="100"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtVenue1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                </div>
                            <div class="form-group">
                                    <label>List of Participants</label>
                                    <asp:TextBox runat="server" ID="txtParticipants1" Width="100%" MaxLength="500" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtParticipants1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                </div>
                            <div class="form-group">
                                    <label>Issues</label>
                                    <asp:TextBox runat="server" ID="txtIssues1" Width="100%" MaxLength="500" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                </div>
                            <div class="form-group">
                                    <label>Recommendations</label>
                                    <asp:TextBox runat="server" ID="txtRecommendations1" Width="100%" MaxLength="500" TextMode="MultiLine" Rows="3"></asp:TextBox>
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
