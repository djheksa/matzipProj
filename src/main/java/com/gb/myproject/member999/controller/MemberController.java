package com.gb.myproject.member999.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gb.myproject.blog.model.BlogDto;
import com.gb.myproject.blog.service.BlogService;
import com.gb.myproject.member999.model.KakaoMemberDto;
import com.gb.myproject.member999.model.MemberDto;
import com.gb.myproject.member999.model.S_likeDto;
import com.gb.myproject.member999.service.MemberService;
import com.gb.myproject.store.model.Store;
import com.gb.myproject.store.service.StoreService;

@Controller
@RequestMapping(value = "/member")
public class MemberController {
	@Autowired
	MemberService mService;
	@Autowired
	BlogService bService;
	@Autowired
	StoreService sService;

	// 카카오톡 로그인 실행
	@RequestMapping(value = "/kakaoLogin", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView kakaoLogin(@ModelAttribute KakaoMemberDto dto, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		MemberDto mdto = mService.selectKakaoLogin(dto);
		if (mdto == null) { // 카카오톡으로 처음 로그인
			mv.addObject("kakaoData", dto);
			mv.addObject("flag", "y");
			mv.setViewName("member/kakaoJoin");
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("member", mdto);
			mv.addObject("message", "환영합니다 " + mdto.getName() + " 님");
			mv.addObject("url", request.getContextPath() + "/index");
			mv.setViewName("alert");
		}
		return mv;
	}

	// 일반 로그인 실행
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(@ModelAttribute MemberDto dto, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", dto.getId());
		map.put("password", dto.getPassword());
		MemberDto mdto = mService.selectLogin(map);
		if (mdto != null) {
			HttpSession session = request.getSession();
			session.setAttribute("member", mdto);
			mv.addObject("message", "환영합니다 " + mdto.getName() + " 님");
			mv.addObject("url", request.getContextPath() + "/index");
			mv.setViewName("alert");
		} else {
			mv.addObject("message", "로그인실패 아이디 또는 비밀번호를 확인해 주세요");
			mv.addObject("url", request.getContextPath() + "/index?login=popUp");
			mv.setViewName("alert");
		}

		return mv;
	}

	// 회원가입 뷰
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public void insertView() {

	}

	// 회원가입 실행
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute MemberDto dto, Model model) {
		int flag = mService.insertMember(dto);
		ModelAndView mv = new ModelAndView();
		if (flag != 0) {
			mv.addObject("message", "회원가입 완료! 로그인 창으로 이동합니다");
			mv.addObject("url", "../index?login=popUp");
			mv.setViewName("alert");
		} else {
			mv.addObject("message", "오류 잠시후 다시 시도해주세요");
			mv.addObject("url", "../index");
			mv.setViewName("alert");
		}
		return mv;
	}

	// 회원정보 수정 뷰 - 마이페이지에서 수정
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String updateView(int idx, Model model, HttpServletRequest request) {
		List<Store> storeList = new ArrayList<Store>();
		// m_idx로 찜 DB에서 가져온 s_idx를 이용해 맛집 리스트 생성
		List<S_likeDto> likeList = mService.selectLikeList(idx);
		for (S_likeDto i : likeList) {
			storeList.add(sService.getStoreInfo(i.getS_idx()));
		}
		// m_idx를 이용해 blog리스트를 가져옴
		List<BlogDto> blogList = bService.selectMyBlogList(idx);
		for (BlogDto b : blogList) {
			b.setImgList(bService.selectImg(b.getIdx()));
		}
		model.addAttribute("storeList", storeList);
		model.addAttribute("blogList", blogList);
		return "member/mypage";
	}

	// 회원정보 수정 실행
	@RequestMapping(value = "/mypage", method = RequestMethod.POST)
	public ModelAndView update(@ModelAttribute MemberDto dto, HttpServletRequest request) {
		int flag = mService.updateMember(dto);
		ModelAndView mv = new ModelAndView();
		if (flag != 0) {
			HttpSession session = request.getSession();
			MemberDto mdto = mService.selectOneMember(dto.getIdx());
			session.setAttribute("member", mdto);
			mv.addObject("message", mdto.getName() + " 회원님의 정보 수정 완료!");
			mv.addObject("url", "./mypage?idx=" + mdto.getIdx());
			mv.setViewName("alert");
		} else {
			mv.addObject("message", "오류 잠시후 다시 시도해주세요");
			mv.addObject("url", request.getContextPath() + "/index");
			mv.setViewName("alert");
		}
		return mv;
	}

