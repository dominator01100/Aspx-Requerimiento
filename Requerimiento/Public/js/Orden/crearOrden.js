let contenedor = document.querySelector("#productsContainer"),
    selectInput = document.querySelector("#sltProducto"),
    btnAdd = document.querySelector("#btnAdd"),
    arreglo = [];

btnAdd.addEventListener("click", agregarProducto);

function agregarProducto() {
    let productoIndex = selectInput.selectedIndex,
        productoText = selectInput.options[selectInput.selectedIndex].text;
    productoValue = selectInput.value;

    if (arreglo.includes(productoIndex)) {
        Swal.fire(
            "Error!",
            "El producto seleccionado ya se encuentra en la lista.",
            "error"
        );
    } else {
        arreglo.push(productoIndex);
        const producto = document.createElement("div");
        producto.classList.add("mb-3");
        producto.classList.add("row");
        producto.setAttribute("id", `nodo${productoIndex}`);
        producto.innerHTML = `
            <div class="col-3">
                <span>${productoText}</span><input type="text" class="form-control col-3" id="producto${productoIndex}" name="producto${productoIndex}" value="${productoValue}" readonly hidden>
            </div>
            <div class="col-3">
                <input type="number" class="form-control col-3" id="cantidad${productoIndex}" name="cantidad${productoIndex}" min="1" placeholder="Cantidad">
            </div>
            <div class="col-3">
                <input type="number" class="form-control col-3" id="precio${productoIndex}" name="precio${productoIndex}" min="0" placeholder="Precio">
            </div>
            <div class="col-3">
            <button class="btn btn-warning" onclick="Remove(${productoIndex}); return false;"><i class="fas fa-trash"></i></button>
            </div>
        `;
        contenedor.appendChild(producto);
    }
}

function Remove(indice) {
    let nodoHijo = document.querySelector(`#nodo${indice}`);
    arreglo.splice(parseInt(indice), 1);
    contenedor.removeChild(nodoHijo);
}

/* VALIDACION DEL FORMULARIO */
jQuery.validator.addMethod(
    "valFecha",
    function (value, element) {
        return (
            this.optional(element) ||
            /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/.test(value)
        );
    },
    "El formato de fecha debe ser yyyy-mm-dd."
);

$("#crearOrden").validate({
    onkeyup: false,

    rules: {
        txtFechaOrden: {
            required: true,
            valFecha: true,
        },

        ctl00$contenido$ddlProveedor: {
            required: true,
        },

        txtFechaEstimada: {
            required: true,
            valFecha: true,
        },
    },

    messages: {
        txtFechaOrden: {
            required: "La fecha de la orden es requerida.",
        },

        ctl00$contenido$ddlProveedor: {
            required: "El Proveedor es requerido.",
        },

        txtFechaEstimada: {
            required: "La fecha estimada es requerida.",
        },
    },

    submitHandler: function (form, e) {
        e.preventDefault();
        crearOrden();
        crearProductos();
    },
});

function producto(producto, cantidadPedida, precio) {
    this.producto = producto;
    this.cantidadPedida = cantidadPedida;
    this.precio = precio;
}

function crearOrden() {
    let parametros = {
        numero: $("#txtNumeroOrden").val(),
        fechaOrden: $("#txtFechaOrden").val(),
        Proveedor: $("#ddlProveedor").val(),
        fechaEntrega: $("#txtFechaEstimada").val(),
    };

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        url: "CrearOrden.aspx/generarOrden",
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

function crearProductos() {
    arreglo.forEach(i => {
        let producto = {
            Producto: document.querySelector(`#producto${arreglo[i]}`).value,
            Cantidad: document.querySelector(`#cantidad${arreglo[i]}`).value,
            Precio: document.querySelector(`#precio${arreglo[i]}`).value,
            Orden: $("#txtNumeroOrden").val(),
        }
    
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: "CrearOrden.aspx/CrearProductosEnOrden",
            data: JSON.stringify(producto),
            async: false,
            success: function (response) {
                Swal.fire("Éxito!", response.d.StatusDescription, "success");
            },
            error: function (response, status, error) {
                Swal.fire("Error!", response.d.StatusDescription, "error");
            },
        });
    });  
}

function ejecutar() {
    $.when(crearOrden).then(crearProductos);
}
