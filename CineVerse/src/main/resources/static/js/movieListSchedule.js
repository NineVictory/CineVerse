$(document).ready(function() {
/*    let currentPage = 1;
    const rowCount = 20;*/
/*    const displayedMovies = new Set();*/
/*	const itemsPerPage = 20; // 한 번에 표시할 영화 개수
    let currentPage = 1;*/
	const selectedGenres = new Set();
/*	 let status = $("#statusCheckbox").is(':checked') ? 1 : '';*/

/*	// 초기 영화 목록 설정
    function showInitialMovies() {
        $('.movie').hide(); // 모든 항목 숨기기
        $('.movie').slice(0, itemsPerPage).show(); // 처음 20개 항목 표시
        console.log("Initial movies shown");
    }

    // 더보기 버튼 클릭 시 더 많은 영화 표시
    $("#loadMoreButton").click(function() {
		console.log("Load more clicked");
        const totalItems = $('.movie').length;
        const itemsToShow = currentPage * itemsPerPage;

        // 다음 페이지 항목들만 표시
        $('.movie').slice(itemsToShow, itemsToShow + itemsPerPage).show();

        currentPage++;

        // 모든 항목이 표시된 경우 버튼 숨기기
        if (itemsToShow + itemsPerPage >= totalItems) {
            $("#loadMoreButton").hide();
        }
    });*/
    
    // 상영 중인 영화 필터링
    $("#statusCheckbox").change(function() {
       var status = $(this).is(':checked') ? 1 : '';
        location.href = '/movie/movieListSchedule?status=' + status;
        
/*        currentPage = 1;
        loadMovies(true);*/
    });

   // 최신순, 북마크순 체크박스 상태 관리
    $("input[name='movieorder']").change(function() {
        var selectedCheckboxes = $("input[name='movieorder']:checked");

        if (selectedCheckboxes.length > 1) {
            // 이미 체크된 다른 체크박스를 해제
            $("input[name='movieorder']").not(this).prop('checked', false);
         
        }

        // 기본 정렬 값 설정 
        var movieorder = $("input[name='movieorder']:checked").val() || 1;
        console.log('Selected movieorder:', movieorder);  // 디버그 로그 추가

        location.href = '/movie/movieListSchedule?keyfield=' + $('#keyfield-select').val() + '&keyword=' + $('#keyword').val() + '&movieorder=' + movieorder;
    });

    // 체크박스 해제 방지
    $("input[name='movieorder']").click(function() {
        if ($("input[name='movieorder']:checked").length === 0) {
            $(this).prop('checked', true);
        }
    });

    // 기본 정렬 값을 최신순으로 설정
    if ($("input[name='movieorder']:checked").length === 0) {
        $("input[name='movieorder'][value='1']").prop('checked', true);
    }

  /*  // 더보기 버튼 클릭 이벤트
    $("#loadMoreButton").click(function() {
        loadMoreMovies();
    });
    
    function loadMovies(reset = false) {
        if (reset) {
            currentPage = 1;
            displayedMovies.clear();
            $("#movieListContainer ul.movie-list").empty();
        }
        loadMoreMovies();
    }

    function loadMoreMovies() {
        currentPage++;
        $.ajax({
            url: "/movie/loadMoreMovies",
            method: "GET",
            data: {
                pageNum: currentPage,
                rowCount: rowCount,
                keyfield: $('#keyfield').val(),
                keyword: $('#keyword').val(),
                movieorder: $("input[name='movieorder']:checked").val() || 1,
            },
            success: function(response) {
                const movieListSchedule = response.movieListSchedule;

                if (movieListSchedule.length > 0) {
                    let html = '';
                    movieListSchedule.forEach(movie => {
                        if (!displayedMovies.has(movie.m_code)) {
                            displayedMovies.add(movie.m_code);
                            html += `
                                <li class='movie'>
                                    <img alt='영화1' src='/upload/${movie.m_filename}' onclick="location.href='movieDetail?m_code=${movie.m_code}'">
                                    <p><a href='movieDetail?m_code=${movie.m_code}'><b>${movie.m_name}</b></a></p>
                                    <div class='bookAopen'>
                                        <div>예매율 34.1% | 개봉일 ${movie.m_opendate}</div>
                                    </div>
                                    <div class='movie-button'>
                                        <div class='movie-fav-button-detail'>
                                            <img class='output_bookMark' data-num='${movie.m_code}' src='/images/heart01.png'>
                                            <span class='output_mfcount'></span>
                                        </div>
                                        <div class='movie-reservation-button-list'>예매하기</div>
                                    </div>
                                </li>`;
                        }
                    });
                    $("#movieListContainer ul.movie-list").append(html);
                }

                if (movieListSchedule.length < rowCount) {
                    $("#loadMoreButton").hide();
                }
            },
            error: function(xhr, status, error) {
                console.error("Error loading more movies:", error);
            }
        });
    }*/
 
   // 장르 체크박스 클릭 이벤트
$('.toggle-button').click(function() {
        let genre = $(this).data('genre');
        if ($(this).hasClass('active')) {
            $(this).removeClass('active');
            selectedGenres.delete(genre);
        } else {
            $(this).addClass('active');
            selectedGenres.add(genre);
        }
        filterMoviesByGenres();
    });
	
	$("#movieListContainer ul.movie-list").append(html);

	// 등급에 따라 클래스명을 반환하는 함수
	function getGradeClass(rating) {
	    switch(rating) {
	        case '12세관람가':
	        case '12세이상관람가':
	            return 'gr_12';
	        case '전체관람가':
	            return 'gr_all';
	        case '15세관람가':
	        case '15세이상관람가':
	            return 'gr_15';
	        case '18세관람가(청소년관람불가)':
	        case '청소년관람불가':
	            return 'gr_19';
	        default:
	            return '';
	    }
	}
	
    // 장르로 영화 필터링
// 장르로 영화 필터링
 function filterMoviesByGenres() {
        if (selectedGenres.size === 0) {
            window.location.href = '/movie/movieList';
        } else {
            $.ajax({
                url: '/movie/filterMoviesByGenres',
                type: 'GET',
                traditional: true,
                data: { genres: Array.from(selectedGenres) },
                dataType: 'json',
                success: function(response) {
                    let html = '';
                    $("#movieListContainer ul.movie-list").empty();
                    response.forEach(function(movie) {
                        let filenames = movie.m_filename.split('|');
                        let mainImage = filenames[0];
                        html = `
                            <li class="movie">
                                <img alt="영화1" src="${mainImage}" onclick="location.href='movieDetail?m_code=${movie.m_code}'">
                                <div class="overlay">
                                    <button class="btn-book" onclick="location.href='/movie/movieReserve'">예매하기</button>
                                    <button class="btn-details" onclick="location.href='movieDetail?m_code=${movie.m_code}'">상세보기</button>
                                </div>
                                <div class="movie_name_list">
                                    <div class="movie_list_grade">
                                        <div class="movie_list_gn">
                                            <span class="ic_grade ${getGradeClass(movie.rating)}"></span>
                                            <span class="movie_name"><b>${movie.m_name}</b></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="bookAopen">
                                    <div>개봉일 ${movie.m_opendate}</div>
                                    <div>예매율 0%</div>
                                </div>
                            </li>
                        `;
                        $("#movieListContainer ul.movie-list").append(html);
                    });
                },
                error: function(xhr, status, error) {
                    console.error('Error filtering movies:', error);
                }
            });
        }
    }
});
