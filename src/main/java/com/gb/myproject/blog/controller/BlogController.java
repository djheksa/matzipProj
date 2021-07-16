package com.gb.myproject.blog.controller;

import java.io.File;
import java.io.IOException;
import java.net.http.HttpResponse;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gb.myproject.blog.model.BlogDto;
import com.gb.myproject.blog.model.ImgDto;
import com.gb.myproject.blog.model.PageDto;
import com.gb.myproject.blog.model.RequestVo;
import com.gb.myproject.blog.service.BlogService;

@Controller
@RequestMapping(value = "/blog")
public class BlogController {

	@Autowired
	BlogService service;

	@RequestMapping(value = { "/list" })
	public void pageList(@ModelAttribute PageDto dto, Model model) {

		int currentPage;
		List<BlogDto> list;
		int totalCount;
		int pageSize = 5;

		if (dto.getPage() == 0)
			currentPage = 1;
		else
			currentPage = dto.getPage();
		PageDto pageDto;
		ModelMap modelMap = new ModelMap();
		modelMap.put("field", dto.getField());
		modelMap.put("findText", dto.getFindText());
		modelMap.put("category", dto.getCategory());

		if (dto.getFindText() != null) {
			totalCount = service.searchCount(modelMap);
		} else {
			totalCount = service.blogListCount();
		}

		pageDto = new PageDto(currentPage, pageSize, totalCount, dto.getField(), dto.getFindText(), dto.getCategory());
		list = service.makePageList(pageDto);
		for (BlogDto b : list) {
			b.setImgList(service.selectImg(b.getIdx()));
		}
		modelMap.put("page", pageDto);
		modelMap.put("list", list);
		model.addAllAttributes(modelMap);

	}

	// 상세보기
	@RequestMapping("/detail")
	public String detail(int idx, int page, String field, String findText, Model model,
			@CookieValue(value = "view", required = false) String cookie, HttpServletResponse response) {
		// 파라미터 처리
		Cookie newcoo;
		// 조회수 증가여부 String.valueOf(idx) : idx정수를 문자열로 변환
		if (cookie != null && !cookie.contains(String.valueOf(idx))) { // view라는 이름의 쿠키 값에 idx가 없는가?
			// 조회수 +1증가 서비스 호출
			cookie += "/" + idx; // 읽은 글의 idx를 cookie문자열에 연결하기(쿠키에 제한된문자, 한글인코딩 확인)
			service.updateCount(idx);
			newcoo = new Cookie("view", cookie);
		} else {
			newcoo = new Cookie("view", String.valueOf(idx));
		}

		newcoo.setMaxAge(50 * 60);
		// setPath 설정 안하면 기본적으로 현재 위치 --> http://localhost:8085/freeboard/blog
		newcoo.setPath("/myproject"); // 쿠키의 적용범위 --> --> http://localhost:8085/myproject
		response.addCookie(newcoo); // 새로만들어진 cookie문자열 결과를 쿠키에 저장하기
		if (field != null) {
			model.addAttribute("field", field);
			model.addAttribute("findText", findText);
		}
		// service 메소드 호출
		// view에 리턴받은 DTO를 전달
		BlogDto bDto = service.selectBlog(idx);
		// img타입의 리스트로 가져온 정보를 blog에 set
		bDto.setImgList(service.selectImg(idx));
		model.addAttribute("bean", bDto);
		// list 에서 전달받은 현재페이지를 다시 detail.jsp에게도 전달 -> 목록이동시에 원래보던 페이지로 이동
		if (page != 0)
			model.addAttribute("page", page);

		return "/blog/detail";
	}

	// 글쓰기 - view
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public void insert() {

	}

	// 글쓰기 - 저장
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String save(@ModelAttribute RequestVo re) throws IllegalStateException, IOException {

		service.insertBlog(re.getBDto());

		MultipartFile[] file = re.getIDto().getFile(); // 파일들 받아오기
		String path = "c:\\upload\\";
		String result = "";
		ImgDto iDto;
		for (MultipartFile f : file) {
			if (f.getOriginalFilename().length() != 0) {

				result = getNewFileName(f.getOriginalFilename());
				iDto = ImgDto.builder().img_name(result).b_idx(re.getBDto().getIdx()).build();
				service.imgInsert(iDto);
				if (f.getSize() != 0) // 파일의 사이즈가 0이 아닐때 //파일업로드
					f.transferTo(new File(path + getNewFileName(f.getOriginalFilename())));
			}
		}

		return "redirect:/blog/list";

	}

