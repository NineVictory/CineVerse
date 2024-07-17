package kr.spring.movie.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.movie.dao.MovieRankMapper;
import kr.spring.movie.vo.MovieRankAPIVO;

@Service
@Transactional
public class MovieRankServiceImpl implements MovieRankService {

    @Autowired
    private MovieRankMapper movieRankMapper;
    
    // 사용할 kobis 요청 url
    private final String REQUEST_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";
    // 내가 사용하는 키값
    private final String AUTH_KEY = "deeb2f78a00af08af33c39554a83a1df";
    // 오늘 날짜 형식에 맞춰 변환 시켜주기
    private final SimpleDateFormat DATE_FMT = new SimpleDateFormat("yyyyMMdd");

    @Scheduled(cron = "0 10 8 * * *") // 8시 10분에 실행되도록 설정해놓음 초 분 시 형태 뒤에는 일 달 이런거 문제는 해당 내용들이 실행되기 위해서는 서버가 켜져있어야한다.
    public void updateMovieRank() {
    	// 불러올 수 있는 날짜가 하루 전의 날짜기 때문에 당일보다 -1된 값으로 지정
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.DATE, -1);
        
        // mpa에 key, targetDt, 몇 개 뽑아오는지 담아서 보내면
        Map<String, String> paramMap = new HashMap<>();
        paramMap.put("key", AUTH_KEY);
        paramMap.put("targetDt", DATE_FMT.format(cal.getTime()));
        paramMap.put("itemPerPage", "10");

        try {
        	// 요청할 url과 각각의 값들을 넣어줘서 연결 시킨다 get 방식으로
            URL requestURL = new URL(REQUEST_URL + "?" + makeQueryString(paramMap));
            HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();	// conn 객체를 생성하여 get 요청 방식으로 결정 
            conn.setRequestMethod("GET");												// 사이트에서 get으로 받아오라고 해서 그에 맞게 작성
            conn.setDoInput(true);

            // 버퍼드 리더를 통해 서버 응답을 읽어오며 utf-8 인코딩 해주고
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String readline;
            
            // 스트링 빌더를 통해서 각 줄을 하나의 문자열로 결합해준다
            StringBuilder response = new StringBuilder();	
            while ((readline = br.readLine()) != null) { //응답의 각 줄들을 읽어오면서 readline에 저장하고 더 읽어올게 없으면 null 반환 시킨다
                response.append(readline);
            }	
            // 루프를 돌면서 읽어온 값들(readline)을 response에 저장한다
            
            // response에 저장한 문자열들을 JSONObject로 변환하여 responseBody에 저장시킨다
            // responseBody에서 boxOfficeResult 객체를 추출합니다.
            // boxOfficeResult(불러올때 지정된 명칭)에서 dailyBoxOfficeList 배열(지정된 명칭)을 추출.
            JSONObject responseBody = new JSONObject(response.toString());
            JSONObject boxOfficeResult = responseBody.getJSONObject("boxOfficeResult");
            JSONArray dailyBoxOfficeList = boxOfficeResult.getJSONArray("dailyBoxOfficeList");
            Iterator<Object> iter = dailyBoxOfficeList.iterator();
            // 값이 있을 동안에는 while 문을 돌면서 테이블에 계속 삽입해준다 데이터가 없을 때 까지
            while (iter.hasNext()) {
                JSONObject boxOffice = (JSONObject) iter.next();
                MovieRankAPIVO movieRank = new MovieRankAPIVO();
                movieRank.setRnum(boxOffice.getString("rnum"));
                movieRank.setRank(boxOffice.getString("rank"));
                movieRank.setShowrange(boxOfficeResult.getString("showRange"));
                movieRank.setMovienm(boxOffice.getString("movieNm"));
                movieRank.setMoviecd(boxOffice.getString("movieCd"));
                movieRank.setOpendt(boxOffice.getString("openDt"));
                movieRank.setSalesamt(boxOffice.getString("salesAmt"));
                movieRank.setSalesacc(boxOffice.getString("salesAcc"));
                movieRank.setAudicnt(boxOffice.getString("audiCnt"));
                movieRank.setAudiacc(boxOffice.getString("audiAcc"));

                movieRankMapper.insertMovieRank(movieRank);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void insertMovieRank(MovieRankAPIVO movieRankAPI) {
        movieRankMapper.insertMovieRank(movieRankAPI);
    }

    private String makeQueryString(Map<String, String> paramMap) {
        StringBuilder sb = new StringBuilder();
        paramMap.entrySet().forEach(entry -> {
            if (sb.length() > 0) {
                sb.append('&');
            }
            sb.append(entry.getKey()).append('=').append(entry.getValue());
        });
        return sb.toString();
    }

	@Override
	public List<MovieRankAPIVO> getMovieRank(String showrange) {
		return movieRankMapper.getMovieRank(showrange);
	}

	@Override
	public Integer getMovieRankCnt(String showrange) {
		return movieRankMapper.getMovieRankCnt(showrange);
	}
}
