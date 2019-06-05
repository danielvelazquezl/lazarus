$.validator.addMethod("quantityRequired", $.validator.methods.required,
    "Campo obligatorio.");
$.validator.addMethod("quantityPositive", $.validator.methods.digits,
    $.validator.format("Cantidad debe ser un entero positivo."));
$.validator.addMethod("minQuantity", $.validator.methods.min,
    $.validator.format("Cantidad debe ser mayor a 0."));

$(document).ready(function() {
    jQuery.validator.addClassRules("validame", {
        quantityRequired: true,
        quantityPositive: true,
        minQuantity: 1
    });
    $("#movement_form").validate({
        errorPlacement: function(error, element) {
            error.appendTo(element.parent("td").next("td"));
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});