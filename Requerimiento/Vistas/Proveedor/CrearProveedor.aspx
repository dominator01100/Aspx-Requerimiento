<%@ Page Title="Proveedor - Crear" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="CrearProveedor.aspx.cs" Inherits="Requerimiento.Vistas.Proveedor.CrearProveedor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <h1 class="text-center">Crear Proveedor</h1>
    
    <form class="mb-3" method="post" id="crearProveedor">
        <div class="mb-3">
            <label for="txtNombreProveedor" class="form-label">Nombre del Proveedor</label>
            <input type="text" class="form-control" id="txtNombreProveedor" name="txtNombreProveedor" minlength="3" maxlength="30">
        </div>

        <input id="btnCrear" class="btn btn-primary btn-lg w-25" type="submit" value="Crear" />
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    <script src="../../Public/js/Proveedor/crearProveedor.js"></script>
</asp:Content>