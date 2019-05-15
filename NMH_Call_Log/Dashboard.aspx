<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="NMH_Call_Log.Dashboard" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="refresh" content="60" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Dashboard (Today's Summary) </h3>
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
                  <h3 runat="server" id="lblTotalCalls" > 256 </h3>
                  <p>Total Calls</p>
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
                  <h3 runat="server" id="lblEscalated"> 65 <sup style="font-size: 20px"></sup></h3>
                  <p>Escalated</p>
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
                  <h3 runat="server" id="lblPending"> 42 </h3>
                  <p>Pending</p>
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
                  <h3 runat="server" id="lblCompleted"> 33 </h3>
                  <p>Completed</p>
                </div>
                <div class="icon">
                  <i class="ion ion-pie-graph"></i>
                </div>
               
              </div>
            </div><!-- ./col -->
          </div>


                <div class="row">
                    <div class="col-md-6">
                   <telerik:RadHtmlChart runat="server" Width="100%" Height="500px" ID="chtCallsByServiceType" Skin="Silk" DataSourceID="callServiceTypeSource">
            <PlotArea>
                <Series>
                    <telerik:ColumnSeries Name="Total Calls" DataFieldY="TOTALCALLS">
                        <TooltipsAppearance Color="White"  />
                    </telerik:ColumnSeries>
                </Series>
                <XAxis DataLabelsField="SERVICETYPE" Visible="true">
                    <LabelsAppearance RotationAngle="60"> </LabelsAppearance>
                    <TitleAppearance Text="Category" Visible="false"></TitleAppearance>
                </XAxis>
                <YAxis >
                    <LabelsAppearance></LabelsAppearance>
                    <TitleAppearance Text="Total Calls" Visible="false"> </TitleAppearance>
                </YAxis>
            </PlotArea>
            <Legend >
                <Appearance Visible="false" > </Appearance>
            </Legend>
            <ChartTitle Text="Calls by Service Type">
            </ChartTitle>
        </telerik:RadHtmlChart>

         <asp:SqlDataSource ID="callServiceTypeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="select s.SERVICETYPE, count(c.CallId) as TOTALCALLS from tblCallLog c inner join tblServiceType s on c.ServiceTypeId = s.Id where CAST(calldate as date) = CAST(getdate() as DATE) group by SERVICETYPE"></asp:SqlDataSource>
                    
                </div>

                    <%--<telerik:RadButton ID="btnExport" Text="Export to PDF" runat="server" OnClientClicked="exportRadHtmlChart" UseSubmitBehavior="false" AutoPostBack="false"></telerik:RadButton>--%>
                    <%--<telerik:RadClientExportManager ID="RadClientExportManager1" runat="server"></telerik:RadClientExportManager>--%>

                    

                    <div class="col-md-6">
                                 <telerik:RadHtmlChart ID="chtCallByCallType" runat="server" Width="100%" Height="500px" DataSourceID="callTypeSource">
                                    <ChartTitle Text="Calls by Call Type">
                                        <Appearance Visible="True" >
                                        </Appearance>
                                    </ChartTitle>
                                    <Legend>
                                        <Appearance Visible="True" Position="Bottom">
                                        </Appearance>
                                    </Legend>
                                    <PlotArea>
                                        <Series>
                                            <telerik:PieSeries Name="CALLTYPE" StartAngle="90" DataFieldY="TOTALCALLS" NameField="CALLTYPE" >
                                                <LabelsAppearance DataField="CALLTYPE" Position="OutsideEnd" Visible="true"></LabelsAppearance>
                                            </telerik:PieSeries>
                                        </Series>
                                    </PlotArea>
                                </telerik:RadHtmlChart>
             
                                <asp:SqlDataSource ID="callTypeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT CALLTYPE, count(CallId) as TOTALCALLS from tblCallLog where CAST(calldate as date) = CAST(getdate() as DATE) group by CALLTYPE"></asp:SqlDataSource>
                            </div>
                </div>

            </div><!-- /.box-body -->
         
          </div><!-- /.box -->
</asp:Content>
