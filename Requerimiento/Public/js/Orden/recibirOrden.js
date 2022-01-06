$("#formRecibirOrden").validate({
    submitHandler: function (form, e) {
        e.preventDefault();
        modificarOrden();
        modificarProductos();
    },
});

function modificarOrden() {
    let parametros = {
        numero: $("#contenido_txtNumero").val(),
    };

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        url: "RecibirOrden.aspx/actualizarOrden",
        data: JSON.stringify(parametros),
        async: false,
        success: function (response) {
            Swal.fire("Éxito!", response.d.StatusDescription, "success");
        },
        error: function (response, status, error) {
            Swal.fire("Error!", response.d.StatusDescription, "error");
        },
    });
}

function modificarProductos() {
    let i = 0;
    let count = $("#contenido_gvProductos>tbody>tr").length;
    count = parseInt(count);
    count = count - 1;

    while (i < count) {
        let producto = {
            Producto: document.querySelector(
                `#contenido_gvProductos_txtcodigoProducto_${i}`
            ).value,
            Cantidad: document.querySelector(
                `#contenido_gvProductos_txtCantidadRecibida_${i}`
            ).value,
            Orden: $("#contenido_txtNumero").val(),
        };
        i++;

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: "RecibirOrden.aspx/actualizarProductos",
            data: JSON.stringify(producto),
            async: false,
            success: function (response) {
                Swal.fire("Éxito!", response.d.StatusDescription, "success");
            },
            error: function (response, status, error) {
                Swal.fire("Error!", response.d.StatusDescription, "error");
            },
        });
    }
}
