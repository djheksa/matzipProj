package com.gb.myproject.store.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gb.myproject.blog.model.BlogDto;
import com.gb.myproject.blog.service.BlogService;
import com.gb.myproject.member999.model.MemberDto;
import com.gb.myproject.member999.service.MemberService;
import com.gb.myproject.review.service.ReviewService;
import com.gb.myproject.store.model.Store;
import com.gb.myproject.store.service.StoreService;

@Controller
@RequestMapping("/store")
public class StoreController {
	@Autowired
	StoreService service;
	@Autowired
	MemberService mService;
	@Autowired
	ReviewService rService;
	@Autowired
	BlogService bService;
	MemberDto mdto;

	//전철을 선택하면 map.jsp로 이동  
		@RequestMapping(value="/map",method=RequestMethod.GET)
		public String insert(String stationmap , Model model) {
			
			model.addAttribute("stationmap", stationmap);
			model.addAttribute("stations",service.getStationName());
			//return "/store/map"; //처음에 데이터 저장시 경로
			return "redirect:station"; //데이터 저장된 후 경로
		} 
	
	
		 //맛집 데이터 DB에 저장 
		 @RequestMapping(value = "/map", method = RequestMethod.POST, headers = { "Content-type=application/json" }) 
		 public String save(@RequestBody Store store,String stationmap, Model model) throws Exception { 
			 System.out.println(store);
		 List<String> list_sname = Arrays.asList(store.getS_name().split("/"));
		  List<String> list_sidx = Arrays.asList(store.getS_idx().split("/")); 
		  List<String> list_s_addr = Arrays.asList(store.getS_addr().split("/")); 
		  List<String> list_station = Arrays.asList(store.getStation().split("/")); 
		  List<String> list_phone =Arrays.asList(store.getS_phone().split("/"));
		  List<String> list_url = Arrays.asList(store.getS_url().split(",")); 
		  List<String> list_x = Arrays.asList(store.getX().split("/")); 
		  List<String> list_y = Arrays.asList(store.getY().split("/")); 
		  service.insert(list_sname,list_sidx,list_s_addr,list_station,list_phone, list_url,list_x,list_y); 
		 // return "redirect:/store/station?stationmap="+stationmap; 
		  return null;
		  }
	 
	
		//맛집데이터 저장 후 선택한 역 뷰 출력
	     @RequestMapping(value = "/station", method = RequestMethod.GET)
	        public void getStationMap(String stationmap,String test,String temp,Model model) {
	             List<Store> s = service.getStoreMap(stationmap);
	            model.addAttribute("bean", service.getStoreMap(stationmap));
	            model.addAttribute("stationmap",stationmap);
	            model.addAttribute("stations",service.getStationName());
	            List<BlogDto> list;


	            list = bService.selectBlogListMap();
	            for (BlogDto b : list) {
	                b.setImgList(bService.selectImg(b.getIdx()));
	            }
	            model.addAttribute("list", list);

	        }
	
	//맛집 선택 
		@RequestMapping(value="/store", method=RequestMethod.GET)
		public String getStoreInfo(String s_idx,Model model,HttpServletRequest request) {
			HttpSession session = request.getSession(); 
			mdto = (MemberDto)session.getAttribute("member");
			String state="unlike"; //찜 초기상태
			if(mdto!=null) { 
				int m_idx = mdto.getIdx();
				Map<String,Object> map = new HashMap<String, Object>();
				map.put("s_idx", s_idx);
				map.put("m_idx", m_idx);
				String temp = mService.selectLikeStore(map);
				System.out.println(temp);
				if(temp!=null) { //likeDB에 있다면
					state="like";	 				
				}
			}
			if(rService.selectReviewCount(s_idx)!=0) {
				model.addAttribute("star_avg",rService.selectStarAvg(s_idx)); 
			}else {
			model.addAttribute("star_avg",0.0); //리뷰 평균 
			}
			
			model.addAttribute("state",state); //like 찜 상태
			model.addAttribute("bean", service.getStoreInfo(s_idx)); //스토어 정보 
			model.addAttribute("reviews",rService.selectReviewList(s_idx)); //리뷰 리스트 가져오기 
			return "/store/store_info";
		}	
	
		//찜 눌렀을 때
		@RequestMapping(value="/store_like", method=RequestMethod.POST)
		public String getStoreId(String s_idx,String state ,Model model,HttpServletRequest request) {
			HttpSession session = request.getSession();
			mdto = (MemberDto)session.getAttribute("member");

			if(mdto==null) {
				model.addAttribute("state","unlike");
				return "redirect:/store/store?s_idx="+s_idx;
			}
			else {
				int m_idx = mdto.getIdx();
				Map<String,Object> map = new HashMap<String, Object>();
				map.put("s_idx", s_idx);
				map.put("m_idx", m_idx);
				if(state.equals("unlike")){
					mService.deleteStoreLike(map);
				}
				else{
					mService.insertLike(map);
				}

				model.addAttribute("state",state);
				
				return "redirect:/store/store?s_idx="+s_idx;
			}		
		}
		

}
