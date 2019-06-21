$(document).ready(function() {
    $("#sales_invoice_mov").validate({
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        },
        rules: {
            "sales_invoice[invoice_number]": { required: true },
            "sales_invoice[date]": { required: true }
        },
        messages: {
            
            "sales_invoice[invoice_number]": "Campo obligatorio.",
            "sales_invoice[date]": "Campo obligatorio."
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});