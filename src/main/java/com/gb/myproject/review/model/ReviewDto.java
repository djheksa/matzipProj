package com.gb.myproject.review.model;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReviewDto {
	private int idx;
	private String content;
	private LocalDateTime wdate;
	private String id;
	private int star;
	private int m_idx;
	private String s_idx;
	
}
