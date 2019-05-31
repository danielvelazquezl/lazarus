//let pay_value;

$(document).ready(function(){
    hideElements(true,true,true);
    $('.remove_fields').hide();
    $('.pay_method_value').selectize({
        create: false,
        sortField: 'text'
    });
});

$(document).on('click','.add_fields',function (e) {
    let fields = $('fieldset');
    $('fieldset').last().children().first().children().first().find('.pay_method_value').selectize({
        create: false,
        sortField: 'text'
    });
    //console.log($('fieldset').last().children().first().children().first().find('.pay_method_value'));
});

$(document).on('change', '.pay_method_value', function (e) {
   let pay_value = $('#'+e.target.id+' option:selected').text();
    console.log(pay_value);
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


function hideElements(id,check,bank,creditCard){
    //se busca el padre del padre del text field, de ahi se busca cual columna mostrar
    const parentElem = $('#'+id).parent().parent();
    (bank == true)? parentElem.find('.bank').addClass('d-none') : parentElem.find('.bank').removeClass('d-none');
    (creditCard == true)? parentElem.find('.credit-card').addClass('d-none') : parentElem.find('.credit-card').removeClass('d-none');
    (check == true)? parentElem.find('.check').addClass('d-none') : parentElem.find('.check').removeClass('d-none');
}
