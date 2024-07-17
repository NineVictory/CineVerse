$(document).ready(function() {
    // 페이지 로딩 후 실행될 코드

    // 이미지 업로드 input 요소의 change 이벤트 핸들러
    $('#ab_upload').on('change', function(event) {
        const preview = $('#preview');
        const files = event.target.files;

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
        
        $('.img-count').text('(' +totalPreviewCount + '/3)');
        

        

        // 전체 수가 3을 초과하면 경고 메시지를 표시하고 함수를 종료
        if (totalPreviewCount > 3) {
            alert('이미지는 최대 3개까지 업로드할 수 있습니다.');
            clearFileInput(); // 파일 입력 요소 초기화
            return;
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

    // 페이지 로딩 시 이미 ab_filename이 존재하는 경우 미리보기 추가하기
    const existingFileNames = $('.preview-image').map(function() {
        return $(this).attr('data-filename');
    }).get();
    
    imgcount = existingFileNames.length;
	$('.img-count').text('(' +imgcount+'/3)');
	    
    
    

    if (existingFileNames.length > 0) {
        existingFileNames.forEach(function(fileName) {
            const img = $('<img>').attr({
                'src': '../upload/' + fileName, // 이미지 경로 설정
                'data-filename': fileName // 파일명 데이터 속성 추가
            }).addClass('preview-image');

            const removeButton = $('<button>').addClass('remove-button').text('X');

            // 클릭 이벤트 바인딩
            removeButton.on('click', function() {
                img.parent().remove(); // 미리보기 삭제
                // 필요시 다른 로직 추가
            });

            const container = $('<div>').addClass('preview-image-container').append(img).append(removeButton);
            $('#preview').append(container);
        });
    }
    
	titleLength = $('#ab_title').val().length;
	$('.divcontainer').text('(' +titleLength+'/40)');
	    
     $(document).on('keyup','#ab_title',function(){
		//입력한 글자수 구하기
		let inputLength = $(this).val().length;
		
		if(inputLength>40){
			$(this).val($(this).val().substring(0,40));
		}else{
			//남은 글자수 구하기
			let remain = '(' + inputLength + '/40)';
			
			$('.divcontainer').text(remain);
			
		}
	});
});


/*$(document).ready(function() {
    // 미리보기 이미지 생성
    function createPreview(fileName) {
        const img = $('<img>').attr({
            'src': '../upload/' + fileName, // 이미지 경로 설정
            'data-filename': fileName // 파일명 데이터 속성 추가
        }).addClass('preview-image');

        const removeButton = $('<button>').addClass('remove-button').text('X');

        removeButton.on('click', function() {
            $(this).parent().remove(); // 미리보기 삭제
            removeFile(fileName);
        });

        const container = $('<div>').addClass('preview-image-container').append(img).append(removeButton);
        $('#preview').append(container);
    }

    // 파일 목록에서 제거
    function removeFile(fileName) {
        const input = $('#ab_upload')[0];
        const files = Array.from(input.files);

        const updatedFiles = files.filter(file => file.name !== fileName);

        const dataTransfer = new DataTransfer();
        updatedFiles.forEach(file => dataTransfer.items.add(file));

        input.files = dataTransfer.files;
    }

    // 페이지 로딩 시 기존 이미지 미리보기 생성
    if (ab_filenames.length > 0) {
        ab_filenames.forEach(fileName => {
            createPreview(fileName);
        });
    }

    // 이미지 업로드 input 요소의 change 이벤트 핸들러
    $('#ab_upload').on('change', function(event) {
        const preview = $('#preview');
        const files = event.target.files;

        const existingFileNames = preview.find('.preview-image').map(function() {
            return $(this).attr('data-filename');
        }).get();

        const uniqueFiles = Array.from(files).filter(file => {
            return !existingFileNames.includes(file.name);
        });

        const newFilesCount = uniqueFiles.length;
        const existingPreviewCount = preview.find('.preview-image-container').length;
        const totalPreviewCount = existingPreviewCount + newFilesCount;

        if (totalPreviewCount > 3) {
            alert('이미지는 최대 3개까지 업로드할 수 있습니다.');
            clearFileInput();
            return;
        }

        uniqueFiles.forEach(file => {
            const reader = new FileReader();

            reader.onload = function(e) {
                const container = $('<div>').addClass('preview-image-container');

                const img = $('<img>').attr({
                    'src': e.target.result,
                    'data-filename': file.name
                }).addClass('preview-image');

                const removeButton = $('<button>').addClass('remove-button').text('X');

                removeButton.on('click', function() {
                    container.remove();
                    removeFile(file.name);
                });

                container.append(img).append(removeButton);
                preview.append(container);
            };

            reader.readAsDataURL(file);
        });

        function clearFileInput() {
            $('#ab_upload').val('');
        }
    });

    // 제목 글자 수 카운트
    let titleLength = $('#ab_title').val().length;
    $('.divcontainer').text('(' + titleLength + '/40)');

    $(document).on('keyup', '#ab_title', function() {
        let inputLength = $(this).val().length;

        if (inputLength > 40) {
            $(this).val($(this).val().substring(0, 40));
        } else {
            let remain = '(' + inputLength + '/40)';
            $('.divcontainer').text(remain);
        }
    });
});*/