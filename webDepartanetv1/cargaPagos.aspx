<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="cargaPagos.aspx.cs" Inherits="webDepartanetv1.cargaPagos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <h4>Carga de comprobante de pago</h4>
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ddlCatalogoMensualidad" CssClass="col-md-2 control-label">Mensualidad</asp:Label>
            <div class="col-md-10">
                <asp:DropDownList ID="ddlCatalogoMensualidad" runat="server" AutoPostBack="true">
                </asp:DropDownList>
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtDescripcion" CssClass="col-md-2 control-label">Descripción</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtDescripcion" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDescripcion"
                    CssClass="text-danger" ErrorMessage="El campo de Nombre es obligatorio." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="FileUpload1" CssClass="col-md-2 control-label">Carga de comprobante</asp:Label>
            <div class="col-md-10">
                <asp:FileUpload ID="FileUpload1" runat="server" />
            </div>

        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" ID="btnGuardar" Text="Guardar" CssClass="btn btn-default" OnClick="btnGuardar_Click" />
            </div>
        </div>
    </div>

</asp:Content>
