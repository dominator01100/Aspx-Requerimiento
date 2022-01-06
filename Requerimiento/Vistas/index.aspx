<%@ Page Title="Requerimiento - Inicio" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Requerimiento.Vistas.index" %>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <h1 class="text-center mb-3">REQUERIMIENTO</h1>

    <h2>REQUERIMIENTO DE USUARIO:</h2>

    <p>
        Como empresa que trabaja en el sector de la tecnología requiero tener control de las compras que realizo a mis proveedores. Tengo varios proveedores de los mismos productos cada uno maneja precios diferentes, el proceso inicia con una orden de compra que necesitamos registrar en el sistema, la cual tiene el detalle de lo que se requiere pedir al proveedor, en el momento en que llega la mercancía se debe poder buscar la orden de compra y registrarle la cantidad recibida y el precio, estas cantidades se deben almacenar en el sistema para poder tener dos informes que se requieren:
    </p>

    <ol>
        <li>Las compras que se le realizaron.</li>
        <li>El total del producto recibido en el sistema.</li>
    </ol>

    <h2>DETALLE DE LA SOLICITUD:</h2>

    <p><span class="fw-bold">Orden de compra:</span> Se requiere un formulario de creación de orden de compra que tenga los siguientes campos:</p>

    <ul>
        <li>Encabezado: Numero de orden de compra (generado automático al crear el documento), Fecha orden, proveedor, fecha estimada de entrega</li>
        <li>Detalle: Producto, cantidad, precio</li>
        <li>Se permite adicionar varios productos, editar y eliminar</li>
    </ul>

    <p><span class="fw-bold">Recepción de mercancía:</span> opción de consultar las órdenes de compra que están pendientes por recibirse, debe tener un filtro por fecha y cuando se consulte deben aparecer las siguientes columnas:</p>

    <ul>
        <li>Numero de orden de compra</li>
        <li>Proveedor (nit y nombre)</li>
        <li>Fecha de la orden</li>
        <li>Fecha estimada</li>
        <li>Precio total</li>
        <li>Botón para recibir la orden</li>
        <li>Botón para cancelar la orden</li>
    </ul>

    <p>Al dar clic en el botón para recibir orden de compra el sistema debe mostrar el encabezado y el detalle de la orden de compra (solo para consulta), debe colocarse al lado de la cantidad un campo que si es editable en el cual se permitirá registrar las cantidades recibidas de cada producto (este es el único campo que se permite editar), debe aparecer un botón de guardar todo en el cual se confirme que se van a recibir esas cantidades para esa orden de compra, cuando la orden este recibida debe desaparecer del listado de pendientes.</p>

    <p>Al dar clic en el botón cancelar orden, el sistema debe preguntar si esta seguro que desea cancelar la orden y al confirmar se debe cancelar y no debe aparecer en el listado de pendientes.</p>

    <h2>INFORMES</h2>

    <ol>
        <li>
            <p>
                Se requiere consulta donde se filtre por un rango de fechas o por el estado de la orden de compra, en la cual aparezca la información siguiente en el detalle:
Numero de orden de compra, fecha de la orden, proveedor (nit y nombre) fecha de entrega del producto, fecha de registro en el sistema en el momento de la entrega, precio total de la orden y estado de la orden.
            </p>
        </li>

        <li>
            <p>Se requiere una consulta donde se filtre por un rango de fechas o por un producto que muestre la siguiente información:</p>
            <ul>
                <li>Código del producto, descripción del producto, cantidad total de producto pedido, cantidad total del producto recibido, precio promedio, precio promedio total y Botón de ver detalles (este botón solo se habilita para las ordenes que hayan sido recibidas, las demás debe mostrar el botón oculto).</li>
                <li>Al dar clic en el botón de ver detalles el sistema debe abrir una ventana emergente donde se muestre el numero de la orden de compra, fecha de recepcion, proveedor (nit y nombre) de las ordenes de compra recibidas que contienen el producto seleccionado.</li>
            </ul>
        </li>
    </ol>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
</asp:Content>
