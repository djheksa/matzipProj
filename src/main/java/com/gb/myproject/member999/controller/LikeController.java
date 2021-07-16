package com.gb.myproject.member999.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.gb.myproject.member999.service.MemberService;

@Controller
@RequestMapping(value="/like")
public class LikeController {
	@Autowired
	MemberService mService;
	
	//찜하기 --------------보류
	@RequestMapping(value="insertLike")
	public String insertLike(int idx) {
		
		return "/store/detail";
	}
	//마이페이지에서 찜 목록 삭제
	@RequestMapping(value="deleteLike",params = "eventPage=mypage")
	public ModelAndView deleteLikeMypage(int idx, Model model) {
		ModelAndView mv = new ModelAndView();
		int flag = mService.deleteMemberLike(idx);
		if(flag != 0) {
			mv.addObject("message","삭제완료");
			
		}else {
			mv.addObject("message","오류 잠시후 다시 시도해 주세요");
		}
		mv.setViewName("./member/mypage");
		return mv;
	}
	//맛집에서 찜 체크 해제 버튼누름 -> 요청 -> 삭제 ->바뀐값으로 store 디테일 재실행
	@RequestMapping(value="deleteLike",params = "eventPage=storeDetail")
	public ModelAndView deleteLikeStore(int m_idx,int s_idx,Model model) {
		ModelAndView mv = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("m_idx", m_idx);
		map.put("s_idx", s_idx);
		int flag = mService.deleteStoreLike(map);
		if(flag != 0) {
			mv.addObject("message","찜 취소");
		}else {
			mv.addObject("message","오류 잠시후 다시 시도해 주세요");
		}
		mv.setViewName("./store/detail");
		return mv;
	}
	
	
}
