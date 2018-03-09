<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="fichaInquilino.aspx.cs" Inherits="webDepartanetv1.fichaInquilino" %>

<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="form-horizontal">
        <h4>Departamentos</h4>
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />

        <div class="row">
            <div class="float-right">
                <asp:Button ID="btnAgregar" runat="server" CssClass="btn btn-success float-right" Style="float: right;" Text="Agregar inquilino" CausesValidation="false" OnClick="btnAgregar_Click"></asp:Button>
            </div>
            <asp:GridView ID="gvFichaInquilinos" runat="server" AutoGenerateColumns="False" DataKeyNames="id" CssClass="table table-bordered bs-table table-hover" OnRowEditing="gvFichaInquilinos_RowEditing" OnSelectedIndexChanged="gvFichaInquilinos_SelectedIndexChanged" OnSelectedIndexChanging="gvFichaInquilinos_SelectedIndexChanging">
                <HeaderStyle BackColor="#337ab7" Font-Bold="True" Font-Size="Smaller" ForeColor="White" />
                <Columns>
                    <%--botones de acción sobre los registros...--%>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200px">
                        <ItemTemplate>
                            <%--Botones de eliminar y editar cliente...--%>
                            <asp:Button ID="btnDelete" runat="server" Text="Inhabilitar" CssClass="btn btn-danger" CommandName="Delete" OnClientClick="return confirm('¿Desea Inhabilitar?');" />
                            <asp:Button ID="btnEdit" runat="server" CausesValidation="false" Text="Editar" CssClass="btn btn-info" CommandName="Edit" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            Tipo<br />
                            Inquilino
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td><%# TipoInquilino((int)Eval("tipo_inquilino")) %>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            Ubicación
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblInquilino" runat="server" Text='<%#Eval("appaterno").ToString() + Eval("apmaterno").ToString() + ", " + Eval("nombre").ToString() %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            Ocupantes
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td>Tel. Cel.:
                                    </td>
                                    <td><%# Eval("tel_cel")%></td>
                                </tr>
                                <tr>
                                    <td>Tel. Casa:
                                    </td>
                                    <td><%# Eval("tel_casa")%></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            Observaciones
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblCorreo" runat="server" Text='<%#Eval("correo") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <!-- Bootstrap Modal Dialog -->
    <div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <asp:UpdatePanel ID="upModal" runat="server" ChildrenAsTriggers="true" UpdateMode="Always">
                <ContentTemplate>
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">
                                <asp:Label ID="lblModalTitle" runat="server" Text="Ficha de inquilino"></asp:Label></h4>
                        </div>
                        <div class="modal-body" style="height: 600px;">
                            <div class="col-md-10">
                                <asp:Label runat="server" AssociatedControlID="rblTipo" CssClass="col-md-2 control-label">Tipo</asp:Label>
                                <asp:RadioButtonList ID="rblTipo" CssClass="radio-inline" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" AutoPostBack="false">
                                    <asp:ListItem class="radio-inline" Text="Dueño/responsable" Value="2"></asp:ListItem>
                                    <asp:ListItem class="radio-inline" Text="Inquilino" Value="1"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="rblTipo"
                                    CssClass="text-danger" ErrorMessage="El campo es obligatorio." />
                            </div>
                            <div class="col-md-10">
                                <asp:Label runat="server" AssociatedControlID="txtAppaterno" CssClass="col-md-5 control-labe">Apellido paterno</asp:Label>
                                <asp:TextBox runat="server" ID="txtAppaterno" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAppaterno"
                                    CssClass="text-danger" ErrorMessage="El campo es obligatorio." />
                            </div>
                            <div class="col-md-10">
                                <asp:Label runat="server" AssociatedControlID="txtApmaterno" CssClass="col-md-5 control-labe">Apellido materno</asp:Label>
                                <asp:TextBox runat="server" ID="txtApmaterno" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtApmaterno"
                                    CssClass="text-danger" ErrorMessage="El campo es obligatorio." />
                            </div>
                            <div class="col-md-10">
                                <asp:Label runat="server" AssociatedControlID="txtNombre" CssClass="col-md-5 control-labe">Nombre</asp:Label>
                                <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre"
                                    CssClass="text-danger" ErrorMessage="El campo es obligatorio." />
                            </div>
                            <div class="col-md-10">
                                <asp:Label runat="server" AssociatedControlID="txtTelcel" CssClass="col-md-5 control-labe">Tel. Cel.</asp:Label>
                                <asp:TextBox runat="server" ID="txtTelcel" CssClass="form-control" TextMode="Phone" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTelcel"
                                    CssClass="text-danger" ErrorMessage="El campo es obligatorio." />
                            </div>
                            <div class="col-md-10">
                                <asp:Label runat="server" AssociatedControlID="txtTelCasa" CssClass="col-md-5 control-labe">Tel. Casa</asp:Label>
                                <asp:TextBox runat="server" ID="txtTelCasa" CssClass="form-control" TextMode="Phone" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTelCasa"
                                    CssClass="text-danger" ErrorMessage="El campo es obligatorio." />
                            </div>
                            <div class="col-md-10">
                                <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-md-5 control-labe">Correo</asp:Label>
                                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" TextMode="Email" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                                    CssClass="text-danger" ErrorMessage="El campo es obligatorio." />
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                            <asp:Button ID="btnActualizar" runat="server" CssClass="btn btn-info" aria-hidden="true" Text="Actualizar" OnClick="btnActualizar_Click"></asp:Button>
                            <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-success" aria-hidden="true" Text="Guardar" OnClick="btnGuardar_Click"></asp:Button>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

</asp:Content>
