package com.gb.myproject.blog.mapper;

import java.util.List;
import java.util.Map;

import com.gb.myproject.blog.model.BlogDto;
import com.gb.myproject.blog.model.ImgDto;
import com.gb.myproject.blog.model.PageDto;

public interface BlogMapper {

	int blogListCount(); // 전체게시글 갯수

	List<BlogDto> selectBlogList(); // 전체게시글

	List<BlogDto> selectCategoryList(String category); // 게시글 카테고리별 정렬

	List<BlogDto> selectMyBlogList(int m_idx); // 내가 쓴글

	List<BlogDto> getPagelist(PageDto dto); // 한 페이지 게시글

	BlogDto selectBlog(int idx); // 글 하나 갖고오기

	int insertBlog(BlogDto dto); // 글쓰기

	int updateBlog(BlogDto dto); // 글수정

	int deleteBlog(int idx); // 글삭제

	List<BlogDto> selectSearch(PageDto dto); // 검색 게시글

	int searchCount(Map<String, String> map); // 검색 카운트

	List<BlogDto> selectMyList(); // 내가 쓴글

	int myListCount(); // 내가 쓴 글 갯수

	int updateCount(int idx); // 조회수

	int updateRecom(Map<String, Object> map); // 추천수

	List<ImgDto> selectImg(int b_idx); // 이미지 가져오기

	int imgInsert(ImgDto img); // 이미지 삽입

	int imgUpdate(ImgDto img); // 이미지 수정

	int deleteImg(Map<String, Object> map); // 이미지 삭제

	int deleteALlImg(int b_idx); // 이미지 전체삭제

	int insertRecom(Map<String, Object> map); // 추천 insert

	String selectRecom(Map<String, Object> map); // 추천 select
	
	int deleteRecom(int b_idx);					//추천 delete
	
	List<BlogDto> selectBlogListMap(); // station 페이지에서 보여줄 추천높은 게시글
}
