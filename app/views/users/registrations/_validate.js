$(document).ready(function() {
    $("#new_user_form").validate({
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        },
        rules: {
            "user[user_name]": {
                required: true
            },
            "user[email]": {
                required: true,
                email: true
            },
            "user[password]": {
                required: true,
                minlength: 6
            },
            "user[password_confirmation]": {
                required: true,
                equalTo: "#user_password"
            }
        },
        messages: {
            "user[user_name]": "Campo obligatorio.",
            "user[email]": {
                required: "Campo obligatorio.",
                email: "Dirección de correo inválida. Ej: example@dominio.com.",
                remote: "Ya existe esta dirección de correo."
            },
            "user[password]": {
                required: "Campo obligatorio.",
                minlength: "6 caracteres como minimo."
            },
            "user[password_confirmation]": {
                required: "Campo obligatorio.",
                equalTo: "Las contraseñas no coinciden.",
                minlength: "6 caracteres como minimo."
            }
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});