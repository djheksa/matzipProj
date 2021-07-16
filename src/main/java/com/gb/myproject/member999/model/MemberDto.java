package com.gb.myproject.member999.model;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberDto {
	private int idx;
	private String name;
	private String password;
	private String id;
	private String phone;
	private int age;
	private LocalDateTime wdate;
	
}
