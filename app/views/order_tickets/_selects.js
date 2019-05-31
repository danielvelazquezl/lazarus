$(document).ready(function () {
    $('#order_ticket_client_id,#order_ticket_employee_id,#order_ticket_pay_method_id').selectize({
        create: true,
        sortField: 'text'
    });

});