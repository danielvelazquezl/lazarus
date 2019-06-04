
//se esconden campos de forma de pago que no sean Efectivo
$(document).ready(function(){
    hideElements(true,true,true);
    $('.remove_fields').hide();
    //se pone selectize a selector de formas de pago
    $('.pay_method_value').selectize({
        create: false,
        sortField: 'text'
    });
});
//para poner selectize cuando se agrega otra forma de pago
$(document).on('click','.add_fields',function (e) {
    //let fields = $('fieldset');
    $('fieldset').last().children().first().children().first().find('.pay_method_value').selectize({
        create: false,
        sortField: 'text'
    });
    //se quita saldo actual
    let balance = $('#balance-field').val();
    //se setea en nuevo campo de forma a pagar saldo pendiente
    //en pago
    $('fieldset').last().children().first().children('#amount_div').find('.amount-value').val((balance === '')? 0: balance);

});
//si se elige una forma de pago
$(document).on('change', '.pay_method_value', function (e) {
   let pay_value = $('#'+e.target.id+' option:selected').text();
    console.log(pay_value);
    //se esconden campos que no sean necesarios mostrar
    switch(pay_value) {
        case 'Efectivo':
            hideElements(e.target.id, true,true,true);
            break;
        case 'Tarjeta de credito':
            hideElements(e.target.id,true,true,false);
            break;
        case 'Cheque':
            hideElements(e.target.id,false,false,true);
            break;
        default:

    }
});

//funcion para esconder campos de form de forma de pago
function hideElements(id,check,bank,creditCard){
    //se busca el padre del padre del text field, de ahi se busca cual columna mostrar
    const parentElem = $('#'+id).parent().parent();
    (bank == true)? parentElem.find('.bank').addClass('d-none') : parentElem.find('.bank').removeClass('d-none');
    (creditCard == true)? parentElem.find('.credit-card').addClass('d-none') : parentElem.find('.credit-card').removeClass('d-none');
    (check == true)? parentElem.find('.check').addClass('d-none') : parentElem.find('.check').removeClass('d-none');
}
