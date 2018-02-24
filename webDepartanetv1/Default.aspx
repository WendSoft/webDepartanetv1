<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="webDepartanetv1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>DEPARTA.NET</h1>
        <p class="lead">DEPARTA.NET Es el gestór de información que tu condominio necesita</p>
        <%--<p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>--%>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>Cómo empezar</h2>
            <p>
                Si cuentas con usuario y contraseña, ingresa a "Iniciar Sesión", en caso contrario, te invitamos a registrarte en "Resitrarte"
            </p>
            <%--<p>
                <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301948">Learn more &raquo;</a>
            </p>--%>
        </div>
        <div class="col-md-4">
            <h2>Gestión de condominios</h2>
            <p>
                Gestiona la información de tus inquilinos
            </p>

            <%--<p>
                <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301949">Learn more &raquo;</a>
            </p>--%>
        </div>
        <div class="col-md-4">
            <h2>Reporte de pagos</h2>
            <p>
                Registra pagos de cualquier tipo
            </p>
            <%--<p>
                <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301950">Learn more &raquo;</a>
            </p>--%>
        </div>
    </div>

</asp:Content>
