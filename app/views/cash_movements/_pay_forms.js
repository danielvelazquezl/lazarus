let value = ''

$(document).ready(function(){
    hideElements(true,true,true)
    $('.remove_fields').hide()
})

$(document).on('change', '#pay_method_value_id', function (e) {
    value = $('#pay_method_value_id option:selected').text();

    switch(value) {
        case 'Efectivo':
            hideElements(true,true,true)
            break;
        case 'Tarjeta de credito':
            hideElements(true,true,false)
            break;
        case 'Cheque':
            hideElements(false,true,true)
            break;
        default:

    }
});

$('#myform').submit(function() {
   return false
});

function hideElements(check,bank,creditCard){

    (bank == true)? $('.bank').addClass('d-none') : $('.bank').removeClass('d-none');
    (creditCard == true)? $('.credit-card').addClass('d-none') : $('.credit-card').removeClass('d-none');
    (check == true)? $('.check').addClass('d-none') : $('.check').removeClass('d-none');
}
