$(document).ready(function() {
	
	var checkbox = $('#myCheckbox');
    var memNum = checkbox.data('num');
	
    var urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('mem_num') == memNum) {
        checkbox.prop('checked', true);
    }
    
	checkbox.change(function(event){
		if(this.checked){
			if(memNum == null || memNum == ''){
				alert('로그인 후 이용해주세요.');
				event.preventDefault();
                this.checked = false;
			}else{
			location.href='consultList?mem_num=' +memNum;
			this.checked;
			}
		}else{
			location.href='consultList';
		}
	});
});
