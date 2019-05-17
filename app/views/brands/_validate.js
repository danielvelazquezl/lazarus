$(document).ready(function () {
    $("#brand_form").validate({
        //error place
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        },
        //rules
        rules: {
            "brand[description]": {
                required: true,
                description: true
            }
        },
        //error messages
        messages: {
            "brand[description]": "Campo obligatorio."
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});