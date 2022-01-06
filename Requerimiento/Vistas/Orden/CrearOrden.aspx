<%@ Page Title="Orden - Crear" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="CrearOrden.aspx.cs" Inherits="Requerimiento.Vistas.Orden.CrearOrden" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <h1 class="text-center">Crear Orden</h1>

    <form class="mb-3" method="post" id="crearOrden" runat="server">

        <h2>Encabezado</h2>

        <div class="mb-3">
            <label for="txtNumeroOrden" class="form-label">Número de Orden</label>
            <asp:TextBox ID="txtNumeroOrden" CssClass="form-control" runat="server" ClientIDMode="Static" ReadOnly="true"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label for="txtFechaOrden" class="form-label">Fecha de Orden</label>
            <input type="date" class="form-control" id="txtFechaOrden" name="txtFechaOrden">
        </div>

        <div class="mb-3">
            <label for="ddlProveedor" class="form-label">Proveedor</label>
            <asp:DropDownList ID="ddlProveedor" runat="server" ClientIDMode="Static" CssClass="form-control">
            </asp:DropDownList>
        </div>

        <div class="mb-3">
            <label for="txtFechaEstimada" class="form-label">Fecha Estimada de Entrega</label>
            <input type="date" class="form-control" id="txtFechaEstimada" name="txtFechaEstimada">
        </div>

        <h2>Detalle</h2>

        <div class="mb-3">
            <label for="sltProducto" class="form-label">Productos: <span class="text-muted">Seleccione el producto y agréguelo con el botón.</span></label>
            <asp:DropDownList ID="sltProducto" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:DropDownList>
        </div>

        <div class="mb-3">
            <input type="button" id="btnAdd" value="Añadir Producto" class="btn btn-primary" />
        </div>

        <div class="mb-3" id="productsContainer">
        </div>

        <input id="btnCrear" class="btn btn-primary btn-lg w-25" type="submit" value="Crear" />
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    <script src="../../Public/js/Orden/crearOrden.js"></script>
</asp:Content>
