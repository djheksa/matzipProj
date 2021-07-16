package com.gb.myproject.blog.model;

import java.time.LocalDateTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class BlogDto {
	private int idx;
	private String subject;		//제목
	private String content;		//내용
	private String station;		//역이름
	private String img_name;	//띄울사진
	private String s_name;		//맛집이름
	private LocalDateTime wdate;//작성일자
	private int b_count;		//조회수
	private int b_recom;		//추천수
	private int m_idx;			//작성자 idx
	private List<ImgDto> imgList;	//인서트 시 가져온 이미지 담기
	private PageDto pDto;
}
