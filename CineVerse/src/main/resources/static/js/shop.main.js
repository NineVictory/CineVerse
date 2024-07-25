$(function() {
	
    const queryParams = new URLSearchParams(window.location.search);

    function updateQueryParam() {
        const isChecked = $('.checkQuantity').is(':checked');
        
        if (isChecked) {
            queryParams.set('p_quantity', '1');
        } else {
            queryParams.delete('p_quantity');
        }
        
        window.location.search = queryParams.toString();
    }

    $('.checkQuantity').change(function(event) {
        updateQueryParam();
    });
});
