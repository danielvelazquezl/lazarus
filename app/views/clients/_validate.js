$(document).ready(function() {
    $("#client_form").validate({
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        },
        rules: {
            "client[name]": { required: true },
            "client[ruc]": { required: true }
        },
        messages: {
            "client[name]": "Campo obligatorio.",
            "client[ruc]": "Campo obligatorio."
        },
        submitHandler: function(form) {
            form.submit();
        }
    }); 
});