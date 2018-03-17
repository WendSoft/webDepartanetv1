<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="fichaDeptos.aspx.cs" Inherits="webDepartanetv1.fichaDeptos" %>

<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="form-horizontal">
        <h4>Departamentos</h4>
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />

        <div class="row">
            <div class="float-right">
                <asp:Button ID="btnAgregar" runat="server" CssClass="btn btn-success float-right" Style="float: right;" Text="Agregar Departamento" CausesValidation="false" OnClick="btnAgregar_Click"></asp:Button>
            </div>
            <asp:GridView ID="gvFichasDepartamentos" runat="server" AutoGenerateColumns="False" DataKeyNames="id" CssClass="table table-bordered bs-table table-hover" OnRowEditing="gvFichasDepartamentos_RowEditing" OnSelectedIndexChanged="gvFichasDepartamentos_SelectedIndexChanged" OnSelectedIndexChanging="gvFichasDepartamentos_SelectedIndexChanging">
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
                            Estatus
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblEstatus" runat="server" Text="Ocupado"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            Ubicación
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblUbicacionDepto" runat="server" Text="">
                           <%# construyeUbicacion((int)Eval("id"))%>
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
                                    <td>Dueño:
                                    </td>
                                    <td><%# ObtenOcupantes((int)Eval("id"),"dueño")%></td>
                                </tr>
                                <tr>
                                    <td>Inquilino responsable:
                                    </td>
                                    <td><%# ObtenOcupantes((int)Eval("id"),"responsable")%></td>
                                </tr>
                                <tr>
                                    <td>Inquilinos:
                                    </td>
                                    <td><%# ObtenOcupantes((int)Eval("id"),"inquilino")%></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            Observaciones
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblObservaciones" runat="server" Text='<%#Eval("observaciones") %>'></asp:Label>
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
                        <asp:Label ID="lblModalTitle" runat="server" Text="Ficha de departamento"></asp:Label></h4>
                </div>
                <div class="modal-body" style="height: 390px;">

                    <div class="col-md-8">
                        <asp:Label runat="server" AssociatedControlID="txtNumero" CssClass="col-md-3 control-label">Número</asp:Label>
                        <asp:TextBox runat="server" ID="txtNumero" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNumero"
                            CssClass="text-danger" ErrorMessage="El campo es obligatorio." />
                    </div>
                    <div class="col-md-8">
                        <asp:Label runat="server" AssociatedControlID="txtEdificio" CssClass="col-md-3 control-label">Edificio</asp:Label>
                        <asp:TextBox runat="server" ID="txtEdificio" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEdificio"
                            CssClass="text-danger" ErrorMessage="El campo es obligatorio." />
                    </div>
                    <div class="col-md-8">
                        <asp:Label runat="server" AssociatedControlID="txtEdificio" CssClass="col-md-3 control-label">Observaciones</asp:Label>
                        <asp:TextBox runat="server" ID="txtObservaciones" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEdificio"
                            CssClass="text-danger" ErrorMessage="El campo es obligatorio." />
                    </div>
                    <div class="col-md-8">
                        <asp:Label runat="server" AssociatedControlID="ddlDuenio" CssClass="col-md-3 control-label">Dueño</asp:Label>
                        <asp:DropDownList ID="ddlDuenio" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-8">
                        <asp:Label runat="server" AssociatedControlID="ddlResponsable" CssClass="col-md-3 control-label">Responsable</asp:Label>
                        <asp:DropDownList ID="ddlResponsable" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                    <asp:Button ID="btnActualizar" runat="server" CssClass="btn btn-info" data-dismiss="modal" aria-hidden="true" Text="Actualizar" OnClick="btnActualizar_Click"></asp:Button>
                    <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-success" aria-hidden="true" Text="Guardar" OnClick="btnGuardar_Click"></asp:Button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