	private static String getNewFileName(String oldfile) {
		String prefix = oldfile.substring(0, oldfile.indexOf("."));
		String ext = oldfile.substring(oldfile.indexOf("."), oldfile.length());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_hhmmss");

		System.out.println(oldfile + ">" + prefix + "_" + sdf.format(Calendar.getInstance().getTime()) + ext);
		return prefix + "_" + sdf.format(Calendar.getInstance().getTime()) + ext;

	}

	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public void updateView(int idx, int page, Model model) {
		BlogDto bDto;
		bDto = service.selectBlog(idx);
		bDto.setImgList(service.selectImg(idx));
		model.addAttribute("bean", bDto);
		model.addAttribute("page", page);

	}

	// 글수정 - 저장
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView update(@ModelAttribute BlogDto bDto) throws IllegalStateException, IOException {
		service.updateBlog(bDto);
		// MultipartFile[] file = img.getFile(); //파일들 받아오기
		String path = "c:\\upload\\";
		String result = "";
		System.out.println(bDto);
//		if(file!=null) {
//		for(MultipartFile f : file) {
//			if(f.getOriginalFilename().length()!=0) {
//			
//			result = getNewFileName(f.getOriginalFilename());
//			img = ImgDto.builder().img_name(result).b_idx(blog.getIdx()).build();
//			service.imgInsert(img);
//			if(f.getSize() != 0) 	//파일의 사이즈가 0이 아닐때
//				//파일업로드
//				f.transferTo(new File(path + getNewFileName(f.getOriginalFilename())));
//			}
//		}
//		service.imgUpdate(new ImgDto(0, result, blog.getIdx(), null));	//덮어씌우기
//		}
		BlogDto blogDto = service.selectBlog(bDto.getIdx());
		for (int i = 0; i < bDto.getImgList().size(); i++) {
			blogDto.setImgList(bDto.getImgList());
		}
		ModelAndView mav = new ModelAndView();

		mav.addObject("page", bDto.getPDto().getPage());
		mav.addObject("idx", bDto.getIdx());
		mav.addObject("field", bDto.getPDto().getField());
		mav.addObject("findText", bDto.getPDto().getFindText());
		mav.addObject("bean", blogDto);
		mav.setViewName("redirect:detail");
		return mav;
	}

	// 글삭제
	@RequestMapping(value="delete")
	public String delete(int idx) {
		service.deleteBlog(idx);
		return "redirect:/blog/list";
	}

	@ExceptionHandler(NumberFormatException.class)
	public ModelAndView handleErr(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("url", request.getRequestURL()); // 애트리뷰트 저장
		mav.setViewName("/error/error");
		return mav;
	}

//	//추천수 증가
//	@RequestMapping(value="/recom/{idx}",method=RequestMethod.PUT,headers = {"Content-Type=application/json"})
//	@ResponseBody
//	public Map<String,Object> recom(@RequestBody Map<String , Object> pMap) {
//		System.out.println("추천 idx값"+pMap.get("idx")+"  "+pMap.get("m_idx"));
//		Map<String,Object> map = new HashMap<String,Object>();
//		map.put("idx", pMap.get("idx"));
//		map.put("m_idx", pMap.get("m_idx"));
//		service.updateRecom(map); //추천수 +1
//		System.out.println("카운트 업데이트 실행완료");
//		map.put("flag", "true");
//		return map;
//	}
//	@RequestMapping(value="recomCount/{idx}", method=RequestMethod.GET)
//	public Map<String , Object> recom(@PathVariable int idx) {
//		System.out.println("카운트 셀렉트 실행"+idx);
//		Map<String,Object> map = new HashMap<String, Object>();
//		BlogDto dto = service.selectBlog(idx);
//		map.put("count",dto.getB_recom());
//		return map;
//	}
	@RequestMapping(value = "/recom/{b_idx}", method = RequestMethod.POST, headers = { "Content-Type=application/json;" })
	@ResponseBody
	public Map<String, Object> recom(@RequestBody Map<String, Object> pMap) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("m_idx", pMap.get("m_idx"));
		map.put("b_idx", pMap.get("b_idx"));
		String flag = service.selectRecom(map);
		if(flag == null) {	//찾아온 값이 없으면 추천가능
			service.updateRecom(map); // 추천수 +1
			service.insertRecom(map);
			map.put("flag", true);
			map.put("message", "추천 완료!");
		}else {	//찾아온값이 있으므로 추천 증가 x
			map.put("flag", false);
			map.put("message", "한 블로그 글당 한번만 추천 가능합니다");
		}
		return map;
	}

	@RequestMapping(value = "recomCount/{idx}", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> recom(@PathVariable int idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		BlogDto dto = service.selectBlog(idx);
		map.put("count", dto.getB_recom());
		return map;
	}

	// 이미지 삭제
	@RequestMapping(value = "/imgDelete/{idx}", method = RequestMethod.POST, headers = {
			"Content-Type=application/json;" })
	@ResponseBody
	public Map<String, Object> imgDelete(@RequestBody Map<String, Object> pMap) {
		service.deleteImg(pMap); // 추천수 +1
		pMap.put("flag", "삭제 완료");
		return pMap;
	}
}
