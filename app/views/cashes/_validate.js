$(document).ready(function () {
    $("#cashes_form").validate({
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        },
        rules: {
            "cash[description]": {
                required: true
            }
        },
        messages: {
            "cash[description]": "Campo obligatorio."
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});