$.validator.addMethod("quantityRequired", $.validator.methods.required,
    "Campo obligatorio.");
$.validator.addMethod("quantityPositive", $.validator.methods.digits,
    $.validator.format("Cantidad debe ser un entero positivo."));
$.validator.addMethod("minQuantity", $.validator.methods.min,
    $.validator.format("Cantidad debe ser mayor a 0."));

$(document).ready(function() {
    $.validator.addClassRules("validame", {
        quantityRequired: true,
        quantityPositive: true,
        minQuantity: 1
    });
    $("#movement_form").validate({
        erroPlacement: function(error, element) {
            error.insertAfter(element);
        },
        rules: {
            "movement_proof[comment]": {
                required: true
            }
        },
        messages: {
            "movement_proof[comment]": "Campo obligatorio."
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});