package com.gb.myproject.blog.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.gb.myproject.blog.mapper.BlogMapper;
import com.gb.myproject.blog.model.BlogDto;
import com.gb.myproject.blog.model.ImgDto;
import com.gb.myproject.blog.model.PageDto;

@Component
public class BlogServiceImpl implements BlogService{

	@Autowired 
	BlogMapper dao;
	
	@Override
	public int blogListCount() {
		return dao.blogListCount();
	}

	@Override
	public List<BlogDto> selectBlogList() {
		return dao.selectBlogList();
	}

	@Override
	public List<BlogDto> getPagelist(PageDto dto) {
		return dao.getPagelist(dto);
	}

	@Override
	public BlogDto selectBlog(int idx) {
		return dao.selectBlog(idx);
	}

	@Override
	public int insertBlog(BlogDto dto) {
		return dao.insertBlog(dto);
	}

	@Override
	public int updateBlog(BlogDto dto) {
		return dao.updateBlog(dto);
	}

	@Override
	public int deleteBlog(int idx) {
		return dao.deleteBlog(idx);
	}

	@Override
	public List<BlogDto> selectSearch(PageDto dto) {
		//paging에 검색을 위한 필드와 검색어 속성 포함
		return dao.selectSearch(dto);
	}

	@Override
	public int searchCount(ModelMap map) {
		Map<String,String> daomap = new HashMap<String, String>();
		daomap.put("field", (String) map.get("field"));
		daomap.put("findText", (String) map.get("findText"));
		return dao.searchCount(daomap);
	}


	@Override
	public List<BlogDto> makePageList(PageDto pageDto) {
		List<BlogDto> list;
		if(pageDto.getCategory()==null) pageDto.setCategory("idx");
		System.out.println("service imple에서 카테고리"+pageDto.getCategory());
		if(pageDto.getFindText()!= null && !pageDto.getFindText().equals("")) {	//검색값이 있으면
			System.out.println("검색값 잇음");
			list = selectSearch(pageDto);
		}else {							//검색값이 없으면
			System.out.println("전체");
			list=getPagelist(pageDto);
		}
		return list;
	}

	@Override
	public List<BlogDto> selectMyList() {
		return dao.selectMyList();
	}
	
	@Override
	public int myListCount() {
		return dao.myListCount();
	}
	
	@Override
	public int updateCount(int idx) {
		return dao.updateCount(idx);
	}
	
	@Override
	public int updateRecom(Map<String,Object> map) {
		return dao.updateRecom(map);
	}

	@Override
	public int imgInsert(ImgDto img) {
		return dao.imgInsert(img);
	}

	@Override
	public int imgUpdate(ImgDto img) {
		return dao.imgUpdate(img);
	}

	@Override
	public int deleteImg(Map<String,Object> map) {
		return dao.deleteImg(map);
	}

	@Override
	public int deleteALlImg(int b_idx) {
		return dao.deleteALlImg(b_idx);
	}

	@Override
	public List<BlogDto> selectMyBlogList(int m_idx) {
		return dao.selectMyBlogList(m_idx);
	}

	@Override
	public List<ImgDto> selectImg(int b_idx) {
		return dao.selectImg(b_idx);
	}

	@Override
	public List<BlogDto> selectCategoryList(String category) {
		return dao.selectCategoryList(category);
	}

	@Override
	public int insertRecom(Map<String, Object> map) {
		return dao.insertRecom(map);
	}

	@Override
	public String selectRecom(Map<String, Object> map) {
		return dao.selectRecom(map);
	}

	@Override
	public int deleteRecom(int b_idx) {
		return dao.deleteRecom(b_idx);
	}

	@Override
	public List<BlogDto> selectBlogListMap() {
		return dao.selectBlogListMap();
	}
}
