<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="MemberUtilization.aspx.cs" Inherits="NMH_Call_Log.CR.Reports.MemberUtilization" %>

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
              <h3 class="box-title">Member Utilization - Claims for Active Policy </h3>
              <div class="box-tools pull-right">
                <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                <button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
              </div>
            </div><!-- /.box-header -->
            <div class="box-body">
                <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="upProcess">
                           <ProgressTemplate>
                            <div class="divWaiting">            
	                            <asp:Label ID="lblWait" runat="server" Text="Processing... " />
	                              <asp:Image ID="imgWait" runat="server" ImageAlign="Top" ImageUrl="/Content/dist/img/loader.gif" />
                                </div>
                             </ProgressTemplate>
                       </asp:UpdateProgress>

                   <asp:Panel runat="server" DefaultButton="btnSearch">
            <asp:UpdatePanel runat="server" ID="upProcess">
            <ContentTemplate>
                 <div class="modal-content">
                        <div class="modal-body">

                            <div class="row">
                            <div class="col-md-11">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <label class="col-sm-2 control-label">Company</label>
                                    <div class="col-sm-10">
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
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-2 control-label">Member </label>
                                    <div class="col-sm-10">
                                        <telerik:RadComboBox ID="dlMember" runat="server" Width="100%" DataSourceID="memberSource" MaxHeight="300" EmptyMessage="Select Member" Filter="Contains"
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
                            </div>
                                        <%--<div class="col-md-2">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">OPD</label>
                                    <div class="col-sm-8">
                                        <h2 style="color:red; font-weight:bold" runat="server" id="lblOPD">0.00</h2>
                                       
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">IP</label>
                                    <div class="col-sm-8">
                                        <h2 style="color:red; font-weight:bold" runat="server" id="lblIPD">0.00</h2>
                                       
                                    </div>
                                </div>
                                </div>
                            </div>--%>
                        </div>
                            <div class="row">
                                <div class="col-md-3">

                                </div>
                                <div class="col-md-3">
                                    <label>Out-Patient</label>
                                    <h2 style="color:red; font-weight:bold" runat="server" id="lblOPD">0.00</h2>
                                </div>
                                <div class="col-md-3">
                                     <label>In-Patient</label>
                                    <h2 style="color:red; font-weight:bold" runat="server" id="lblIPD">0.00</h2>
                                </div>
                                <div class="col-md-3">

                                </div> 
                            </div>

                            <div>
                                <telerik:RadGrid ID="claimGrid" runat="server" ShowFooter="False" AutoGenerateColumns="False" AllowSorting="True" DataSourceID="claimSource" GroupPanelPosition="Top" CellSpacing="-1" GridLines="Both">
                                    <ClientSettings>
                                        <Selecting AllowRowSelect="True" />
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                        <Resizing AllowColumnResize="true" AllowRowResize="true" AllowResizeToFit="true" EnableRealTimeResize="true" ClipCellContentOnResize="true" ResizeGridOnColumnResize="true" />
                                    </ClientSettings>
                                    <GroupingSettings CaseSensitive="false" />
                                    <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="Claim_Utilization" HideStructureColumns="true">

                                    </ExportSettings>
                                    <MasterTableView DataSourceID="claimSource">
                                        <Columns>
                                         <telerik:GridBoundColumn DataField="MemberNo" FilterControlAltText="Filter MemberNo column" HeaderText="MemberNo" SortExpression="MemberNo" UniqueName="MemberNo">
                                            <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Company" FilterControlAltText="Filter Company column" HeaderText="Company" SortExpression="Company" UniqueName="Company">
                                            <HeaderStyle Width="150px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="FullName" FilterControlAltText="Filter FullName column" HeaderText="FullName" SortExpression="FullName" UniqueName="FullName" ReadOnly="True">
                                            <HeaderStyle Width="150px" />
                                            </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Relationship" FilterControlAltText="Filter Relationship column" HeaderText="Relation" SortExpression="Relationship" UniqueName="Relationship">
                                         <HeaderStyle Width="60px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="DOB" FilterControlAltText="Filter DOB column" HeaderText="DOB" SortExpression="DOB" UniqueName="DOB" ReadOnly="True"  DataFormatString="{0:MM/dd/yyyy}">
                                         <HeaderStyle Width="80px" />
                                         </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ClaimsNo" FilterControlAltText="Filter ClaimsNo column" HeaderText="ClaimsNo" SortExpression="ClaimsNo" UniqueName="ClaimsNo">
                                            <HeaderStyle Width="150px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="DateofAttendance" DataType="System.DateTime" FilterControlAltText="Filter DateofAttendance column" HeaderText="DateofAttendance" SortExpression="DateofAttendance" UniqueName="DateofAttendance" DataFormatString="{0:MM/dd/yyyy}">
                                            <HeaderStyle Width="120px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Inout" FilterControlAltText="Filter Inout column" HeaderText="Inout" SortExpression="Inout" UniqueName="Inout">
                                            <HeaderStyle Width="50px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ServiceName" FilterControlAltText="Filter ServiceName column" HeaderText="ServiceName" SortExpression="ServiceName" UniqueName="ServiceName">
                                            <HeaderStyle Width="150px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="TariffName" FilterControlAltText="Filter TariffName column" HeaderText="TariffName" SortExpression="TariffName" UniqueName="TariffName">
                                            <HeaderStyle Width="150px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Diagnosis" FilterControlAltText="Filter Diagnosis column" HeaderText="Diagnosis" SortExpression="Diagnosis" UniqueName="Diagnosis">
                                            <HeaderStyle Width="200px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Claimed" DataType="System.Decimal" FilterControlAltText="Filter Claimed column" HeaderText="Claimed" SortExpression="Claimed" UniqueName="Claimed">
                                            <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ApprovedAmount" DataType="System.Decimal" FilterControlAltText="Filter ApprovedAmount column" HeaderText="Approved" SortExpression="ApprovedAmount" UniqueName="ApprovedAmount">
                                            <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            
                                            <telerik:GridBoundColumn DataField="ServiceProvider" FilterControlAltText="Filter ServiceProvider column" HeaderText="ServiceProvider" SortExpression="ServiceProvider" UniqueName="ServiceProvider">
                                            <HeaderStyle Width="150px" />
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                                <asp:SqlDataSource ID="claimSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Get_Member_Utilization" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="dlMember" DefaultValue="0" Name="MemberID" PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                       </div>

                <div class="modal-footer">
                    <asp:Button ID="btnSearch" runat="server" Text="RUN" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnExcelExport" runat="server" Text="Excel" CssClass="btn btn-success" OnClick="btnExcelExport_Click" CausesValidation="false" />
                </div>
            </div>
            </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnExcelExport" />
                </Triggers>
        </asp:UpdatePanel>
        </asp:Panel>
            </div><!-- /.box-body -->
         
          </div><!-- /.box -->

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
