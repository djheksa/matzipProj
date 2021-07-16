package com.gb.myproject.blog.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class RequestVo {
	private BlogDto bDto;
	private ImgDto iDto;
	private String page;
	//private String findText;
	//private String field;
	
}
