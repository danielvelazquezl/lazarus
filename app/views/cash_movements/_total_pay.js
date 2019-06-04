
document.addEventListener('click',(event) => {
   if (event.target.matches('.pay_check')) {
     let checkedInvoices = 0;

     let invoiceValue = parseInt(event.target.dataset.invoiceValue);
     let totalField = document.getElementById("total-field");
     let lastValue = totalField.value;

     let balanceField = document.getElementById("balance-field");
     let balanceLastValue = balanceField.value;

     if(event.target.checked){
       totalField.value = (lastValue === '')? invoiceValue : parseInt(lastValue) + invoiceValue;
       balanceField.value = (balanceLastValue === '')?  invoiceValue : parseInt(balanceLastValue) + invoiceValue;

       //totalField.value = totalField.value.toLocaleString('es');
       //balanceField.value = balanceField.value.toLocaleString('es')
       ++ checkedInvoices;
     }
     else {
       totalField.value = (lastValue === '')? 0 : parseInt(lastValue) - invoiceValue;
       balanceField.value = (balanceLastValue === '')? 0 : parseInt(balanceLastValue) - invoiceValue;
       -- checkedInvoices;
     }

     document.getElementById('pay-btn').disabled = (0 >= checkedInvoices);
   }
 });

//reiniciar campos de montos al buscar facturas de cliente
$('#search-invoices').click(function () {


    $('#total-field').val('');
    $('#balance-field').val('');
    $('#pay-field').val('');
    $('#pay-btn').prop('disabled', true);

});







