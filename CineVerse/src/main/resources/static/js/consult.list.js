$(document).ready(function() {
	
	var checkbox = $('#myCheckbox');
    var memNum = checkbox.data('num');

    var urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('mem_num') == memNum) {
        checkbox.prop('checked', true);
    }
    
	checkbox.change(function(){
		if(this.checked){
			location.href='consultList?mem_num=' +memNum;
			this.checked;
		}else{
			location.href='consultList';
		}
	});
});
