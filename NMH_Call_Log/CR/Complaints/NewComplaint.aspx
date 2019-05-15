<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="NewComplaint.aspx.cs" Inherits="NMH_Call_Log.CR.Complaints.NewComplaint" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/dist/css/telerikCombo.css" rel="stylesheet" />
    <style type="text/css">
        .ncol1{
              margin: 0;
            padding: 0 5px 0 0;
            width: 20%;
            line-height: 14px;
            float: left;
        }
        .ncol2{
              margin: 0;
    padding: 0 5px 0 0;
    width: 40%;
    line-height: 14px;
    float: left;
        }
        .ncol3{
              margin: 0;
    padding: 0 5px 0 0;
    width: 20%;
    line-height: 14px;
    float: left;
        }
        .ncol4{
              margin: 0;
    padding: 0 5px 0 0;
    width: 20%;
    line-height: 14px;
    float: left;
        }
        .ncol5{
              margin: 0;
    padding: 0 5px 0 0;
    width: 15%;
    line-height: 14px;
    float: left;
        }
 
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">New Complaint </h3>
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
                                       <telerik:RadDateTimePicker runat="server" ID="dpDate" Width="100%" ></telerik:RadDateTimePicker>
                                       <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                   </div>
                                   <div class="col-md-3">
                                       <label>Contact No</label>
                                       <asp:TextBox runat="server" ID="txtCallerNo" Width="100%" TextMode="Phone"></asp:TextBox>
                                       <%--<asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtCallerNo" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>--%>
                                   </div>
                                   <div class="col-md-6">
                                       <label>Complainant Name</label>
                                       <asp:TextBox runat="server" ID="txtCallerName" Width="100%"></asp:TextBox>
                                       <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtCallerName" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                   </div>
                               </div>
                           </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                  <label>Company</label>
                                  <telerik:RadComboBox ID="dlCompany" runat="server" Width="100%" DataSourceID="companySource" MaxHeight="200" EmptyMessage="Select Company" Filter="Contains" AutoPostBack="true"
                                           OnItemDataBound="dlCompany_ItemDataBound" OnDataBound="dlCompany_DataBound" OnItemsRequested="dlCompany_ItemsRequested" EnableLoadOnDemand="true"
                                            OnClientItemsRequested="UpdateCompanyItemCountField" HighlightTemplatedItems="true" MarkFirstMatch="true" CausesValidation="false" >
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
                                  <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlCompany" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                             </div>
                                <%--<div class="col-md-3">
                                    <label  onclick="openMemberModal()">Member Details</label>
                                    <asp:RadioButton ID="rdMemberNo" onclick="openMemberModal()" runat="server" Width="100%" Text="Click Here" />
                                   
                                </div>--%>
                                <div class="col-md-9">
                                     <label>Member</label>
                                     <telerik:RadComboBox ID="dlMember" runat="server" Width="100%" DataSourceID="memberSource" MaxHeight="300" EmptyMessage="Select Member" Filter="Contains" OnSelectedIndexChanged="dlMember_SelectedIndexChanged" AutoPostBack="true"
                                           OnItemDataBound="dlMember_ItemDataBound" OnDataBound="dlMember_DataBound" OnItemsRequested="dlMember_ItemsRequested" EnableLoadOnDemand="true"
                                            OnClientItemsRequested="UpdateMemberItemCountField" HighlightTemplatedItems="true" MarkFirstMatch="true" CausesValidation="false" >
                                            <HeaderTemplate>
                <ul>
                     <li class="ncol1">MEMBER NO</li>
                    <li class="ncol2"> FULLNAME</li>
                    <li class="ncol3"> DOB</li>
                    <li class="ncol4"> STATUS</li>
                </ul>
            </HeaderTemplate>
            <ItemTemplate>
                <ul>
                     <li class="ncol1">
                        <%# DataBinder.Eval(Container.DataItem, "MemberNo")%></li>

                    <li class="ncol2">
                        <%# DataBinder.Eval(Container.DataItem, "FullName")%></li>
                    <li class="ncol3">
                        <%# DataBinder.Eval(Container.DataItem, "Dob2", "{0:dd-MMM-yyyy}")%></li>
                    <li class="ncol4">
                        <%# DataBinder.Eval(Container.DataItem, "Status")%></li>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                A total of
                <asp:Literal runat="server" ID="memberCount" />
                items
            </FooterTemplate>
                                        </telerik:RadComboBox>
                                        <asp:SqlDataSource ID="memberSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT top (100) ID, MemberNo, FullName, Dob2, Status FROM [VW_Members] WHERE CompanyID = @CompanyID">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="dlCompany" Name="CompanyID" PropertyName="SelectedValue" Type="Int32" DefaultValue="0"/>
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlMember" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                 </div>
                            </div>
                        </div> 
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                       <label>Contact Email</label>
                                       <asp:TextBox runat="server" ID="txtContactEmail" Width="100%"></asp:TextBox>
                                   </div>
                                <div class="col-md-3">
                                    <label>Source of Complaint</label>
                                    <telerik:RadDropDownList runat="server" ID="dlComplaintSource" Width="100%" >
                                        <Items>
                                            <telerik:DropDownListItem Text="Visitation" />
                                            <telerik:DropDownListItem Text="Email" />
                                            <telerik:DropDownListItem Text="Call" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                                <div class="col-md-3">
                                    <label>Complaint Type</label>
                                    <telerik:RadDropDownList runat="server" ID="dlComplaintType" Width="100%" DataSourceID="deptSource" DataTextField="Department" DataValueField="id"></telerik:RadDropDownList>
                                </div>
                                <div class="col-md-3">
                                    <label>Priority</label>
                                    <telerik:RadDropDownList runat="server" ID="dlPriority" Width="100%" >
                                        <Items>
                                            <telerik:DropDownListItem Text="High" />
                                            <telerik:DropDownListItem Text="Medium" />
                                            <telerik:DropDownListItem Text="Low" />
                                        </Items>
                                    </telerik:RadDropDownList>
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
                            <asp:Button runat="server" ID="btnReturn" CssClass="btn btn-warning" Text="Return" PostBackUrl="~/CR/Complaints/Complaints.aspx" CausesValidation="false" />
                            <asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-primary" Text="Add New" OnClick="btnAddNew_Click" CausesValidation="false" />
                            <asp:Button runat="server" ID="btnEscalate" CssClass="btn btn-info" Text="Referral" Enabled="false" OnClientClick="openEscalateModal()" CausesValidation="false" />
                            <asp:Button runat="server" ID="btnResolve" CssClass="btn btn-danger" Text="Resolution" OnClientClick="openResolveModal()" CausesValidation="false" />
                            <asp:Button runat="server" ID="btnSave" CssClass="btn btn-success" Text="Save" OnClick="btnSave_Click" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </div><!-- /.box-body -->
         
          </div><!-- /.box -->

    <!-- nmh member modal -->
         <%--<div class="modal fade" id="membermodal">
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
         </div>--%>

    <!-- escalate modal -->
         <div class="modal fade" id="escalatemodal">
    <div class="modal-dialog" style="width:50%">
        <asp:Panel runat="server" DefaultButton="btnSaveEscalate">
                    <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Referral</h4>
                </div>
                        <div class="modal-body">
                            <div class="alert alert-info" runat="server" id="lblEscalate">NOT REFERRED</div>
                             <div class="form-group">
                                        <label>Refer To</label>
                                       <telerik:RadDropDownList runat="server" ID="dlDepartment" Width="100%" DataSourceID="deptSource" DataTextField="Department" DataValueField="id" DefaultMessage="Select Department">
                                    </telerik:RadDropDownList>
                                 <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlDepartment" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="escalate"></asp:RequiredFieldValidator>
                                    <asp:SqlDataSource ID="deptSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [id], [Department] FROM [tblDepartment]"></asp:SqlDataSource>
                             </div>
                            <%--<div class="form-group">
                                        <label>Status</label>
                                       <telerik:RadDropDownList runat="server" ID="dlEscalateStatus" Width="100%" DefaultMessage="Select Status" >
                                           <Items>
                                               <telerik:DropDownListItem Text="Pending" />
                                               <telerik:DropDownListItem Text="Completed" />
                                           </Items>
                                    </telerik:RadDropDownList>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlEscalateStatus" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="escalate"></asp:RequiredFieldValidator>
                             </div>--%>
                            <div class="form-group">
                                    <label>Comment</label>
                                    <asp:TextBox runat="server" ID="txtEscalateComment" Width="100%" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                </div>
                            <div class="form-group">
                                       <label>Referral Date</label>
                                       <telerik:RadDateTimePicker runat="server" ID="dpEscalationDate" Width="100%" ></telerik:RadDateTimePicker>
                                       <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpEscalationDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="escalate"></asp:RequiredFieldValidator>
                                   </div>
                            <div class="form-group">
                                       <label>Feedback Date</label>
                                       <telerik:RadDateTimePicker runat="server" ID="dpFeedbackDate" Width="100%" ></telerik:RadDateTimePicker>
                                       <%--<asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpFeedbackDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="escalate"></asp:RequiredFieldValidator>--%>
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

    
    <!-- resolution modal -->
         <div class="modal fade" id="resolvemodal">
    <div class="modal-dialog" style="width:50%">
        <asp:Panel runat="server" DefaultButton="btnSaveResolution">
                    <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Resolution</h4>
                </div>
                        <div class="modal-body">
                            <div class="alert alert-info" runat="server" id="lblResolve">NOT RESOLVED</div>
                            <div class="form-group">
                                    <label>Final Resolution</label>
                                    <asp:TextBox runat="server" ID="txtFinalResolution" Width="100%" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                </div>
                            <div class="form-group">
                                       <label>Resolution Date</label>
                                       <telerik:RadDateTimePicker runat="server" ID="dpResolutionDate" Width="100%" ></telerik:RadDateTimePicker>
                                       <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpResolutionDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="resolve"></asp:RequiredFieldValidator>
                                   </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveResolution" runat="server" Text="Save" CssClass="btn btn-success" ValidationGroup="resolve" OnClick="btnSaveResolution_Click" />
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

            $('#membermodal').on('shown.bs.modal', function () {
                $('#txtMemberNo').focus();
            });

            function closeMemberModal() {
                $('#membermodal').modal('hide');
            }
            function openEscalateModal() {
                $('#escalatemodal').modal('show');
            }
            function closeEscalateModal() {
                $('#escalatemodal').modal('hide');
            }
            function openResolveModal() {
                $('#resolvemodal').modal('show');
            }
            function closeResolveModal() {
                $('#resolvemodal').modal('hide');
            }
    </script>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function UpdateCompanyItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
            function UpdateMemberItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
