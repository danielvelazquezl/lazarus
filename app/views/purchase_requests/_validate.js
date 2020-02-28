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
    $("#purchase_request_form").validate({
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});