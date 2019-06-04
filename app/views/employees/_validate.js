$(document).ready(function() {
    $("#employee_form").validate({
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        },
        rules: {
            "person[name]": { required: true },
            "employee[ci]": { required: true },
            "employee[sex]": { required: true },
            "employee[charge]": { required: true },
            "employee[birth_date": { required: true },
            "person[email]": { required: true }
        },
        messages: {
            "person[name]": "Campo obligatorio.",
            "employee[ci]": "Campo obligatorio.",
            "employee[sex]": "Campo obligatorio.",
            "employee[charge]": "Campo obligatorio.",
            "employee[birth_date": "Campo obligatorio.",
            "person[email]": "Campo obligatorio."
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});