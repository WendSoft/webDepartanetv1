<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="webDepartanetv1.Productos1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal container-fluid">
        <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
        <script>
            $(document).ready(function () {
                $("[id$=txtVencimiento]").datepicker({ dateFormat: 'dd/mm/yy' });
            });
        </script>
        <h4>Conceptos de pago</h4>
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
        <div class="row">
            <div class="float-right">
                <asp:Button ID="btnAgregar" runat="server" CssClass="btn btn-success float-right" Style="float: right;" Text="Agregar Concepto" CausesValidation="false" OnClick="btnAgregar_Click"></asp:Button>
            </div>
            <asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="False" Font-Size="Smaller" DataKeyNames="id"
                CssClass="table table-bordered bs-table  table-hover" OnPreRender="gvProductos_PreRender" OnRowDeleted="gvProductos_RowDeleted" OnRowEditing="gvProductos_RowEditing" OnSelectedIndexChanged="gvProductos_SelectedIndexChanged" OnSelectedIndexChanging="gvProductos_SelectedIndexChanging">
                <HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />
                <%--                   <EditRowStyle BackColor="#ffffcc" />--%>
                <SelectedRowStyle BackColor="#FFFFCC" />
                <EmptyDataRowStyle ForeColor="Red" CssClass="table table-bordered" />
                <EmptyDataTemplate>
                    No hay datos cargados
                </EmptyDataTemplate>
                <%--Paginador...--%>
                <PagerTemplate>
                    <div class="row" style="margin-top: 20px;">
                        <div class="col-lg-1" style="text-align: right;">
                            <h5>
                                <asp:Label ID="MessageLabel" Text="Ir a la pág." runat="server" /></h5>
                        </div>
                        <div class="col-lg-1" style="text-align: left;">
                            <asp:DropDownList ID="PageDropDownList" Width="50px" AutoPostBack="true" OnSelectedIndexChanged="PageDropDownList_SelectedIndexChanged" runat="server" CssClass="form-control" /></h3>
                        </div>
                        <div class="col-lg-10" style="text-align: right;">
                            <h3>
                                <asp:Label ID="CurrentPageLabel" runat="server" CssClass="label label-warning" /></h3>
                        </div>
                    </div>
                </PagerTemplate>
                <Columns>
                    <%--botones de acción sobre los registros...--%>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200px">
                        <ItemTemplate>
                            <%--Botones de eliminar y editar cliente...--%>
                            <asp:Button ID="btnDelete" runat="server" Text="Inhabiliar" CssClass="btn btn-danger" CommandName="Delete" OnClientClick="return confirm('¿Desea inhabilitar el concepto?');" />
                            <asp:Button ID="btnEdit" runat="server" CausesValidation="false" Text="Editar" CssClass="btn btn-info" CommandName="Edit" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--campos editables...--%>
                    <asp:TemplateField HeaderText="Esatus">
                        <ItemTemplate>
                            <asp:Label ID="lblEstatus" runat="server"><%# ((int)Eval("Activo") == 1) ?  "Activo"  : "Inactivo" %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Periodo">
                        <ItemTemplate>
                            <asp:Label ID="lblPeriodo" runat="server"><%# Eval("Periodo")%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="150px" HeaderText="Nombre">
                        <ItemTemplate>
                            <asp:Label ID="lblNombre" runat="server"><%# Eval("Nombre")%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="250px" HeaderText="Descripcion">
                        <ItemTemplate>
                            <asp:Label ID="lblDrscripcion" runat="server"><%# Eval("Descripcion")%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Vencimiento">
                        <ItemTemplate>
                            <asp:Label ID="lblVencimiento" runat="server"><%# setDateTime((DateTime)Eval("vencimiento"))%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="150px" HeaderText="Importe">
                        <ItemTemplate>
                            <asp:Label ID="lblImporte" runat="server"><%# Eval("Importe")%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <!-- Bootstrap Modal Dialog -->
    <div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">
                        <asp:Label ID="lblModalTitle" runat="server" Text="Concepto de pago"></asp:Label></h4>
                </div>
                <div class="modal-body" style="height: 360px;">
                    <div class="col-md-8">
                        <asp:Label runat="server" AssociatedControlID="ddlPeriodo" CssClass="col-md-3 control-label">Periodo</asp:Label>
                        <asp:DropDownList ID="ddlPeriodo" runat="server">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-8">
                        <asp:Label runat="server" AssociatedControlID="txtNombre" CssClass="col-md-3 control-label">Nombre</asp:Label>
                        <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre"
                            CssClass="text-danger" ErrorMessage="El campo de Nombre es obligatorio." />
                    </div>
                    <div class="col-md-8">
                        <asp:Label runat="server" AssociatedControlID="txtDescripcion" CssClass="col-md-3 control-label">Descripción</asp:Label>
                        <asp:TextBox runat="server" ID="txtDescripcion" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDescripcion"
                            CssClass="text-danger" ErrorMessage="El campo de Descripción es obligatorio." />
                    </div>
                    <div class="col-md-8">
                        <asp:Label runat="server" AssociatedControlID="txtVencimiento" CssClass="col-md-3 control-label">Vencimiento</asp:Label>
                        <asp:TextBox runat="server" ID="txtVencimiento" CssClass="form-control" TextMode="Date" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtVencimiento"
                            CssClass="text-danger" Display="Dynamic" ErrorMessage="El campo de de vencimiento es obligatorio." />
                    </div>
                    <div class="col-md-8">
                        <asp:Label runat="server" AssociatedControlID="txtImporte" CssClass="col-md-3 control-label">Importe</asp:Label>
                        <asp:TextBox runat="server" ID="txtImporte" CssClass="form-control" TextMode="Number" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtImporte"
                            CssClass="text-danger" Display="Dynamic" ErrorMessage="El campo de de importe es obligatorio." />
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                    <asp:Button runat="server" ID="btnGuardar" Text="Guardar" aria-hidden="true" CssClass="btn btn-success" OnClick="btnGuardar_Click" />
                    <asp:Button ID="btnActualizar" runat="server" CssClass="btn btn-info" aria-hidden="true" Text="Actualizar" OnClick="btnActualizar_Click"></asp:Button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
