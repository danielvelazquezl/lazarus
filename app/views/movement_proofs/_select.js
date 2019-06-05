$(document).ready(function () {
    $('#movement_proof_person_id, #movement_proof_deposit_id, #movement_proof_movement_type_id, .component-select').selectize({
        create: false,
        sortField: 'text'
    });
});