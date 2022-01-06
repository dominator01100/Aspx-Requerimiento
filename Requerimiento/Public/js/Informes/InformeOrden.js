var $sd = $('#startDate'),
    $ed = $('#endDate');

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

jQuery.validator.addMethod(
    "valOrderStatus",
    function (value, element) {
        return (
            this.optional(element) ||
            /1|2|3/.test(value)
        );
    },
    'La orden seleccionada no es valida.'
);

$("#orderInforme").validate({
    onkeyup: false,

    rules: {
        ctl00$contenido$startDate: {
            required: function (element) {
                return ($ed.val().length > 0);
            },
            valFecha: true,
        },
        ctl00$contenido$endDate: {
            required: function (element) {
                return ($sd.val().length > 0);
            },
            valFecha: true,
        },
        ctl00$contenido$orderStatus: {
            valOrderStatus: true,
        },
    },

    messages: {
        ctl00$contenido$startDate: {
            required: 'La fecha de inicio es requerida.',
        },
        ctl00$contenido$endDate: {
            required: 'La fecha fin es requerida.',
        },
    },

    submitHandler: function (form) {
        form.submit();
    }
});
