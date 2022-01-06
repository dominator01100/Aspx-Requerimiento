<%@ Page Title="Informe- Orden" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="InformeOrden.aspx.cs" Inherits="Requerimiento.Vistas.Informes.InformeOrden" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <h1 class="text-center">Informe Orden</h1>

    <form id="orderInforme" runat="server">
        <p class="fw-bold">Rango de fechas</p>
        <div class="row">
            <div class="mb-3 col-6">
                <asp:Label ID="lblstartDate" runat="server" Text="Fecha Inicio" AssociatedControlID="startDate" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="startDate" ClientIDMode="Static" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="mb-3 col-6">
                <asp:Label ID="lblendDate" runat="server" Text="Fecha Fin" AssociatedControlID="endDate" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="endDate" ClientIDMode="Static" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
            </div>
        </div>

        <div class="mb-3">
            <asp:Label ID="lblorderStatus" runat="server" Text="Estado de la Orden" AssociatedControlID="orderStatus" CssClass="form-label fw-bold"></asp:Label>
            <asp:DropDownList ID="orderStatus" CssClass="form-control" ClientIDMode="Static" runat="server">
                <asp:ListItem Value="" disabled="disabled" Selected="True" Text="-- Seleccione una opción --"></asp:ListItem>
                <asp:ListItem Value="1" Text="Pendiente"></asp:ListItem>
                <asp:ListItem Value="2" Text="Cancelada"></asp:ListItem>
                <asp:ListItem Value="3" Text="Recibida"></asp:ListItem>
            </asp:DropDownList>
        </div>

        <asp:Button ID="btnFiltrarOrden" runat="server" Text="Filtrar" CssClass="btn btn-primary btn-lg w-25 mb-3" OnClick="btnFiltrarOrden_Click" />

        <asp:GridView ID="gvInformeOrden" runat="server" CssClass="table table-responsive table-striped text-center mb-3" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="orden" HeaderText="Orden" />
                <asp:BoundField DataField="fechaOrden" HeaderText="Fecha de Orden" />
                <asp:BoundField DataField="nit" HeaderText="Nit" />
                <asp:BoundField DataField="nombreProveedor" HeaderText="Proveedor" />
                <asp:BoundField DataField="fechaEntrega" HeaderText="Fecha de Entrega" />
                <asp:BoundField DataField="PrecioTotal" HeaderText="Precio Total" />
                <asp:BoundField DataField="estado" HeaderText="Estado" />
            </Columns>
        </asp:GridView>
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    <script src="../../Public/js/Informes/InformeOrden.js"></script>
</asp:Content>
