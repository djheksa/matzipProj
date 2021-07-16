package com.gb.myproject;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.gb.myproject.member999.service.MemberService;


class Test1 extends Configuration{
	@Autowired
	MemberService mService;
	
	
	@Test
	void test() {
		double test = 2.3454;
		DecimalFormat df = new DecimalFormat("#.#");
		test = Double.parseDouble(df.format(test));
		System.out.println(test);
		test=2.34634;
		double test1 = Math.round((test*10)/10.0);
		System.out.println(test1);
	}
	void selectLogin() {
		Map<String,String> map = new HashMap<String, String>();
		map.put("id", "asd");
		map.put("password", "1234");
		System.out.println(mService.selectLogin(map));
	}

}
