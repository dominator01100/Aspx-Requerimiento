<%@ Page Title="Informe - Producto" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="InformeProductos.aspx.cs" Inherits="Requerimiento.Vistas.Informes.InformeProductos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <h1 class="text-center">Informe Productos</h1>

    <form id="orderProducts" runat="server">
        <p class="fw-bold" style="display:none;">Rango de fechas</p>
        <div class="row" style="display:none;">
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
            <asp:Label ID="lblProductos" runat="server" Text="Producto" AssociatedControlID="ddlProductos" CssClass="form-label fw-bold"></asp:Label>
            <asp:DropDownList ID="ddlProductos" CssClass="form-control" ClientIDMode="Static" runat="server">
            </asp:DropDownList>
        </div>

        <asp:Button ID="btnFiltrarProductos" runat="server" Text="Filtrar" CssClass="btn btn-primary btn-lg w-25 mb-3" OnClick="btnFiltrarProductos_Click" />

        <asp:GridView ID="gvInformeOrden" runat="server" CssClass="table table-responsive table-striped text-center mb-3" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="producto" HeaderText="Código de Producto" />
                <asp:BoundField DataField="CantidadP" HeaderText="Cantidad Total Pedida" />
                <asp:BoundField DataField="CantidadR" HeaderText="Cantidad Total Recibida" />
                <asp:BoundField DataField="PrecioP" HeaderText="Precio Promedio" />
                <asp:BoundField DataField="PrecioT" HeaderText="Precio Total" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton type="button" ID="btnOMI" runat="server" Text="Info" ClientIDMode="Static" CssClass="btn btn-primary" UseSubmitBehavior="false" data-bs-toggle="modal" data-bs-target="#productModal" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <!-- Modal -->
        <div class="modal" id="productModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">Modal Heading</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <asp:GridView ID="gvInfo" runat="server" CssClass="table table-table-striped text-center" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="numero" HeaderText="Orden" />
                                <asp:BoundField DataField="fechaEntrega" HeaderText="Fecha de Entrega" />
                                <asp:BoundField DataField="nit" HeaderText="Nit" />
                                <asp:BoundField DataField="nombreProveedor" HeaderText="Proveedor" />
                            </Columns>

                        </asp:GridView>
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    <script src="../../Public/js/Informes/InformeProductos.js"></script>
</asp:Content>
