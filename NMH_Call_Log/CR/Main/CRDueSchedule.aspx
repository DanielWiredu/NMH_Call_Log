<%@ Page Title="" Language="C#" MasterPageFile="~/CRHome.Master" AutoEventWireup="true" CodeBehind="CRDueSchedule.aspx.cs" Inherits="NMH_Call_Log.CR.Main.CRDueSchedule" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
table {
    border-collapse: collapse;
    width: 100%;
}

th {
    padding: 8px;
    text-align: left;
    border-bottom: 3px solid #000000;
    font-size:larger;
}
/*h3 {
    text-align: left;
    border-bottom: 2px solid #000000;
    font-weight:bold;
}*/
td {
    padding: 5px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    height: 35px;
}
.tdempInfo {
    padding: 5px;
    text-align: left;
    border-bottom:none !important;
}
.tdlabel {
    padding: 5px;
    text-align: left;
    border-bottom:none !important;
    font-weight:bold;
}
.tdlabelh {
    padding: 5px;
    text-align: right;
    /*border-bottom: 1px solid #ddd;*/
    font-weight:bold;
}
.tdlabelg {
    padding: 5px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    font-weight:bold;
}
tr:hover{background-color:#f5f5f5}
/*tr:nth-child(odd) {background-color: #f2f2f2}*/
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


       <div class="row">
        <div class="col-md-6">
          <div class="box box-danger">
            <div class="box-header">
              <h3 class="box-title">Info Sessions</h3>
            </div>
            <div class="box-body">
                <asp:Panel runat="server">
            <telerik:RadListView ID="lvInfoSessions" RenderMode="Lightweight" Width="97%" runat="server" ItemPlaceholderID="sessionHolder" DataKeyNames="id">
                <LayoutTemplate>                 
                    <fieldset class="layoutFieldset" >
                        <asp:Panel ID="sessionHolder" runat="server">
                        </asp:Panel>
                    </fieldset>
                </LayoutTemplate>
                <ItemTemplate>
                                <table>
                                    <tr > 
                                            <td style="width:70%">
                                               <asp:LinkButton ID="lkCompany" runat="server" CommandName="Select" Enabled="false">
                                                <asp:Label ID="lblCompany" runat="server" Text='<%# Bind("Company") %>'></asp:Label>
                                            </asp:LinkButton>
                                            </td>
                                            <td style="width:30%; text-align:right; color:green; font-size:smaller; padding-bottom:15px;">
                                                <%# DataBinder.Eval(Container.DataItem, "SessionDate", "{0:dd-MMM-yyyy h:mm tt}") %>
                                            </td>
                                        </tr>
                                    </table>
                </ItemTemplate>
            </telerik:RadListView>
        </asp:Panel>
            </div>
            <!-- /.box-body -->
              <div class="sidebar-title">
                        <h5>
                            <i class="fa fa-minus-square-o"></i>
                            <a href="/CR/Main/ClientSessions.aspx">
                                more
                            </a>
                        </h5>
                    </div>
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col (left) -->
        <div class="col-md-6">
          <div class="box box-primary">
            <div class="box-header">
              <h3 class="box-title">News Letters</h3>
            </div>
            <div class="box-body">
                <asp:Panel runat="server">
            <telerik:RadListView ID="lvNewsLetters" RenderMode="Lightweight" Width="97%" runat="server" ItemPlaceholderID="letterHolder" DataKeyNames="id">
                <LayoutTemplate>                 
                    <fieldset class="layoutFieldset" >
                        <asp:Panel ID="letterHolder" runat="server">
                        </asp:Panel>
                    </fieldset>
                </LayoutTemplate>
                <ItemTemplate>
                                <table>
                                    <tr > 
                                            <td style="width:70%">
                                               <asp:LinkButton ID="lkPeriod" runat="server" CommandName="Select" Enabled="false">
                                                <asp:Label ID="lblPeriod" runat="server" Text='<%# Bind("LPeriod") %>'></asp:Label>
                                            </asp:LinkButton>
                                            </td>
                                            <td style="width:30%; text-align:right; color:green; font-size:smaller; padding-bottom:15px;">
                                                <%# DataBinder.Eval(Container.DataItem, "DueDate", "{0:dd-MMM-yyyy h:mm tt}") %>
                                            </td>
                                        </tr>
                                    </table>
                </ItemTemplate>
            </telerik:RadListView>
        </asp:Panel>
               
            </div>
            <!-- /.box-body -->
              <div class="sidebar-title">
                        <h5>
                            <i class="fa fa-minus-square-o"></i>
                            <a href="/CR/Main/ClientLetters.aspx">
                                more
                            </a>
                        </h5>
                    </div>
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
              <h3 class="box-title">Health Talks</h3>
            </div>
            <div class="box-body">
                <asp:Panel runat="server">
            <telerik:RadListView ID="lvHealthTalks" RenderMode="Lightweight" Width="97%" runat="server" ItemPlaceholderID="healthTalkHolder" DataKeyNames="id">
                <LayoutTemplate>                 
                    <fieldset class="layoutFieldset" >
                        <asp:Panel ID="healthTalkHolder" runat="server">
                        </asp:Panel>
                    </fieldset>
                </LayoutTemplate>
                <ItemTemplate>
                                <table>
                                    <tr > 
                                            <td style="width:70%">
                                               <asp:LinkButton ID="lkTalkCompany" runat="server" CommandName="Select" Enabled="false">
                                                <asp:Label ID="lblTalkCompany" runat="server" Text='<%# Bind("Company") %>'></asp:Label>
                                            </asp:LinkButton>
                                            </td>
                                            <td style="width:30%; text-align:right; color:green; font-size:smaller; padding-bottom:15px;">
                                                <%# DataBinder.Eval(Container.DataItem, "TalkDate", "{0:dd-MMM-yyyy h:mm tt}") %>
                                            </td>
                                        </tr>
                                    </table>
                </ItemTemplate>
            </telerik:RadListView>
        </asp:Panel>
            </div>
            <!-- /.box-body -->
                    <div class="sidebar-title">
                        <h5>
                            <i class="fa fa-minus-square-o"></i>
                            <a href="/CR/Main/HealthTalks.aspx">
                                more
                            </a>
                        </h5>
                    </div>
          </div>
            </div>
            <div class="col-md-6">
                <div class="box box-primary">
            <div class="box-header">
              <h3 class="box-title">Health Screening</h3>
            </div>
            <div class="box-body">
                <asp:Panel runat="server">
            <telerik:RadListView ID="lvHealthScreening" RenderMode="Lightweight" Width="97%" runat="server" ItemPlaceholderID="healthScreenHolder" DataKeyNames="id">
                <LayoutTemplate>                 
                    <fieldset class="layoutFieldset" >
                        <asp:Panel ID="healthScreenHolder" runat="server">
                        </asp:Panel>
                    </fieldset>
                </LayoutTemplate>
                <ItemTemplate>
                                <table>
                                    <tr > 
                                            <td style="width:70%">
                                               <asp:LinkButton ID="lkScreenCompany" runat="server" CommandName="Select" Enabled="false">
                                                <asp:Label ID="lblScreenCompany" runat="server" Text='<%# Bind("Company") %>'></asp:Label>
                                            </asp:LinkButton>
                                            </td>
                                            <td style="width:30%; text-align:right; color:green; font-size:smaller; padding-bottom:15px;">
                                                <%# DataBinder.Eval(Container.DataItem, "ScreenDate", "{0:dd-MMM-yyyy h:mm tt}") %>
                                            </td>
                                        </tr>
                                    </table>
                </ItemTemplate>
            </telerik:RadListView>
        </asp:Panel>
            </div>
            <!-- /.box-body -->
                    <div class="sidebar-title">
                        <h5>
                            <i class="fa fa-minus-square-o"></i>
                            <a href="/CR/Main/HealthScreening.aspx">
                                more
                            </a>
                        </h5>
                    </div>
          </div>
            </div>
        </div>
</asp:Content>
