package com.gb.myproject.blog.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ImgDto {
	private int idx;
	private String img_name;
	private int b_idx;
	private MultipartFile[] file;
}
