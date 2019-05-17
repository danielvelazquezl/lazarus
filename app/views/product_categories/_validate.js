$(document).ready(function() {
    $("#product_category_form").validate({
        //error place
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        },
        rules: {
            "product_category[description]": {
                required: true,
                description: true
            }
        },
        messages: {
            "product_category[description]": "Campo obligatorio."
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});