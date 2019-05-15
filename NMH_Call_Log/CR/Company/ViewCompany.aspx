<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="ViewCompany.aspx.cs" Inherits="NMH_Call_Log.CR.Company.ViewCompany" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Main content -->
    <section class="content">

      <!-- SELECT2 EXAMPLE -->
      <div class="box box-info">
        <div class="box-header with-border">
          <h3 class="box-title" runat="server" id="hdCompany" style="font-weight:bold">Company Details</h3>

          <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
          </div>
        </div>

        <!-- /.box-header -->
        <div class="box-body">
           <asp:UpdatePanel runat="server" >
               <ContentTemplate>
                             <asp:HiddenField runat="server" ID="hfCompanyId" />
                    <div class="row">
                        <div class="col-md-6">
                    <div class="form-horizontal">
                        <div class="form-group">
                                    <label class="col-sm-4 control-label">Initial Join Date</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDatePicker ID="dpJoinDate" runat="server" Width="100%" Enabled="false" MinDate="1/1/1850"></telerik:RadDatePicker>
                                    </div>
                                </div>
                        <div class="form-group">
                                    <label class="col-sm-4 control-label">Start Date</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDatePicker ID="dpStartDate" runat="server" Width="100%" Enabled="false" MinDate="1/1/1850"></telerik:RadDatePicker>
                                    </div>
                                </div>
                        <div class="form-group">
                                    <label class="col-sm-4 control-label">Expiry Date</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDatePicker ID="dpExpiryDate" runat="server" Width="100%" Enabled="false" MinDate="1/1/1850"></telerik:RadDatePicker>
                                    </div>
                                </div>
                        <div class="form-group">
                                    <label class="col-sm-4 control-label">Postal Address</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtPostalAddress" runat="server" Width="100%" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                    </div>
                                </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-horizontal">
                        <div class="form-group">
                                    <label class="col-sm-4 control-label">Contact Person</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtContactPerson" runat="server" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                        <div class="form-group">
                                    <label class="col-sm-4 control-label">Contact Number</label>
                                    <div class="col-sm-8">
                                       <asp:TextBox ID="txtContactNumber" runat="server" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Email</label>
                                    <div class="col-sm-8">
                                       <asp:TextBox ID="txtEmail" runat="server" Width="100%" ></asp:TextBox>
                                    </div>
                                </div>
                        
                        <div class="form-group">
                                    <label class="col-sm-4 control-label">Company Phone</label>
                                    <div class="col-sm-8">
                                       <asp:TextBox ID="txtCompanyPhone" runat="server" Width="100%" ></asp:TextBox>
                                    </div>
                                </div>
                        <div class="form-group">
                                    <label class="col-sm-4 control-label">Concession</label>
                                    <div class="col-sm-8">
                                        <asp:CheckBox ID="chkConcession" runat="server" Width="100%" />
                                    </div>
                                </div>
                        
                    </div>
                </div>
        </div>
            
        <div class="modal-footer">
            <asp:Button runat="server" CssClass="btn btn-warning" Text="Return" PostBackUrl="~/CR/Company/CompanyList.aspx" CausesValidation="false" />
            <asp:Button ID="btnUpdateCompany" runat="server" CssClass="btn btn-success" Text="Save Changes" OnClick="btnUpdateCompany_Click" OnClientClick="if (Page_IsValid) {this.value='Processing...';this.disabled=true; }" UseSubmitBehavior="false" />
        </div>
               </ContentTemplate>
           </asp:UpdatePanel>
        <!-- /.box-body -->
      </div>
      <!-- /.box -->

      <div class="row">
        <div class="col-md-6">

          <div class="box box-danger">
            <div class="box-header">
              <h3 class="box-title">Policies</h3>
            </div>
            <div class="box-body">
                <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <telerik:RadGrid ID="companyPolicyGrid" runat="server" DataSourceID="companyPolicySource" GroupPanelPosition="Top" OnItemCommand="companyPolicyGrid_ItemCommand">
                    <ClientSettings>
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="True" UseStaticHeaders="true" ScrollHeight="200px" />
                    </ClientSettings>
                    <MasterTableView AutoGenerateColumns="false"  PageSize="50" DataSourceID="companyPolicySource">
                                <Columns>
                                    <telerik:GridButtonColumn Text="Edit" CommandName="Edit" UniqueName="Edit" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle Font-Underline="true" ForeColor="Green" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridBoundColumn DataField="RowId" Display="false" DataType="System.Int32" HeaderText="RowId" SortExpression="RowId" UniqueName="RowId">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PolicyCode" HeaderText="PolicyCode" SortExpression="PolicyCode" UniqueName="PolicyCode">
                                    <HeaderStyle Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PolicyStartDate" HeaderText="PolicyStartDate" SortExpression="PolicyStartDate" UniqueName="PolicyStartDate" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PolicyEndDate" HeaderText="PolicyEndDate" SortExpression="PolicyEndDate" UniqueName="PolicyEndDate" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PolicyStatus" HeaderText="PolicyStatus" SortExpression="PolicyStatus" UniqueName="PolicyStatus" EmptyDataText="">
                                     <HeaderStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Premium" HeaderText="Premium" SortExpression="Premium" UniqueName="Premium" DataFormatString="{0:N2}" EmptyDataText="0.00">
                                    <HeaderStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Comments" HeaderText="Comments" SortExpression="Comments" UniqueName="Comments" EmptyDataText="">
                                    <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                </telerik:RadGrid>

                <asp:SqlDataSource ID="companyPolicySource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT RowId, PolicyCode, PolicyStartDate, PolicyEndDate, PolicyStatus, Premium, Comments FROM [Vw_CompanyPolicy] WHERE (CompanyID = @CompanyID) ORDER BY RowId DESC">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hfCompanyId" DefaultValue="0" Name="CompanyID" PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnUpdatePolicy" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>

            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->

        </div>
        <!-- /.col (left) -->
        <div class="col-md-6">
          <div class="box box-primary">
            <div class="box-header">
              <h3 class="box-title">Plans</h3>
            </div>
            <div class="box-body">

                <telerik:RadGrid ID="companyPlanGrid" runat="server" DataSourceID="companyPlanSource" GroupPanelPosition="Top">
                    <ClientSettings>
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="200px" />
                    </ClientSettings>
                    <MasterTableView AutoGenerateColumns="false"  PageSize="50" DataSourceID="companyPlanSource">
                                <Columns>
                                    <telerik:GridBoundColumn Display="false" DataField="PlanId" DataType="System.Int32" FilterControlAltText="Filter PlanId column" HeaderText="PlanId" ReadOnly="True" SortExpression="PlanId" UniqueName="PlanId">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Plans" FilterControlAltText="Filter Plans column" HeaderText="Plans" SortExpression="Plans" UniqueName="Plans">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                </telerik:RadGrid>
                <asp:SqlDataSource ID="companyPlanSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT PlanID, Plans FROM Vw_Company_X_Plan_Benefits_Limits_New WHERE (CompanyID = @CompanyID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hfCompanyId" DefaultValue="0" Name="CompanyID" Type="Int32" PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->

          <!-- /.box -->
        </div>
        <!-- /.col (right) -->
      </div>
      <!-- /.row -->

        <div class="row">
            <div class="col-md-6">
                <div class="box box-success">
            <div class="box-header">
              <h3 class="box-title">Assigned CR Offcer</h3>
            </div>
            <div class="box-body">

                <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <telerik:RadGrid ID="crOfficerGrid" runat="server" AllowAutomaticDeletes="true" DataSourceID="crOfficerSource" GroupPanelPosition="Top" OnItemDeleted="crOfficerGrid_ItemDeleted" OnItemCommand="crOfficerGrid_ItemCommand">
                    <ClientSettings>
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="200px" />
                    </ClientSettings>
                    <MasterTableView AutoGenerateColumns="false"  PageSize="50" DataSourceID="crOfficerSource" AllowAutomaticDeletes="true" CommandItemDisplay="Top" DataKeyNames="Id">
                                <Columns>
                                    <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" HeaderText="Id" SortExpression="id" UniqueName="Id">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CROfficerName" HeaderText="CROfficerName" SortExpression="CROfficerName" UniqueName="CROfficerName" EmptyDataText="">
                                    <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DateAssigned" HeaderText="DateAssigned" SortExpression="DateAssigned" UniqueName="DateAssigned" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridCheckBoxColumn DataField="Active" DataType="System.Boolean" FilterControlAltText="Filter Active column" HeaderText="A" SortExpression="Active" UniqueName="Active" StringTrueValue="1" StringFalseValue="0" >
                                         <HeaderStyle Width="30px" />
                                         </telerik:GridCheckBoxColumn>
                                    <telerik:GridButtonColumn CommandName="Delete" Text="Delete" CommandArgument="Delete" UniqueName="Delete" ConfirmText="Delete this record?">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle Font-Underline="true" ForeColor="Red" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                </telerik:RadGrid>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSaveCROfficer" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
                <asp:SqlDataSource ID="crOfficerSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id, CROfficerName, DateAssigned, Active FROM [vwCompanyCROfficer] WHERE (CompanyId = @CompanyId) ORDER BY DateAssigned DESC" DeleteCommand="DELETE FROM tblCompanyCROfficer WHERE Id = @Id">
                    <DeleteParameters>
                      <asp:Parameter Name="Id" Type="Int32" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hfCompanyId" DefaultValue="0" Name="CompanyId" PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

            </div>
            <!-- /.box-body -->
          </div>
            </div>
            <div class="col-md-6">
                <div class="box box-primary">
            <div class="box-header">
              <h3 class="box-title">Contact Persons</h3>
            </div>
            <div class="box-body">

                <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <telerik:RadGrid ID="companyContactGrid" runat="server" AllowAutomaticDeletes="true" DataSourceID="companyContactSource" GroupPanelPosition="Top" OnItemDeleted="companyContactGrid_ItemDeleted" OnItemCommand="companyContactGrid_ItemCommand">
                    <ClientSettings>
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="200px" />
                    </ClientSettings>
                    <MasterTableView AutoGenerateColumns="false"  PageSize="50" DataSourceID="companyContactSource" AllowAutomaticDeletes="true" CommandItemDisplay="Top" DataKeyNames="Id">
                                <Columns>
                                    <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" HeaderText="Id" SortExpression="id" UniqueName="Id">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ContactName" HeaderText="ContactName" SortExpression="ContactName" UniqueName="ContactName" EmptyDataText="">
                                    <HeaderStyle Width="140px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ContactNo" HeaderText="ContactNo" SortExpression="ContactNo" UniqueName="ContactNo" EmptyDataText="">
                                    <HeaderStyle Width="140px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmailAddress" HeaderText="EmailAddress" SortExpression="EmailAddress" UniqueName="EmailAddress" EmptyDataText="">
                                    <HeaderStyle Width="140px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Rank" HeaderText="Rank" SortExpression="Rank" UniqueName="Rank">
                                    <HeaderStyle Width="140px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn CommandName="Delete" Text="Delete" CommandArgument="Delete" UniqueName="Delete" ConfirmText="Delete this record?">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle Font-Underline="true" ForeColor="Red" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                </telerik:RadGrid>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSaveContact" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>

                <asp:SqlDataSource ID="companyContactSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id, ContactName, ContactNo, EmailAddress, Rank FROM [tblCompanyContacts] WHERE (CompanyId = @CompanyId) ORDER BY Id DESC" DeleteCommand="DELETE FROM tblCompanyContacts WHERE Id = @Id">
                    <DeleteParameters>
                      <asp:Parameter Name="Id" Type="Int32" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hfCompanyId" DefaultValue="0" Name="CompanyId" PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

            </div>
            <!-- /.box-body -->
          </div>
            </div>
        </div>

    </section>
    <!-- /.content -->

         <div class="modal fade" id="policyDetailsmodal">
    <div class="modal-dialog" style="width:50%">
            <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Policy Details</h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Premium</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtPremium" Width="100%" MinValue="0"></telerik:RadNumericTextBox>
                            </div>
                            <div class="form-group">
                                <label>Comments</label>
                                <asp:TextBox runat="server" ID="txtComments" Width="100%" TextMode="MultiLine" Rows="5"></asp:TextBox>
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button runat="server" ID="btnUpdatePolicy" Text="Save Changes" CssClass="btn btn-success" OnClick="btnUpdatePolicy_Click" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

             <div class="modal fade" id="newContactmodal">
    <div class="modal-dialog" style="width:50%">
            <asp:UpdatePanel runat="server" >
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">New Company Contact</h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                 <label>Contact Name</label>
                                  <asp:TextBox runat="server" ID="txtContactName" Width="100%" MaxLength="100"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtContactName" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="newContact"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                 <label>Contact Number</label>
                                  <asp:TextBox runat="server" ID="txtContactNo" Width="100%" MaxLength="50"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtContactNo" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="newContact"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                 <label>Email Address</label>
                                  <asp:TextBox runat="server" ID="txtContactEmail" Width="100%" MaxLength="100"></asp:TextBox>
                             </div>
                            <div class="form-group">
                                       <label>Rank</label>
                                       <telerik:RadDropDownList ID="dlRank" runat="server" Width="100%">
                                           <Items>
                                               <telerik:DropDownListItem Text="Officer" />
                                               <telerik:DropDownListItem Text="HR" />
                                               <telerik:DropDownListItem Text="Manager" />
                                               <telerik:DropDownListItem Text="CEO" />
                                           </Items>
                                       </telerik:RadDropDownList>
                                   </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button runat="server" ID="btnSaveContact" Text="Save" CssClass="btn btn-success" OnClick="btnSaveContact_Click" ValidationGroup="newContact" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

    <div class="modal fade" id="newCROfficermodal">
    <div class="modal-dialog" style="width:50%">
            <asp:UpdatePanel runat="server" >
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Assign CR Officer</h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                  <label>CR Officer</label>
                                       <telerik:RadDropDownList ID="dlCROfficer" runat="server" Width="100%" DefaultMessage="Select CR Officer" DataSourceID="crSource" DataValueField="ID" DataTextField="CRName" DropDownHeight="300px"></telerik:RadDropDownList>
                                        <asp:SqlDataSource ID="crSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT ID, FName + ' ' + LName as CRName from tblUsers WHERE AccountTypeID = 2"></asp:SqlDataSource>
                                  <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlCROfficer" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="newCROfficer"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                       <label>Assigned Date</label>
                                       <telerik:RadDatePicker runat="server" ID="dpAssignedDate" Width="100%" ></telerik:RadDatePicker>
                                       <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpAssignedDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="newCROfficer"></asp:RequiredFieldValidator>
                                   </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button runat="server" ID="btnSaveCROfficer" Text="Save" CssClass="btn btn-success" ValidationGroup="newCROfficer" OnClick="btnSaveCROfficer_Click" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

    <script type="text/javascript">
        function showPolicyDetailsModal() {
            $('#policyDetailsmodal').modal('show');
        }
        function closePolicyDetailsModal() {
            $('#policyDetailsmodal').modal('hide');
        }
        function showNewContactModal() {
            $('#newContactmodal').modal('show');
        }
        function closeNewContactModal() {
            $('#newContactmodal').modal('hide');
        }
        function showNewCROfficerModal() {
            $('#newCROfficermodal').modal('show');
        }
        function closeNewCROfficerModal() {
            $('#newCROfficermodal').modal('hide');
        }
    </script>
</asp:Content>
