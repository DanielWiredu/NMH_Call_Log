<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="EditCallLog.aspx.cs" Inherits="NMH_Call_Log.Main.EditCallLog" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="/Content/dist/css/telerikCombo.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Edit Call </h3>
              <%--<div class="box-tools pull-right">
                <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                <button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
              </div>--%>
            </div><!-- /.box-header -->
            <div class="box-body">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                           <div class="form-group">
                               <div class="row">
                                   <div class="col-md-3">
                                       <label>Date</label>
                                       <telerik:RadDateTimePicker runat="server" ID="dpDate" Width="100%" Enabled="false" ></telerik:RadDateTimePicker>
                                       <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                   </div>
                                   <div class="col-md-3">
                                       <label>Caller No</label>
                                       <asp:TextBox runat="server" ID="txtCallerNo" Width="100%" TextMode="Number"></asp:TextBox>
                                       <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtCallerNo" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                   </div>
                                   <div class="col-md-6">
                                       <label>Caller Name</label>
                                       <asp:TextBox runat="server" ID="txtCallerName" Width="100%"></asp:TextBox>
                                       <%--<asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtCallerName" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>--%>
                                   </div>
                               </div>
                           </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <label onclick="openMemberModal()">Caller Type</label>
                                    <asp:RadioButtonList runat="server" ID="rdCallerType" AutoPostBack="true" RepeatDirection="Horizontal" OnSelectedIndexChanged="rdCallerType_SelectedIndexChanged">
                                        <asp:ListItem Text="Non NMH Member" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="NMH Member" Value="1"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="col-md-3">
                                    <label>Type of Call</label>
                                    <telerik:RadDropDownList runat="server" ID="dlCallType" Width="100%">
                                        <Items>
                                            <telerik:DropDownListItem Text="Enquiry" />
                                            <telerik:DropDownListItem Text="Request" />
                                            <telerik:DropDownListItem Text="Complaint" />
                                            <telerik:DropDownListItem Text="Drop Call" />
                                            <telerik:DropDownListItem Text="Live Chat" />
                                            <telerik:DropDownListItem Text="Whatsapp Chat" />
					                        <telerik:DropDownListItem Text="Outbound" />
                                            <telerik:DropDownListItem Text="MYH Registration" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                                <div class="col-md-3">
                                    <label>Service Type</label>
                                    <telerik:RadDropDownList runat="server" ID="dlServiceType" Width="100%" DataSourceID="servicetypeSource" DataTextField="ServiceType" DataValueField="id" AutoPostBack="true" CausesValidation="false" DefaultMessage="Select Service Type">
                                    </telerik:RadDropDownList>
                                    <asp:SqlDataSource ID="servicetypeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [id], [ServiceType] FROM [tblServiceType]"></asp:SqlDataSource>
                                </div>
                                <div class="col-md-3">
                                    <label>Reason of Call</label>
                                    <telerik:RadDropDownList runat="server" ID="dlCallReason" Width="100%" DataSourceID="callreasonSource" DataTextField="CallReason" DataValueField="id" DefaultMessage="Select Call Reason">
                                    </telerik:RadDropDownList>
                                    <asp:SqlDataSource ID="callreasonSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [id], [CallReason] FROM [tblCallReason] WHERE ([ServiceTypeId] = @ServiceTypeId)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="dlServiceType" DefaultValue="0" Name="ServiceTypeId" PropertyName="SelectedValue" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>
                        </div> 
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-6">
                                    <label>Location</label>
                                    <asp:TextBox runat="server" ID="txtLocation" Width="100%"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label>Facility</label>
                                    <telerik:RadComboBox ID="dlProvider" runat="server" Width="100%" DataSourceID="providerSource" MaxHeight="200" EmptyMessage="Select Provider" Filter="Contains"
                                           OnItemDataBound="dlProvider_ItemDataBound" OnDataBound="dlProvider_DataBound" OnItemsRequested="dlProvider_ItemsRequested" EnableLoadOnDemand="true"
                                            OnClientItemsRequested="UpdateProviderItemCountField" HighlightTemplatedItems="true" MarkFirstMatch="true"  >
                                            <HeaderTemplate>
                <ul>
                    <li class="ncolfull">PROVIDER</li>
                </ul>
            </HeaderTemplate>
            <ItemTemplate>
                <ul>
                    <li class="ncolfull">
                        <%# DataBinder.Eval(Container.DataItem, "ServiceProvider")%></li>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                A total of
                <asp:Literal runat="server" ID="providerCount" />
                items
            </FooterTemplate>
                                        </telerik:RadComboBox>
                                        <asp:SqlDataSource ID="providerSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT top (30) ID, ServiceProvider FROM [ServiceProviders]"></asp:SqlDataSource>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-6">
                                    <label>Description</label>
                                    <asp:TextBox runat="server" ID="txtDescription" Width="100%" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label>Comment</label>
                                    <asp:TextBox runat="server" ID="txtComment" Width="100%" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                </div>
                            </div>
                        </div>           
                        <div class="modal-footer">
                            <asp:Button runat="server" ID="btnReturn" CssClass="btn btn-warning" Text="Return" PostBackUrl="~/Main/CallLog.aspx" CausesValidation="false" />
                            <asp:Button runat="server" ID="btnFollowUp" CssClass="btn btn-success" Text="Save Follow Up" OnClick="btnFollowUp_Click" CausesValidation="false" />
                            <asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-primary" Text="Add New" OnClick="btnAddNew_Click" CausesValidation="false" />
                            <asp:Button runat="server" ID="btnEscalate" CssClass="btn btn-info" Text="Escalate" OnClientClick="openEscalateModal()" CausesValidation="false" />
                            <asp:Button runat="server" ID="btnSave" CssClass="btn btn-success" Text="Update" OnClick="btnSave_Click" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </div><!-- /.box-body -->
         
          </div><!-- /.box -->

    <!-- nmh member modal -->
         <div class="modal fade" id="membermodal">
    <div class="modal-dialog" style="width:50%">
        <asp:Panel runat="server" DefaultButton="btnFind">
                    <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">NMH Member</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label>Member No</label>
                                       <asp:TextBox runat="server" ID="txtMemberNo" Width="100%" MaxLength="50"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtMemberNo" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="member"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                        <label>Member Name</label>
                                       <asp:TextBox runat="server" ID="txtMemberName" Width="100%" ReadOnly="true"></asp:TextBox>
                             </div>
                            <div class="form-group">
                                        <label>Company</label>
                                       <asp:TextBox runat="server" ID="txtMemberCompany" Width="100%" ReadOnly="true"></asp:TextBox>
                             </div>
                            <div class="form-group">
                                        <label>Plan</label>
                                       <asp:TextBox runat="server" ID="txtMemberPlan" Width="100%" ReadOnly="true"></asp:TextBox>
                             </div>
                            <div class="form-group">
                                        <label>Status</label>
                                       <asp:TextBox runat="server" ID="txtMemberStatus" Width="100%" ReadOnly="true"></asp:TextBox>
                             </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnFind" runat="server" Text="Find" CssClass="btn btn-success" ValidationGroup="member" OnClick="btnFind_Click" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </asp:Panel>
        </div>
         </div>

    <!-- escalate modal -->
         <div class="modal fade" id="escalatemodal">
    <div class="modal-dialog" style="width:50%">
        <asp:Panel runat="server" DefaultButton="btnSaveEscalate">
                    <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Escalation</h4>
                </div>
                        <div class="modal-body">
                            <div class="alert alert-info" runat="server" id="lblEscalate">NOT ESCALATED</div>
                             <div class="form-group">
                                        <label>Escalate To</label>
                                       <telerik:RadDropDownList runat="server" ID="dlDepartment" Width="100%" DataSourceID="deptSource" DataTextField="Department" DataValueField="id" DefaultMessage="Select Department">
                                    </telerik:RadDropDownList>
                                 <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlDepartment" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="escalate"></asp:RequiredFieldValidator>
                                    <asp:SqlDataSource ID="deptSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [id], [Department] FROM [tblDepartment]"></asp:SqlDataSource>
                             </div>
                            <div class="form-group">
                                        <label>Status</label>
                                       <telerik:RadDropDownList runat="server" ID="dlEscalateStatus" Width="100%" DefaultMessage="Select Status" >
                                           <Items>
                                               <telerik:DropDownListItem Text="Pending" />
                                               <telerik:DropDownListItem Text="Completed" />
                                           </Items>
                                    </telerik:RadDropDownList>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtCallerNo" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="escalate"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                    <label>Comment</label>
                                    <asp:TextBox runat="server" ID="txtEscalateComment" Width="100%" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveEscalate" runat="server" Text="Save" CssClass="btn btn-success" ValidationGroup="escalate" OnClick="btnSaveEscalate_Click" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </asp:Panel>
        </div>
         </div>

        <script type="text/javascript">
            function openMemberModal() {
                $('#membermodal').modal('show');
            }
            function closeMemberModal() {
                $('#membermodal').modal('hide');
            }
            function openEscalateModal() {
                $('#escalatemodal').modal('show');
            }
            function closeEscalateModal() {
                $('#escalatemodal').modal('hide');
            }
    </script>

     <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function UpdateProviderItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
