package com.gb.myproject.review.service;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.gb.myproject.review.mapper.ReviewMapper;
import com.gb.myproject.review.model.ReviewDto;

@Component
public class ReviewServiceImpl implements ReviewService{
	@Autowired
	ReviewMapper rdao;
	@Override
	public List<ReviewDto> selectReviewList(String s_idx) {
		// TODO Auto-generated method stub
		return rdao.selectReviewList(s_idx);
	}

	@Override
	public int selectReviewCount(String s_idx) {
		// TODO Auto-generated method stub
		return rdao.selectReviewCount(s_idx);
	}

	@Override
	public int insertReview(ReviewDto rdto) {
		// TODO Auto-generated method stub
		return rdao.insertReview(rdto);
	}

	@Override
	public int deleteReview(int idx) {
		// TODO Auto-generated method stub
		return rdao.deleteReview(idx);
	}

	@Override
	public double selectStarAvg(String s_idx) {
		DecimalFormat df = new DecimalFormat("#.#");
		double result =Double.parseDouble(df.format(rdao.selectStarAvg(s_idx)));
		return result;
	}
	
}
