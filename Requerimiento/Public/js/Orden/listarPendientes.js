jQuery.validator.addMethod(
    "filtroFecha",
    function (value, element) {
        // allow any non-whitespace characters as the host part
        return (
            this.optional(element) ||
            /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/.test(value)
        );
    },
    "El formato de fecha debe ser yyyy-mm-dd."
);

$("#ListarPendientes").validate({
    onkeyup: false,

    rules: {
        ctl00$contenido$txtfiltroFecha: {
            required: true,
            filtroFecha: true,
        },
    },

    messages: {
        ctl00$contenido$txtfiltroFecha: {
            required: "La fecha es requerida.",
        },
    },

    submitHandler: function (form) {
        form.submit();
    },
});

function deleteOrder(orden) {
    let parametros = {
        Orden: orden,
    };

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "dataType",
        url: "ListarPendientes.aspx/cancelarOrden",
        data: JSON.stringify(parametros),
        success: function (response) {
        },
        error: function (response, status, error) {
            deleteRow(orden);
        },
    });
}

function deleteRow(orden) {
    const nodo = document.querySelector(`#btnModalCancel${orden}`).parentNode
        .parentNode,
        tabla = document.querySelector("tbody");
    tabla.removeChild(nodo);
}
