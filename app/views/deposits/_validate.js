$(document).ready(function() {
    $("#deposit_form").validate({
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        },
        rules: {
            "deposit[description]": {
                required: true,
                description: true
            }
        },
        messages: {
            "deposit[description]": "Campo obligatorio."
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});