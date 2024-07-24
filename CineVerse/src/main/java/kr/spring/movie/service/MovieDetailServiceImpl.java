package kr.spring.movie.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.movie.dao.MovieDetailMapper;
import kr.spring.movie.vo.MovieDetailKFAPIVO;
import kr.spring.movie.vo.MovieVO;

@Service
@Transactional
public class MovieDetailServiceImpl implements MovieDetailService {
	
	 @Autowired
	private MovieDetailMapper movieDetailMapper;
	 
	    private final String REQUEST_URL = "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp";
	    private final String AUTH_KEY = "675M9K1PB39AXBK8RK6Y";

	@Override
	public void insertMovieDetail(MovieDetailKFAPIVO movieDetail) {
		// 변수 설정
        Map<String, String> paramMap = new HashMap<String, String>();
        paramMap.put("collection", "kmdb_new2");
        paramMap.put("releaseDts", "20230901");
        paramMap.put("releaseDte", "20231231");
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
                    JSONObject CodeNoObject = movies.getJSONObject("CommCodes");
                    if (CodeNoObject.has("CommCode")) {
                        JSONArray CodeArray = CodeNoObject.getJSONArray("CommCode");
                        CodeNo = extractArrayData(CodeArray, "CodeNo");
                    }
                    
                    // 예고편 추출
                    String teasers = "";
                    JSONObject TeaserUrlObject = movies.getJSONObject("vods");
                    if (TeaserUrlObject.has("vod")) {
                        JSONArray TeaserArray = TeaserUrlObject.getJSONArray("vod");
                        teasers = extractArrayData(TeaserArray, "vodUrl");
                    }

                        movieDetail.setDOCID(movies.getString("DOCID"));
                        movieDetail.setMovieSeq(movies.getString("movieSeq"));
                        movieDetail.setTitle(movies.getString("title"));
                        movieDetail.setTitleOrg(movies.getString("titleOrg"));
                        movieDetail.setDirectorNm(directors);
                        movieDetail.setActorNm(actors);
                        movieDetail.setNation(movies.getString("nation"));
                        movieDetail.setCompany(movies.getString("company"));
                        movieDetail.setPlot(plots);
                        movieDetail.setRuntime(movies.getString("runtime"));
                        movieDetail.setRating(movies.getString("rating"));
                        movieDetail.setGenre(movies.getString("genre"));
                        movieDetail.setKeywords(movies.getString("keywords"));
                        movieDetail.setRepRlsDate(movies.getString("repRlsDate"));
                        movieDetail.setPosters(movies.getString("posters"));
                        movieDetail.setCodeNo(CodeNo);
                        movieDetail.setTeasers(teasers);
                        movieDetail.setStlls(movies.getString("stlls"));

                        movieDetailMapper.insertMovieDetail(movieDetail);
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

	@Override
	public List<MovieVO> selectRankMovie(String showrange) {
		return movieDetailMapper.selectRankMovie(showrange);
	}
}
