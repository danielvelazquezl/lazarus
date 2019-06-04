$(document).ready(function() {
    $("#provider_form").validate({
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        },
        rules: {
            "person[name]": { required: true },
            "person[phone]": { required: true },
            "provider[ruc]": { required: true }
        },
        messages: {
            "person[name]": "Campo obligatorio.",
            "provider[ruc]": "Campo obligatorio.",
            "person[phone]": "Campo obligatorio."
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});