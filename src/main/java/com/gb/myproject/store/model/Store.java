package com.gb.myproject.store.model;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Store {
	private String s_name;
	private String s_idx;
	//private String img_name;
	private String s_addr;
	private String station;
	private String s_phone;
	private String s_url;
	private String x;
	private String y;
}
