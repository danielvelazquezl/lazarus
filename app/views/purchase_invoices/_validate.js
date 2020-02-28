$(document).ready(function() {
    $("#purchase_invoice_mov").validate({
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        },
        rules: {
            "purchase_invoice[stamped]": { required: true },
            "purchase_invoice[invoice_number]": { required: true },
            "purchase_invoice[date]": { required: true }
        },
        messages: {
            "purchase_invoice[stamped]": "Campo obligatorio.",
            "purchase_invoice[invoice_number]": "Campo obligatorio.",
            "purchase_invoice[date]": "Campo obligatorio."
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});