<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="NMH_Call_Log.CR.Dashboard" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="refresh" content="60" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Dashboard (Current Month Summary) </h3>
              <%--<div class="box-tools pull-right">
                <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                <button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
              </div>--%>
            </div><!-- /.box-header -->
            <div class="box-body">
                
                <div class="row">
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-aqua">
                <div class="inner">
                  <h3 runat="server" id="lblTotalComplaints" > 256 </h3>
                  <p>Total Complaints</p>
                </div>
                <div class="icon">
                  <i class="ion ion-bag"></i>
                </div>
                  
              </div>
            </div><!-- ./col -->
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-teal">
                <div class="inner">
                  <h3 runat="server" id="lblReferred"> 65 <sup style="font-size: 20px"></sup></h3>
                  <p>Referred</p>
                </div>
                <div class="icon">
                  <i class="ion ion-stats-bars"></i>
                </div>
               
              </div>
            </div><!-- ./col -->
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-yellow">
                <div class="inner">
                  <h3 runat="server" id="lblUnResolved"> 42 </h3>
                  <p>Unresolved</p>
                </div>
                <div class="icon">
                  <i class="ion ion-bonfire"></i>
                </div>
                
              </div>
            </div><!-- ./col -->
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-green">
                <div class="inner">
                  <h3 runat="server" id="lblResolved"> 33 </h3>
                  <p>Resolved</p>
                </div>
                <div class="icon">
                  <i class="ion ion-pie-graph"></i>
                </div>
               
              </div>
            </div><!-- ./col -->
          </div>


                <div class="row">
                    <div class="col-md-6">
                   <telerik:RadHtmlChart runat="server" Width="100%" Height="500px" ID="chtComplaintByType" Skin="Silk" DataSourceID="complaintTypeSource">
            <PlotArea>
                <Series>
                    <telerik:ColumnSeries Name="Total Complaints" DataFieldY="TOTALCOMPLAINTS">
                        <TooltipsAppearance Color="White"  />
                    </telerik:ColumnSeries>
                </Series>
                <XAxis DataLabelsField="COMPLAINTTYPE" Visible="true">
                    <LabelsAppearance RotationAngle="60"> </LabelsAppearance>
                    <TitleAppearance Text="Category" Visible="false"></TitleAppearance>
                </XAxis>
                <YAxis >
                    <LabelsAppearance></LabelsAppearance>
                    <TitleAppearance Text="Total Complaints" Visible="false"> </TitleAppearance>
                </YAxis>
            </PlotArea>
            <Legend >
                <Appearance Visible="false" > </Appearance>
            </Legend>
            <ChartTitle Text="Complaints by Type">
            </ChartTitle>
        </telerik:RadHtmlChart>

        <asp:SqlDataSource ID="complaintTypeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="select COMPLAINTTYPEDEPT AS COMPLAINTTYPE, COUNT(CALLID) AS TOTALCOMPLAINTS from vwComplaintLog where MONTH(calldate) = MONTH(getdate()) and YEAR(calldate) = YEAR(getdate()) group by COMPLAINTTYPEDEPT"></asp:SqlDataSource>

         <%--<asp:SqlDataSource ID="complaintTypeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="select d.DEPARTMENT AS COMPLAINTTYPE, count(c.CallId) as TOTALCOMPLAINTS from tblCallLog c inner join tblDepartment d on c.ComplaintType = d.Id where CRChannel='CR' AND MONTH(calldate) = MONTH(getdate()) group by DEPARTMENT"></asp:SqlDataSource>--%>
                    
                </div>

                    <%--<telerik:RadButton ID="btnExport" Text="Export to PDF" runat="server" OnClientClicked="exportRadHtmlChart" UseSubmitBehavior="false" AutoPostBack="false"></telerik:RadButton>--%>
                    <%--<telerik:RadClientExportManager ID="RadClientExportManager1" runat="server"></telerik:RadClientExportManager>--%>

                    

                    <div class="col-md-6">
                                 <telerik:RadHtmlChart ID="chtComplaintBySource" runat="server" Width="100%" Height="500px" DataSourceID="complaintSource">
                                    <ChartTitle Text="Complaints By Source">
                                        <Appearance Visible="True" >
                                        </Appearance>
                                    </ChartTitle>
                                    <Legend>
                                        <Appearance Visible="True" Position="Bottom">
                                        </Appearance>
                                    </Legend>
                                    <PlotArea>
                                        <Series>
                                            <telerik:PieSeries Name="COMPLAINTSOURCE" StartAngle="90" DataFieldY="TOTALCOMPLAINTS" NameField="COMPLAINTSOURCE" >
                                                <LabelsAppearance DataField="COMPLAINTSOURCE" Position="OutsideEnd" Visible="true"></LabelsAppearance>
                                            </telerik:PieSeries>
                                        </Series>
                                    </PlotArea>
                                </telerik:RadHtmlChart>
             
                                <asp:SqlDataSource ID="complaintSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT COMPLAINTSOURCE, count(CallId) as TOTALCOMPLAINTS from vwComplaintLog where MONTH(calldate) = MONTH(getdate()) and YEAR(calldate) = YEAR(getdate()) group by COMPLAINTSOURCE"></asp:SqlDataSource>
                            </div>
                </div>

                <telerik:RadNotification RenderMode="Lightweight" ID="ntTodo" runat="server" Text="Task(s) date due, Kindly check schedule" Position="Center"
                                                    Animation="Slide" AutoCloseDelay="0" Width="400" Height="150" Title="Due Task(s)" EnableRoundedCorners="true">
                                </telerik:RadNotification>

            </div><!-- /.box-body -->
         
          </div><!-- /.box -->
</asp:Content>
