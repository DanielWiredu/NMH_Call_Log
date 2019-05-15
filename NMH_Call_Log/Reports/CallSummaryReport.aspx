<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="CallSummaryReport.aspx.cs" Inherits="NMH_Call_Log.Reports.CallSummaryReport" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Call Summary Report </h3>
              <div class="box-tools pull-right">
                <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                <button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
              </div>
            </div><!-- /.box-header -->
            <div class="box-body">
               
                 <asp:UpdatePanel runat="server">
                     <ContentTemplate>
                         <div class="modal-content">
                        <div class="modal-body">
                             <div class="form-group">
                                 <div class="row">
                                     <div class="col-md-1">

                                     </div>
                                      <div class="col-md-4">
                                     <label>Type of Call</label>
                                    <telerik:RadDropDownList runat="server" ID="dlCallType" Width="100%" DefaultMessage="Select Call Type" >
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
                                    <label>Start Date</label>
                                    <telerik:RadDatePicker runat="server" ID="dpStartDate" DateInput-ReadOnly="true" Width="100%"></telerik:RadDatePicker>
                                     <asp:RequiredFieldValidator runat="server" ControlToValidate="dpStartDate" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                     <label>End Date</label>
                                    <telerik:RadDatePicker runat="server" ID="dpEndDate" DateInput-ReadOnly="true" Width="100%"></telerik:RadDatePicker>
                                     <asp:RequiredFieldValidator runat="server" ControlToValidate="dpEndDate" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                                     <div class="col-md-1">

                                     </div> 
                                 </div>
                                  
                             </div>
                            <div>
                              
                            </div>
                       </div>

                <div class="modal-footer">
                    <asp:Button ID="btnGenerate" runat="server" Text="Generate Report" CssClass="btn btn-primary"  OnClick="btnGenerate_Click" />
                </div>
            </div>
                     </ContentTemplate>
                 </asp:UpdatePanel>

            </div><!-- /.box-body -->
         
          </div><!-- /.box -->
</asp:Content>