	// 아이디 찾기 뷰
	@RequestMapping(value = "/findId", method = RequestMethod.GET)
	public void findIdView() {
	}

	// 아이디 찾기 실행
	@RequestMapping(value = "/findId", method = RequestMethod.POST)
	public ModelAndView findId(@ModelAttribute MemberDto dto) {
		ModelAndView mv = new ModelAndView();
		String findId = mService.selectId(dto);
		if (findId != null) {
			mv.addObject("findId", findId);
			mv.setViewName("member/findId");
		} else {
			mv.addObject("message", "일치하는 정보가 없습니다 다시 시도해 주세요");
			mv.addObject("url", "./findId");
			mv.setViewName("alert");
		}
		return mv;
	}

	// 비번 찾기 뷰
	@RequestMapping(value = "findPw", method = RequestMethod.GET)
	public void findPwView() {

	}

	// 비번 찾기 조건
	@RequestMapping(value = "findPw", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> findPw(@RequestBody Map<String, Object> pMap) {
		String id = pMap.get("id").toString();
		String phone = pMap.get("phone").toString();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("phone", phone);
		MemberDto dto = mService.selectPw(map);
		if (dto != null) { // 값이 있으면 비번 변경 가능
			map.put("flag", "y");
			map.put("dto", dto);
		} else { // 값이 없으면 아이디나 폰번호가 일치하지 않음
			map.put("flag", "n");
		}
		return map;
	}

	// 비밀번호 변경 ->현재 비밀번호 체크후 맞으면 새로운 비밀번호로 변경 ----비밀번호는 찾기 없음 무조건 변경만 가능
	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	public ModelAndView changePassword(int idx, String oldPassword, String newPassword, String findPw,
			HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		if(oldPassword==null) oldPassword="findPw";
		map.put("idx", idx);
		map.put("password", oldPassword);
		String oldPasswordCheck = mService.selectPassword(map);

		if (oldPasswordCheck != null || findPw.equals("y")) {
			map.put("password", newPassword);
			int flag = mService.updatePassword(map);
			if (flag != 0) {
				mv.addObject("message", "비밀번호 변경 성공! 다시 로그인 해주세요");
				mv.addObject("url", request.getContextPath() + "/index?login=popUp");
				HttpSession session = request.getSession();
				session.invalidate();
				mv.setViewName("alert");
			} else {
				mv.addObject("message", "오류 잠시후 다시 시도해 주세요");
				mv.addObject("url", request.getContextPath() + "/index");
				mv.setViewName("alert");
			}
		} else {
			mv.addObject("message", "현재 비밀번호가 일치하지 않습니다. 다시 시도해 주세요");
			mv.addObject("url", "./mypage?idx=" + idx);
			mv.setViewName("alert");

		}
		return mv;
	}

	// 회원탈퇴 -> 비밀번호를 입력해서 일치하면 탈퇴가능
	@RequestMapping(value = "/deleteMember",method=RequestMethod.GET)
	public ModelAndView deleteMember(int idx,HttpServletRequest request) {
		System.out.println("들어옴");
		ModelAndView mv = new ModelAndView();
		System.out.println(idx);
		int flag = mService.deleteMember(idx);
		System.out.println(flag);
		if (flag != 0) {
			HttpSession session = request.getSession();
			session.invalidate();
			mv.addObject("message", "회원탈퇴 완료");
			mv.addObject("url", request.getContextPath()+"/index");
		} else {
			mv.addObject("message", "오류 잠시후 다시 시도해주세요");
			mv.addObject("url", request.getContextPath()+"/index");
		}
		mv.setViewName("alert");
		return mv;
	}

	// 로그아웃
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public ModelAndView logout(int idx, HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		ModelAndView mv = new ModelAndView();
		mv.addObject("message", "로그아웃 되었습니다");
		mv.addObject("url", "../index");
		mv.setViewName("alert");

		return mv;
	}

	// 아이디 중복체크
	@RequestMapping(value = "idDoubleCheck", method = RequestMethod.POST, headers = {
			"Content-Type=application/json;" })
	@ResponseBody
	public Map<String, Object> idDoubleCheck(@RequestBody Map<String, Object> pMap) {
		String id = pMap.get("id").toString();
		Map<String, Object> map = new HashMap<String, Object>();
		MemberDto dto = mService.selectDoubleCheck(id);
		System.out.println(dto);
		if (dto != null) { // 값이 있으면 아이디 사용 불가능
			map = null;
		} else { // 값이 없으면 사용 가능
			map.put("id", id);
		}
		return map;
	}

}
