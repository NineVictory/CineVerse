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

    @Scheduled(cron = "0 0 2 * * *") // 매일 새벽 2시에 실행되도록 설정해놓음 초 분 시
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
        	// 요청 url과 각각의 값들을 넣어줘서 연결 시킨다 get 방식으로
            URL requestURL = new URL(REQUEST_URL + "?" + makeQueryString(paramMap));
            HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();
            conn.setRequestMethod("GET");
            conn.setDoInput(true);

            // 버퍼드 리더를 통해 읽어오며 utf-8
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String readline;
            StringBuilder response = new StringBuilder();
            while ((readline = br.readLine()) != null) {
                response.append(readline);
            }
            
            // json object들을 변환해주는데 각각의 내용과 배열들의 이름이 불러와지는 값에 알맞게 작성이 되면 된다
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
                movieRank.setShowRange(boxOfficeResult.getString("showRange"));
                movieRank.setMovieNm(boxOffice.getString("movieNm"));
                movieRank.setMovieCd(boxOffice.getString("movieCd"));
                movieRank.setOpenDt(boxOffice.getString("openDt"));
                movieRank.setSalesAmt(boxOffice.getString("salesAmt"));
                movieRank.setSalesAcc(boxOffice.getString("salesAcc"));
                movieRank.setAudiCnt(boxOffice.getString("audiCnt"));
                movieRank.setAudiAcc(boxOffice.getString("audiAcc"));

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

    @Override
    public List<MovieRankAPIVO> getMovieRank() {
        return movieRankMapper.getMovieRank();
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
}
