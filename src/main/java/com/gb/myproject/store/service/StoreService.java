package com.gb.myproject.store.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gb.myproject.store.mapper.StoreMapper;
import com.gb.myproject.store.model.Station;
import com.gb.myproject.store.model.Store;

public interface StoreService {

	public void insert(List<String> s_name , List<String> s_idx,
			List<String> s_addr,List<String> station,List<String> s_phone,
			List<String> s_url ,List<String> list_x, List<String> list_y );
	public List<Store> getStoreMap(String station);
	public void reset();
	public List<Station> getStationName();
	public Store getStoreInfo(String s_idx);
}
