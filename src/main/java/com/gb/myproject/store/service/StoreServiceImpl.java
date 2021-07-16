package com.gb.myproject.store.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gb.myproject.review.mapper.ReviewMapper;
import com.gb.myproject.store.mapper.StoreMapper;
import com.gb.myproject.store.model.Station;
import com.gb.myproject.store.model.Store;

@Service
public class StoreServiceImpl implements StoreService{
	@Autowired
	StoreMapper sdao;   //dao 는 bean (클래스의 객체)

	
	public void insert(List<String> s_name , List<String> s_idx,
			List<String> s_addr,List<String> station,List<String> s_phone,
			List<String> s_url ,List<String> list_x, List<String> list_y ) {
		sdao.reset();
		List<Store> list=new ArrayList<Store>();
		for(int i =0;i<s_idx.size();i++) { 
			
			//list.add(new Store(s_name.get(i),s_idx.get(i),s_addr.get(i),station.get(i),s_phone.get(i),s_url.get(i),list_x.get(i),list_y.get(i)));
			Store temp= new Store(s_name.get(i),s_idx.get(i),s_addr.get(i),station.get(i),s_phone.get(i),s_url.get(i),list_x.get(i),list_y.get(i));
			sdao.insert(temp);
			System.out.println(temp);
		}
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list",list);
	}
	public List<Store> getStoreMap(String station) {
		return sdao.getStoreMap(station);
	}
	public void reset() {
		sdao.reset();
	}
	public List<Station> getStationName() {
		return sdao.getStationName();
	}
	public Store getStoreInfo(String s_idx){
		return sdao.getStoreInfo(s_idx);
	}
}
