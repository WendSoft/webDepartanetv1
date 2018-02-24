<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="generalPagos.aspx.cs" Inherits="webDepartanetv1.generalPagos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <script type="text/javascript">
            $(document).ready(function () {
                $(".clickArchivo").each(function () {
                    var a = 0;
                    $(this).click(function () {
                        displayDoc($(this).attr('title'));
                    });
                });
            });



            function displayDoc(args) {
                window.open("Archivos/" + args);
            }
        </script>
        <h4>Comprobantes de pago</h4>
        <hr />
        <asp:GridView ID="gvComprobantes" runat="server" AutoGenerateColumns="False" DataKeyNames="id,id_producto,id_usuario" CssClass="table table-bordered bs-table table-hover" OnSelectedIndexChanged="gvComprobantes_SelectedIndexChanged" OnSelectedIndexChanging="gvComprobantes_SelectedIndexChanging">
            <HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />
            <Columns>
                <%--botones de acción sobre los registros...--%>


                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200px">
                    <ItemTemplate>
                        <%--Botones de eliminar y editar cliente...--%>
                        <asp:Button ID="btnSelect" runat="server" Text="Confirmar comprobante" CssClass="btn btn-success" CommandName="Select" OnClientClick="return confirm('¿Desea confirmar el pago?');" OnClick="btnSelect_Click" />
                    </ItemTemplate>

                    <HeaderStyle Width="200px"></HeaderStyle>

                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField>
                    <HeaderTemplate>
                        Usuario
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblUsuario" runat="server" Text='<%#ObtenUsuario(Eval("id_usuario").ToString()) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <HeaderTemplate>
                        Comprobante
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblProducto" runat="server" Text='<%#ObtenProducto(int.Parse(Eval("id_producto").ToString())) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <HeaderTemplate>
                        Descripción
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblDescripcion" runat="server" Text='<%#Bind("descripcion") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center">
                    <HeaderTemplate>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Image ID="imgArchivo" CssClass="clickArchivo" runat="server" ImageUrl="~/img/Search-Images-icon.png" ToolTip='<%#Bind("nom_archivo") %>' />
                    </ItemTemplate>

                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                </asp:TemplateField>
                <asp:BoundField DataField="fecha_alta" HeaderText="Fecha alta" InsertVisible="False" ReadOnly="True" SortExpression="fecha_alta" ControlStyle-Width="70px">
                    <ControlStyle Width="70px"></ControlStyle>
                </asp:BoundField>
                <%--<asp:TemplateField>
                    <HeaderTemplate>
                        Fecha alta
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblFechaAlta" runat="server" Text='<%#Bind("fecha_alta") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>--%>
                <asp:TemplateField>
                    <HeaderTemplate>
                        Validado
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblValidado" runat="server" Text='<%#Bind("fecha_validado") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <HeaderTemplate>
                        Observaciones
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="txtObservaciones" TextMode="MultiLine" Text='<%#Eval("observaciones") %>' runat="server" Height="106px" Width="383px"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
