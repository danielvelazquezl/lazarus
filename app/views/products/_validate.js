$.validator.addMethod("quantityRequired", $.validator.methods.required,
"Campo obligatorio.");
$.validator.addMethod("quantityPositive", $.validator.methods.digits,
    $.validator.format("Cantidad debe ser mayor un entero positivo."));
$.validator.addMethod("minQuantity", $.validator.methods.min,
    $.validator.format("Cantidad debe ser mayor a 0."));

$(document).ready(function () {
    jQuery.validator.addClassRules("validame", {
        quantityRequired: true,
        quantityPositive: true,
        minQuantity: 1
    });
    $("#product_form").validate({
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        },
        submitHandler: function() {
            $("#product_form").get(0).submit(1);
        }
    });
    $("#component_form").validate({
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        },
        rules: {
            "product[description]": {
                required: true
            }
        },
        messages: {
            "product[description]": "Campo obligatorio."
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});