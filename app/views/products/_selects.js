$(document).ready(function () {
    $('#product_product_category_id, #product_brand_id').selectize({
        create: true,
        sortField: 'text'
    });

    /*$(document).on('click','.add_fields',function(){
        $('#product_product_items_attributes_0_component_id').selectize({
            create: true,
            sortField: 'text'
        })
    });*/
});