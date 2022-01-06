$("#crearProducto").validate({
    onkeyup: false,

    rules: {
        txtNombreProducto: {
            required: true,
            normalizer: function (value) {
                return (this.value = $.trim(value));
            },
            minlength: 5,
            maxlength: 30,
        },
    },

    messages: {
        txtNombreProducto: {
            required: "El nombre del producto es obligatorio.",
            minlength: "El nombre debe contener al menos 5 caracteres.",
            maxlength: "El nombre debe contener como máximo 30 caracteres.",
        },
    },

    submitHandler: function (form) {
        let parametros = {
            Nombre: $("#txtNombreProducto").val(),
        };

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: "CrearProducto.aspx/crearProducto",
            data: JSON.stringify(parametros),
            success: function (response) {
                Swal.fire(
                    'Éxito!',
                    response.d.StatusDescription,
                    'success'
                  );
            },
            error: function (response, status, error) {
                Swal.fire(
                    'Error!',
                    response.d.StatusDescription,
                    'error'
                  );
            },
        });

        document.querySelector("#txtNombreProducto").value = "";
    },
});