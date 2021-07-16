package com.gb.myproject.review.service;

import java.util.List;

import com.gb.myproject.review.model.ReviewDto;

public interface ReviewService {
	List<ReviewDto> selectReviewList(String s_idx);	//리뷰리스트
	int selectReviewCount(String s_idx);		//리뷰카운트
	int deleteReview(int idx);				//리뷰삭제
	double selectStarAvg(String s_idx);		//별점평균
	int insertReview(ReviewDto rdto);
}
