<%@ Page Title="Orden - Recibir" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="RecibirOrden.aspx.cs" Inherits="Requerimiento.Vistas.Orden.RecibirOrden" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <h1 class="text-center">Recibir Orden</h1>

    <form method="post" runat="server" id="formRecibirOrden" class="m-auto">
        <div class="row border border-primary m-auto mb-3 py-2">
            <div class="mb-3 col-12 row">
                <h2 class="offset-2 col-3">Número</h2>
                <asp:TextBox ID="txtNumero" runat="server" ReadOnly="true" CssClass="border-top-0 border-end-0 border-start-0 col-5"></asp:TextBox>
            </div>
            <div class="mb-3 col-12 row">
                <label class="offset-2 col-3">Fecha de Orden</label>
                <asp:TextBox ID="txtFechaOrden" runat="server" ReadOnly="true" CssClass="border-top-0 border-end-0 border-start-0 col-5"></asp:TextBox>
            </div>
            <div class="mb-3 col-12 row">
                <label class="offset-2 col-3">Proveedor</label>
                <asp:TextBox ID="txtProveedor" runat="server" ReadOnly="true" CssClass="border-top-0 border-end-0 border-start-0 col-5"></asp:TextBox>
            </div>
            <div class="col-12 row">
                <label class="offset-2 col-3">Fecha estimada de Entrega</label>
                <asp:TextBox ID="txtFechaEstimada" runat="server" ReadOnly="true" CssClass="border-top-0 border-end-0 border-start-0 col-5"></asp:TextBox>
            </div>
        </div>

        <asp:GridView ID="gvProductos" runat="server" CssClass="table table-striped border-secondary text-center mb-3" AutoGenerateColumns="False">
            <Columns>
                <asp:TemplateField HeaderText="Código">
                    <ItemTemplate>
                        <asp:TextBox ID="txtcodigoProducto" CssClass="text-center border-0" ReadOnly="true" runat="server" TextMode="Number" Text='<%# Eval("codigoProducto") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="nombreProducto" HeaderText="Nombre" />
                <asp:BoundField DataField="cantidadPedida" HeaderText="Cantidad Pedida" />
                <asp:BoundField DataField="precio" HeaderText="Precio" />
                <asp:TemplateField HeaderText="Cantidad Recibida">
                    <ItemTemplate>
                        <asp:TextBox ID="txtCantidadRecibida" CssClass="text-center" runat="server" min="1" TextMode="Number" /><br />
                        <asp:RangeValidator ControlToValidate="txtCantidadRecibida" MinimumValue="1" MaximumValue="999" Type="Integer"
                            Text="La cantidad debe estar entre 0 y 999." runat="server" Display="Dynamic" CssClass="text-danger" Font-Size="Small" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <div class="d-flex mb-3">
            <input id="btnRecibir" class="btn btn-primary btn-lg w-25" type="submit" value="Recibir" />
        </div>
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    <script src="../../Public/js/Orden/recibirOrden.js"></script>
</asp:Content>
