$.validator.addMethod("quantityRequired", $.validator.methods.required,
    "Campo obligatorio.");

$.validator.addMethod("quantityPositive", $.validator.methods.digits,
    $.validator.format("Cantidad debe ser un entero positivo."));

$.validator.addMethod("minQuantity", $.validator.methods.min,
    $.validator.format("Cantidad debe ser mayor a 0."));

$.validator.addMethod("Required", $.validator.methods.required,
    $.validator.format("Campo obligatorio."));

$(document).ready(function () {
    $.validator.addClassRules({
        validame: {
            required: true,
            digits: true,
            min: 1
        },
        validame2: {
            required: true
        }
    });
    /*jQuery.validator.addClassRules("validame2", {
        Required: true
    });
    jQuery.validator.addClassRules("validame", {
        quantityRequired: true,
        quantityPositive: true,
        minQuantity: 1
    });*/
    $("#cash_movement_form").validate({
        errorPlacement: function(error, element) {
            error.appendTo(element.parent("td").next("td"));
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});