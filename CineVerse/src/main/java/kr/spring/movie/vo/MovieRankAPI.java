package kr.spring.movie.vo;

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
import java.util.Map;
 
import org.json.JSONArray;
import org.json.JSONObject;
 
public class MovieRankAPI {
 
    // 상수 설정
    //   - 요청(Request) 요청 변수
	// kobis 일별 박스 오피스 json으로 불러오는 url
    private final String REQUEST_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";
    // 발급받은 인증키
    private final String AUTH_KEY = "deeb2f78a00af08af33c39554a83a1df";
 
    //날짜 kobis의 요청에 맞게 변환시켜서 입력하기
    private final SimpleDateFormat DATE_FMT = new SimpleDateFormat("yyyyMMdd");
 
    // Map -> QueryString
    public String makeQueryString(Map<String, String> paramMap) {
        final StringBuilder sb = new StringBuilder();
 
        paramMap.entrySet().forEach(( entry )->{
            if( sb.length() > 0 ) {
                sb.append('&');
            }
            sb.append(entry.getKey()).append('=').append(entry.getValue());
        });
 
        return sb.toString();
    }
 
    // API요청
    public void requestAPI() {
        // 변수설정
        // 해당 날짜에서 하루 뺀 날짜로 날짜 지정하기
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.DATE, -1);
 
        // 변수 설정
        //   - 요청(Request) 인터페이스 Map (불러오는 사람이 직접 지정하는 것)
        Map<String, String> paramMap = new HashMap<String, String>();
        paramMap.put("key"          , AUTH_KEY);                        // 발급받은 인증키
        paramMap.put("targetDt"     , DATE_FMT.format(cal.getTime()));  // 조회하고자 하는 날짜
        paramMap.put("itemPerPage"  , "10");                            // 결과 ROW 의 개수(10개)
 
        try {
            // Request URL 연결 객체 생성 - 매핑하여 전달하고자하는 값들 전달
            URL requestURL = new URL(REQUEST_URL+"?"+makeQueryString(paramMap));
            HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();
 
            // GET 방식으로 요청하여 input에다가 삽입시키기
            conn.setRequestMethod("GET");
            conn.setDoInput(true);
 
            // 응답(Response) 구조 작성
            //   - Stream -> JSONObject
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String readline = null;
            StringBuffer response = new StringBuffer();
            while ((readline = br.readLine()) != null) {
                response.append(readline);
            }
 
            // JSON 객체로  변환
            JSONObject responseBody = new JSONObject(response.toString());
 
            // 데이터 추출
            JSONObject boxOfficeResult = responseBody.getJSONObject("boxOfficeResult");
 
            // 박스오피스 주제 출력
            String boxofficeType = boxOfficeResult.getString("boxofficeType");
            System.out.println(boxofficeType);
 
            // 박스오피스 목록 출력
            JSONArray dailyBoxOfficeList = boxOfficeResult.getJSONArray("dailyBoxOfficeList");
            Iterator<Object> iter = dailyBoxOfficeList.iterator();
            while(iter.hasNext()) {
                JSONObject boxOffice = (JSONObject) iter.next();
                System.out.printf("  %s - %s\n", boxOffice.get("rnum"), boxOffice.get("movieNm"));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
 
    public static void main(String[] args) {
        // API 객체 생성
        MovieRankAPI api = new MovieRankAPI();
 
        // API 요청
        api.requestAPI();
    }
}
