package com.gb.myproject.store.mapper;

import java.util.List;
import java.util.Map;

import com.gb.myproject.store.model.Station;
import com.gb.myproject.store.model.Store;


public interface StoreMapper {
	public void insert(Store store);	
	public List<Store> getStoreMap(String station);
	public void reset();
	public List<Station> getStationName();
	public Store getStoreInfo(String s_idx);
}
