let checkedInvoices = 0
//let invoicesId = []
 document.addEventListener('click', (event) => {
   if (event.target.matches('.pay_check')) {
       const invoiceId = event.target.id
       const invoiceValue = parseInt(event.target.dataset.invoiceValue);
       let field = document.getElementById("total-field");
       const lastValue = document.getElementById("total-field").value;

       //invoicesId.push(invoiceId)

     if(event.target.checked){
       field.value = (lastValue == '')? 0 + invoiceValue : parseInt(lastValue) + invoiceValue;
       ++ checkedInvoices;
     }
     else {
       field.value = (lastValue == '')? 0 : parseInt(lastValue) - invoiceValue;
       -- checkedInvoices;
     }

     if(checkedInvoices <= 0){
         document.getElementById('pay-btn').disabled = true;
     }
     else{
         document.getElementById('pay-btn').disabled = false;
     }
   }
 });

