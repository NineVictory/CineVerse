package kr.spring.movie.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EMovieVO {
	private String rank;
	private String em_title;
    private String em_director;
    private String em_actor;
    private String em_company;
    private String em_plot;
    private String em_runtime;
    private String em_rating;
    private String em_genre;
    private String em_release;
    private String em_posters;

}
