package com.suw.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.suw.dao.BaseDAO;
import com.suw.entity.Favourite;
import com.suw.service.FavouriteService;

@Service("favouriteService")
public class FavouriteServiceImpl implements FavouriteService {
	
	@Resource
	private BaseDAO<Favourite> baseDAO;

	@Override
	public Favourite save(Favourite f) {
		return baseDAO.save(f);
	}

	@Override
	public Favourite get(int userId, int questionId) {
		return baseDAO.get("from Favourite f where f.userId=? and f.questionId=?", new Object[]{userId,questionId});
	}

	@Override
	public void delete(int userId, int questionId) {
		baseDAO.delete("delete from Favourite f where f.userId=? and f.questionId=?", new Object[]{userId,questionId});
	}

	
	
}
