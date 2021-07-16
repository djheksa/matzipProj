package com.gb.myproject.member999.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.gb.myproject.member999.mapper.MemberMapper;
import com.gb.myproject.member999.model.KakaoMemberDto;
import com.gb.myproject.member999.model.MemberDto;
import com.gb.myproject.member999.model.S_likeDto;

@Component
public class MemberServiceImpl implements MemberService{
	@Autowired
	MemberMapper mDao;
	
	
	@Override
	public MemberDto selectLogin(Map<String, String> map) {
		return mDao.selectLogin(map);
	}

	@Override
	public int insertMember(MemberDto dto) {
		
		return mDao.insertMember(dto);
	}

	@Override
	public int updateMember(MemberDto dto) {
		
		return mDao.updateMember(dto);
	}

	@Override
	public int updatePassword(Map<String,Object> map) {
		
		return mDao.updatePassword(map);
	}

	@Override
	public int deleteMember(int idx) {
		// TODO Auto-generated method stub
		return mDao.deleteMember(idx);
	}

	@Override
	public int insertLike(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mDao.insertLike(map);
	}

	@Override
	public List<S_likeDto> selectLikeList(int m_idx) {
		
		return mDao.selectLikeList(m_idx);
	}

	@Override
	public int selectLikeCount(int s_idx) {
		// TODO Auto-generated method stub
		return mDao.selectLikeCount(s_idx);
	}

	@Override
	public int deleteMemberLike(int idx) {
		// TODO Auto-generated method stub
		return mDao.deleteMemberLike(idx);
	}

	@Override
	public int deleteStoreLike(Map<String,Object> map) {
		// TODO Auto-generated method stub
		return mDao.deleteStoreLike(map);
	}

	@Override
	public String selectId(MemberDto dto) {
		// TODO Auto-generated method stub
		return mDao.selectId(dto);
	}

	@Override
	public String selectPassword(Map<String,Object> map) {
		// TODO Auto-generated method stub
		return mDao.selectPassword(map);
	}

	@Override
	public MemberDto selectKakaoLogin(KakaoMemberDto dto) {
		return mDao.selectKakaoLogin(dto);
	}

	@Override
	public String selectLikeStore(Map<String, Object> map) {
		return mDao.selectLikeStore(map);
	}
	@Override
	public MemberDto selectOneMember(int idx) {
		return mDao.selectOneMember(idx);
	}
	@Override
	public MemberDto selectDoubleCheck(String id) {
		return mDao.selectDoubleCheck(id);
	}

	@Override
	public MemberDto selectPw(Map<String, Object> map) {
		return mDao.selectPw(map);
	}
}
