<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="webDepartanetv1.Productos1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
        <script>
            $(document).ready(function () {
                $("[id$=txtVencimiento]").datepicker();
            });
        </script>
        <h4>Catálogo de mensualidades</h4>
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ddlPeriodo" CssClass="col-md-2 control-label">Periodo</asp:Label>
            <div class="col-md-10">
                <asp:DropDownList ID="ddlPeriodo" runat="server">
                    <asp:ListItem Text="Periodo 2019" Value="2019">

                    </asp:ListItem>
                    <asp:ListItem Text="Periodo 2018" Value="2018">

                    </asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtNombre" CssClass="col-md-2 control-label">Nombre</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre"
                    CssClass="text-danger" ErrorMessage="El campo de Nombre es obligatorio." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtDescripcion" CssClass="col-md-2 control-label">Descripción</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtDescripcion" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDescripcion"
                    CssClass="text-danger" ErrorMessage="El campo de Descripción es obligatorio." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtVencimiento" CssClass="col-md-2 control-label">Vencimiento</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtVencimiento" class="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtVencimiento"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="El campo de de vencimiento es obligatorio." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtImporte" CssClass="col-md-2 control-label">Importe</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtImporte"  CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtImporte"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="El campo de de importe es obligatorio." />
            </div>
        </div>

        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" ID="btnGuardar" Text="Guardar" CssClass="btn btn-default" OnClick="btnGuardar_Click" />
            </div>
        </div>
    </div>
</asp:Content>
