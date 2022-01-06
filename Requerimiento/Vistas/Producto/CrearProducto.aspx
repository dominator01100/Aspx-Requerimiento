<%@ Page Title="Producto - Crear" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="CrearProducto.aspx.cs" Inherits="Requerimiento.Vistas.Producto.CrearProducto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <h1 class="text-center">Crear Producto</h1>

    <form class="mb-3" method="post" id="crearProducto">
        <div class="mb-3">
            <label for="txtNombreProducto" class="form-label">Nombre del Producto</label>
            <input type="text" class="form-control" id="txtNombreProducto" name="txtNombreProducto" minlength="3" maxlength="30">
        </div>

        <input id="btnCrear" class="btn btn-primary btn-lg w-25" type="submit" value="Crear" />
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    <script src="../../Public/js/Producto/crearProducto.js"></script>
</asp:Content>
