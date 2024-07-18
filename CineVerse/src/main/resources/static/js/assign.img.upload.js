$(document).ready(function() {
    $('#ab_upload').on('change', function(event) {
        const preview = $('#preview');
        const files = event.target.files;
        
        const MAX_FILE_SIZE = 4000 * 1024 * 1024; // 4000MB
  	  	const MAX_TOTAL_SIZE = 6000 * 1024 * 1024; // 6000MB
   		const MAX_FILE_COUNT = 3;

        // 이미 존재하는 파일명 목록 가져오기
        const existingFileNames = preview.find('.preview-image').map(function() {
            return $(this).attr('data-filename');
        }).get();

        // 새로 추가된 파일 중에서 중복되지 않는 파일 필터링
        const uniqueFiles = Array.from(files).filter(file => {
            return !existingFileNames.includes(file.name);
        });

        // 새로 추가된 파일 수
        const newFilesCount = uniqueFiles.length;

        // 이미 존재하는 미리보기 이미지 수
        const existingPreviewCount = preview.find('.preview-image-container').length;

        // 새로 추가된 파일 수와 이미 존재하는 미리보기 이미지 수를 합하여 전체 수 계산
        const totalPreviewCount = existingPreviewCount + newFilesCount;

        // 전체 수가 3을 초과하면 경고 메시지를 표시하고 함수를 종료
        if (totalPreviewCount > 3) {
            alert('이미지는 최대 3개까지 업로드할 수 있습니다.');
            clearFileInput(); // 파일 입력 요소 초기화
            return;
        }
        
        let totalSize = 0;
        let isValid = true;
		for (let i = 0; i < files.length; i++) {
            totalSize += files[i].size;
        }

        if (totalSize > MAX_TOTAL_SIZE) {
            alert("총 파일 크기는 6000MB를 초과할 수 없습니다.");
            isValid = false;
        }

        for (let i = 0; i < files.length; i++) {
            if (files[i].size > MAX_FILE_SIZE) {
                alert("각 파일 크기는 4000MB를 초과할 수 없습니다: " + files[i].name);
                isValid = false;
                break;
            }
        }

        if (!isValid) {
            event.target.value = ""; // 파일 입력 초기화
        }
        
        
        
        // 파일별로 미리보기 생성
        uniqueFiles.forEach(file => {
            const reader = new FileReader();

            reader.onload = function(e) {
                const container = $('<div>').addClass('preview-image-container');

                const img = $('<img>').attr({
                    'src': e.target.result,
                    'data-filename': file.name // 파일명 데이터 속성 추가
                }).addClass('preview-image');

                const removeButton = $('<button>').addClass('remove-button').text('X');

                // 클릭 이벤트 바인딩
                removeButton.on('click', function() {
                    container.remove(); // 미리보기 삭제
                    updateFileInput(file); // input 파일 목록 업데이트
                });

                container.append(img).append(removeButton);
                preview.append(container);
            };

            reader.readAsDataURL(file);
        });

        // 파일 입력 요소 초기화 함수
        function clearFileInput() {
            $('#ab_upload').val(''); // 입력 요소의 값을 비워줌
        }

        // 파일 입력 요소 업데이트 함수
        function updateFileInput(fileToRemove) {
            const input = $('#ab_upload')[0];
            const files = Array.from(input.files);

            // 파일 목록에서 삭제할 파일 제거
            const updatedFiles = files.filter(file => file !== fileToRemove);

            // DataTransfer 객체 생성하여 업데이트된 파일 목록 설정
            const dataTransfer = new DataTransfer();
            updatedFiles.forEach(file => dataTransfer.items.add(file));

            // 파일 입력 요소에 업데이트된 파일 목록 설정
            input.files = dataTransfer.files;
        }
    });
    
    $(document).on('keyup','#ab_title',function(){
		//입력한 글자수 구하기
		let inputLength = $(this).val().length;
		
		if(inputLength>40){
			$(this).val($(this).val().substring(0,40));
		}else{
			//남은 글자수 구하기
			let remain = inputLength + '/40';
			
			$('.divcontainer').text(remain);
			
		}
	});
	
    
    
});
