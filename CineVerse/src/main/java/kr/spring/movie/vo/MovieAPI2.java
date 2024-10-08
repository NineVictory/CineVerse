package kr.spring.movie.vo;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

public class MovieAPI2 {
    // 상수 설정
    private final String REQUEST_URL = "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp";
    private final String AUTH_KEY = "675M9K1PB39AXBK8RK6Y";

    // Map -> QueryString
    public String makeQueryString(Map<String, String> paramMap) {
        final StringBuilder sb = new StringBuilder();

        paramMap.entrySet().forEach((entry) -> {
            if (sb.length() > 0) {
                sb.append('&');
            }
            sb.append(entry.getKey()).append('=').append(entry.getValue());
        });

        return sb.toString();
    }

    // API 요청
    public void requestAPI() {

        // 변수 설정
        Map<String, String> paramMap = new HashMap<String, String>();
        paramMap.put("collection", "kmdb_new2");
        paramMap.put("releaseDts", "20240601");
        paramMap.put("listCount", "500");
        paramMap.put("detail", "Y");
        paramMap.put("ServiceKey", AUTH_KEY);

        try {
            // Request URL 연결 객체 생성
            URL requestURL = new URL(REQUEST_URL + "?" + makeQueryString(paramMap));
            HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();

            // GET 방식으로 요청
            conn.setRequestMethod("GET");
            conn.setDoInput(true);

            // 응답(Response) 구조 작성 - Stream -> JSONObject
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String readline = null;
            StringBuffer response = new StringBuffer();
            while ((readline = br.readLine()) != null) {
                response.append(readline);
            }

            // JSON 객체로 변환
            JSONObject responseBody = new JSONObject(response.toString());

            // 데이터 추출
            JSONArray dataArray = responseBody.getJSONArray("Data");
            
            for (int i = 0; i < dataArray.length(); i++) {
                JSONObject dataObject = dataArray.getJSONObject(i);
                JSONArray resultArray = dataObject.getJSONArray("Result");
                
                Iterator<Object> iter = resultArray.iterator();
                while (iter.hasNext()) {
                    JSONObject movies = (JSONObject) iter.next();
                    
                    // plots 추출
                    String plots = "";
                    JSONObject plotsObject = movies.getJSONObject("plots");
                    if (plotsObject.has("plot")) {
                        JSONArray plotArray = plotsObject.getJSONArray("plot");
                        plots = extractArrayData(plotArray, "plotText");
                    }
                    
                    // directors 추출
                    String directors = "";
                    JSONObject directorsObject = movies.getJSONObject("directors");
                    if (directorsObject.has("director")) {
                        JSONArray directorArray = directorsObject.getJSONArray("director");
                        directors = extractArrayData(directorArray, "directorNm");
                    }
                    
                    // actors 추출
                    String actors = "";
                    JSONObject actorsObject = movies.getJSONObject("actors");
                    if (actorsObject.has("actor")) {
                        JSONArray actorArray = actorsObject.getJSONArray("actor");
                        actors = extractArrayData(actorArray, "actorNm");
                    }
                    
                    // 영화 코드 추출
                    String CodeNo = "";
                    JSONObject CodeNoObject = movies.getJSONObject("Codes");
                    if (CodeNoObject.has("Code")) {
                        JSONArray CodeArray = CodeNoObject.getJSONArray("Code");
                        CodeNo = extractArrayData(CodeArray, "CodeNo");
                    }
                    
                    // 예고편 추출
                    String teasers = "";
                    JSONObject TeaserUrlObject = movies.getJSONObject("vods");
                    if (TeaserUrlObject.has("vod")) {
                        JSONArray TeaserArray = TeaserUrlObject.getJSONArray("vod");
                        teasers = extractArrayData(TeaserArray, "vodUrl");
                    }
                    
                    
                    // 출력 또는 저장
                    System.out.printf("%s - %s - %s - %s - %s - %s - %s - %s - %s - %s - %s - %s - %s- %s \n",
                        movies.get("stlls"),movies.get("DOCID"), movies.get("movieSeq"), movies.get("title"), plots,movies.get("company"),CodeNo,teasers
                        ,movies.get("keywords"),movies.get("runtime"), movies.get("rating"), movies.get("genre"), movies.get("repRlsDate"),
                        directors, actors);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // JSONArray의 특정 필드 값을 추출하는 메소드
    private String extractArrayData(JSONArray jsonArray, String fieldName) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject item = jsonArray.getJSONObject(i);
            if (sb.length() > 0) {
                sb.append(", ");
            }
            sb.append(item.getString(fieldName));
        }
        return sb.toString();
    }

    public static void main(String[] args) {
        MovieAPI2 api = new MovieAPI2();
        api.requestAPI();
    }
}
