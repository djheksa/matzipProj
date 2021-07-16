package com.gb.myproject.review.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gb.myproject.member999.model.MemberDto;
import com.gb.myproject.member999.service.MemberService;
import com.gb.myproject.review.model.ReviewDto;
import com.gb.myproject.review.service.ReviewService;
import com.gb.myproject.store.service.StoreService;

@Controller
@RequestMapping("/store")
public class ReviewController {
	@Autowired
	ReviewService rService;
	@Autowired
	MemberService mService;
	@Autowired
	StoreService sService;
	
	MemberDto mdto;

//리뷰 쓰기
	@RequestMapping(value="/store_review", method=RequestMethod.POST)
	public String insertReview(@ModelAttribute ReviewDto rdto,Model model) {

			rService.insertReview(rdto);

			//return "redirect:/store/store?id="+id;
			return "redirect:/store/store?s_idx="+rdto.getS_idx();
			
	}
	//리뷰 삭제
	@RequestMapping(value="/review_delete", method=RequestMethod.POST)
	public String deleteReview(int r_idx,String s_idx,Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		mdto = (MemberDto)session.getAttribute("member");
	
			rService.deleteReview(r_idx);

			return "redirect:/store/store?s_idx="+s_idx;
			
	}

}
