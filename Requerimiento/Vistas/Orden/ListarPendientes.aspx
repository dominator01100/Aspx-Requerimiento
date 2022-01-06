<%@ Page Title="Orden - Listar Pendientes" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ListarPendientes.aspx.cs" Inherits="Requerimiento.Vistas.Orden.ListarPendientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <h1 class="text-center">Ordenes Pendientes</h1>

    <form class="mb-3" method="post" id="ListarPendientes" runat="server">
        <div class="d-flex justify-content-center gap-2">
            <p class="mb-0">Seleccione la fecha para filtrar los resultados:</p>
            <asp:TextBox runat="server" TextMode="Date" ID="txtfiltroFecha" />
        </div>

        <div class="d-flex justify-content-center mb-3">
            <asp:Button Text="Buscar" runat="server" CssClass="btn btn-primary" OnClick="btnFiltro_Click" />
        </div>

        <asp:GridView ID="gvPendientes" runat="server" CssClass="table table-responsive table-striped text-center" AutoGenerateColumns="False" OnRowCommand="gvPendientes_RowCommand">
            <columns>
                <asp:BoundField DataField="numero" HeaderText="Número de Orden" />
                <asp:BoundField DataField="Nit" HeaderText="Nit" />
                <asp:BoundField DataField="Proveedor" HeaderText="Proveedor" />
                <asp:BoundField DataField="FechaOrden" HeaderText="Fecha de Orden" />
                <asp:BoundField DataField="FechaEstimada" HeaderText="Fecha Estimada" />
                <asp:BoundField DataField="PrecioTotal" HeaderText="Precio Total" />
                <asp:TemplateField>
                    <itemtemplate>
                        <asp:Button runat="server" ID="btnRun" Text="Recibir" CssClass="btn btn-success" CommandName="Recibir" CommandArgument='<%# Eval("numero") %>'/>
                    </itemtemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <itemtemplate>
                        <button type="button" class="btn btn-danger click" data-bs-toggle="modal" data-bs-target='<%# string.Concat("#cancelarModal", Eval("numero"))%>' id='<%# string.Concat("btnModalCancel", Eval("numero"))%>'>
                            Cancelar
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id='<%# string.Concat("cancelarModal", Eval("numero"))%>' tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Cancelar Orden</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        ¿Está seguro de cancelar la orden?
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick='<%# string.Concat("deleteOrder(", Eval("numero"), ");")%>'>Sí</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </itemtemplate>
                </asp:TemplateField>
            </columns>
        </asp:GridView>
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    <script src="../../Public/js/Orden/listarPendientes.js"></script>
</asp:Content>
