$(document).ready(function() {
    $("#client_form").validate({
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        },
        rules: {
            "person[name]": { required: true },
            "person[phone]": { required: true },
            "client[ruc]": { required: true }
        },
        messages: {
            "person[name]": "Campo obligatorio.",
            "client[ruc]": "Campo obligatorio.",
            "person[phone]": "Campo obligatorio."
        },
        submitHandler: function(form) {
            form.submit();
        }
    }); 
});