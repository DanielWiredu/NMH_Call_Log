<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="MemberBenefits.aspx.cs" Inherits="NMH_Call_Log.CR.Main.MemberBenefits" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="/Content/dist/css/telerikCombo.css" rel="stylesheet" />
    <link href="/Content/dist/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <style type="text/css">
        .ncol1{
              margin: 0;
            padding: 0 5px 0 0;
            width: 13%;
            line-height: 14px;
            float: left;
        }
        .ncol2{
              margin: 0;
    padding: 0 5px 0 0;
    width: 30%;
    line-height: 14px;
    float: left;
        }
        .ncol3{
              margin: 0;
    padding: 0 5px 0 0;
    width: 30%;
    line-height: 14px;
    float: left;
        }
        .ncol4{
              margin: 0;
    padding: 0 5px 0 0;
    width: 12%;
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
   <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Member Benefits </h3>
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
                             <div class="form-group">
                                 <div class="row">
                                      <div class="col-md-12">
                                     <label>Member</label>
                                     <telerik:RadComboBox ID="dlMember" runat="server" Width="100%" DataSourceID="memberSource" MaxHeight="300" EmptyMessage="Select Member" Filter="Contains" OnSelectedIndexChanged="dlMember_SelectedIndexChanged" AutoPostBack="true"
                                           OnItemDataBound="dlMember_ItemDataBound" OnDataBound="dlMember_DataBound" OnItemsRequested="dlMember_ItemsRequested" EnableLoadOnDemand="true"
                                            OnClientItemsRequested="UpdateMemberItemCountField" HighlightTemplatedItems="true" MarkFirstMatch="true"  >
                                            <HeaderTemplate>
                <ul>
                     <li class="ncol1">MEMBER NO</li>
                    <li class="ncol2"> FULLNAME</li>
                    <li class="ncol3"> COMPANY</li>
                    <li class="ncol4"> PLAN</li>
                    <li class="ncol5"> STATUS</li>
                </ul>
            </HeaderTemplate>
            <ItemTemplate>
                <ul>
                     <li class="ncol1">
                        <%# DataBinder.Eval(Container.DataItem, "MemberNo")%></li>

                    <li class="ncol2">
                        <%# DataBinder.Eval(Container.DataItem, "FullName")%></li>
                    <li class="ncol3">
                        <%# DataBinder.Eval(Container.DataItem, "Company")%></li>
                    <li class="ncol4">
                        <%# DataBinder.Eval(Container.DataItem, "Plan")%></li>
                    <li class="ncol5">
                        <%# DataBinder.Eval(Container.DataItem, "Status")%></li>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                A total of
                <asp:Literal runat="server" ID="memberCount" />
                items
            </FooterTemplate>
                                        </telerik:RadComboBox>
                                        <asp:SqlDataSource ID="memberSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT top (100) ID, MemberNo, FullName, Company, [Plan], Status FROM [VW_Members]"></asp:SqlDataSource>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlMember" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                 </div>

                                 </div>
                                  
                             </div>
                            <div>
                                <telerik:RadGrid ID="memberBenefitGrid" runat="server" AllowPaging="true" AllowSorting="True" DataSourceID="memberBenefitSource" GroupPanelPosition="Top">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <GroupHeaderItemStyle BackColor="#00cc66" ForeColor="Black" Font-Bold="true" Width="50px" Font-Size="Medium"  />
                              <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="MemberBenefits" HideStructureColumns="true" >
                                  <Excel Format="Html" />
                                    </ExportSettings>      
                            <MasterTableView AutoGenerateColumns="False" DataSourceID="memberBenefitSource" AllowAutomaticDeletes="false" PageSize="100" GroupLoadMode="Server" EnableGroupsExpandAll="true" GroupsDefaultExpanded="false">
                                <GroupByExpressions>
                                           <telerik:GridGroupByExpression>
                                               <SelectFields>
                                                   <telerik:GridGroupByField FieldName="BenefitGroup" HeaderText=" "></telerik:GridGroupByField>
                                               </SelectFields>
                                               <GroupByFields>
                                                   <telerik:GridGroupByField FieldName="BenefitGroup" SortOrder="Ascending" ></telerik:GridGroupByField>
                                               </GroupByFields>
                                           </telerik:GridGroupByExpression>
                                    
                                       </GroupByExpressions>
                                <Columns>
                                    <%--<telerik:GridBoundColumn Display="false" DataField="RowId" DataType="System.Int32" FilterControlAltText="Filter RowId column" HeaderText="RowId" SortExpression="RowId" UniqueName="RowId">
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
                                    </telerik:GridBoundColumn>--%>
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
                                </Columns>
                            </MasterTableView>
                                        </telerik:RadGrid>

                                        <asp:SqlDataSource ID="memberBenefitSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT   BenefitGroup.BenefitGroup, Benefits.Benefit, Company_X_Plan_Benefits_Limits.CoverStatus, Company_X_Plan_Benefits_Limits.CoverLimit, Company_X_Plan_Benefits_Limits.CoverComment
FROM            Benefits INNER JOIN
                         BenefitGroup ON Benefits.BenefitGroupId = BenefitGroup.Id INNER JOIN
                         Vw_Members INNER JOIN
                         Company_X_Plan_Benefits_Limits ON Vw_Members.CompanyID = Company_X_Plan_Benefits_Limits.CompanyID AND Vw_Members.ActualPlanID = Company_X_Plan_Benefits_Limits.PlanID ON 
                         Benefits.ID = Company_X_Plan_Benefits_Limits.BenefitID
WHERE        (Vw_Members.ID = @MemberId)">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="dlMember" Name="MemberId" PropertyName="SelectedValue" Type="Int32" DefaultValue="0"/>
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                            </div>
                       </div>

                <div class="modal-footer">
                    <asp:Button ID="btnSearch" runat="server" Text="Find" CssClass="btn btn-primary"  OnClick="btnSearch_Click" />
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
            function UpdateMemberItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
